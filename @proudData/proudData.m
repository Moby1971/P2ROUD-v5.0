classdef proudData

    % Data and parameter class for p2roud app

    properties

        % Data
        rawKspace = {};
        unsKspace = {};
        mrdKspace = [];
        images = [];
        phaseImages = [];
        phaseImagesOrig = [];
        flowImages = [];
        mask = [];
        nsaSpace = [];
        fillingSpace = [];
        pixelSize = [];
        mrdFooter;
        newMrdFooter;
        rprFile;
        newRprFile;

        % Filenames
        filename;
        PPL = 'unknown';

        % Sequence parameters
        dataType = '2D';
        totalAcqTime = 0;
        NO_SAMPLES = 1;
        NO_SAMPLES_ORIG = 1;
        NO_VIEWS = 1;
        NO_VIEWS_ORIG = 1;
        NO_VIEWS_2 = 1;
        NO_VIEWS_2_ORIG = 1;
        DISCARD = 0;
        EXPERIMENT_ARRAY = 1;
        oversample = 0;
        nr_repetitions = 1;
        NO_AVERAGES = 1;
        NO_SLICES = 1;
        NO_ECHOES = 1;
        nav_on = 0;
        VIEWS_PER_SEGMENT = 1;
        SLICE_THICKNESS = 1;
        SLICE_SEPARATION = 1;
        SLICE_INTERLEAVE = 1;
        slab_ratio = 100;
        r_angle_var;
        p_angle_var;
        s_angle_var;
        nr_coils = 1;
        nrCoils = 1;
        FOV = 30;
        PHASE_ORIENTATION = 0;
        FOVf = 8;
        aspectratio = 1;
        alpha = 20;
        te = 2;
        te_us = 0;
        TE;
        tr = 10;
        tr_extra_us = 0;
        TR;
        ti = 1000;
        VFA_angles = [];
        VFA_size = 0;
        flipAngleArray = [];
        frame_loop_on = 0;
        radial_on = 0;
        slice_nav = 0;
        date;
        pixelshift1 = 0;
        pixelshift2 = 0;
        coil_scaling = 1;
        coilSensitivities = [1 1 1 1 1 1 1 1];
        scanner = 'MRS';
        field_strength = 7;
        acqdur = 0;
        timeperframe = 0;
        nr_frames = 1;

        % K-space trajectory related
        pe1_order = 0;
        pe2_centric_on = 0;
        pe2_traj = 0;
        gp_var_mul = [];
        gp_var_proud = [];
        trajType = '';
        seqTrajectory;
        proudArray = [];

        % Flow related
        venc = 0;
        vencAmp = [];
        flowCompOn = 0;
        vencTable = [];
        flowFnc = [];

        % Navigator related
        no_samples_nav = 10;
        no_samples_discard = 35;

        % Segmentation related
        threshold = 0;
        
        % Flags
        validFile_flag = false;
        validReco_flag = false;
        validVenc_flag = false;
        validFlow_flag = false;
        validMask_flag = false;
        multiEchoes_flag = false;
        multiRepetitions_flag = false;
        multiFlipAngles_flag = false;
        multiCoil_flag = false;
        multiSlab_flag = false;
        validTrajectory_flag = false
        rprFile_flag = false;
        proudRecoScan_flag = false;
        retroRecoScan_flag = false;
        coilActive_flag = [1 1 1 1 1 1 1];


    end % properties



    % -----------------------------------------------------------------
    % Methods
    % -----------------------------------------------------------------
    %
    % obj = proudData()
    % obj = setNumberOfCoils(obj, app, flist)
    % obj = readProudData(obj, app, mrdfile, flist)
    % obj = readBtypeData(obj, app, mrdfile, flist)
    % obj = readMrdFooter(obj, mrdfile)
    % obj = makeMrdFooter(obj, par)
    % obj = readRprFile(obj, app, fn)
    % obj = writeToRprFile(obj, filename)
    % obj = makeRprFile(obj, par)
    % obj = writeDataToMrd(obj, filename, parameters)
    % obj = setDataParameters(obj, app)
    % obj = permute3Dkspace(obj)
    % obj = permute2Dkspace(obj)
    % obj = sortScanner2DKspaceMRD(obj, app, kTable)
    % obj = sortScanner3DKspaceMRD(obj, app, kTable)
    % obj = sort2DKspaceMRD(obj, app)
    % obj = sort3DKspaceMRD(obj, app)
    % obj = sortProudKspaceMRD(obj, app)
    % obj = chopNav(obj)
    % obj = applyTukey(obj)
    % obj = csReco2DCine(obj,app,flipAngle)
    % obj = csReco2D(obj,app,flipAngle,echoTime)
    % obj = fftReco2D(obj,app,flipAngle,echoTime)
    % obj = csReco3D(obj,app,flipAngle,echoTime)
    % obj = fftReco3D(obj,app,flipAngle,echoTime)
    % obj = csRecoRadial(obj,app,flipAngle,echoTime)
    % obj = scaleImages(obj)
    % obj = calcPixelSize(obj,app)
    % obj = backToKspace(obj)
    % obj = recoSurFiles(obj, surpath, suffix, mrdfilename, rprfilename)
    % obj = unwrap3D(obj)
    % obj = calcFlow(obj)
    % 
    %
    % Static Methods:
    %
    % output = circTukey2D(dimy,dimx,row,col,filterwidth)
    % output = circTukey3D(dimz,dimy,dimx,lev,row,col,filterwidth)
    % y = gauss(x,s,m)
    % y = fft2r(x)
    % y = fft3r(x)
    % [im,dim,par,unsortedkspace] = importMRD(filename, reordering1, reordering2)
    % struct = jcampread(filename)
    % output = fracCircShift(input,shiftsize)
    % [dydtx,dydty,dydtz] = partialDerivative3D(app,kTraj,xNew,calibSize)
    % [dydtx,dydty] = partialDerivative2D(app,kTraj,Xnew,calibSize)
    % Xnew = lowRankThresh3D(Xold,kSize,thresh) 
    % Xnew = lowRankThresh2D(Xold,kSize,thresh)
    % kSpaceNew = trajInterpolation(kSpaceOld,dShift)
    % res = im2row3D(im, winSize)
    % res = im2row2D(im, winSize)
    % v = vec(x)
    % X = fft3Dmri(x)
    % X = ifft3Dmri(x)
    % X = fft2Dmri(x)
    % X = ifft2Dmri(x)
    %




    methods (Access = public)

        % ---------------------------------------------------------------------------------
        % Empty object constructor
        % ---------------------------------------------------------------------------------
        function obj = proudData()

        end % proudData




        % ---------------------------------------------------------------------------------
        % Set the number of coils
        % ---------------------------------------------------------------------------------
        function obj = setNumberOfCoils(obj, app, flist)

            obj.nrCoils = length(flist);
            if obj.nrCoils>1
                obj.multiCoil_flag = true;
                app.TextMessage('Multi receiver coil data detected ...');
            else
                obj.multiCoil_flag = false;
                app.TextMessage('Single coil data ...');
            end

        end % setNumberOfCoils




        % ---------------------------------------------------------------------------------
        % Load the data
        % ---------------------------------------------------------------------------------
        function obj = readProudData(obj, app, mrdfile, flist)

            obj.proudRecoScan_flag = false;
            obj.retroRecoScan_flag = false;
            obj.validFile_flag = true;

            obj.rawKspace = {};
            obj.unsKspace = {};
            for i=1:obj.nrCoils
                app.TextMessage(strcat('Loading coil #',num2str(i)));
                if contains(mrdfile,'p2roud')
                    obj.proudRecoScan_flag = true;
                    [obj.rawKspace{i},~,parameters,obj.unsKspace{i}] = proudData.importMRD(fullfile(flist(i).folder,flist(i).name),'seq','seq');
                elseif contains(mrdfile,'retro')
                    obj.retroRecoScan_flag = true;
                    [obj.rawKspace{i},~,parameters,obj.unsKspace{i}] = proudData.importMRD(fullfile(flist(i).folder,flist(i).name),'seq','seq');
                else
                    [obj.rawKspace{i},~,parameters,obj.unsKspace{i}] = proudData.importMRD(fullfile(flist(i).folder,flist(i).name),'seq','cen');
                end
                if isfield(parameters,'pe2_centric_on')
                    if parameters.pe2_centric_on == 0
                        [obj.rawKspace{i},~,parameters,obj.unsKspace{i}] = proudData.importMRD(fullfile(flist(i).folder,flist(i).name),'seq','seq');
                    end
                end
            end

            if isfield(parameters,'filename')
                obj.filename = parameters.filename;
            end

            if isfield(parameters,'PPL')
                parameters.PPL = replace(parameters.PPL,'\',filesep);
                [~,name,ext] = fileparts(parameters.PPL);
                obj.PPL = strcat(name,ext);
            end

            if isfield(parameters,'NO_SAMPLES')
                obj.NO_SAMPLES = parameters.NO_SAMPLES;
                obj.NO_SAMPLES_ORIG = parameters.NO_SAMPLES;
            else
                indx = ndims(obj.rawKspace{1});
                obj.NO_SAMPLES = size(obj.rawKspace{1},indx);
                obj.NO_SAMPLES_ORIG = size(obj.rawKspace{1},indx);
            end

            if isfield(parameters,'oversample')
                obj.oversample = parameters.oversample;
            end

            if isfield(parameters,'NO_VIEWS')
                obj.NO_VIEWS = parameters.NO_VIEWS;
                obj.NO_VIEWS_ORIG = parameters.NO_VIEWS;
            end

            if isfield(parameters,'NO_VIEWS_2')
                obj.NO_VIEWS_2 = parameters.NO_VIEWS_2;
                obj.NO_VIEWS_2_ORIG = parameters.NO_VIEWS_2;
            end

            if isfield(parameters,'NO_ECHOES')
                obj.NO_ECHOES = parameters.NO_ECHOES;
            end

            if isfield(parameters,'DISCARD')
                obj.DISCARD = parameters.DISCARD;
            end

            if isfield(parameters,'slab_ratio')
                obj.slab_ratio = parameters.slab_ratio;
            end

            if isfield(parameters,'EXPERIMENT_ARRAY')
                obj.EXPERIMENT_ARRAY = parameters.EXPERIMENT_ARRAY;
                obj.nr_repetitions = parameters.EXPERIMENT_ARRAY;
            end

            if isfield(parameters,'NO_AVERAGES')
                obj.NO_AVERAGES = parameters.NO_AVERAGES;
            end

            if isfield(parameters,'NO_SLICES')
                obj.NO_SLICES = parameters.NO_SLICES;
            end

            if isfield(parameters,'SLICE_THICKNESS')
                obj.SLICE_THICKNESS= parameters.SLICE_THICKNESS;
            end

            if isfield(parameters,'SLICE_SEPARATION')
                obj.SLICE_SEPARATION = parameters.SLICE_SEPARATION;
            end

            if isfield(parameters,'SLICE_INTERLEAVE')
                obj.SLICE_INTERLEAVE = parameters.SLICE_INTERLEAVE;
            end

            if isfield(parameters,'r_angle_var')
                obj.r_angle_var = parameters.r_angle_var;
            end

            if isfield(parameters,'p_angle_var')
                obj.p_angle_var = parameters.p_angle_var;
            end

            if isfield(parameters,'s_angle_var')
                obj.s_angle_var = parameters.s_angle_var;
            end

            if isfield(parameters,'nr_coils')
                obj.nr_coils = parameters.nr_coils;
            end

            if isfield(parameters,'FOV')
                obj.FOV = parameters.FOV;
            end

            if isfield(parameters,'PHASE_ORIENTATION')
                obj.PHASE_ORIENTATION = parameters.PHASE_ORIENTATION;
            end

            if isfield(parameters,'FOVf')
                obj.FOVf = parameters.FOVf;
            end

            obj.aspectratio = obj.FOVf/8;

            if isfield(parameters,'alpha')
                obj.alpha = parameters.alpha;
            end

            if isfield(parameters,'te')
                obj.te = parameters.te;
            end

            if isfield(parameters,'te_us')
                obj.te_us = parameters.te_us;
            end

            obj.TE = obj.te + obj.te_us/1000;

            if isfield(parameters,'tr')
                obj.tr = parameters.tr;
            end

            if isfield(parameters,'tr_extra_us')
                obj.tr_extra_us = parameters.tr_extra_us;
            end

            obj.TR = obj.tr + obj.tr_extra_us/1000;

            if isfield(parameters,'pe1_order')
                obj.pe1_order = parameters.pe1_order;
            end

            if isfield(parameters,'pe2_centric_on')
                obj.pe2_centric_on = parameters.pe2_centric_on;
            end

            if isfield(parameters,'ti')
                obj.ti = parameters.ti;
            end

            if isfield(parameters,'VFA_angles')
                obj.VFA_angles = parameters.VFA_angles;
            end

            if isfield(parameters,'VFA_size')
                obj.VFA_size = parameters.VFA_size;
            end

            if isfield(parameters,'frame_loop_on')
                obj.frame_loop_on = parameters.frame_loop_on;
            end

            if isfield(parameters,'radial_on')
                obj.radial_on = parameters.radial_on;
            end

            if isfield(parameters,'slice_nav')
                obj.slice_nav = parameters.slice_nav;
            end

            if isfield(parameters,'no_samples_nav')
                obj.no_samples_nav = parameters.no_samples_nav;
            end

            if isfield(parameters,'gp_var_mul')
                obj.gp_var_mul = parameters.gp_var_mul;
            end

            if isfield(parameters,'nav_on')
                obj.nav_on = parameters.nav_on;
            end

            if isfield(parameters,'VIEWS_PER_SEGMENT')
                obj.VIEWS_PER_SEGMENT = parameters.VIEWS_PER_SEGMENT;
            end

            if isfield(parameters,'date')
                obj.date = parameters.date;
            end

            if isfield(parameters,'coil_scaling')
                obj.coil_scaling = parameters.coil_scaling;
            end

            if isfield(parameters,'pixelshift1')
                obj.pixelshift1 = parameters.pixelshift1;
            end

            if isfield(parameters,'pixelshift2')
                obj.pixelshift2 = parameters.pixelshift2;
            end

            if isfield(parameters,'pe2_traj')
                obj.pe2_traj = parameters.pe2_traj;
            end

            if isfield(parameters,'scanner')
                obj.scanner = parameters.scanner;
            end

            % Flow related parameters

            if isfield(parameters,'VENC')
                obj.venc = parameters.VENC;
            end

            if isfield(parameters,'venc_amp')
                obj.vencAmp = parameters.venc_amp(1:obj.venc+1);
            end

            if isfield(parameters,'flow_comp_on')
                obj.flowCompOn = parameters.flow_comp_on;
            end

        end % readProudData



        % ---------------------------------------------------------------------------------
        % Read b-type scanner data   XXX currently not used XXX
        % ---------------------------------------------------------------------------------
        function obj = readBtypeData(obj, app, mrdfile, flist) %#ok<*INUSL> 

            obj.proudRecoScan_flag = false;
            obj.retroRecoScan_flag = false;
            obj.validFile_flag = true;

            obj.rawKspace = {};
            obj.unsKspace = {};

            % Import path
            [importPath,~,~] = fileparts(flist);

            % Parameters
            info1 = proudData.jcampread(strcat(importPath,'acqp'));
            info2 = proudData.jcampread(strcat(importPath,'method'));

            % Scanner type
            obj.scanner = 'B-type';

            % Slices
            obj.NO_SLICES = str2num(info1.NSLICES);
            obj.SLICE_THICKNESS = str2num(info2.pvm.slicethick) * obj.NO_SLICES;

            % Matrix in readout direction
            obj.NO_SAMPLES = info1.acq.size(1) / 2;
            if isfield(info2.pvm,"matrix")
                obj.NO_VIEWS = info2.pvm.encmatrix(1);
            end

            % Matrix in phase encoding direction
            obj.NO_VIEWS = info1.acq.size(2);
            if isfield(info2.pvm,"matrix")
                obj.NO_VIEWS = info2.pvm.encmatrix(2);
            end

            % Phase encoding orientation
            obj.PHASE_ORIENTATION = 1;
            pm1 = -1;
            pm2 = -1;

            if isfield(info2.pvm,'spackarrreadorient')
                if strcmp(info2.pvm.spackarrreadorient,'L_R')
                    obj.PHASE_ORIENTATION = 0;
                    flr =  0;
                    pm1 = +1;
                    pm2 = -1;
                end
                if strcmp(info2.pvm.spackarrreadorient,'A_P')
                    obj.PHASE_ORIENTATION = 1;
                    flr =  0;
                    pm1 = -1;
                    pm2 = -1;
                end
                if strcmp(info2.pvm.spackarrreadorient,'H_F')
                    obj.PHASE_ORIENTATION = 1;
                    flr =  0;
                    pm1 = -1;
                    pm2 = -1;
                end
            end

            % Matrix in 2nd phase encoding direction
            obj.NO_VIEWS_2 = 1;
            obj.pe2_centric_on = 0;

            % FOV
            obj.FOV = info1.acq.fov(1)*10;
            FOV2 = info1.acq.fov(2)*10;
            obj.FOVf = round(8*FOV2/obj.FOV);
            obj.aspectratio = obj.FOVf/8;

            % Sequence parameters
            obj.TR = info1.acq.repetition_time;
            obj.TE = info1.acq.echo_time;
            obj.alpha = str2num(info1.acq.flip_angle);
            obj.NO_ECHOES = 1;
            obj.NO_AVERAGES = str2num(info1.NA);
            obj.EXPERIMENT_ARRAY = str2num(info1.NR);

            % Other parameters
            obj.date = datetime;
            obj.PPL = 'b-type sequence';
            obj.filename = 'btype';
            obj.field_strength = str2num(info1.BF1)/42.58; %#ok<*ST2NM> 
            obj.filename = 111;
            obj.pe1_order = 2;
            obj.radial_on = 0;
            obj.slice_nav = 0;
            obj.no_samples_nav = 0;

            % Number of receiver coils
            obj.nr_coils = str2num(info2.pvm.encnreceivers);

            % Trajectory 1st phase encoding direction
            if isfield(info2.pvm,'ppggradamparray1')
                if isfield(info2.pvm,'enczfaccel1') && isfield(info2.pvm,'encpftaccel1')
                    obj.gp_var_mul = round(pm1 * info2.pvm.ppggradamparray1 * str2num(info2.pvm.enczfaccel1) * str2num(info2.pvm.encpftaccel1) * (obj.NO_VIEWS / 2 - 0.5));
                else
                    obj.gp_var_mul = round(pm1 * info2.pvm.ppggradamparray1 * (obj.NO_VIEWS / 2 - 0.5));
                end
                obj.pe1_order = 3;
            elseif isfield(info2.pvm,'encvalues1')
                if isfield(info2.pvm,'enczf') && isfield(info2.pvm,'encpft')
                    obj.gp_var_mul = round(pm1 * info2.pvm.encvalues1 * info2.pvm.enczf(2) * info2.pvm.encpft(2) * (obj.NO_VIEWS / 2 - 0.5));
                else
                    obj.gp_var_mul = round(pm1 * info2.pvm.encvalues1 * (obj.NO_VIEWS / 2 - 0.5));
                end
                obj.pe1_order = 3;
            else
                obj.pe1_order = 2;
            end

            % Data type
            datatype = 'int32';
            if isfield(info1.acq,'word_size')
                if strcmp(info1.acq.word_size,'_32_BIT')
                    datatype = 'int32';
                end
                if strcmp(info1.acq.word_size,'_16_BIT')
                    datatype = 'int16';
                end
            end

            % Read data
            if isfile(strcat(importPath,'fid.orig'))
                fileID = fopen(strcat(importPath,'fid.orig'));
            elseif isfile(strcat(importPath,'rawdata.job0'))
                fileID = fopen(strcat(importPath,'rawdata.job0'));
            else
                fileID = fopen(strcat(importPath,'fid'));
            end
            dataRaw = fread(fileID,datatype);
            fclose(fileID);
            kreal = dataRaw(1:2:end);
            kim = dataRaw(2:2:end);
            kspace = kreal + 1j*kim;

            % Phase offset
            if isfield(info1.acq,'phase1_offset')
                obj.pixelshift1 = round(pm1 * obj.NO_VIEWS * info1.acq.phase1_offset / obj.FOV);
            end

            % 2D data
            if strcmp(info2.pvm.spatdimenum,"2D") || strcmp(info2.pvm.spatdimenum,"<2D>")

                obj.dataType = "2D";

                % In case k-space trajectory was hacked by macro
                if isfield(info2.pvm,'ppggradamparray1')
                    obj.NO_VIEWS = length(info2.pvm.ppggradamparray1);
                end

                % Imaging k-space
                kspace = reshape(kspace,obj.NO_SLICES,obj.NO_SAMPLES,obj.nr_coils,obj.NO_VIEWS,obj.EXPERIMENT_ARRAY);
                kspace = permute(kspace,[3,5,6,7,1,4,2]);
          
            end

            % 3D data
            if strcmp(info2.pvm.spatdimenum,"3D") || strcmp(info2.pvm.spatdimenum,"<3D>")

                obj.dataType = "3D";

                % 2nd phase encoding direction
                obj.NO_VIEWS_2 = info1.acq.size(3);
                if isfield(info2.pvm,"matrix")
                    obj.NO_VIEWS = info2.pvm.encmatrix(3);
                end

                % Phase offset 2
                if isfield(info1.acq,'phase2_offset')
                    obj.pixelshift2 = round(pm2 * obj.NO_VIEWS_2 * info1.acq.phase2_offset/obj.FOV);
                end

                % Slice thickness
                obj.SLICE_THICKNESS = str2num(info2.pvm.slicethick);

                % 2nd phase encoding trajectory
                obj.pe2_centric_on = 0;
                if isfield(info2.pvm,"encsteps2")
                    obj.pe2_traj = info2.pvm.encsteps2;
                    obj.pe2_centric_on = 2;
                end
                if isfield(info2.pvm,'encvalues2')
                    obj.pe2_traj = round(info2.pvm.encvalues2 * (obj.NO_VIEWS_2/2-0.5));
                    obj.pe2_centric_on = 2;
                end

                % K-space
                kspace = reshape(kspace,obj.nr_coils,obj.NO_SAMPLES,obj.NO_VIEWS,obj.NO_VIEWS_2,obj.EXPERIMENT_ARRAY);
                kspace = permute(kspace,[1,5,6,7,3,4,2]);
            
            end

            % Flip readout if needed
            if flr
                kspace = flip(kspace,5);
            end

            % Coil intensity scaling
            if isfield(info2.pvm,'encchanscaling')
                for i = 1:obj.nr_coils
                    kspace(:,:,i,:) = kspace(:,:,i,:) * info2.pvm.encchanscaling(i);
                end
            end

            % Return the object
            for i = 1:obj.nr_coils
                obj.rawKspace{i} = kspace(i,:,:,:,:);
                sz = size(kspace,2:ndims(kspace));
                obj.rawKspace{i} = reshape(obj.rawKspace{i},sz);
            end
            obj.unsKspace = obj.rawKspace;

        end % importB




        % ---------------------------------------------------------------------------------
        % Read MRD footer
        % ---------------------------------------------------------------------------------
        function obj = readMrdFooter(obj, mrdfile)

            % Read information from the header and footer first
            fid = fopen(mrdfile,'r');
            val = fread(fid,4,'int32');
            xdim = val(1);
            ydim = val(2);
            zdim = val(3);
            dim4 = val(4);
            fseek(fid,18,'bof');
            datatype=fread(fid,1, 'uint16');
            datatype = dec2hex(datatype);
            fseek(fid,152,'bof');
            val = fread(fid,2, 'int32');
            dim5 = val(1);
            dim6 = val(2);
            no_samples = xdim;
            no_views = ydim;
            no_views_2 = zdim;
            no_slices = dim4;
            no_echoes = dim5;
            no_expts = dim6;

            % Determine datatype
            if size(datatype,2)>1
                onlydatatype = datatype(2);
                iscomplex = 2;
            else
                onlydatatype = datatype(1);
                iscomplex = 1;
            end
            switch onlydatatype
                case '0'
                    datasize = 1; % size in bytes
                case '1'
                    datasize = 1; % size in bytes
                case '2'
                    datasize = 2; % size in bytes
                case '3'
                    datasize = 2; % size in bytes
                case '4'
                    datasize = 4; % size in bytes
                case '5'
                    datasize = 4; % size in bytes
                case '6'
                    datasize = 8; % size in bytes
                otherwise
                    datasize = 4; % size in bytes
            end

            % Fast forward to beginning of footer
%           fseek(fid,512,'bof');

            fseek(fid,400,'bof');
            num2read = no_expts*no_echoes*no_slices*no_views_2*no_views*no_samples*iscomplex;
            fseek(fid,num2read*datasize,'cof');

            % Read the footer
            sample_filename = char(fread(fid,120,'uchar')');
            obj.mrdFooter = char(fread(fid,Inf,'uchar')');
            fclose(fid);

        end % readMrdFooter




        % ---------------------------------------------------------------------------------
        % Make MRD footer
        % ---------------------------------------------------------------------------------
        function obj = makeMrdFooter(obj, par)

            inputfooter = obj.mrdFooter;

            parameters = {':NO_SAMPLES no_samples, ',':NO_VIEWS no_views, ',':NO_VIEWS_2 no_views_2, ', ...
                ':NO_ECHOES no_echoes, ',':EXPERIMENT_ARRAY no_experiments, ',':NO_AVERAGES no_averages, ', ...
                ':VAR pe1_order, ',':VAR pe2_centric_on, ',':VAR slice_nav, ',':VAR radial_on, ', ...
                ':VAR frame_loop_on, ',':VAR tr, ',':VAR te, ', ...
                ':BATCH_SLICES batch_slices, ',':NO_SLICES no_slices, ' ...
                ':VIEWS_PER_SEGMENT views_per_seg, ',':DISCARD no_discard, ' ...
                ':VAR nav_on, ',':VAR tr_extra_us, ',':VAR te_us, ',':SLICE_THICKNESS gs_var, '

                };

            replacepars = {par.NoSamples,par.NoViews,par.NoViews2, ...
                par.NoEchoes,par.NoExperiments,par.NoAverages, ...
                par.peorder,par.pe2_centric_on,par.slicenav,par.radialon, ...
                par.frameloopon,par.tr,par.te, ...
                par.batchslices,par.NoSlices, ...
                par.viewspersegment,par.nodiscard, ...
                par.navon,par.tr_extra_us,par.te_us,par.SLICE_THICKNESS

                };

            for i = 1:length(parameters)

                txt = parameters{i};
                var = replacepars{i};

                pos = strfind(inputfooter,txt);

                if ~isempty(pos)
                    
                    oldtxtlength = strfind(inputfooter(pos+length(txt):pos+length(txt)+12),char(13))-1;

                    if contains(txt,'SLICE_THICKNESS')
                        commapos = [];
                        commapos = strfind(inputfooter(pos+length(txt):pos+length(txt)+6),' ');
                        inputfooter = insertAfter(inputfooter,pos+length(txt)+commapos,'      ');
                        pos = pos+commapos;
                    end
                 
                    newtext = [num2str(var),'     '];
                    newtext = newtext(1:6);

                    inputfooter = replaceBetween(inputfooter,pos+length(txt),pos+length(txt)+oldtxtlength-1,newtext);
                end

            end

            obj.newMrdFooter  = inputfooter;

        end % makeMrdFooter




        % ---------------------------------------------------------------------------------
        % Read RPR 
        % ---------------------------------------------------------------------------------
        function obj = readRprFile(obj, app, fn)

            try
                app.TextMessage('Reading RPR file ...');
                fid = fopen(fn,'r');
                obj.rprFile = char(fread(fid,Inf,'uchar')');
                fclose(fid);
                obj.rprFile_flag = true;
            catch ME
                obj.rprFile = '';
                app.TextMessage('WARNING: RPR file not found ...');
                app.TextMessage(ME.message);
                app.SetStatus(1);
                obj.rprFile_flag = false;
            end

        end % readRprFile




        % ---------------------------------------------------------------------------------
        % Write RPR file
        % ---------------------------------------------------------------------------------
        function obj = writeToRprFile(obj, filename)

            fid = fopen(filename,'wb');
            fwrite(fid,obj.newRprFile,'int8');
            fclose(fid);

        end % writeToRprFile




        % ---------------------------------------------------------------------------------
        % Make RPR file
        % ---------------------------------------------------------------------------------
        function obj = makeRprFile(obj, par)

            inputrpr = obj.rprFile;

            parameters = {
                ':EDITTEXT LAST_ECHO ',':EDITTEXT MAX_ECHO ', ...
                ':EDITTEXT LAST_EXPT ',':EDITTEXT MAX_EXPT ', ...
                ':EDITTEXT SAMPLES_DIM1 ',':EDITTEXT DATA_LENGTH1 ', ':EDITTEXT OUTPUT_SIZE1 ', ...
                ':EDITTEXT SAMPLES_DIM2 ',':EDITTEXT DATA_LENGTH2 ', ':EDITTEXT OUTPUT_SIZE2 ', ...
                ':EDITTEXT SAMPLES_DIM3 ',':EDITTEXT DATA_LENGTH3 ', ':EDITTEXT OUTPUT_SIZE3 ', ...
                ':EDITTEXT LAST_SLICE ',':EDITTEXT MAX_SLICE ', ...
                ':COMBOBOX FFT_DIM1 ',':COMBOBOX FFT_DIM2 ',':COMBOBOX FFT_DIM3 ', ...
                ':RADIOBUTTON VIEW_ORDER_1',':RADIOBUTTON VIEW_ORDER_2'
                };

            replacepars = {par.NoEchoes,par.NoEchoes, ...
                par.NoExperiments, par.NoExperiments, ...
                par.NoSamples, par.NoSamples, par.NoSamples, ...
                par.NoViews, par.NoViews, par.NoViews, ...
                par.NoViews2, par.NoViews2, par.NoViews2, ...
                par.NoSlices, par.NoSlices, ...
                par.NoSamples, par.NoViews, par.NoViews2, ...
                par.View1order, par.View2order
                };

            for i = 1:length(parameters)

                txt = parameters{i};
                var = replacepars{i};

                pos = strfind(inputrpr,txt);

                if ~isempty(pos)

                    if ~isstring(var)

                        oldtxtlength = strfind(inputrpr(pos+length(txt):pos+length(txt)+15),char(13))-1;
                        newtext = [num2str(var),'     '];
                        newtext = newtext(1:6);
                        inputrpr = replaceBetween(inputrpr,pos+length(txt),pos+length(txt)+oldtxtlength-1,newtext);

                    else

                        oldtxtlength = strfind(inputrpr(pos+length(txt):pos+length(txt)+15),char(13))-1;
                        newtext = strcat(" ",var,"           ");
                        newtext = extractBefore(newtext,12);
                        inputrpr = replaceBetween(inputrpr,pos+length(txt),pos+length(txt)+oldtxtlength-1,newtext);

                    end

                end

            end

            obj.newRprFile = inputrpr;

        end % makeRprFile




        % ---------------------------------------------------------------------------------
        % Write MRD file
        % ---------------------------------------------------------------------------------
        function obj = writeDataToMrd(obj, filename, parameters)

            % Description: Function to convert multidimensional complex data to MRD format file
            % Author: Ruslan Garipov / MR Solutions Ltd
            % Date: 17/04/2020
            % Inputs: string filename, N-dimensional data matrix, dimensions structure with the following fields:
            % .NoExperiments
            % .NoEchoes
            % .NoSlices
            % .NoSamples
            % .NoViews
            % .NoViews2
            % footer - int8 data type footer as copied from an MRD containing a copy of
            % the PPR file, including preceeding 120-byte zeros
            % Output: 1 if write was successful, 0 if not, -1 if failed early (e.g. the dimension checks)

            % data: multidimensional, complex float, with dimensions arranged
            % dimensions: structure

            data = obj.mrdKspace;
            footer = obj.newMrdFooter;

            % Get dimensions of the actual image data
            if (size(data,1)~=parameters.NoSamples)
                return;
            end
            if (size(data,2)>1)
                if (size(data,2)~=parameters.NoViews)
                    return;
                end
            end
            if (size(data,3)>1)
                if (size(data,3)~=parameters.NoViews2)
                    return;
                end
            end
            if (size(data,4)>1)
                if (size(data,4)~=parameters.NoSlices)
                    return;
                end
            end
            if (size(data,5)>1)
                if (size(data,5)~=parameters.NoEchoes)
                    return;
                end
            end
            if (size(data,6)>1)
                if (size(data,6)~=parameters.NoExperiments)
                    return;
                end
            end

            % For 3D data permute the 2nd and 3rd dimension
            if (size(data,3)>1)
                data = flip(permute(data,[1,3,2,4,5,6,7]),2);
            end

            header1 = zeros(128,1); % 4x128=512 bytes
            header1(1)  = parameters.NoSamples;
            header1(2)  = parameters.NoViews;
            header1(3)  = parameters.NoViews2;
            header1(4)  = parameters.NoSlices;
            header1(39) = parameters.NoEchoes;
            header1(40) = parameters.NoExperiments;

            % Set datatype - 'complex float'
            header1(5)  = hex2dec('150000');

            % Open new file for writing
            fid1 = fopen(filename,'wb');

            % Write 512 byte header
            fwrite(fid1,header1,'int32');

            % Convert to 1D array with alternating real and imag part of the data
            temp = data;
            temp = temp(:);
            a = real(temp);
            b = imag(temp);
            temp = transpose([a b]);
            temp = temp(:);

            % Write data at once
            fwrite(fid1,temp,'float32');

            fwrite(fid1,char(13));

            % write the footer
            fwrite(fid1,footer,'int8');

            % close file
            fclose(fid1);

        end % writeDataToMrd




        % ---------------------------------------------------------------------------------
        % Set data type parameters
        % ---------------------------------------------------------------------------------
        function obj = setDataParameters(obj, app)

            % 2D or 3D data
            if obj.NO_VIEWS_2 > 1
                obj.dataType = "3D";
                app.TextMessage('3D data detected ...');
                obj.multiSlab_flag = false;
                if obj.NO_SLICES > 1
                    app.TextMessage('Multi-slab data ...');
                    obj.multiSlab_flag = true;
                end
            else
                obj.dataType = "2D";
                app.TextMessage('2D data detected ...');
            end

            % Check for radial data acquisition
            if obj.radial_on == 1
                obj.dataType = "2Dradial";
                app.TextMessage('Radial data detected ...');
                % center the echo for radial acquistions
                % for i = 1:obj.nrCoils
                %    obj.rawKspace{i} = center_radial_echo(app,obj.rawKspace{i});
                % end
            end

            % More than 1 flip angle
            flipAngles = obj.alpha;
            if obj.VFA_size > 0
                obj.multiFlipAngles_flag = true;
                flipAngles = obj.VFA_angles(1:obj.VFA_size);
                app.TextMessage('Multi-flip angle data detected ...');
            end
            obj.flipAngleArray = flipAngles;

            % More than 1 echo
            if obj.NO_ECHOES > 1
                obj.multiEchoes_flag = true;
                app.TextMessage('Multi-echo data detected ...');
            end

            % More than 1 repetition
            if obj.EXPERIMENT_ARRAY > 1
                if obj.multiFlipAngles_flag
                    obj.EXPERIMENT_ARRAY = obj.EXPERIMENT_ARRAY/obj.VFA_size;
                end
                if obj.EXPERIMENT_ARRAY > 1
                    obj.multiRepetitions_flag = true;
                    app.TextMessage('Multi-dynamic data detected ...');
                end
            end

        end % setDataParameters




        % ---------------------------------------------------------------------------------
        % Permute 3D k-space data
        % ---------------------------------------------------------------------------------
        function obj = permute3Dkspace(obj)

            for i=1:obj.nrCoils

                switch ndims(obj.rawKspace{i})

                    case 3
                        obj.rawKspace{i} = permute(obj.rawKspace{i},[3,1,2]);

                    case 4
                        obj.rawKspace{i} = permute(obj.rawKspace{i},[4,2,3,1]);

                    case 5
                        obj.rawKspace{i} = permute(obj.rawKspace{i},[5,3,4,1,2]);

                    case 6
                        obj.rawKspace{i} = permute(obj.rawKspace{i},[6,4,5,1,2,3]);

                end

            end

            % Permute data to (X, Y, Z, NR, NFA, NE, SLAB)    ---- NOT FULLY TESTED -----
            for i=1:obj.nrCoils

                if ndims(obj.rawKspace{i})==4 && obj.multiFlipAngles_flag
                    obj.rawKspace{i} = permute(obj.rawKspace{i},[1,2,3,5,4,6,7]);
                end
                if ndims(obj.rawKspace{i})==4 && obj.multiEchoes_flag
                    obj.rawKspace{i} = permute(obj.rawKspace{i},[1,2,3,5,6,4,7]);
                end
                if ndims(obj.rawKspace{i})==4 && obj.multiSlab_flag
                    obj.rawKspace{i} = permute(obj.rawKspace{i},[1,2,3,5,6,7,4]);
                end
                if ndims(obj.rawKspace{i})==5 && obj.multiEchoes_flag && obj.multiFlipAngles_flag
                    obj.rawKspace{i} = permute(obj.rawKspace{i},[1,2,3,6,4,5,7]);
                end
                if ndims(obj.rawKspace{i})==5 && obj.multiEchoes_flag && obj.multiRepetitions_flag
                    obj.rawKspace{i} = permute(obj.rawKspace{i},[1,2,3,4,6,5,7]);
                end
                if ndims(obj.rawKspace{i})==5 && obj.multiRepetitions_flag && obj.multiFlipAngles_flag
                    obj.rawKspace{i} = permute(obj.rawKspace{i},[1,2,3,4,5,6,7]);
                end

            end

            % Flip odd echoes for multi-echo T2*
             if contains(obj.PPL,'flash') && ~(obj.retroRecoScan_flag == true || obj.proudRecoScan_flag == true)
                if obj.NO_ECHOES > 1
                    for j = 2:2:obj.NO_ECHOES
                        for i = 1:obj.nrCoils
                            obj.rawKspace{i}(:,:,:,:,:,j,:) = flip(obj.rawKspace{i}(:,:,:,:,:,j,:),1);
                        end
                    end
                end
            end

        end % permute3DKspace




        % ---------------------------------------------------------------------------------
        % Permute 2D k-space data
        % ---------------------------------------------------------------------------------
        function obj = permute2Dkspace(obj)

            for i=1:obj.nrCoils

                switch ndims(obj.rawKspace{i})

                    case 2
                        obj.rawKspace{i} = permute(obj.rawKspace{i},[2,1]);

                    case 3
                        if obj.NO_SLICES > 1
                            obj.rawKspace{i} = permute(obj.rawKspace{i},[3,2,1]);
                        else
                            obj.rawKspace{i} = permute(obj.rawKspace{i},[3,2,4,1]);
                        end

                    case 4
                        if obj.NO_SLICES > 1
                            obj.rawKspace{i} = permute(obj.rawKspace{i},[4,3,2,1]);
                        else
                            obj.rawKspace{i} = permute(obj.rawKspace{i},[4,3,5,1,2]);
                        end

                    case 5
                        if obj.NO_SLICES > 1
                            obj.rawKspace{i} = permute(obj.rawKspace{i},[5,4,3,1,2]);
                        else
                            obj.rawKspace{i} = permute(obj.rawKspace{i},[5,4,6,1,2,3]);
                        end

                    case 6
                        if obj.NO_SLICES > 1
                            obj.rawKspace{i} = permute(obj.rawKspace{i},[6,5,4,1,2,3]);
                        else
                            obj.rawKspace{i} = permute(obj.rawKspace{i},[6,5,7,1,2,3,4]);
                        end

                end

            end

            % Permute data to (X, Y, Z, NR, NFA, NE)    ---- NOT FULLY TESTED -----
            for i=1:obj.nrCoils

                if ndims(obj.rawKspace{i})==4 && obj.multiFlipAngles_flag
                    obj.rawKspace{i} = permute(obj.rawKspace{i},[1,2,3,5,4,6]);
                end
                if ndims(obj.rawKspace{i})==4 && obj.multiEchoes_flag
                    obj.rawKspace{i} = permute(obj.rawKspace{i},[1,2,3,5,6,4]);
                end
                if ndims(obj.rawKspace{i})==5 && obj.multiEchoes_flag && obj.multiFlipAngles_flag
                    obj.rawKspace{i} = permute(obj.rawKspace{i},[1,2,3,6,4,5]);
                end
                if ndims(obj.rawKspace{i})==5 && obj.multiEchoes_flag && obj.multiRepetitions_flag
                    obj.rawKspace{i} = permute(obj.rawKspace{i},[1,2,3,4,6,5]);
                end
                if ndims(obj.rawKspace{i})==5 && obj.multiRepetitions_flag && obj.multiFlipAngles_flag
                    obj.rawKspace{i} = permute(obj.rawKspace{i},[1,2,3,4,5,6]);
                end

            end

            % Flip odd echoes for multi-echo T2*
            if contains(obj.PPL,'flash') && ~(obj.retroRecoScan_flag == true || obj.proudRecoScan_flag == true || obj.frame_loop_on == true)
                if obj.NO_ECHOES > 1
                    for j = 2:2:obj.NO_ECHOES
                        for i = 1:obj.nrCoils
                           obj.rawKspace{i}(:,:,:,:,:,j) = flip(obj.rawKspace{i}(:,:,:,:,:,j),1);
                        end
                    end
                end
            end
           
        end % permute2DKspace




        % ---------------------------------------------------------------------------------
        % Sort 2D k-space data based on scanner k-space rtable.rtv
        % ---------------------------------------------------------------------------------
        function obj = sortScanner2DKspaceMRD(obj, app, kTable)

            app.TextMessage('Sorting k-space ...');

            for coil = 1:obj.nrCoils

                app.TextMessage(strcat('Sorting coil',{' '},num2str(coil),' ...'));

                % Coil data
                kSpaceRaw = obj.rawKspace{coil};

                % Dimensions
                [dimx,dimy,dimz,nrrep,nrfa,nrte] = size(kSpaceRaw);
                kSpace = zeros(size(kSpaceRaw));
                trajectory = ones(dimx*dimy*dimz*nrrep*nrfa*nrte,7);

                % Navigator yes or no, for RARE echo train correction
                firsty = 0;
                if obj.nav_on == 1
                    firsty = obj.VIEWS_PER_SEGMENT;
                end

                % Counter
                tcnt = 1;

                % Loop over all dimensions
                for teCounter=1:nrte

                    for faCounter=1:nrfa

                        for repCounter=1:nrrep

                            app.TextMessage(strcat('Sorting dynamic',{' '},num2str(nrrep),' ...'));

                            for z=1:dimz

                                % Determine shift of echoes based on navigator echoes
                                if firsty>0

                                    % Calculate phase difference between even and odd echoes
                                    PHshift = zeros(firsty,1);
                                    for nav=1:firsty
                                        navecho1 = squeeze(kSpaceRaw(round(dimx/2)+1,1,z,repCounter,faCounter,teCounter));
                                        navecho2 = squeeze(kSpaceRaw(round(dimx/2)+1,nav,z,repCounter,faCounter,teCounter));
                                        PHshift(nav) = phase(navecho2) - phase(navecho1);
                                    end

                                    % Sorting including phase correction based on navigator
                                    for j = firsty+1:dimy

                                        idx = mod(j-firsty+1,firsty)+1;
                                        y = kTable(j)+round(firsty/2);
                                   
                                        kSpace(:,y,z,repCounter,faCounter,teCounter) = kSpaceRaw(:,j,z,repCounter,faCounter,teCounter).*exp(-1i*PHshift(idx));

                                        for x = 1:dimx

                                            % Fill the k-space trajectory array
                                            trajectory(tcnt,1) = x;
                                            trajectory(tcnt,2) = y;
                                            trajectory(tcnt,3) = z;
                                            trajectory(tcnt,4) = repCounter;
                                            trajectory(tcnt,5) = faCounter;
                                            trajectory(tcnt,6) = teCounter;
                                            tcnt = tcnt + 1;

                                        end

                                    end

                                else

                                    % Sorting without phase correction
                                    for j = firsty+1:dimy
                                        y = kTable(j)+round(firsty/2);
                                        kSpace(:,y,z,repCounter,faCounter,teCounter) = kSpaceRaw(:,j,z,repCounter,faCounter,teCounter);

                                        for x = 1:dimx

                                            % Fill the k-space trajectory array
                                            trajectory(tcnt,1) = x;
                                            trajectory(tcnt,2) = y;
                                            trajectory(tcnt,3) = z;
                                            trajectory(tcnt,4) = repCounter;
                                            trajectory(tcnt,5) = faCounter;
                                            trajectory(tcnt,6) = teCounter;
                                            tcnt = tcnt + 1;

                                        end

                                    end

                                end

                            end

                        end

                    end

                end

                obj.rawKspace{coil} = kSpace;

            end

            % Trajectory
            obj.seqTrajectory = trajectory;
            obj.validTrajectory_flag = true;

        end % sortScannerKspaceMRD




        % ---------------------------------------------------------------------------------
        % Sort 3D k-space data based on scanner k-space rtable.rtv
        % ---------------------------------------------------------------------------------
        function obj = sortScanner3DKspaceMRD(obj, app, kTable)

            app.TextMessage('Sorting k-space ...');

            for coil = 1:obj.nrCoils

                app.TextMessage(strcat('Sorting coil',{' '},num2str(coil),' ...'));

                % Coil data
                kSpaceRaw = obj.rawKspace{coil};

                % Dimensions
                [dimx,dimy,dimz,nrrep,nrfa,nrte] = size(kSpaceRaw);
                kSpace = zeros(size(kSpaceRaw));
                trajectory = ones(dimx*dimy*dimz*nrrep*nrfa*nrte,7);

                % Navigator yes or no, for RARE echo train correction
                firsty = 0;
                if obj.nav_on == 1
                    firsty = obj.VIEWS_PER_SEGMENT;
                end

                % Counter
                tcnt = 1;

                % Loop over all dimensions
                for teCounter=1:nrte

                    for faCounter=1:nrfa

                        for repCounter=1:nrrep

                            app.TextMessage(strcat('Sorting dynamic',{' '},num2str(nrrep),' ...'));

                            for z=1:dimz

                                for j = firsty+1:dimy

                                    y = kTable(j)+round(firsty/2);
   
                                    kSpace(:,y,z,repCounter,faCounter,teCounter) = kSpaceRaw(:,j,z,repCounter,faCounter,teCounter);

                                    for x = 1:dimx

                                        % Fill the k-space trajectory array
                                        trajectory(tcnt,1) = x;
                                        trajectory(tcnt,2) = y;
                                        trajectory(tcnt,3) = z;
                                        trajectory(tcnt,4) = repCounter;
                                        trajectory(tcnt,5) = faCounter;
                                        trajectory(tcnt,6) = teCounter;
                                        tcnt = tcnt + 1;

                                    end

                                end

                            end

                        end

                    end

                end

                obj.rawKspace{coil} = kSpace;

            end

            % Trajectory
            obj.seqTrajectory = trajectory;
            obj.validTrajectory_flag = true;

        end % sortScanner3DKspaceMRD




        % ---------------------------------------------------------------------------------
        % Sort 2D k-space data, using gp_var_mul
        % ---------------------------------------------------------------------------------
        function obj = sort2DKspaceMRD(obj, app)

            app.TextMessage('Sorting k-space ...');

            obj.rawKspace = {};
            obj.nsaSpace = [];
            obj.fillingSpace = [];

            % Size of the image matrix
            dimx = obj.NO_SAMPLES_ORIG;
            dimy = obj.NO_VIEWS;
            nrSlices = obj.NO_SLICES;
            nrRep = obj.EXPERIMENT_ARRAY;
            arrayLength = obj.NO_VIEWS_ORIG;
            frames = app.NREditField.Value;

            for coil = 1:obj.nrCoils

                app.TextMessage(strcat('Sorting coil',{' '},num2str(coil),' ...'));

                % Unsorted k-space for each coil
                ukspace = obj.unsKspace{coil};

                % Pre-allocate large matrices
                aframes = frames;
                aframes(aframes==1) = 2; % allocate at least 2 frames, because preallocating 1 does not work
                kSpace = zeros(dimx, dimy, nrSlices, aframes);
                avgSpace = zeros(dimx, dimy, nrSlices, aframes);
                trajectory = ones(dimx * arrayLength * nrSlices * nrRep, 7);

                % Fill the ky-space locations
                ky = zeros(arrayLength, 1);
                i = 1:arrayLength;
                ky(i) = int16(obj.gp_var_mul(i)) + round(dimy/2) + 1;     % contains the y-coordinates of the custom k-space sequentially

                % Duplicate for multiple acquired repetitions
                ky = repmat(ky,1,nrRep * nrSlices);

                % Number of k-space points per frame
                kPointsPerFrame = round(obj.NO_VIEWS_ORIG * nrRep / frames);

                % Trajectory counter
                cnt = 0;

                % Loop over slices
                for slice = 1:nrSlices
                  
                    % Loop over desired number of frames
                    for dynamic = 1:frames

                        app.TextMessage(strcat('Sorting dynamic',{' '},num2str(dynamic),' ...'));

                        % Code below not correct for slices !!!!
                        wStart = (dynamic - 1) * kPointsPerFrame + 1; % starting k-line for specific frame
                        wEnd = dynamic * kPointsPerFrame;             % ending k-line for specific frame
                        if wEnd > arrayLength * nrRep
                            wEnd = arrayLength * nrRep;
                        end

                        for w = wStart:wEnd

                            for x = 1:dimx

                                kSpace(x,ky(w),slice,dynamic) = kSpace(x,ky(w),slice,dynamic) + ukspace((w - 1) * dimx + x);
                                avgSpace(x,ky(w),slice,dynamic) = avgSpace(x,ky(w),slice,dynamic) + 1;

                                % Fill the k-space trajectory array for viewing purposes
                                cnt = cnt + 1;
                                trajectory(cnt,1) = x;
                                trajectory(cnt,2) = ky(w);
                                trajectory(cnt,3) = slice;
                                trajectory(cnt,4) = dynamic;

                            end

                        end

                    end

                end

                % Normalize by dividing through number of averages
                kSpace = kSpace./avgSpace;
                kSpace(isnan(kSpace)) = complex(0);
                kSpace = kSpace(:,:,:,1:frames);

                % Return the object
                obj.rawKspace{coil} = kSpace(:,:,:,1:frames);

            end

            % For k-space filling visualization
            obj.nsaSpace = avgSpace(:,:,:,1:frames);
            fillingKSpace = avgSpace./avgSpace;
            fillingKSpace(isnan(fillingKSpace)) = 0;
            obj.fillingSpace = fillingKSpace(:,:,:,1:frames);

            % Trajectory
            obj.seqTrajectory = trajectory;

        end % sort2DKspaceMRD




        % ---------------------------------------------------------------------------------
        % Sort 3D k-space data
        % ---------------------------------------------------------------------------------
        function obj = sort3DKspaceMRD(obj, app)

            app.TextMessage('Sorting k-space ...');

            obj.rawKspace = {};
            obj.nsaSpace = [];
            obj.fillingSpace = [];

            % Size of the image matrix (X, Y, Z, NR, NFA, NE)
            dimx = obj.NO_SAMPLES_ORIG;
            dimy = obj.NO_VIEWS;
            dimz = obj.NO_VIEWS_2;
            nRep = obj.EXPERIMENT_ARRAY;
            arrayLength = obj.NO_VIEWS_ORIG*dimz;
            dimyOrig = obj.NO_VIEWS_ORIG;
            frames = app.NREditField.Value;

            for coil = 1:obj.nrCoils

                app.TextMessage(strcat('Sorting coil',{' '},num2str(coil),' ...'));

                % Unsorted k-space for each coil
                unsortedKspace = obj.unsKspace{coil};

                % Preallocate memory for the matrices
                aFrames = frames;
                aFrames(aFrames==1)=2;
                kSpace = zeros(dimx, dimy, dimz, aFrames); % Allocate at least 2 frames, because preallocating 1 does not work
                avgSpace = zeros(dimx, dimy, dimz, aFrames);
                trajectory = ones(dimx*arrayLength*nRep,7);

                % Centric or linear k-space ordering for views2
                kzp = zeros(dimz,1);
                if parameters.pe2_centric_on == 1
                    kzp(1) = 0;
                    for i = 1:dimz-1
                        kzp(i+1) = (-1)^i * round(i/2);
                    end
                    kzp = kzp - min(kzp) + 1;
                else
                    kzp = 1:dimz;
                end

                % Fill the ky-space locations
                cnt1 = 1;
                cnt = 1;
                ky = zeros(arrayLength,1);
                kz = zeros(arrayLength,1);
                for i = 1:arrayLength
                    ky(i) = int16(parameters.gp_var_mul(cnt1)) + round(dimy/2) + 1;
                    kz(i) = kzp(cnt);
                    cnt = cnt + 1;
                    if cnt > dimz
                        cnt = 1;
                        cnt1 = cnt1 + 1;
                        cnt1(cnt1 > dimyOrig) = 1;
                    end
                end

                % Duplicate for multiple acquired repetitions
                ky = repmat(ky,1,nRep);
                kz = repmat(kz,1,nRep);

                % Number of k-space points per frame
                kPointsPerFrame = round(dimyOrig * dimz * nRep / frames);
                app.TextMessage(strcat('k-lines per dynamic =',{' '},num2str(kPointsPerFrame),' ...'));

                % Trajectory counter
                cnt = 0;

                % Loop over desired number of frames
                for dynamic = 1:frames

                    app.TextMessage(strcat('Sorting dynamic',{' '},num2str(dynamic),' ...'));

                    wStart = (dynamic - 1) * kPointsPerFrame + 1; % starting k-line for specific frame
                    wEnd = dynamic * kPointsPerFrame;             % ending k-line for specific frame
                    wEnd(wEnd > arrayLength*nRep) = arrayLength * nRep;

                    % Loop over y-dimension (views)
                    for w = wStart:wEnd

                        % Loop over x-dimension (readout)
                        for x = 1:dimx

                            kSpace(x,ky(w),kz(w),dynamic) = kSpace(x,ky(w),kz(w),dynamic) + unsortedKspace((w - 1) * dimx + x);
                            avgSpace(x,ky(w),kz(w),dynamic) = avgSpace(x,ky(w),kz(w),dynamic) + 1;

                            % Fill the k-space trajectory array
                            cnt = cnt + 1;
                            trajectory(cnt,1) = x;
                            trajectory(cnt,2) = ky(w);
                            trajectory(cnt,3) = kz(w);
                            trajectory(cnt,4) = dynamic;

                        end

                    end

                end

                % Normalize by dividing through number of averages
                kSpace = kSpace./avgSpace;
                kSpace(isnan(kSpace)) = complex(0);
                obj.rawKspace{coil} = kSpace(:,:,:,1:frames);

            end

            % For k-space filling visualization
            obj.nsaSpace = avgSpace(:,:,:,1:frames);
            fillSpace = avgSpace./avgSpace;
            fillSpace(isnan(fillSpace)) = 0;
            obj.fillingSpace = fillSpace(:,:,:,1:frames);

            % Trajectory
            obj.seqTrajectory = trajectory;

        end % sort3DKspaceMRD




        % ---------------------------------------------------------------------------------
        % Sort PROUD trajectory data
        % ---------------------------------------------------------------------------------
        function obj = sortProudKspaceMRD(obj, app)

            app.TextMessage('Sorting k-space ...');

            obj.rawKspace = {};
            obj.nsaSpace = [];
            obj.fillingSpace = [];

            % Size of the image matrix
            dimx = obj.NO_SAMPLES;
            dimy = obj.NO_VIEWS;
            dimz = obj.NO_VIEWS_2;
            nRep = obj.EXPERIMENT_ARRAY;
            frames = app.NREditField.Value;

            for coil = 1:obj.nrCoils

                app.TextMessage(strcat('Sorting coil',{' '},num2str(coil),' ...'));

                % Unsorted k-space for each coil
                unsortedKspace = obj.unsKspace{coil};

                % Preallocate memory for the matrices
                aFrames = frames;
                aFrames(aFrames==1)=2; % Allocate at least 2 frames, because preallocating 1 does not work
                kSpace = zeros(dimx, dimy, dimz, aFrames);
                avgSpace = zeros(dimx, dimy, dimz, aFrames);
                trajectory = ones(dimx*dimy*dimz*nRep,7);

                % Fill the ky and kz k-space locations
                ky = zeros(length(obj.proudArray),1);
                kz = zeros(length(obj.proudArray),1);
                for i = 1:length(obj.proudArray)
                    ky(i) = int8(obj.proudArray(1,i)) + round(dimy/2) + 1;     % contains the y-coordinates of the custom k-space sequentially
                    kz(i) = int8(obj.proudArray(2,i)) + round(dimz/2) + 1;   % contains the z-coordinates of the custom k-space sequentially
                end

                % Duplicate for multiple acquired repetitions
                ky = repmat(ky,1,nRep+1);
                kz = repmat(kz,1,nRep+1);

                % Number of k-space points per frame
                klinesperframe = round(dimy*dimz*nRep/frames);
                app.TextMessage(strcat('k-lines per frame =',{' '},num2str(klinesperframe),' ...'));

                % Trajectory counter
                cnt = 0;

                % Loop over desired number of frames
                for t = 1:frames

                    app.TextMessage(strcat('Sorting dynamic',{' '},num2str(t),' ...'));

                    wstart = (t - 1) * klinesperframe + 1; % starting k-line for specific frame
                    wend = t * klinesperframe;             % ending k-line for specific frame
                    if wend > dimy*dimz*nRep
                        wend = dimy*dimz*nRep;
                    end

                    % Loop over y- and z-dimensions (views and views2)
                    for w = wstart:wend

                        % Loop over x-dimension (readout)
                        for x = 1:dimx

                            % Fill the k-space and signal averages matrix
                            kSpace(x,ky(w),kz(w),t) = kSpace(x,ky(w),kz(w),t) + unsortedKspace((w-1)*dimx + x);
                            avgSpace(x,ky(w),kz(w),t) = avgSpace(x,ky(w),kz(w),t) + 1;

                            % Fill the k-space trajectory array
                            cnt = cnt + 1;
                            trajectory(cnt,1) = x;
                            trajectory(cnt,2) = ky(w);
                            trajectory(cnt,3) = kz(w);
                            trajectory(cnt,4) = t;

                        end

                    end

                end

                % Normalize by dividing through number of averages
                kSpace = kSpace./avgSpace;
                kSpace(isnan(kSpace)) = complex(0);
                obj.rawKspace{coil} = kSpace(:,:,:,1:frames);

            end

            % For k-space filling visualization
            obj.nsaSpace = avgSpace(:,:,:,1:frames);
            fillingkSpace = avgSpace./avgSpace;
            fillingkSpace(isnan(fillingkSpace)) = 0;
            obj.fillingSpace = fillingkSpace(:,:,:,1:frames);

            % Trajectory
            obj.seqTrajectory = trajectory;

        end % sortProudKspaceMRD




        % ---------------------------------------------------------------------------------
        % Remove navigator if present
        % ---------------------------------------------------------------------------------
        function obj = chopNav(obj)

            % Chop of the navigator if present
            if obj.slice_nav == 1

                discard = obj.no_samples_discard + obj.no_samples_nav;
                for i=1:obj.nrCoils
                    obj.rawKspace{i} = obj.rawKspace{i}(discard+1:end,:,:,:,:,:);
                end
                obj.nsaSpace = obj.nsaSpace(discard+1:end,:,:,:,:,:);
                obj.fillingSpace = obj.fillingSpace(discard+1:end,:,:,:,:,:);
                obj.NO_SAMPLES = obj.NO_SAMPLES - discard;

            end

        end % chopNav




        % ---------------------------------------------------------------------------------
        % Apply Tukey k-space filter
        % ---------------------------------------------------------------------------------
        function obj = applyTukey(obj)

            filterwidth = 0.1;
            dimx = size(obj.rawKspace{1},1);
            dimy = size(obj.rawKspace{1},2);
            dimz = size(obj.rawKspace{1},3);

            switch obj.dataType

                case {"2D","2Dradial"}

                    kSpaceSum = zeros(dimx,dimy);
                    for i=1:obj.nrCoils
                        kSpaceSum = kSpaceSum + squeeze(sum(obj.rawKspace{i},[3 4 5 6 7 8]));
                    end
                    [row, col] = find(ismember(kSpaceSum, max(kSpaceSum(:))));
                    for i = 1:obj.nrCoils
                        flt = proudData.circTukey2D(dimx,dimy,row,col,filterwidth);
                        tukeyFilter(:,:,1,1,1,1) = flt;
                        obj.rawKspace{i} = obj.rawKspace{i}.*tukeyFilter;
                    end

                case "3D"

                    kSpaceSum = zeros(dimx,dimy,dimz);
                    for i=1:obj.nrCoils
                        kSpaceSum = kSpaceSum + squeeze(sum(obj.rawKspace{i},[4 5 6 7 8]));
                    end
                    [~,idx] = max(kSpaceSum(:));
                    [lev, row, col] = ind2sub(size(kSpaceSum),idx);
                    for i=1:obj.nrCoils
                        flt = proudData.circTukey3D(dimx,dimy,dimz,lev,row,col,filterwidth);
                        tukeyFilter(:,:,:,1,1,1) = flt;
                        obj.rawKspace{i} = obj.rawKspace{i}.*tukeyFilter;
                    end

            end

        end % applyTukey




        % ---------------------------------------------------------------------------------
        % Image reconstruction: compressed sensing 2D CINE
        % ---------------------------------------------------------------------------------
        function obj = csReco2DCine(obj,app,flipAngle)

            % CS regularization parameters
            LW = app.WVxyzEditField.Value;
            TVxy = app.TVxyzEditField.Value;
            LR = app.LRxyzEditField.Value;
            TVd = app.TVtimeEditField.Value;

            kSpaceRaw = cell(obj.nrCoils);
            for i=1:obj.nrCoils
                kSpaceRaw{i} = obj.rawKspace{i}(:,:,:,:,flipAngle,:);
            end

            % kSpaceRaw = {coil}[X Y slices NR FA NE z]
            %                    1 2    3    4 5  6  7
            dimx = app.XEditField.Value;
            dimy = app.YEditField.Value;
            dimz = size(kSpaceRaw{1},3);
            dimd = app.NREditField.Value;
            dimte = size(kSpaceRaw{1},6);

            % Resize k-space to next power of 2
            for i = 1:obj.nrCoils
                kSpaceRaw{i} = bart(app,['resize -c 0 ',num2str(dimx),' 1 ',num2str(dimy),' 2 ',num2str(dimz),' 3 ',num2str(dimd)],kSpaceRaw{i});
            end

            % Put all data in a normal matrix
            kSpace = zeros(dimx,dimy,dimz,dimd,1,dimte,1,obj.nrCoils);
            for i = 1:obj.nrCoils
                kSpace(:,:,:,:,:,:,1,i) = kSpaceRaw{i}*obj.coilActive_flag(i);
            end

            % Bart dimensions
            % 	READ_DIM,       1   z
            % 	PHS1_DIM,       2   y
            % 	PHS2_DIM,       3   x
            % 	COIL_DIM,       4   coils
            % 	MAPS_DIM,       5   sense maps
            % 	TE_DIM,         6   TE
            % 	COEFF_DIM,      7
            % 	COEFF2_DIM,     8
            % 	ITER_DIM,       9
            % 	CSHIFT_DIM,     10
            % 	TIME_DIM,       11  dynamics
            % 	TIME2_DIM,      12
            % 	LEVEL_DIM,      13
            % 	SLICE_DIM,      14  slices
            % 	AVG_DIM,        15

            %                             1  2  3  4  5  6  7  8  9  10 11 12 13 14
            kSpacePics = permute(kSpace,[7 ,2 ,1 ,8 ,9 ,6 ,5 ,10,11,12,4 ,13,14,3 ]);

            % wavelet in y and x spatial dimensions 2^1 + 2^2 = 6
            % total variation in y and x spatial dimensions 2^1 + 2^2 = 6
            % total variation in TE and dynamic dimension 2^5 + 2^10 = 1056

            if obj.nrCoils>1 && app.AutoSensitivityCheckBox.Value==1

                % ESPIRiT reconstruction
                TextMessage(app,'ESPIRiT reconstruction ...');

                % Calculate coil sensitivity maps with ecalib bart function
                kSpacePicsSum = sum(kSpacePics,[11,12]);
                sensitivities = bart(app,'ecalib -S -I -a', kSpacePicsSum);      % ecalib with softsense

                % Pics reconstuction
                picsCommand = 'pics -S';
                if LW>0
                    picsCommand = [picsCommand,' -RW:6:0:',num2str(LW)];
                end
                if TVxy>0
                    picsCommand = [picsCommand,' -RT:6:0:',num2str(TVxy)];
                end
                if LR>0
                    % Locally low-rank in the spatial domain
                    blocksize = round(max([dimx dimy])/16);  % Block size
                    app.TextMessage(strcat('Low-rank block size =',{' '},num2str(blocksize)));
                    picsCommand = [picsCommand,' -RL:6:6:',num2str(LR),' -b',num2str(blocksize)];
                end
                if TVd>0
                    picsCommand = [picsCommand,' -RT:1056:0:',num2str(TVd)];
                end
                imageTmp = bart(app,picsCommand,kSpacePics,sensitivities);

                % Sum of squares reconstruction
                imageReg = abs(bart(app,'rss 16', imageTmp));
                
                % Phase images
                phaseImageReg = angle(imageTmp(:,:,:,:,1,:));

            end

            if obj.nrCoils==1 || app.AutoSensitivityCheckBox.Value==0

                % Sensitivity correction
                sensitivities = ones(1,dimy,dimx,obj.nrCoils,1,1,1,1,1,1,1,1,1,dimz);
                for i = 1:obj.nrCoils
                    sensitivities(:,:,:,i,:) = sensitivities(:,:,:,i,:)*obj.coilSensitivities(i)*obj.coilActive_flag(i);
                end

                % Pics reconstuction
                picsCommand = 'pics -S';
                if LW>0
                    picsCommand = [picsCommand,' -RW:6:0:',num2str(LW)];
                end
                if TVxy>0
                    picsCommand = [picsCommand,' -RT:6:0:',num2str(TVxy)];
                end
                if LR>0
                    % Locally low-rank in the spatial domain
                    blocksize = round(max([dimx dimy])/16);  % Block size
                    app.TextMessage(strcat('Low-rank block size =',{' '},num2str(blocksize)));
                    picsCommand = [picsCommand,' -RL:6:6:',num2str(LR),' -b',num2str(blocksize)];
                end
                if TVd>0
                    picsCommand = [picsCommand,' -RT:1056:0:',num2str(TVd)];
                end
                imageTmp = bart(app,picsCommand,kSpacePics,sensitivities);

                % Modulus image
                imageReg = abs(imageTmp);

                % Phase images
                phaseImageReg = angle(imageTmp);

            end

            % Rearrange to correct orientation: x, y, slices, dynamics, flip-angle, TE (cine)
            imageReg = permute(imageReg,[3 2 14 11 4 6 1 5 7 8 9 10 12 13 15]);
            phaseImageReg = permute(phaseImageReg,[3 2 14 11 4 6 1 5 7 8 9 10 12 13 15]);

            % X Y slices NR flip-angles echo-times
            imagesOut = flip(flip(imageReg,2),3);
            phaseImagesOut = flip(flip(phaseImageReg,2),3);

            % Return the images object
            for i = 1:dimd
                for j = 1:dimte
                    obj.images(:,:,:,i,flipAngle,j) = imagesOut(:,:,:,i,1,j);
                    obj.phaseImages(:,:,:,i,flipAngle,j) = phaseImagesOut(:,:,:,i,1,j);
                    obj.phaseImagesOrig(:,:,:,i,flipAngle,j) = phaseImagesOut(:,:,:,i,1,j);
                end
            end

        end % csReco2DCine




        % ---------------------------------------------------------------------------------
        % Image reconstruction: compressed sensing 2D
        % ---------------------------------------------------------------------------------
        function obj = csReco2D(obj,app,flipAngle,echoTime)

            % CS regularization parameters
            LW = app.WVxyzEditField.Value;
            TVxy = app.TVxyzEditField.Value;
            LR = app.LRxyzEditField.Value;
            TVd = app.TVtimeEditField.Value;

            kSpaceRaw = cell(obj.nrCoils);
            for i=1:obj.nrCoils
                kSpaceRaw{i} = obj.rawKspace{i}(:,:,:,:,flipAngle,echoTime);
            end

            if app.bartDetected_flag
                % CS reco with BART

                % kSpaceRaw = {coil}[X Y slices NR]
                %                    1 2    3    4
                dimx = app.XEditField.Value;
                dimy = app.YEditField.Value;
                dimz = size(kSpaceRaw{1},3);
                dimd = app.NREditField.Value;

                % Resize k-space to next power of 2
                for i = 1:obj.nrCoils
                    kSpaceRaw{i} = bart(app,['resize -c 0 ',num2str(dimx),' 1 ',num2str(dimy),' 2 ',num2str(dimz),' 3 ',num2str(dimd)],kSpaceRaw{i});
                end

                % kspace data x,y,NR,slices,coils
                kSpace = zeros(dimx,dimy,dimz,dimd,1,obj.nrCoils);
                for i = 1:obj.nrCoils
                    kSpace(:,:,:,:,:,i) = kSpaceRaw{i}*obj.coilActive_flag(i);
                end

                % Bart dimensions
                % 	READ_DIM,       1   z
                % 	PHS1_DIM,       2   y
                % 	PHS2_DIM,       3   x
                % 	COIL_DIM,       4   coils
                % 	MAPS_DIM,       5   sense maps
                % 	TE_DIM,         6
                % 	COEFF_DIM,      7
                % 	COEFF2_DIM,     8
                % 	ITER_DIM,       9
                % 	CSHIFT_DIM,     10
                % 	TIME_DIM,       11  dynamics
                % 	TIME2_DIM,      12
                % 	LEVEL_DIM,      13
                % 	SLICE_DIM,      14  slices
                % 	AVG_DIM,        15

                %                             0  1  2  3  4  5  6  7  8  9  10 11 12 13
                %                             1  2  3  4  5  6  7  8  9  10 11 12 13 14
                kSpacePics = permute(kSpace,[5 ,2 ,1 ,6 ,7 ,8 ,9 ,10,11,12,4 ,13,14,3 ]);

                % wavelet in y and x spatial dimensions 2^1+2^2=6
                % total variation in y and x spatial dimensions 2^1+2^2=6
                % total variation in dynamic dimension 2^10 = 1024

                if obj.nrCoils>1 && app.AutoSensitivityCheckBox.Value==1

                    % ESPIRiT reconstruction
                    TextMessage(app,'ESPIRiT reconstruction ...');

                    % Calculate coil sensitivity maps with ecalib bart function
                    kSpacePicsSum = sum(kSpacePics,[11,12]);
                    sensitivities = bart(app,'ecalib -S -I -a', kSpacePicsSum);      % ecalib with softsense

                    % Pics reconstuction
                    picsCommand = 'pics -S';
                    if LW>0
                        picsCommand = [picsCommand,' -RW:6:0:',num2str(LW)];
                    end
                    if TVxy>0
                        picsCommand = [picsCommand,' -RT:6:0:',num2str(TVxy)];
                    end
                    if LR>0
                        % Locally low-rank in the spatial domain
                        blocksize = round(max([dimx dimy])/16);  % Block size
                        app.TextMessage(strcat('Low-rank block size =',{' '},num2str(blocksize)));
                        picsCommand = [picsCommand,' -RL:6:6:',num2str(LR),' -b',num2str(blocksize)];
                    end
                    if TVd>0
                        picsCommand = [picsCommand,' -RT:1024:0:',num2str(TVd)];
                    end
                    imageTmp = bart(app,picsCommand,kSpacePics,sensitivities);

                    % Sum of squares reconstruction
                    imageReg = abs(bart(app,'rss 16', imageTmp));

                    % Phase image
                    phaseImageReg = angle(imageTmp(:,:,:,:,1,:));
                  
                end

                if obj.nrCoils==1 || app.AutoSensitivityCheckBox.Value==0

                    % Sensitivity correction
                    sensitivities = ones(1,dimy,dimx,obj.nrCoils,1,1,1,1,1,1,1,1,1,dimz);
                    for i = 1:obj.nrCoils
                        sensitivities(:,:,:,i,:) = sensitivities(:,:,:,i,:)*obj.coilSensitivities(i)*obj.coilActive_flag(i);
                    end

                    % Pics reconstruction
                    picsCommand = 'pics -S';
                    if LW>0
                        picsCommand = [picsCommand,' -RW:6:0:',num2str(LW)];
                    end
                    if TVxy>0
                        picsCommand = [picsCommand,' -RT:6:0:',num2str(TVxy)];
                    end
                    if LR>0
                        % Locally low-rank in the spatial domain
                        blocksize = round(max([dimx dimy])/16);  % Block size
                        app.TextMessage(strcat('Low-rank block size =',{' '},num2str(blocksize)));
                        picsCommand = [picsCommand,' -RL:6:6:',num2str(LR),' -b',num2str(blocksize)];
                    end
                    if TVd>0
                        picsCommand = [picsCommand,' -RT:1024:0:',num2str(TVd)];
                    end
                    imageTmp = bart(app,picsCommand,kSpacePics,sensitivities);

                    % Modulus image
                    imageReg = abs(imageTmp);

                    % Phase image
                    phaseImageReg = angle(imageTmp);

                end

                % Rearrange to correct orientation: x, y, slices, dynamics,
                imageReg = reshape(imageReg,[1,dimy,dimx,dimd,dimz,1]);
                phaseImageReg = reshape(phaseImageReg,[1,dimy,dimx,dimd,dimz,1]);

                imagesOut = permute(imageReg,[3,2,5,4,1,6]);
                imagesOut = flip(flip(imagesOut,2),3);

                phaseImagesOut = permute(phaseImageReg,[3,2,5,4,1,6]);
                phaseImagesOut = flip(flip(phaseImagesOut,2),3);

                % Return the images object
                obj.images(:,:,:,:,flipAngle,echoTime) = imagesOut;
                obj.phaseImages(:,:,:,:,flipAngle,echoTime) = phaseImagesOut;
                obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = phaseImagesOut;

            else

                % 2D CS reco in MATLAB

                app.TextMessage('WARNING: Bart toolbox not available, slow reconstruction ...');

                % kSpaceRaw = {coil}[X Y slices NR]
                %                    1 2    3   4
                dimx = size(kSpaceRaw{1},1);
                dimy = size(kSpaceRaw{1},2);
                dimz = size(kSpaceRaw{1},3);
                dimd = size(kSpaceRaw{1},4);
                app.NREditField.Value = dimd;
                ndimx = app.XEditField.Value;
                ndimy = app.YEditField.Value;

                % Kspace data [x,y,z,dynamics,coils]
                kSpace = zeros(dimx,dimy,dimz,dimd,obj.nrCoils);
                if app.AutoSensitivityCheckBox.Value == 1
                    for i = 1:obj.nrCoils
                        kSpace(:,:,:,:,i) = kSpaceRaw{i}*obj.coilActive_flag(i);
                    end
                else
                    for i = 1:obj.nrCoils
                        kSpace(:,:,:,:,i) = kSpaceRaw{i}*obj.coilSensitivities(i)*obj.coilActive_flag(i);
                    end
                end
                kSpace = permute(kSpace,[1,2,4,3,5]);
                averages = obj.fillingSpace(:,:,:,:,flipAngle,echoTime);
                averages = permute(averages,[1,2,4,3]);

                % Reset progress counter
                param.iteration = 0;
                drawnow;

                % Preallocate
                imagesOut = zeros(ndimx,ndimy,dimz,dimd);

                % Slice loop
                for slice = 1:dimz

                    % Fool the reco if dimd = 1, it needs at least 2 dynamics
                    if dimd == 1
                        kSpace(:,:,2,:) = kSpace(:,:,1,:);
                    end

                    % Kspace of slice
                    kData = squeeze(kSpace(:,:,:,slice,:));
                    kMask = squeeze(averages(:,:,:,slice,1));

                    % Zero-fill or crop x-dimension
                    if ndimx > dimx
                        padsizex = round((ndimx - dimx)/2);
                        kdatai = padarray(kData,[padsizex,0,0,0],'both');
                        maski = padarray(kMask,[padsizex,0,0],'both');
                    else
                        cropsize = round((dimx - ndimx)/2)-1;
                        cropsize(cropsize<0)=0;
                        kdatai = kData(cropsize+1:end-cropsize,:,:,:);
                        maski = kMask(cropsize+1:end-cropsize,:,:);
                    end

                    % Zero-fill or crop y-dimension
                    if ndimy > dimy
                        padsizey = round((ndimy - dimy)/2);
                        kdatai = padarray(kdatai,[0,padsizey,0,0],'both');
                        maski = padarray(maski,[0,padsizey,0],'both');
                    else
                        cropsize = round((dimy - ndimy)/2)-1;
                        cropsize(cropsize<0)=0;
                        kdatai = kdatai(:,cropsize+1:end-cropsize,:,:);
                        maski = maski(:,cropsize+1:end-cropsize,:);
                    end

                    % Make sure dimensions are exactly ndimx, ndimy
                    kdatai = kdatai(1:ndimx,1:ndimy,:,:);
                    maski = maski(1:ndimx,1:ndimy,:);

                    % Make the mask
                    maski = maski./maski;
                    maski(isnan(maski)) = 1;
                    maski = logical(maski);

                    % Size of the data
                    [nx,ny,~,obj.nrCoils]=size(kdatai);

                    % Normalize the data in the range of approx 0 - 1 for better numerical stability
                    kdatai = kdatai/max(abs(kdatai(:)));

                    % Coil sensitivity map
                    b1 = ones(nx,ny,obj.nrCoils);

                    % Data
                    param.y = kdatai;

                    % Reconstruction design matrix
                    param.E = Emat_yxt(maski,b1);

                    % Total variation (TV) constraint in the temporal domain & Wavelet in spatial domain
                    param.TV = TVOP;
                    param.TVWeight = TVd/8;

                    % Wavelet
                    param.W = Wavelet('Daubechies',12,12);
                    param.L1Weight = LW;

                    % Number of iterations, 2 x 10 iterations
                    param.nite = 10;
                    param.nouter = 2;
                    param.totaliterations = dimz * param.nouter * param.nite;

                    % Linear reconstruction
                    nrd = size(kdatai,3);
                    kdata1 = squeeze(randn(ndimx,ndimy,nrd,obj.nrCoils))/2000 + kdatai;  % add a little bit of randomness, such that linear reco is not exactly right
                    recon_dft = param.E'*kdata1;

                    % Iterative reconstruction
                    recon_cs = recon_dft;
                    for n = 1:param.nouter
                        [recon_cs,param.iteration] = CSL1NlCg(app,recon_cs,param);
                    end
                    imageTmp = recon_cs;

                    % Output reconstructed image
                    if dimd == 1
                        imagesOut(:,:,slice,:) = abs(imageTmp(:,:,1));
                        phaseImagesOut(:,:,slice,:) = angle(imageTmp(:,:,1));
                    else
                        imagesOut(:,:,slice,:) = abs(imageTmp);
                        phaseImagesOut(:,:,slice,:) = angle(imageTmp);
                    end

                end

                % Orientations are flipped
                imagesOut = flip(flip(imagesOut,1),3);
                phaseImagesOut = flip(flip(phaseImagesOut,1),3);

                % There seems to be a 1 pixel shift with this reco, correct for this:
                imagesOut = circshift(imagesOut,-1,1);
                imagesOut = circshift(imagesOut,-1,2);
                phaseImagesOut = circshift(phaseImagesOut,-1,1);
                phaseImagesOut = circshift(phaseImagesOut,-1,2);

                % Return the images object
                obj.images(:,:,:,:,flipAngle,echoTime) = imagesOut;
                obj.phaseImages(:,:,:,:,flipAngle,echoTime) = phaseImagesOut;
                obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = phaseImagesOut;

            end

        end % csReco2D




        % ---------------------------------------------------------------------------------
        % Image reconstruction: FFT 2D
        % ---------------------------------------------------------------------------------
        function obj = fftReco2D(obj,app,flipAngle,echoTime)

            kSpaceRaw = cell(obj.nrCoils);
            for i=1:obj.nrCoils
                kSpaceRaw{i} = obj.rawKspace{i}(:,:,:,:,flipAngle,echoTime);
            end

            % kSpaceRaw = {coil}[X Y slices dynamics]
            %                    1 2    3      4
            dimx = size(kSpaceRaw{1},1);
            dimy = size(kSpaceRaw{1},2);
            dimz = size(kSpaceRaw{1},3);
            dimd = size(kSpaceRaw{1},4);

            % Requested dimensions
            ndimx = app.XEditField.Value;
            ndimy = app.YEditField.Value;
            ndimz = app.ZEditField.Value;
            ndimd  = app.NREditField.Value;

            for i = 1:obj.nrCoils
                if dimd ~= ndimd || dimz ~= ndimz
                    % Interpolate the time dimension if requested
                    kSpaceRaw{i} = permute(kSpaceRaw{i},[4,3,1,2]);
                    kSpaceRaw{i} = imresize(kSpaceRaw{i},[ndimd,ndimz]);
                    kSpaceRaw{i} = permute(kSpaceRaw{i},[3,4,2,1]);
                end
                % Kspace data x,y,NR,slices
                kSpaceRaw{i} = permute(kSpaceRaw{i},[1,2,4,3]);
            end

            % Kspace data x,y,NR,slices,coils
            kSpace = zeros(dimx,dimy,ndimd,ndimz,obj.nrCoils);

            if app.AutoSensitivityCheckBox.Value == 1
                for i = 1:obj.nrCoils
                    kSpace(:,:,:,:,i) = kSpaceRaw{i}*obj.coilActive_flag(i);
                end
            else
                for i = 1:obj.nrCoils
                    kSpace(:,:,:,:,i) = kSpaceRaw{i}*obj.coilSensitivities(i)*obj.coilActive_flag(i);
                end
            end

            % Preallocate
            imagesOut = zeros(ndimx,ndimy,ndimz,ndimd);
            phaseImagesOut = zeros(ndimx,ndimy,ndimz,ndimd);

            % Slice and dynamic loop
            for slice = 1:ndimz

                for dynamic = 1:ndimd

                    % Kspace of dynamic and slice
                    kData = squeeze(kSpace(:,:,dynamic,slice,:));

                    % Zero-fill or crop x-dimension
                    if ndimx > dimx
                        padsizex = round((ndimx - dimx)/2);
                        kdatai = padarray(kData,[padsizex,0,0],'both');
                    else
                        cropsize = round((dimx - ndimx)/2)-1;
                        cropsize(cropsize<0)=0;
                        kdatai = kData(cropsize+1:end-cropsize,:,:);
                    end

                    % Zero-fill or crop y-dimension
                    if ndimy > dimy
                        padsizey = round((ndimy - dimy)/2);
                        kdatai = padarray(kdatai,[0,padsizey,0],'both');
                    else
                        cropsize = round((dimy - ndimy)/2)-1;
                        cropsize(cropsize<0)=0;
                        kdatai = kdatai(:,cropsize+1:end-cropsize,:);
                    end

                    % Make sure dimensions are exactly ndimx, ndimy, coils
                    kdatai = kdatai(1:ndimx,1:ndimy,:);

                    % FFT
                    imageTmp = zeros(ndimx,ndimy,obj.nrCoils);
                    for coil = 1:obj.nrCoils
                        imageTmp(:,:,coil) = proudData.fft2r(squeeze(kdatai(:,:,coil)));
                    end

                    % Sum of squares
                    image2D = rssq(imageTmp,3);
                    
                    % Phase images
                    image2Dphase = mean(angle(imageTmp),3);
                    
                    % Denoising
                    if app.DeNoiseCheckBox.Value
                        [image2D,~,~] = wdenoise2(image2D,'CycleSpinning',1);
                    end

                    % Return the image
                    imagesOut(:,:,slice,dynamic) = image2D;
                    phaseImagesOut(:,:,slice,dynamic) = image2Dphase;

                end

            end

            % Flip 2nd dimension
            imagesOut = flip(imagesOut,2);
            phaseImagesOut = flip(phaseImagesOut,2);

            % Return the images object
            obj.images(:,:,:,:,flipAngle,echoTime) = imagesOut;
            obj.phaseImages(:,:,:,:,flipAngle,echoTime) = phaseImagesOut;
            obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = phaseImagesOut;

        end %fftReco2D




        % ---------------------------------------------------------------------------------
        % Image reconstruction: compressed sensing 3D
        % ---------------------------------------------------------------------------------
        function obj = csReco3D(obj,app,flipAngle,echoTime)

            % Reset progress counter
            param.iteration = 0;
            drawnow;

            % CS regularization parameters
            LambdaWavelet = app.WVxyzEditField.Value;
            TVxyz = app.TVxyzEditField.Value;
            LR = app.LRxyzEditField.Value;
            TVd = app.TVtimeEditField.Value;

            kSpaceRaw = cell(obj.nrCoils);
            for i=1:obj.nrCoils
                kSpaceRaw{i} = obj.rawKspace{i}(:,:,:,:,flipAngle,echoTime,:);
            end

            if app.bartDetected_flag
                % CS reco with BART

                % kSpaceRaw = {coil}[X Y Z dynamics 1 1 slab]
                %                    1 2 3    4     5 6  7
                dimx = app.XEditField.Value;
                dimy = app.YEditField.Value;
                dimz = app.ZEditField.Value;
                dimzo = size(kSpaceRaw{1},3);
                dimd = app.NREditField.Value;
                dims = size(kSpaceRaw{1},7);

                % Resize k-space (kx, ky, kz, dynamics, slab)
                for i=1:obj.nrCoils
                    kSpaceRaw{i} = bart(app,['resize -c 0 ',num2str(dimx),' 1 ',num2str(dimy),' 2 ',num2str(dimz),' 3 ',num2str(dimd)],kSpaceRaw{i});
                end

                app.RecoProgressGauge.Value = 25;
                drawnow;

                kSpace = zeros(dimx,dimy,dimz,dimd,1,1,dims,obj.nrCoils);
                for i = 1:obj.nrCoils
                    kSpace(:,:,:,:,:,:,:,i) = kSpaceRaw{i}*obj.coilActive_flag(i);
                end

                % Bart dimensions
                % 	READ_DIM,       1   z
                % 	PHS1_DIM,       2   y
                % 	PHS2_DIM,       3   x
                % 	COIL_DIM,       4   coils
                % 	MAPS_DIM,       5   sense maps
                % 	TE_DIM,         6
                % 	COEFF_DIM,      7
                % 	COEFF2_DIM,     8
                % 	ITER_DIM,       9
                % 	CSHIFT_DIM,     10
                % 	TIME_DIM,       11  dynamics
                % 	TIME2_DIM,      12
                % 	LEVEL_DIM,      13
                % 	SLICE_DIM,      14  slices
                % 	AVG_DIM,        15
 
                %         BART index          0  1  2  3  4  5  6  7  8  9  10 11 12 13
                %         Matlab index        1  2  3  4  5  6  7  8  9  10 11 12 13 14
                kSpacePics = permute(kSpace,[3 ,2 ,1 ,8 ,5 ,6 ,9 ,10,11,12, 4 13 14 7 ]);

                if obj.nrCoils>1 && app.AutoSensitivityCheckBox.Value==1

                    % ESPIRiT reconstruction
                    TextMessage(app,'ESPIRiT reconstruction ...');

                    % ESPIRiT sensitivity maps
                    kSpacePicsSum = sum(kSpacePics,11);
                    sensitivities = bart(app,'ecalib -I -S -a', kSpacePicsSum);

                    % Wavelet and TV in spatial dimensions 2^0+2^1+2^2=7, total variation in time 2^10 = 1024
                    picsCommand = 'pics -S';
                    if LambdaWavelet>0
                        picsCommand = [picsCommand, ' -RW:7:0:',num2str(LambdaWavelet)];
                    end
                    if TVxyz>0
                        picsCommand = [picsCommand, ' -RT:7:0:',num2str(TVxyz)];
                    end
                    if LR>0
                        % Locally low-rank in the spatial domain
                        blockSize = round(max([dimx dimy dimz])/16);  % Block size
                        app.TextMessage(strcat('Low-rank block size =',{' '},num2str(blockSize)));
                        picsCommand = [picsCommand, ' -RL:7:7:',num2str(LR)];
                    end
                    if TVd>0
                        picsCommand = [picsCommand, ' -RT:1024:0:',num2str(TVd)];
                    end
                    imagesTmp = bart(app,picsCommand,kSpacePics,sensitivities);

                    % Sum of squares
                    imagesReg = abs(bart(app,'rss 16', imagesTmp));
                    phaseImagesReg = angle(imagesTmp(:,:,:,:,1,:));

                end

                if obj.nrCoils==1 || app.AutoSensitivityCheckBox.Value==0

                    % Sensitivity correction
                    sensitivities = ones(dimz,dimy,dimx,obj.nrCoils,1,1,1,1,1,1,dimd,1,1,dims);
                    for i = 1:obj.nrCoils
                        sensitivities(:,:,:,i,:) = sensitivities(:,:,:,i,:)*obj.coilSensitivities(i)*obj.coilActive_flag(i);
                    end

                    % Wavelet and TV in spatial dimensions 2^0+2^1+2^2=7, total variation in time 2^10 = 1024
                    % Regular reconstruction
                    picsCommand = 'pics -S';
                    if LambdaWavelet>0
                        picsCommand = [picsCommand, ' -RW:7:0:',num2str(LambdaWavelet)];
                    end
                    if TVxyz>0
                        picsCommand = [picsCommand, ' -RT:7:0:',num2str(TVxyz)];
                    end
                    if LR>0
                        % Locally low-rank in the spatial domain
                        blockSize = round(max([dimx dimy dimz])/16);  % Block size
                        app.TextMessage(strcat('Low-rank block size =',{' '},num2str(blockSize)));
                        picsCommand = [picsCommand, ' -RL:7:7:',num2str(LR)];
                    end
                    if TVd>0
                        picsCommand = [picsCommand, ' -RT:1024:0:',num2str(TVd)];
                    end
                    imagesTmp = bart(app,picsCommand,kSpacePics,sensitivities);

                    % Absolute value
                    imagesReg = abs(imagesTmp);
                    phaseImagesReg = angle(imagesTmp);

                end

                % Rearrange to correct orientation: x, y, z, dynamics, slab
                imagesReg = reshape(imagesReg,[dimz,dimy,dimx,dimd,dims]);
                imageSlab = permute(imagesReg,[3,2,1,4,5]);
                imageSlab = flip(flip(imageSlab,1),2);
            
                phaseImagesReg = reshape(phaseImagesReg,[dimz,dimy,dimx,dimd,dims]);
                phaseImageSlab = permute(phaseImagesReg,[3,2,1,4,5]);
                phaseImageSlab = flip(flip(phaseImageSlab,1),2);

                if dims>1
                    % Slab ratio + discard
                    nrDiscard = round((dimz*(100-obj.slab_ratio)/200) + obj.DISCARD*dimz/dimzo);
                    if nrDiscard>0
                        imageSlab(:,:,dimz-nrDiscard+1:dimz,:,:) = [];
                        phaseImageSlab(:,:,dimz-nrDiscard+1:dimz,:,:) = [];
                        imageSlab(:,:,1:nrDiscard,:,:) = [];
                        phaseImageSlab(:,:,1:nrDiscard,:,:) = [];
                    end

                    % Concatenate multislab data
                    imageMultiSlab = imageSlab(:,:,:,:,dims);
                    phaseImageMultiSlab = phaseImageSlab(:,:,:,:,dims);
                    for i = dims-1:-1:1
                        imageMultiSlab = cat(3,imageMultiSlab,imageSlab(:,:,:,:,i));
                        phaseImageMultiSlab = cat(3,phaseImageMultiSlab,phaseImageSlab(:,:,:,:,i));
                    end
                else
                    imageMultiSlab = imageSlab(:,:,:,:,1);
                    phaseImageMultiSlab = phaseImageSlab(:,:,:,:,1);
                end

                % Return the image object
                obj.images(:,:,:,:,flipAngle,echoTime) = imageMultiSlab;
                obj.phaseImages(:,:,:,:,flipAngle,echoTime) = phaseImageMultiSlab;
                obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = phaseImageMultiSlab;

            else

                % 3D CS reco in MATLAB

                app.TextMessage('WARNING: Bart toolbox not available, slow reconstruction ...');

                % kSpaceRaw = {coil}[X Y Z dynamics 1 1 slab]
                %                    1 2 3    4     5 6   7  
                dimx = size(kSpaceRaw{1},1);
                dimy = size(kSpaceRaw{1},2);
                dimz = size(kSpaceRaw{1},3);
                dimd = size(kSpaceRaw{1},4);
                app.NREditField.Value = dimd;
                dims = size(kSpaceRaw{1},7);
                ndimx = app.XEditField.Value;
                ndimy = app.YEditField.Value;
                ndimz = app.ZEditField.Value;
                param.iteration = 0;
                    
                % Preallocate
                imageSlab = zeros(ndimx,ndimy,ndimz,dimd,dims);
                phaseImageSlab = zeros(ndimx,ndimy,ndimz,dimd,dims);

                for slab = 1:dims

                    % Kspace data [x,y,z,dynamics,coils]
                    kSpace = zeros(dimx,dimy,dimz,dimd,obj.nrCoils);
                    for i = 1:obj.nrCoils
                        if app.AutoSensitivityCheckBox.Value == 1
                            kSpace(:,:,:,:,i) = kSpaceRaw{i}(:,:,:,:,:,:,slab)*obj.coilActive_flag(i);
                        else
                            kSpace(:,:,:,:,i) = squeeze(kSpaceRaw{i}(:,:,:,:,:,:,slab))*obj.coilSensitivities(i)*obj.coilActive_flag(i);
                        end
                    end
                    averages = obj.fillingSpace(:,:,:,:,flipAngle,echoTime,slab);

                    % Kspace of slice
                    kData = kSpace(:,:,:,:,:);
                    kMask = averages(:,:,:,:);

                    % Fool the reco if dimd = 1, it needs at least 2 dynamics
                    if dimd == 1
                        kData(:,:,:,2,:) = kData(:,:,:,1,:);
                    end

                    % Zero-fill or crop x-dimension
                    if ndimx > dimx
                        padsizex = round((ndimx - dimx)/2);
                        kdatai = padarray(kData,[padsizex,0,0,0,0],'both');
                        maski = padarray(kMask,[padsizex,0,0,0],'both');
                    else
                        cropsize = round((dimx - ndimx)/2)-1;
                        cropsize(cropsize<0)=0;
                        kdatai = kData(cropsize+1:end-cropsize,:,:,:,:);
                        maski = kMask(cropsize+1:end-cropsize,:,:,:);
                    end

                    % Zero-fill or crop y-dimension
                    if ndimy > dimy
                        padsizey = round((ndimy - dimy)/2);
                        kdatai = padarray(kdatai,[0,padsizey,0,0,0],'both');
                        maski = padarray(maski,[0,padsizey,0,0],'both');
                    else
                        cropsize = round((dimy - ndimy)/2)-1;
                        cropsize(cropsize<0)=0;
                        kdatai = kdatai(:,cropsize+1:end-cropsize,:,:,:);
                        maski = maski(:,cropsize+1:end-cropsize,:,:);
                    end

                    % Zero-fill or crop z-dimension
                    if ndimz > dimz
                        padsizez = round((ndimz - dimz)/2);
                        kdatai = padarray(kdatai,[0,0,padsizez,0,0],'both');
                        maski = padarray(maski,[0,0,padsizez,0],'both');
                    else
                        cropsize = round((dimz - ndimz)/2)-1;
                        cropsize(cropsize<0)=0;
                        kdatai = kdatai(:,:,cropsize+1:end-cropsize,:,:);
                        maski = maski(:,:,cropsize+1:end-cropsize,:);
                    end

                    % Make sure dimensions are exactly ndimx, ndimy, ndimz
                    kdatai = kdatai(1:ndimx,1:ndimy,1:ndimz,:,:);
                    maski = maski(1:ndimx,1:ndimy,1:ndimz,:);

                    % Make the mask
                    maski = maski./maski;
                    maski(isnan(maski)) = 1;
                    maski = logical(maski);

                    % Size of the data
                    [nx,ny,nz,nr,nc] = size(kdatai);

                    % Normalize the data in the range of approx 0 - 1 for better numerical stability
                    kdatai = kdatai/max(abs(kdatai(:)));

                    % Coil sensitivity map
                    b1 = ones(nx,ny,nz,nr,nc);

                    % Data
                    param.y = kdatai;

                    % Reconstruction design matrix
                    param.E = Emat_zyxt(maski,b1);

                    % Total variation (TV) constraint in the temporal domain & Wavelet in spatial domain
                    param.TV = TVOP3D;
                    param.TVWeight = TVd/8;

                    % Wavelet
                    param.W = Wavelet('Daubechies',12,12);
                    param.L1Weight = LambdaWavelet;

                    % Number of iterations, 2 x 10 iterations
                    param.nite = 5;  %10
                    param.nouter = 1;  %2
                    param.totaliterations = param.nouter * param.nite * dims;
                   
                    % Linear reconstruction
                    kdata1 = randn(size(kdatai))/2000 + kdatai;  % add a little bit of randomness, such that linear reco is not exactly right
                    recon_dft = param.E'*kdata1;

                    % Iterative reconstruction
                    recon_cs = recon_dft;
                    for n = 1:param.nouter
                        [recon_cs,param.iteration] = CSL1NlCg(app,recon_cs,param);
                    end
                    imageTmp = recon_cs;

                    % Output reconstructed image
                    if dimd == 1
                        imageOut = abs(imageTmp(:,:,:,1));
                        phaseImageOut = angle(imageTmp(:,:,:,1));
                    else
                        imageOut = abs(imageTmp(:,:,:,:));
                        phaseImageOut = angle(imageTmp(:,:,:,:));
                    end

                    % Images are flipped in certain dimensions
                    imageOut = flip(imageOut,3);
                    phaseImageOut = flip(phaseImageOut,3);
              
                    % Images are shifted by 1 pixel in each dimension
                    imageOut = circshift(imageOut,1,1);
                    imageOut = circshift(imageOut,-1,2);
                    imageOut = circshift(imageOut,1,3);
                    phaseImageOut = circshift(phaseImageOut,1,1);
                    phaseImageOut = circshift(phaseImageOut,-1,2);
                    phaseImageOut = circshift(phaseImageOut,1,3);

                    % Return the images object
                    imageSlab(:,:,:,:,slab) = imageOut;
                    phaseImageSlab(:,:,:,:,slab) = phaseImageOut;

                end

                if dims>1
                    % Slab ratio + discard
                    nrDiscard = round((dimz*(100-obj.slab_ratio)/200) + obj.DISCARD*dimz/dimz);
                    if nrDiscard>0
                        imageSlab(:,:,dimz-nrDiscard+1:dimz,:,:) = [];
                        phaseImageSlab(:,:,dimz-nrDiscard+1:dimz,:,:) = [];
                        imageSlab(:,:,1:nrDiscard,:,:) = [];
                        phaseImageSlab(:,:,1:nrDiscard,:,:) = [];
                    end

                    % Concatenate multislab data
                    imageMultiSlab = imageSlab(:,:,:,:,dims);
                    phaseImageMultiSlab = phaseImageSlab(:,:,:,:,dims);
                    for i = dims-1:-1:1
                        imageMultiSlab = cat(3,imageMultiSlab,imageSlab(:,:,:,:,i));
                        phaseImageMultiSlab = cat(3,phaseImageMultiSlab,phaseImageSlab(:,:,:,:,i));
                    end
                else
                    imageMultiSlab = imageSlab(:,:,:,:,1);
                    phaseImageMultiSlab = phaseImageSlab(:,:,:,:,1);
                end

                % Return the image object
                obj.images(:,:,:,:,flipAngle,echoTime) = imageMultiSlab;
                obj.phaseImages(:,:,:,:,flipAngle,echoTime) = phaseImageMultiSlab;
                obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = phaseImageMultiSlab;
            end

        end % csReco3D




        % ---------------------------------------------------------------------------------
        % Image reconstruction: FFT 3D
        % ---------------------------------------------------------------------------------
        function obj = fftReco3D(obj,app,flipAngle,echoTime)

            kSpaceRaw = cell(obj.nrCoils);
            for i=1:obj.nrCoils
                kSpaceRaw{i} = obj.rawKspace{i}(:,:,:,:,flipAngle,echoTime,:);
            end

            % kSpaceRaw = {coil}[X Y slices dynamics, 1 , 1, slab]
            %                    1 2    3      4      5   6    7
            dimx = size(kSpaceRaw{1},1);
            dimy = size(kSpaceRaw{1},2);
            dimz = size(kSpaceRaw{1},3);
            dimd = size(kSpaceRaw{1},4);
            dims = size(kSpaceRaw{1},7);

            % Requested dimensions
            ndimx = app.XEditField.Value;
            ndimy = app.YEditField.Value;
            ndimz = app.ZEditField.Value;
            ndimd = app.NREditField.Value;

            % Interpolate the time dimension if requested
            for i = 1:obj.nrCoils
                if dimd ~= ndimd
                    kSpaceRaw{i} = permute(kSpaceRaw{i},[4,1,2,3,5,6,7]);
                    kSpaceRaw{i} = imresize(kSpaceRaw{i},[ndimd,dimx]);
                    kSpaceRaw{i} = permute(kSpaceRaw{i},[2,3,4,1,5,6,7]);
                end
            end

            % Kspace data x,y,z,dynamics,coils
            kSpace = zeros(dimx,dimy,dimz,ndimd,1,1,dims,obj.nrCoils);
            for i = 1:obj.nrCoils
                if app.AutoSensitivityCheckBox.Value
                    kSpace(:,:,:,:,:,:,:,i) = kSpaceRaw{i}*obj.coilActive_flag(i);
                else
                    kSpace(:,:,:,:,:,:,:,i) = kSpaceRaw{i}*obj.coilSensitivities(i)*obj.coilActive_flag(i);
                end
            end

            % Preallocate
            imageSlab = zeros(ndimx,ndimy,ndimz,ndimd,dims);

            % Slab loop
            for slab = 1:dims

                % Dynamic loop
                for dynamic = 1:ndimd

                    % Kspace of dynamic
                    kData = squeeze(kSpace(:,:,:,dynamic,1,1,slab,:));

                    % Zero-fill or crop x-dimension
                    if ndimx > dimx
                        padsizex = round((ndimx - dimx)/2);
                        kdatai = padarray(kData,[padsizex,0,0],'both');
                    else
                        cropsize = round((dimx - ndimx)/2)-1;
                        cropsize(cropsize<0)=0;
                        kdatai = kData(cropsize+1:end-cropsize,:,:,:);
                    end

                    % Zero-fill or crop y-dimension
                    if ndimy > dimy
                        padsizey = round((ndimy - dimy)/2);
                        kdatai = padarray(kdatai,[0,padsizey,0],'both');
                    else
                        cropsize = round((dimy - ndimy)/2)-1;
                        cropsize(cropsize<0)=0;
                        kdatai = kdatai(:,cropsize+1:end-cropsize,:,:);
                    end

                    % Zero-fill or crop z-dimension
                    if ndimz > dimz
                        padsizez = round((ndimz - dimz)/2);
                        kdatai = padarray(kdatai,[0,0,padsizez],'both');
                    else
                        cropsize = round((dimz - ndimz)/2)-1;
                        cropsize(cropsize<0)=0;
                        kdatai = kdatai(:,:,cropsize+1:end-cropsize,:);
                    end

                    % Make sure dimensions are exactly ndimx, ndimy, coils
                    kdatai = kdatai(1:ndimx,1:ndimy,1:ndimz,:);

                    % FFT
                    imageIm = zeros(ndimx,ndimy,ndimz,obj.nrCoils);
                    for coil = 1:obj.nrCoils
                        imageIm(:,:,:,coil) = proudData.fft3r(squeeze(kdatai(:,:,:,coil)));
                    end

                    % Root sum of squares
                    image3D = rssq(imageIm,4);

                    % Phase images (mean of coils)
                    image3Dphase = mean(angle(imageIm),4);
                    
                    % Denoising
                    if app.DeNoiseCheckBox.Value
                        for i = 1:size(image3D,3)
                            image3D(:,:,i) = wdenoise2(squeeze(image3D(:,:,i)),'CycleSpinning',1);
                        end
                    end

                    % Return the image
                    imageSlab(:,:,:,dynamic,slab) = image3D;
                    phaseImageSlab(:,:,:,dynamic,slab) = image3Dphase;

                end

            end

            % Flip x and y dimensions
            imageSlab = flip(flip(imageSlab,2),1);
            phaseImageSlab = flip(flip(phaseImageSlab,2),1);

            % Slab ratio + discard
            if dims>1
                nrDiscard = round((ndimz*(100-obj.slab_ratio)/200) + (obj.DISCARD*ndimz/dimz));
                if nrDiscard>0
                    imageSlab(:,:,ndimz-nrDiscard+1:ndimz,:,:) = [];
                    imageSlab(:,:,1:nrDiscard,:,:) = [];
                    phaseImageSlab(:,:,ndimz-nrDiscard+1:ndimz,:,:) = [];
                    phaseImageSlab(:,:,1:nrDiscard,:,:) = [];
                end
            end

            % Concatenate multislab data
            imageMultiSlab = imageSlab(:,:,:,:,dims);
            phaseImageMultiSlab = phaseImageSlab(:,:,:,:,dims);

            if dims>1
                for i = dims-1:-1:1
                    imageMultiSlab = cat(3,imageMultiSlab,imageSlab(:,:,:,:,i));
                    phaseImageMultiSlab = cat(3,phaseImageMultiSlab,phaseImageSlab(:,:,:,:,i));
                end
            end

            % Return the image object
            obj.images(:,:,:,:,flipAngle,echoTime) = imageMultiSlab;
            obj.phaseImages(:,:,:,:,flipAngle,echoTime) = phaseImageMultiSlab;
            obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = phaseImageMultiSlab;

        end % fftReco3D




        % ---------------------------------------------------------------------------------
        % Image reconstruction: compressed sensing 2D Radial
        % ---------------------------------------------------------------------------------
        function obj = csRecoRadial(obj,app,flipAngle,echoTime)

            % CS regularization parameters
            LW = app.WVxyzEditField.Value;
            TVxyz = app.TVxyzEditField.Value;
            %LR = app.LRxyzEditField.Value;
            TVd = app.TVtimeEditField.Value;

            kSpaceRaw = cell(obj.nrCoils);
            for i=1:obj.nrCoils
                kSpaceRaw{i} = obj.rawKspace{i}(:,:,:,:,flipAngle,echoTime);
            end

            dimx = app.XEditField.Value;
            dimy = app.YEditField.Value;
            dimz = size(kSpaceRaw{1},3);
            dimd = app.NREditField.Value;

            % Resize k-space (kx, ky, kz, nr)
            for i=1:obj.nrCoils
                kSpaceRaw{i} = bart(['resize -c 0 ',num2str(dimx),' 1 ',num2str(dimy),' 2 ',num2str(dimz),' 3 ',num2str(dimd)],kSpaceRaw{i});
            end

            kspace = zeros(dimx,dimy,dimz,dimd,obj.nrCoils);
            for i = 1:obj.nrCoils
                kspace(:,:,:,:,i) = kSpaceRaw{i};
            end
            kspace_pics = permute(kspace,[3,1,2,5,6,7,8,9,10,11,4]);

            % create trajectory
            bartcommand = ['traj -r -y',num2str(dimy),' -x',num2str(dimx),' -q0:0:0'];
            traj = bart(bartcommand);

            if obj.nrCoils>1

                % sensitivity map
                sensitivities = ones(dimy,dimx);

                %kspace_pics_sum = sum(kspace_pics,11);
                %lowres_img = bart('nufft -i -l6 -d32:32:1 -t', traj, kspace_pics_sum);
                %lowres_ksp = bart('fft -u 7', lowres_img);

                % zeropad to full size
                %bartcommand = ['resize -c 0 ',num2str(dimy),' 1 ',num2str(dimx)];
                %ksp_zerop = bart(bartcommand, lowres_ksp);

                % calculate sensitivity map with bart
                %sensitivities = bart('ecalib -m1', ksp_zerop);

                % reconstruction
                picscommand = ['pics -S -u10 -RW:7:0:',num2str(LW),' -RT:7:0:',num2str(TVxyz),' -RT:1024:0:',num2str(TVd),' -t'];
                images_out = bart(picscommand,traj,kspace_pics,sensitivities);

                % Sum of squares reconstruction
                images_out = abs(bart('rss 16', images_out));

            else

                % Sensitivity map
                sensitivities = ones(dimy,dimx);

                % Reconstruction
                picscommand = ['pics -S -u10 -RW:7:0:',num2str(LW),' -RT:7:0:',num2str(TVxyz),' -RT:1024:0:',num2str(TVd),' -t'];
                images_out = bart(picscommand,traj,kspace_pics,sensitivities);

            end

            % Rearrange to orientation: x, y, z, frames
            images_out = flip(flip(permute(abs(images_out),[3, 2, 1, 11, 4, 5, 6, 7, 8, 9, 10]),1),2);

            % Return the images object
            obj.images(:,:,:,:,flipAngle,echoTime) = images_out;

        end % csRecoRadial




        % ---------------------------------------------------------------------------------
        % Image reconstruction: scale images
        % ---------------------------------------------------------------------------------
        function obj = scaleImages(obj)

            % Scale
            obj.images = round(4095*obj.images/max(obj.images(:)));
            obj.images(isnan(obj.images)) = 0;

        end % scaleImages




        % ---------------------------------------------------------------------------------
        % Image resolution
        % ---------------------------------------------------------------------------------
        function obj = calcPixelSize(obj,app)

            % Calculate pixel size in different dimensions

            [dimx,dimy,dimz,NR,NFA,NE] = size(obj.images);

            fovx = app.FOVViewField1.Value;
            fovy = app.FOVViewField2.Value;
            if contains(obj.dataType,'3D')
                fovz = app.FOVViewField3.Value;
            else
                fovz = app.FOVViewField3.Value*dimz;
            end
            meanFov = mean([fovx fovy fovz]); % not really a physical dimension, but average of x,y and z

            resx = fovx/dimx;
            resy = fovy/dimy;
            resz = fovz/dimz;
            resNR = meanFov/NR;
            resNFA = meanFov/NFA;
            resNE = meanFov/NE;

            obj.pixelSize = [resx resy resz resNR resNFA resNE 1];

        end % calcPixelSize




        % ---------------------------------------------------------------------------------
        % Image reconstruction: backToKspace
        % ---------------------------------------------------------------------------------
        function obj = backToKspace(obj)

            im = obj.images;

            switch obj.dataType

                case {"2D","2Dradial"}

                    % Images = (X, Y, slices, NR, NFA, NE)
                    [~, ~, slices, NR, NFA, NE] = size(im);
    
                    kSpace = zeros(size(im));
                    for i = 1:slices
                        for j = 1:NR
                            for k = 1:NFA
                                for w = 1:NE
                                    kSpace(:,:,i,j,k,w) = proudData.fft2r(squeeze(im(:,:,i,j,k,w)));
                                end
                            end
                        end
                    end

                    % Samples, views, views2, slices, echoes (frames), experiments, flip-angles
                    kSpace = permute(kSpace,[1,2,7,3,6,4,5]);
                    kSpace = flip(kSpace,4);
                   
                    % Return the object
                    obj.mrdKspace = kSpace;

                case "3D"

                    % Images = (X, Y, Z, NR, NFA, NE)
                    [~, ~, ~, NR, NFA, NE] = size(im);

                    kSpace = zeros(size(im));
                    for j = 1:NR
                        for k = 1:NFA
                            for w = 1:NE
                                kSpace(:,:,:,j,k,w) = proudData.fft3r(squeeze(im(:,:,:,j,k,w)));
                            end
                        end
                    end

                    % Samples, views, views2, slices, echoes (frames), experiments, flip-angles
                    kSpace = permute(kSpace,[1,2,3,7,6,4,5]);
             
                    % Return the object
                    obj.mrdKspace = kSpace;

            end

        end % backToKspace




        % ---------------------------------------------------------------------------------
        % Image reconstruction: SUR files
        % ---------------------------------------------------------------------------------
        function obj = recoSurFiles(obj, surpath, suffix, mrdfilename, rprfilename)

           % SUR file names
            surfiles = [surpath, suffix, '_00###.SUR'];

            % Link with the server
            m_Recon = actxserver('recon.Application');

            set(m_Recon,'Visible',1);
            set(m_Recon,'DisplayImages',1);

            % Filenames
            set(m_Recon,'DataFile',mrdfilename);
            set(m_Recon,'RPRFile',rprfilename);
            set(m_Recon,'ImageFile',surfiles);

            % Delete old SUR files
            try
                scmd = ['del /Q ', surpath, '*.SUR'];
                system(scmd);
            catch
            end

            % Do the reco
            invoke(m_Recon,'Run');

            % Wait for recon to complete
            while get(m_Recon,'StatusID')~=4
                if get(m_Recon,'StatusID')==5
                    break;
                end
                pause(0.1);
            end

            % Stop the link
            invoke(m_Recon,'Quit');

        end % recoSurFiles




        % ---------------------------------------------------------------------------------
        % Phase unwrapping
        % ---------------------------------------------------------------------------------
        function obj = unwrap3D(obj)

            slices = size(obj.phaseImages,3);
            dynamics = size(obj.phaseImages,4);
            echoes = size(obj.phaseImages,6);

            if slices > 1
                % 3D or multi-slice
                for i = 1:size(obj.phaseImages,4)
                    for j = 1:size(obj.phaseImages,5)
                        for k = 1:size(obj.phaseImages,6)
                            obj.phaseImages(:,:,:,i,j,k) = unwrap3(squeeze(obj.phaseImages(:,:,:,i,j,k)),squeeze(obj.mask(:,:,:,i,j,k)));
                        end
                    end
                end
            elseif echoes > 1
                % Single slice with multiple echoes
                for i = 1:size(obj.phaseImages,4)
                    for j = 1:size(obj.phaseImages,5)
                        obj.phaseImages(:,:,1,i,j,:) = unwrap3(squeeze(obj.phaseImages(:,:,1,i,j,:)),squeeze(obj.mask(:,:,1,i,j,:)));
                    end
                end
            elseif dynamics > 1
                % Single slice with multiple dynamics
                for j = 1:size(obj.phaseImages,5)
                    for k = 1:size(obj.phaseImages,6)
                        obj.phaseImages(:,:,1,:,j,k) = unwrap3(squeeze(obj.phaseImages(:,:,1,:,j,k)),squeeze(obj.mask(:,:,1,:,j,k)));
                    end
                end
            else
                % 2D single slice
                for i = 1:size(obj.phaseImages,4)
                    for j = 1:size(obj.phaseImages,5)
                        for k = 1:size(obj.phaseImages,6)
                            obj.phaseImages(:,:,1,i,j,k) = unwrap2(squeeze(obj.phaseImages(:,:,1,i,j,k)),squeeze(obj.mask(:,:,1,i,j,k)));
                        end
                    end
                end
            end

        end



        % ---------------------------------------------------------------------------------
        % Flow calculation
        % ---------------------------------------------------------------------------------
        function obj = calcFlow(obj,app)

            encDir = obj.vencTable(:,2:4);
            Venc = obj.vencTable(:,1);
            EncMatrix = encDir.*sign(Venc);                 % Correct for + en - venc
            EncMatrix = [EncMatrix ones(length(Venc),1)];
            encUse = obj.vencTable(:,5);
            encIndx = find(encUse == 1)';
            EncMatrix2 = EncMatrix(encIndx,:);

            app.TextMessage(strcat('Solving with',{' '},num2str(length(encIndx)),{' '},'flow-encoding directions ...'));

            input = obj.phaseImagesOrig;
            sol = zeros(size(input,1),size(input,2),size(input,3),size(input,4),size(input,5),size(input,6),4);

            % Solving the flow equation
            for i = 1:size(input,1)
                for j = 1:size(input,2)
                    for k = 1:size(input,3)
                        for v = 1:size(input,5)
                            for w = 1:size(input,6)
                                sol(i,j,k,1,v,w,:) = linsolve(EncMatrix2,squeeze(input(i,j,k,encIndx,v,w)));
                            end
                        end
                    end
                end
            end

            % Message
            app.TextMessage('Phase unwrapping ...');
            
            % Phase unwrapping
            if size(sol,3) > 1
                for v = 1:size(sol,5)
                    for w = 1:size(sol,6)
                        for k = 1:size(sol,7)
                            sol(:,:,:,1,v,w,k) = unwrap3(sol(:,:,:,1,v,w,k),obj.mask(:,:,:,1,v,w));
                        end
                    end
                end
            else
                for v = 1:size(sol,5)
                    for w = 1:size(sol,6)
                        for k = 1:size(sol,7)
                            sol(:,:,1,1,v,w,k) = unwrap2(sol(:,:,1,1,v,w,k),obj.mask(:,:,1,1,v,w));
                        end
                    end
                end
            end

            % Copy repetitions (nr) to maintain compatibility with viewer
            for i = 1:size(input,4)
                sol(:,:,:,i,:,:,:) = sol(:,:,:,1,:,:,:).*obj.mask(:,:,:,1,:,:);
            end

            % Direction 5 = modulus of the flow Vx, Vy, Vz
            sol(:,:,:,:,:,:,5) = rssq(sol(:,:,:,:,:,:,1:3),7);

            % Calculate flow from phase
            maxVenc = max(abs(Venc(:)));
            sol(:,:,:,:,:,:,1:3) = sol(:,:,:,:,:,:,1:3)*maxVenc/pi;
            sol(:,:,:,:,:,:,5) = sol(:,:,:,:,:,:,5)*maxVenc/pi;

            % Return the object
            obj.flowImages = sol;

            % Message
            app.TextMessage('Flow calculation is done ...');

        end


    end % Public methods





    % ---------------------------------------------------------------------------------
    % Static methods
    % ---------------------------------------------------------------------------------
    methods (Static)


        % ---------------------------------------------------------------------------------
        % 2D Tukey filter
        % ---------------------------------------------------------------------------------
        function output = circTukey2D(dimy,dimx,row,col,filterwidth)

            domain = 256;
            base = zeros(domain,domain);

            tukey1 = tukeywin(domain,filterwidth);
            tukey1 = tukey1(domain/2+1:domain);

            shifty = (row-dimy/2)*domain/dimy;
            shiftx = (col-dimx/2)*domain/dimx;

            y = linspace(-domain/2, domain/2, domain);
            x = linspace(-domain/2, domain/2, domain);

            for i=1:domain

                for j=1:domain

                    rad = round(sqrt((shiftx-x(i))^2 + (shifty-y(j))^2));

                    if (rad <= domain/2) && (rad > 0)

                        base(j,i) = tukey1(rad);

                    end

                end

            end

            output = imresize(base,[dimy dimx]);

        end



        % ---------------------------------------------------------------------------------
        % 3D Tukey filter
        % ---------------------------------------------------------------------------------
        function output = circTukey3D(dimz,dimy,dimx,lev,row,col,filterwidth)

            domain = 256;

            base = zeros(domain,domain,domain);

            tukey1 = tukeywin(domain,filterwidth);
            tukey1 = tukey1(domain/2+1:domain);

            shiftz = (lev-dimz/2)*domain/dimz;
            shifty = (row-dimy/2)*domain/dimy;
            shiftx = (col-dimx/2)*domain/dimx;

            z = linspace(-domain/2, domain/2, domain);
            y = linspace(-domain/2, domain/2, domain);
            x = linspace(-domain/2, domain/2, domain);

            for i=1:domain

                for j=1:domain

                    for k = 1:domain

                        rad = round(sqrt((shiftx-x(i))^2 + (shifty-y(j))^2 + (shiftz-z(k))^2));

                        if (rad <= domain/2) && (rad > 0)

                            base(k,j,i) = tukey1(rad);

                        end

                    end

                end

            end

            output = imresize3(base,[dimz dimy dimx]);

        end



        % ---------------------------------------------------------------------------------
        % Gauss function
        % ---------------------------------------------------------------------------------
        function y = gauss(x,s,m)

            % GAUSS  Gaussian function
            %
            %  Y = GAUSS( X , S , M )
            %
            %  Y = EXP(-(X-M).^2./S.^2)./(sqrt(2*pi).*S);
            %
            %  sum( Y(X=(-inf..inf)) * dX ) = 1/sqrt(2)

            Nin = nargin;

            if Nin < 2
                s = 1;
            end
            if Nin < 3
                m = 0;
            end

            x = ((x-m).^2) ./ (s.^2);

            s = sqrt(2*pi) * s;

            y = exp(-x) ./ s;

        end



        % ---------------------------------------------------------------------------------
        % 2D FFT
        % ---------------------------------------------------------------------------------
        function y = fft2r(x)

            y = fftshift(ifft(fftshift(x,1),[],1),1)*sqrt(size(x,1));
            y = fftshift(ifft(fftshift(y,2),[],2),2)*sqrt(size(x,2));

        end



        % ---------------------------------------------------------------------------------
        % 3D FFT
        % ---------------------------------------------------------------------------------
        function y = fft3r(x)

            y = fftshift(ifft(fftshift(x,1),[],1),1)*sqrt(size(x,1));
            y = fftshift(ifft(fftshift(y,2),[],2),2)*sqrt(size(x,2));
            y = fftshift(ifft(fftshift(y,3),[],3),3)*sqrt(size(x,3));

        end




        % ---------------------------------------------------------------------------------
        % Read MRD file
        % ---------------------------------------------------------------------------------
        function [im,dim,par,unsortedkspace] = importMRD(filename, reordering1, reordering2)

            % Description: Function to open multidimensional MRD/SUR files given a filename with PPR-parsing
            % Read in MRD and SUR file formats
            % Inputs: string filename, reordering1, reordering2
            % reordering1, 2 is 'seq' or 'cen'
            % reordering1 is for 2D (views)
            % reordering2 is for 3D (views2)
            % Outputs: complex data, raw dimension [no_expts,no_echoes,no_slices,no_views,no_views_2,no_samples], MRD/PPR parameters
            % Author: Ruslan Garipov
            % Date: 01/03/2014 - swapped views and views2 dimension - now correct
            % 30 April 2014 - support for reading orientations added
            % 11 September 2014 - swapped views and views2 in the array (otherwise the images are rotated)
            % 13 October 2015 - scaling added as a parameter

            fid = fopen(filename,'r');      % Define the file id
            val = fread(fid,4,'int32');
            xdim = val(1);
            ydim = val(2);
            zdim = val(3);
            dim4 = val(4);
            fseek(fid,18,'bof');
            datatype=fread(fid,1, 'uint16');
            datatype = dec2hex(datatype);
            fseek(fid,48,'bof');
            scaling = fread(fid,1, 'float32');
            bitsperpixel = fread(fid,1, 'uchar');
            fseek(fid,152,'bof');
            val = fread(fid,2, 'int32');
            dim5 = val(1);
            dim6 = val(2);
            fseek(fid,256,'bof');
            text = fread(fid,256);
            no_samples = xdim;  
            no_views = ydim;    
            no_views_2 = zdim;  
            no_slices = dim4;
            no_echoes = dim5;
            no_expts = dim6;

            % Read in the complex image data
            dim = [no_expts,no_echoes,no_slices,no_views_2,no_views,no_samples];

            if size(datatype,2)>1
                onlydatatype = datatype(2);
                iscomplex = 2;
            else
                onlydatatype = datatype(1);
                iscomplex = 1;
            end
            switch onlydatatype
                case '0'
                    dataformat = 'uchar';   
                case '1'
                    dataformat = 'schar';   
                case '2'
                    dataformat = 'short';   
                case '3'
                    dataformat = 'int16';   
                case '4'
                    dataformat = 'int32';   
                case '5'
                    dataformat = 'float32'; 
                case '6'
                    dataformat = 'double';  
                otherwise
                    dataformat = 'int32';   
            end

            num2read = no_expts*no_echoes*no_slices*no_views_2*no_views*no_samples*iscomplex; %*datasize;
            [m_total, count] = fread(fid,num2read,dataformat); % reading all the data at once

            if iscomplex == 2
                a=1:count/2;
                m_real = m_total(2*a-1);
                m_imag = m_total(2*a);
                clear m_total;
                m_C = m_real+m_imag*1i;
                clear m_real m_imag;
            else
                m_C = m_total;
                clear m_total;
            end

            unsortedkspace = m_C;

            n=0;
            % shaping the data manually:
            ord=1:no_views;
            if strcmp(reordering1,'cen')
                for g=1:no_views/2
                    ord(2*g-1)=no_views/2+g;
                    ord(2*g)=no_views/2-g+1;
                end
            end

            ord1 = 1:no_views_2;
            ord2 = ord1;
            if strcmp(reordering2,'cen')
                for g=1:no_views_2/2
                    ord2(2*g-1)=no_views_2/2+g;
                    ord2(2*g)=no_views_2/2-g+1;
                end
            end
            
            % pre-allocate the data matrix
            m_C_1=zeros(no_expts,no_echoes,no_slices,max(ord(:)),max(ord2(:)),no_samples);
           
            for a=1:no_expts
                for b=1:no_echoes
                    for c=1:no_slices
                        for d=1:no_views
                            for e=1:no_views_2
                                m_C_1(a,b,c,ord(d),ord2(e),:) = m_C(1+n:no_samples+n); % sequential ordering
                                n=n+no_samples;
                            end
                        end
                    end
                end
            end

            clear ord;
            clear ord2;
            m_C = squeeze(m_C_1);
            clear m_C_1;
            im=m_C;
            clear m_C;
            sample_filename = char(fread(fid,120,'uchar')');
            ppr_text = char(fread(fid,Inf,'uchar')');
            fclose(fid);

            % Parse fields in ppr section of the MRD file
            if numel(ppr_text)>0
                cell_text = textscan(ppr_text,'%s','delimiter',char(13));
                PPR_keywords = {'BUFFER_SIZE','DATA_TYPE','DECOUPLE_FREQUENCY','DISCARD','DSP_ROUTINE','EDITTEXT','EXPERIMENT_ARRAY','FOV','FOV_READ_OFF','FOV_PHASE_OFF','FOV_SLICE_OFF','GRADIENT_STRENGTH','MULTI_ORIENTATION','Multiple Receivers','NO_AVERAGES','NO_ECHOES','NO_RECEIVERS','NO_SAMPLES','NO_SLICES','NO_VIEWS','NO_VIEWS_2','OBLIQUE_ORIENTATION','OBSERVE_FREQUENCY','ORIENTATION','PHASE_CYCLE','READ/PHASE/SLICE_SELECTION','RECEIVER_FILTER','SAMPLE_PERIOD','SAMPLE_PERIOD_2','SCROLLBAR','SLICE_BLOCK','SLICE_FOV','SLICE_INTERLEAVE','SLICE_THICKNESS','SLICE_SEPARATION','SPECTRAL_WIDTH','SWEEP_WIDTH','SWEEP_WIDTH_2','VAR_ARRAY','VIEW_BLOCK','VIEWS_PER_SEGMENT','SMX','SMY','SWX','SWY','SMZ','SWZ','VAR','PHASE_ORIENTATION','X_ANGLE','Y_ANGLE','Z_ANGLE','PPL','IM_ORIENTATION','IM_OFFSETS'};
                %PPR_type_0 keywords have text fields only, e.g. ":PPL C:\ppl\smisim\1ge_tagging2_1.PPL"
                PPR_type_0 = [23 53];
                %PPR_type_1 keywords have single value, e.g. ":FOV 300"
                PPR_type_1 = [8 42:47];
                %PPR_type_2 keywords have single variable and single value, e.g. ":NO_SAMPLES no_samples, 16"
                PPR_type_2 = [4 7 9:11 15:21 25 31 33 41 49];
                PPR_type_3 = 48; % VAR keyword only (syntax same as above)
                PPR_type_4 = [28 29]; % :SAMPLE_PERIOD sample_period, 300, 19, "33.3 KHz  30 ?s" and SAMPLE_PERIOD_2 - read the first number=timeincrement in 100ns
                %PPR_type_5 keywords have single variable and two values, e.g. ":SLICE_THICKNESS gs_var, -799, 100"
                PPR_type_5 = [34 35];
                % KEYWORD [pre-prompt,] [post-prompt,] [min,] [max,] default, variable [,scale] [,further parameters ...];
                PPR_type_6 = [39 50:52]; % VAR_ARRAY and angles keywords
                PPR_type_7 = [54 55]; % IM_ORIENTATION and IM_OFFSETS (SUR only)

                par = struct('filename',filename);
                for j=1:size(cell_text{1},1)
                    char1 = char(cell_text{1}(j,:));
                    field_ = '';
                    if ~isempty(char1)
                        C = textscan(char1, '%*c%s %s', 1);
                        field_ = char(C{1});
                    end
                    % find matching number in PPR_keyword array:
                    num = find(strcmp(field_,PPR_keywords));
                    if num>0
                        if find(PPR_type_3==num) % :VAR keyword
                            C = textscan(char1, '%*s %s %f');
                            field_title = char(C{1}); field_title(numel(field_title)) = [];
                            numeric_field = C{2};
                            par = setfield(par, field_title, numeric_field); %#ok<*SFLD> 
                        elseif find(PPR_type_1==num)
                            C = textscan(char1, '%*s %f');
                            numeric_field = C{1};
                            par = setfield(par, field_, numeric_field);
                        elseif find(PPR_type_2==num)
                            C = textscan(char1, '%*s %s %f');
                            numeric_field = C{2};
                            par = setfield(par, field_, numeric_field);
                        elseif find(PPR_type_4==num)
                            C = textscan(char1, '%*s %s %n %n %s');
                            field_title = char(C{1}); field_title(numel(field_title)) = []; %#ok<*NASGU> 
                            numeric_field = C{2};
                            par = setfield(par, field_, numeric_field);
                        elseif find(PPR_type_0==num)
                            C = textscan(char1, '%*s %[^\n]');
                            text_field = char(C{1}); %text_field = reshape(text_field,1,[]);
                            par = setfield(par, field_, text_field);
                        elseif  find(PPR_type_5==num)
                            C = textscan(char1, '%*s %s %f %c %f');
                            numeric_field = C{4};
                            par = setfield(par, field_, numeric_field);
                        elseif  find(PPR_type_6==num)
                            C = textscan(char1, '%*s %s %f %c %f', 100);
                            field_ = char(C{1}); field_(end) = [];% the name of the array
                            num_elements = C{2}; % the number of elements of the array
                            numeric_field = C{4};
                            multiplier = [];
                            for l=4:numel(C)
                                multiplier = [multiplier C{l}];
                            end
                            pattern = ':';
                            k=1;
                            tline = char(cell_text{1}(j+k,:));
                            while (~contains(tline, pattern))
                                tline = char(cell_text{1}(j+k,:));
                                arr = textscan(tline, '%*s %f', num_elements);
                                multiplier = [multiplier, arr{1}']; %#ok<*AGROW> 
                                k = k+1;
                                tline = char(cell_text{1}(j+k,:));
                            end
                            par = setfield(par, field_, multiplier);
                        elseif find(PPR_type_7==num) % :IM_ORIENTATION keyword
                            C = textscan(char1, '%s %f %f %f');
                            field_title = char(C{1}); field_title(1) = [];
                            numeric_field = [C{2}, C{3}, C{4}];
                            par = setfield(par, field_title, numeric_field);
                        end
                    end
                end
                if isfield('OBSERVE_FREQUENCY','par')
                    C = textscan(par.OBSERVE_FREQUENCY, '%q');
                    text_field = char(C{1});
                    par.Nucleus = text_field(1,:);
                else
                    par.Nucleus = 'Unspecified';
                end
                par.datatype = datatype;
                file_pars = dir(filename);
                par.date = file_pars.date;
            else
                par = [];
            end
            par.scaling = scaling;

        end



        % ---------------------------------------------------------------------------------
        % Read b-type scanner file info
        % ---------------------------------------------------------------------------------
        function struct = jcampread(filename) %#ok<STOUT>

            % Open file read-only big-endian
            fid = fopen(filename,'r','b');
            skipline=0;

            % Loop through separate lines
            if fid~=-1
                while 1
                    if skipline
                        line=nextline;
                        skipline=0;
                    else
                        line=fgetl(fid);
                    end
                    % Testing the text lines
                    while length(line)<2
                        line=fgetl(fid);
                    end
                    % Parameters and optional size of parameter are on lines starting with '##'
                    if line(1:2) == '##' %#ok<*BDSCA>
                        % Parameter extracting and formatting
                        % Read parameter name
                        paramname = fliplr(strtok(fliplr(strtok(line,'=')),'#'));
                        % Check for illegal parameter names starting with '$' and correct (Matlab does not accepts variable names starting with $)
                        if paramname(1) == '$'
                            paramname = paramname(2:length(paramname));
                            % Check if EOF, if true return
                        elseif paramname(1:3) == 'END'
                            break
                        end
                        % Parameter value formatting
                        paramvalue = fliplr(strtok(fliplr(line),'='));

                        % Check if parameter values are in a matrix and read the next line
                        if paramvalue(1) == '('
                            paramvaluesize = str2num(fliplr(strtok(fliplr(strtok(paramvalue,')')),'(')));
                            % Create an empty matrix with size 'paramvaluesize' check if only one dimension
                            if ~isempty(paramvaluesize)
                                if size(paramvaluesize,2) == 1
                                    paramvaluesize = [paramvaluesize,1];
                                end
                                % Read the next line
                                nextline = fgetl(fid);
                                % See whether next line contains a character array
                                if nextline(1) == '<'
                                    paramvalue = fliplr(strtok(fliplr(strtok(nextline,'>')),'<')); %#ok<*NASGU>
                                elseif strcmp(nextline(1),'L') || strcmp(nextline(1),'A') || strcmp(nextline(1),'H')
                                    paramvalue = nextline;
                                else
                                    % Check if matrix has more then one dimension
                                    if paramvaluesize(2) ~= 1
                                        paramvaluelong = str2num(nextline);
                                        while (length(paramvaluelong)<(paramvaluesize(1)*paramvaluesize(2))) & (nextline(1:2) ~= '##') %#ok<*AND2>
                                            nextline = fgetl(fid);
                                            paramvaluelong = [paramvaluelong str2num(nextline)];
                                        end
                                        if (length(paramvaluelong)==(paramvaluesize(1)*paramvaluesize(2))) & (~isempty(paramvaluelong))
                                            paramvalue=reshape(paramvaluelong,paramvaluesize(1),paramvaluesize(2));
                                        else
                                            paramvalue=paramvaluelong;
                                        end
                                        if length(nextline)>1
                                            if (nextline(1:2) ~= '##')
                                                skipline=1;
                                            end
                                        end
                                    else
                                        % If only 1 dimension just assign whole line to paramvalue
                                        paramvalue = str2num(nextline);
                                        if ~isempty(str2num(nextline))
                                            while length(paramvalue)<paramvaluesize(1)
                                                line=fgetl(fid);
                                                paramvalue = [paramvalue str2num(line)];
                                            end
                                        end
                                    end
                                end
                            else
                                paramvalue='';
                            end
                        end

                        % Add paramvalue to structure.paramname
                        if isempty(findstr(paramname,'_'))
                            eval(['struct.' paramname '= paramvalue;']); %#ok<*EVLDOT>
                        else
                            try
                                eval(['struct.' lower(paramname(1:findstr(paramname,'_')-1)) '.' lower(paramname(findstr(paramname,'_')+1:length(paramname))) '= paramvalue;']);
                            catch
                                eval(['struct.' lower(paramname(1:findstr(paramname,'_')-1)) '.' datestr(str2num(paramname(findstr(paramname,'_')+1:findstr(paramname,'_')+2)),9) ...
                                    paramname(findstr(paramname,'_')+2:length(paramname)) '= paramvalue;']); %#ok<*FSTR>
                            end
                        end
                    elseif line(1:2) == '$$'
                        % The two $$ lines are not parsed for now
                    end
                end
                % Close file
                fclose(fid);

            end

        end % jcampread



        % ---------------------------------------------------------------------------------
        % Fractional circshift
        % ---------------------------------------------------------------------------------
        function output = fracCircShift(input,shiftsize)

            int = floor(shiftsize);     %integer portions of shiftsize
            fra = shiftsize - int;      %fractional portions of shiftsize
            dim = numel(shiftsize);
            output = input;
            for n = 1:numel(shiftsize)  %The dimensions are treated one after another.
                intn = int(n);
                fran = fra(n);
                shift1 = zeros(dim,1);
                shift1(n) = intn;
                shift2 = zeros(dim,1);
                shift2(n) = intn+1;
                %Linear intepolation:
                output = (1-fran)*circshift(output,shift1) + fran*circshift(output,shift2);
            end

        end % fracCircShift


        % ---------------------------------------------------------------------------------
        % 3D partial derivatives
        % ---------------------------------------------------------------------------------
        function [dydtx,dydty,dydtz] = partialDerivative3D(app,kTraj,xNew,calibSize)

            nCoils = size(xNew,4);

            kx = squeeze(kTraj(1,:,:));
            ky = squeeze(kTraj(2,:,:));
            kz = squeeze(kTraj(3,:,:));

            dkx = zeros(size(kx));
            dky = zeros(size(ky));
            dkz = zeros(size(kz));

            dkx(2:end,:) = kx(2:end,:)- kx(1:end-1,:);
            dky(2:end,:) = ky(2:end,:)- ky(1:end-1,:);
            dkz(2:end,:) = kz(2:end,:)- kz(1:end-1,:);
            xNewFFT = 1j*retroReco.ifft3Dmri(xNew);

            repX = repmat([0:(calibSize(1)/2-1), 0, -calibSize(1)/2+1:-1]'/calibSize(1),[1 calibSize(1) calibSize(1) nCoils]);
            repY = permute(repX,[2 1 3]);
            repZ = permute(repX,[3 1 2]);

            tmp = xNewFFT.*repX;
            tmpCalib = bart(app,'bart nufft',kTraj,reshape(tmp,[calibSize nCoils]));
            dydkx = reshape(tmpCalib,[size(kx) nCoils]);

            tmp = xNewFFT.*repY;
            tmpCalib = bart(app,'bart nufft',kTraj,reshape(tmp,[calibSize nCoils]));
            dydky = reshape(tmpCalib,[size(kx) nCoils]);

            tmp = xNewFFT.*repZ;
            tmpCalib = bart(app,'bart nufft',kTraj,reshape(tmp,[calibSize nCoils]));
            dydkz = reshape(tmpCalib,[size(kx) nCoils]);

            dydtx = dydkx.*repmat(dkx,[1 1 1 nCoils]);
            dydty = dydky.*repmat(dky,[1 1 1 nCoils]);
            dydtz = -dydkz.*repmat(dkz,[1 1 1 nCoils]); % positive does not converge

            dydtx(isnan(dydtx)) = 0;
            dydty(isnan(dydty)) = 0;
            dydtz(isnan(dydtz)) = 0;

        end % partialDerivative3D




        % ---------------------------------------------------------------------------------
        % 2D partial derivatives
        % ---------------------------------------------------------------------------------
        function [dydtx,dydty] = partialDerivative2D(app,kTraj,Xnew,calibSize)

            nCoils = size(Xnew,3);

            kx = squeeze(kTraj(1,:,:));
            ky = squeeze(kTraj(2,:,:));

            dkx = zeros(size(kx));
            dky = zeros(size(ky));

            dkx(2:end,:) = kx(2:end,:)- kx(1:end-1,:);
            dky(2:end,:) = ky(2:end,:)- ky(1:end-1,:);

            tmp =(1j*retroReco.ifft2Dmri(Xnew).*repmat([0:(calibSize(1)/2-1), 0, -calibSize(1)/2+1:-1]'/calibSize(1),[1 calibSize(2) nCoils]));
            tmpCalib = bart(app,'bart nufft',kTraj,reshape(tmp,[calibSize 1 nCoils]));
            dydkx = reshape(tmpCalib,[size(kx) nCoils]);

            tmp = (1j*retroReco.ifft2Dmri(Xnew).*repmat([0:(calibSize(1)/2-1), 0, -calibSize(1)/2+1:-1]/calibSize(1),[calibSize(1) 1 nCoils]));
            tmpCalib = bart(app,'bart nufft',kTraj,reshape(tmp,[calibSize 1 nCoils]));
            dydky = reshape(tmpCalib,[size(kx) nCoils]);

            dydtx = dydkx.*repmat(dkx,[1 1 nCoils]);
            dydty = dydky.*repmat(dky,[1 1 nCoils]);

            dydtx(isnan(dydtx)) = 0;
            dydty(isnan(dydty)) = 0;

        end % partialDerivative2D
        
        
        
        % ---------------------------------------------------------------------------------
        % Low rank threshold 3D
        % ---------------------------------------------------------------------------------
        function Xnew = lowRankThresh3D(Xold,kSize,thresh)

            thresh = round(thresh);

            keep = 1:thresh;

            [sx,sy,sz,~] = size(Xold);
            tmp = retroReco.im2row3D(Xold,kSize);
            [tsx,tsy,Nc] = size(tmp);
            A = reshape(retroReco.im2row3D(Xold,kSize),tsx,tsy*Nc);

            [U,S,V] = svd(A,'econ');
            A = U(:,keep)*S(keep,keep)*V(:,keep)';

            A = reshape(A,tsx,tsy*Nc);

            Xnew = retroReco.row2im3D(A,[sx,sy,sz,Nc],kSize);

        end % lowRankThresh3D



        % ---------------------------------------------------------------------------------
        % Low rank threshold 2D
        % ---------------------------------------------------------------------------------
        function Xnew = lowRankThresh2D(Xold,kSize,thresh)

            thresh = round(thresh);

            keep = 1:thresh;
       
            [sx,sy,Nc] = size(Xold);
            tmp = retroReco.im2row2D(Xold,kSize); 

            [tsx,tsy,tsz] = size(tmp);
            A = reshape(retroReco.im2row2D(Xold,kSize),tsx,tsy*tsz);

            [U,S,V] = svd(A,'econ');
            A = U(:,keep)*S(keep,keep)*V(:,keep)';

            A = reshape(A,tsx,tsy,tsz);       

            Xnew = retroReco.row2im2D(A,[sx,sy,Nc],kSize);

        end % lowRankThresh2D



        % ---------------------------------------------------------------------------------
        % Trajectory interpolation 
        % ---------------------------------------------------------------------------------
        function kSpaceNew = trajInterpolation(kSpaceOld,dShift)

            kSpaceNew = zeros(size(kSpaceOld));

            for idx6 = 1:size(kSpaceOld,6) % dynamics

                for idx5 = 1:size(kSpaceOld,5) % frames

                    for idx4 = 1:size(kSpaceOld,4) % slices

                        for idx3 = 1:size(kSpaceOld,3) % spokes

                            kx = interp1((1:size(kSpaceOld,2))+dShift(1),kSpaceOld(1,:,idx3,idx4,idx5,idx6),1:size(kSpaceOld,2),'linear'); %Kx
                            ky = interp1((1:size(kSpaceOld,2))+dShift(2),kSpaceOld(2,:,idx3,idx4,idx5,idx6),1:size(kSpaceOld,2),'linear'); %Ky
                            kz = interp1((1:size(kSpaceOld,2))+dShift(3),kSpaceOld(3,:,idx3,idx4,idx5,idx6),1:size(kSpaceOld,2),'linear'); %Kz

                            if dShift(1) > 0
                                kx(isnan(kx)) = 0;
                            else
                                kx(isnan(kx)) = kSpaceOld(1,isnan(kx),idx3,idx4,idx5,idx6);
                            end

                            if dShift(2) > 0
                                ky(isnan(ky)) = 0;
                            else
                                ky(isnan(ky)) = kSpaceOld(2,isnan(ky),idx3,idx4,idx5,idx6);
                            end

                            if dShift(3) > 0
                                kz(isnan(kz)) = 0;
                            else
                                kz(isnan(kz)) = kSpaceOld(3,isnan(kz),idx3,idx4,idx5,idx6);
                            end

                            kSpaceNew(1,:,idx3,idx4,idx5,idx6) = kx(:);
                            kSpaceNew(2,:,idx3,idx4,idx5,idx6) = ky(:);
                            kSpaceNew(3,:,idx3,idx4,idx5,idx6) = kz(:);

                        end

                    end

                end

            end

        end % kSpaceInterpolation




        % ---------------------------------------------------------------------------------
        % image to rows 3D
        % ---------------------------------------------------------------------------------
        function res = im2row3D(im, winSize)

            [sx,sy,sz,nc] = size(im);
            res = zeros((sx-winSize(1)+1)*(sy-winSize(2)+1)*(sz-winSize(3)+1),prod(winSize),nc);

            count=0;
            for z=1:winSize(3)
                for y=1:winSize(2)
                    for x=1:winSize(1)
                        count = count+1;
                        res(:,count,:) = reshape(im(x:sx-winSize(1)+x,y:sy-winSize(2)+y,z:sz-winSize(3)+z),...
                            (sx-winSize(1)+1)*(sy-winSize(2)+1)*(sz-winSize(3)+1),nc);
                    end
                end
            end

        end % im2row3D


                
        % ---------------------------------------------------------------------------------
        % image to rows 2D
        % ---------------------------------------------------------------------------------
        function res = im2row2D(im, winSize)

            [sx,sy,sz] = size(im);
            res = zeros((sx-winSize(1)+1)*(sy-winSize(2)+1),prod(winSize),sz);

            count=0;
            for y=1:winSize(2)
                for x=1:winSize(1)
                    count = count+1;
                    res(:,count,:) = reshape(im(x:sx-winSize(1)+x,y:sy-winSize(2)+y,:),...
                        (sx-winSize(1)+1)*(sy-winSize(2)+1),1,sz);
                end
            end

        end % im2row2D



        % ---------------------------------------------------------------------------------
        % rows to image 3D
        % ---------------------------------------------------------------------------------
        function [res,W] = row2im3D(mtx, imSize, winSize)

            nCoils = size(mtx,4);
            sx = imSize(1);
            sy = imSize(2);
            sz = imSize(3);
            res = zeros(imSize(1),imSize(2),imSize(3),nCoils);
            W = res;

            count=0;
            for z=1:winSize(3)
                for y=1:winSize(2)
                    for x=1:winSize(1)
                        count = count+1;
                        res(x:sx-winSize(1)+x,y:sy-winSize(2)+y,z:sz-winSize(3)+z,:) = res(x:sx-winSize(1)+x,y:sy-winSize(2)+y,z:sz-winSize(3)+z,:) + reshape(mtx(:,count,:,:),(sx-winSize(1)+1),(sy-winSize(2)+1),(sz-winSize(3)+1),nCoils);
                        W(x:sx-winSize(1)+x,y:sy-winSize(2)+y,z:sz-winSize(3)+z,:) = W(x:sx-winSize(1)+x,y:sy-winSize(2)+y,z:sz-winSize(3)+z,:)+1;
                    end
                end
            end

            res = res./W;

        end % row2im3D


        % ---------------------------------------------------------------------------------
        % rows to image 2D
        % ---------------------------------------------------------------------------------
        function [res,W] = row2im2D(mtx,imSize, winSize)

            sz = size(mtx,3);
            sx = imSize(1); 
            sy = imSize(2);
            res = zeros(imSize(1),imSize(2),sz);
            W = res;

            count=0;
            for y=1:winSize(2)
                for x=1:winSize(1)
                    count = count+1;
                    res(x:sx-winSize(1)+x,y:sy-winSize(2)+y,:) = res(x:sx-winSize(1)+x,y:sy-winSize(2)+y,:) + reshape(mtx(:,count,:),(sx-winSize(1)+1),(sy-winSize(2)+1),sz);
                    W(x:sx-winSize(1)+x,y:sy-winSize(2)+y,:) = W(x:sx-winSize(1)+x,y:sy-winSize(2)+y,:)+1;
                end
            end

            res = res./W;

        end % row2im



        % ---------------------------------------------------------------------------------
        % Vectorize
        % ---------------------------------------------------------------------------------
        function v = vec(x)

            % VEC   Vectorize.
            % VEC(X), where X is a vector, matrix, or N-D array, returns a column vector
            % Containing all of the elements of X; i.e., VEC(X)=X(:).

            v = reshape(x, numel(x), 1);

        end % vec



        % ---------------------------------------------------------------------------------
        % FFT 3D
        % ---------------------------------------------------------------------------------
        function X = fft3Dmri(x)

            X=fftshift(ifft(fftshift(x,1),[],1),1)*sqrt(size(x,1));
            X=fftshift(ifft(fftshift(X,2),[],2),2)*sqrt(size(x,2));
            X=fftshift(ifft(fftshift(X,3),[],3),3)*sqrt(size(x,3));

        end % FFT 3D



        % ---------------------------------------------------------------------------------
        % iFFT 3D
        % ---------------------------------------------------------------------------------
        function x=ifft3Dmri(X)

            x=fftshift(fft(fftshift(X,1),[],1),1)/sqrt(size(X,1));
            x=fftshift(fft(fftshift(x,2),[],2),2)/sqrt(size(X,2));
            x=fftshift(fft(fftshift(x,3),[],3),3)/sqrt(size(X,3));

        end


       
        % ---------------------------------------------------------------------------------
        % FFT 2D
        % ---------------------------------------------------------------------------------
        function X = fft2Dmri(x)

            X=fftshift(ifft(fftshift(x,1),[],1),1)*sqrt(size(x,1));
            X=fftshift(ifft(fftshift(X,2),[],2),2)*sqrt(size(x,2));
        
        end % FFT 2D



        % ---------------------------------------------------------------------------------
        % iFFT 2D
        % ---------------------------------------------------------------------------------
        function x=ifft2Dmri(X)

            x=fftshift(fft(fftshift(X,1),[],1),1)/sqrt(size(X,1));
            x=fftshift(fft(fftshift(x,2),[],2),2)/sqrt(size(X,2));
   
        end




    end % Static methods



end % proudData Class

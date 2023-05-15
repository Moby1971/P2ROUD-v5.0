classdef proudData

    % Data and parameter class for P2ROUD app
    %
    % Gustav Strijkers
    % g.j.strijkers@amsterdamumc.nl
    % February 2023
    %

    properties

        % Data
        rawKspace = {}                                      % raw k-space data
        unsKspace = {}                                      % unsorted k-space data
        mrdKspace = []                                      % k-space data from MRD file
        images = []                                         % magnitude images
        phaseImages = []                                    % phase images
        phaseImagesOrig = []                                % original phase images (without unwrapping)
        flowImages = []                                     % flow images
        mask = []                                           % image mask
        nsaSpace = []                                       % number of signal averages per k-point
        fillingSpace = []                                   % filling (1 = yes / 0 = no) per k-point
        pixelSize = []                                      % pixel size (mm)
        mrdFooter                                           % original MRD footer data
        newMrdFooter                                        % new MRD footer data for export
        rprFile = []                                        % original RPR file data
        sqlFile = []                                        % SQL file data
        newRprFile;                                         % new RPR file data for export
        totalVariation = 'T'                                % total variation  (T) or total generalized variation (G)
        memSize                                             % for testing testing memory size

        % Filenames
        filename;
        PPL = 'unknown'

        % Sequence parameters   
        dataType = '2D'                                     % data type (2D, 2Dms, 3D, 3Dute, 2Dradial)
        totalAcqTime = 0                                    % total acquisition time
        NO_SAMPLES = 1                                      % number of samples (readout)
        SAMPLE_PERIOD                                       % sample period 
        NO_SAMPLES_ORIG = 1                                 % original number of samples (readout)
        NO_VIEWS = 1                                        % number of views1 (phase encoding 2)
        NO_VIEWS_ORIG = 1                                   % original number of views1 (phase encoding 2)
        NO_VIEWS_2 = 1                                      % number of views2 (phase encoding 2)
        NO_VIEWS_2_ORIG = 1                                 % original number of views2 (phase encoding 2)
        no_switches = 1                                     % number of switches
        no_pts_switch = 1                                   % number of pts switches
        DISCARD = 0                                         % number of discarded readout points
        EXPERIMENT_ARRAY = 1                                % number of experiments/repetitions
        oversample = 0                                      % oversample factor in readout direction
        nr_repetitions = 1                                  % number of repetitions
        NO_AVERAGES = 1                                     % number of averages
        NO_SLICES = 1                                       % number of slices
        NO_ECHOES = 1                                       % number of echoes
        nav_on = 0                                          % navigator on (1) / off (0)
        VIEWS_PER_SEGMENT = 0                               % views per segment / interleaved scanning
        lines_per_segment = 1                               % lines per segment
        SLICE_THICKNESS = 1                                 % slice thickness (mm)
        SLICE_SEPARATION = 1                                % slice separation (mm)
        SLICE_INTERLEAVE = 1                                % slice interleave type
        slab_ratio = 80                                     % slab ratio (oversampling)
        r_angle_var                                         % X angle
        p_angle_var                                         % Y angle
        s_angle_var                                         % Z angle
        nr_coils = 1                                        % MRD file number of coils
        nrCoils = 1                                         % number of coils
        FOV = 30                                            % field of view (mm)
        PHASE_ORIENTATION = 0                               % phase orientation 1 = hor. 0 = vert.
        FOVf = 8                                            % field-of-view factor aspect ratio = FOVf/8
        aspectratio = 1                                     % image aspect ratio
        alpha = 20                                          % flip angle
        te = 2                                              % integer echo time (ms)
        te_us = 0                                           % additional echo time (us)
        TE                                                  % echo time TE = te + te_us
        tr = 10                                             % integer TR time (ms)
        tr_extra_us = 0                                     % additional TR time (us)
        TR                                                  % repitition time TR = tr + tr_extra_us
        ti = 1000                                           % inversion time
        VFA_angles = []                                     % MRD file flip angles
        VFA_size = 0                                        % flip angle array size (0 = no array = 1 flip angle)
        flipAngleArray = []                                 % array of flip angles
        frame_loop_on = 0                                   % CINE imaging on (1) / off (0)
        radial_on = 0                                       % radial scanning on (1) / off (0)
        slice_nav = 0                                       % slice navigator on (1) / off (0)
        date                                                % scan date
        pixelshift1 = 0                                     % image shift in views direction
        pixelshift2 = 0                                     % image shift in views2 direction
        coil_scaling = 1                                    % MRD file coil scaling (not used)
        coilSensitivities = [1 1 1 1 1 1 1 1]               % coil sensitiviy calibration
        scanner = 'MRS'                                     % scanner type (MR Solutions)
        field_strength = 7                                  % field strength (7T)
        acqdur = 0                                          % acquisition duration
        timeperframe = 0                                    % time per CINE frame
        nr_frames = 1                                       % number of CINE frames

        % K-space trajectory related
        pe1_order = 0                                       % views2 phase-encoding ordering
        pe2_centric_on = 0                                  % views2 centric ordering true (1) / false (0)
        pe2_traj = 0                                        % views2 trajectory type
        gp_var_mul = []                                     % MRD phase encoding array
        gp_var_proud = []                                   % P2ROUD k-space phase-encoding array (legacy)
        trajType = ''                                       % trajectory type (3Dute, 2Dradial)
        seqTrajectory                                       % k-space trajectory
        proudArray = []                                     % P2ROUD sequence array
        gradTrajectory = []                                 % gradient calibration trajectory (3D UTE)

        % Flow related
        venc = 0                                            % flow encoding VENC
        vencAmp = []                                        % MRD file VENC
        flowCompOn = 0                                      % flow compensation on (1) or off (0)
        vencTable = []                                      % VENC orientation table
   
        % Navigator related
        no_samples_nav = 10                                 % number of navigator samples
        no_samples_discard = 35                             % number of points discarded after navigator

        % Segmentation related
        threshold = 0                                       % segmentation threshold
        
        % Flags
        validFile_flag = false                              % valid MRD file true/false
        validReco_flag = false                              % valid reconstruction true/false
        validVenc_flag = false                              % valid VENC values true/false
        validFlow_flag = false                              % valid flow images true/false
        validMask_flag = false                              % valid mask true/false
        multiEchoes_flag = false                            % multiple echoes true/false
        multiRepetitions_flag = false                       % multiple repetitions true/false
        multiFlipAngles_flag = false                        % multiple flip angles true/false
        multiCoil_flag = false                              % multiple receiver coils true/false
        multiSlab_flag = false                              % multiple 3D slabs true/false
        halfFourier_flag = false                            % half Fourier imaging
        segmentedData_flag = false                          % segmented data acquisition true/false
        validTrajectory_flag = false                        % valid k-space trajectory true/false
        rprFile_flag = false                                % RPR file data available true/false
        proudRecoScan_flag = false                          % MRD data from P2ROUD app true/false
        retroRecoScan_flag = false                          % MRD data from Retrospective app true/false
        coilActive_flag = [1 1 1 1 1 1 1]                   % active coil (1 = yes / 0 = no)
        sqlFlag = false                                     % SQL file available true / false
  
        % Parameters from SQL file
        SQLnumberOfSlices = 1                               % number of slices
        SQLsliceGap = 0                                     % slice gap
        SQLangleX = 0                                       % angle X
        SQLangleY = 0                                       % angle Y
        SQLangleZ = 0                                       % angle Z
        SQLoffsetX = 0                                      % offset X
        SQLoffsetY = 0                                      % offset Y
        SQLoffsetZ = 0                                      % offset Z

        % Image shifts & orientations
        xShift = 0                                          % image shift in X direction
        yShift = 0                                          % image shift in Y direction
        fov_read_off = 0                                    % read-offset from MRD file
        fov_phase_off = 0                                   % phase-offset from MRD file
        LRvec = [1 0 0]'                                    % left-right orientation vector
        APvec = [0 1 0]'                                    % anterior-posterior orientation vector
        HFvec = [0 0 1]'                                    % head-feet orientation vector
        topLabel = ' ';                                     % top label
        bottomLabel = ' ';                                  % bottom label
        leftLabel = ' ';                                    % left label
        rightLabel = ' ';                                   % right label
     
    end % properties



    % -----------------------------------------------------------------
    % Public methods
    % -----------------------------------------------------------------
    %
    % obj = proudData()
    % obj = setNumberOfCoils(obj, app, flist)
    % obj = readProudData(obj, app, mrdfile, flist)
    % obj = readBtypeData(obj, app, mrdfile, flist)
    % obj = readMrdFooter(obj, mrdfile)
    % obj = makeMrdFooter(obj, par)
    % obj = readSQLfile(obj, app, filename)
    % obj = sqlParameters(obj, app)
    % obj = readRprFile(obj, app, fn)
    % obj = writeToRprFile(obj, filename)
    % obj = makeRprFile(obj, par)
    % obj = writeDataToMrd(obj, filename, parameters)
    % obj = setDataParameters(obj, app)
    % obj = permute3Dkspace(obj)
    % obj = permute2Dkspace(obj)
    % obj = sortScanner2DKspaceMRD(obj, app, kTable)
    % obj = sortScanner3DKspaceMRD(obj, app, kTable)
    % obj = sort2DsegmKspaceMRD(obj, app)
    % obj = sort2DKspaceMRD(obj, app)
    % obj = sort3DKspaceMRD(obj, app)
    % obj = sort3DProudKspaceMRD(obj, app)
    % obj = chopNav(obj)
    % obj = applyTukey(obj)
    % obj = csReco2DCine(obj,app,flipAngle)
    % obj = csReco2D(obj,app,flipAngle,echoTime)
    % obj = fftReco2D(obj,app,flipAngle,echoTime)
    % obj = csReco3D(obj,app,flipAngle,echoTime)
    % obj = fftReco3D(obj,app,flipAngle,echoTime)
    % obj = Reco2DRadialCS(obj,app,flipAngle,echoTime)
    % obj = Reco2DRadialNUFFT(obj,app,flipAngle,echoTime)
    % obj = unRing(obj,app)
    % obj = scaleImages(obj)
    % obj = calcPixelSize(obj,app)
    % obj = backToKspace(obj)
    % obj = recoSurFiles(obj, surpath, suffix, mrdfilename, rprfilename)
    % obj = unwrap3D(obj)
    % obj = calcFlow(obj)
    % obj = ExportRecoParametersFcn(obj, app, exportdir)
    % obj = calc2DimageShift(obj, image, app)
    % 
    %
    % -----------------------------------------------------------------
    % Static methods
    % -----------------------------------------------------------------
    %
    % output = circTukey2D(dimy,dimx,row,col,filterwidth)
    % output = circTukey3D(dimz,dimy,dimx,lev,row,col,filterwidth)
    % y = gauss(x,s,m)
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
    % x = ifft3Dmri(X)
    % X = fft2Dmri(x)
    % x = ifft2Dmri(X)
    % traj = twoDradialTrajectory(dimx, dimy, dimz, dimd, dims)
    % imOut = image2Dshift(imIn, xShift, yShift)
    %
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

            % Determine whether data is from multiple receiver coils

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

            % Read the k-space data from the MRD file

            obj.proudRecoScan_flag = false;
            obj.retroRecoScan_flag = false;
            obj.validFile_flag = true;

            obj.rawKspace = {};    % raw k-space data already (pre-)sorted by importMRD function
            obj.unsKspace = {};    % unsorted k-space data

            % Loop over all coils
            for i=1:obj.nrCoils
            
                app.TextMessage(strcat('Loading coil #',num2str(i)));
                
                if contains(mrdfile,'p2roud')
                    % Data previously generated by the P2ROUD app
                    obj.proudRecoScan_flag = true;
                    [obj.rawKspace{i},~,parameters,obj.unsKspace{i}] = proudData.importMRD(fullfile(flist(i).folder,flist(i).name),'seq','seq');
                elseif contains(mrdfile,'retro')
                    % Data generated by the retrospective app
                    obj.retroRecoScan_flag = true;
                    [obj.rawKspace{i},~,parameters,obj.unsKspace{i}] = proudData.importMRD(fullfile(flist(i).folder,flist(i).name),'seq','seq');
                else
                    % All other scanner-generated data
                    [obj.rawKspace{i},~,parameters,obj.unsKspace{i}] = proudData.importMRD(fullfile(flist(i).folder,flist(i).name),'seq','cen');
                end
              
                if isfield(parameters,'pe2_centric_on') && isfield(parameters,'NO_VIEWS_2')
                     % If views2 direction turns out to be linearly ordered re-read the data
                     if parameters.pe2_centric_on == 0 && parameters.NO_VIEWS_2 > 1
                         [obj.rawKspace{i},~,parameters,obj.unsKspace{i}] = proudData.importMRD(fullfile(flist(i).folder,flist(i).name),'seq','seq');
                     end
                end

            end

        
            % Assign the MRD footer variables to object variables

            if isfield(parameters,'filename')
                obj.filename = parameters.filename;
            end

            if isfield(parameters,'PPL')
                parameters.PPL = replace(parameters.PPL,'\',filesep);
                [~,name,ext] = fileparts(parameters.PPL);
                obj.PPL = strcat(name,ext);
            end

            if isfield(parameters,'NO_SAMPLES') && isfield(parameters,'NO_VIEWS')
                if isfield(parameters,'PPL')
                    if contains(parameters.PPL,"epi")
                        if parameters.NO_VIEWS == 1
                            parameters.NO_SAMPLES = parameters.NO_SAMPLES/parameters.no_switches;
                        end
                    end
                end
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
                if isfield(parameters,'PPL')
                   if contains(parameters.PPL,"epi")
                        parameters.NO_VIEWS = parameters.no_switches;
                   end
                end
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

            if isfield(parameters,'lines_per_segment')
                obj.lines_per_segment = parameters.lines_per_segment;
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

            if isfield(parameters,'fov_read_off')
                obj.fov_read_off = parameters.fov_read_off;
            end

            if isfield(parameters,'fov_phase_off')
                obj.fov_phase_off = parameters.fov_phase_off;
            end

            if isfield(parameters,'SAMPLE_PERIOD')
                obj.SAMPLE_PERIOD = parameters.SAMPLE_PERIOD;
            end

            if isfield(parameters,'no_switches')
                obj.no_switches = parameters.no_switches;
            end

            if isfield(parameters,'no_pts_switch')
                obj.no_pts_switch = parameters.no_pts_switch;
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

            % Makes a new MRD file footer by replacing old values with new ones

            inputfooter = obj.mrdFooter;

            % Search parameters
            parameters = {':NO_SAMPLES no_samples, ',':NO_VIEWS no_views, ',':NO_VIEWS_2 no_views_2, ', ...
                ':NO_ECHOES no_echoes, ',':EXPERIMENT_ARRAY no_experiments, ',':NO_AVERAGES no_averages, ', ...
                ':VAR pe1_order, ',':VAR pe2_centric_on, ',':VAR slice_nav, ',':VAR radial_on, ', ...
                ':VAR frame_loop_on, ',':VAR tr, ',':VAR te, ', ...
                ':BATCH_SLICES batch_slices, ',':NO_SLICES no_slices, ' ...
                ':VIEWS_PER_SEGMENT views_per_seg, ',':DISCARD no_discard, ' ...
                ':VAR nav_on, ',':VAR tr_extra_us, ',':VAR te_us, ',':SLICE_THICKNESS gs_var, '

                };

            % Replacement values
            replacepars = {par.NoSamples,par.NoViews,par.NoViews2, ...
                par.NoEchoes,par.NoExperiments,par.NoAverages, ...
                par.peorder,par.pe2_centric_on,par.slicenav,par.radialon, ...
                par.frameloopon,par.tr,par.te, ...
                par.batchslices,par.NoSlices, ...
                par.viewspersegment,par.nodiscard, ...
                par.navon,par.tr_extra_us,par.te_us,par.SLICE_THICKNESS

                };

            % Loop over all parameter names
            for i = 1:length(parameters)

                txt = parameters{i};
                var = replacepars{i};

                % Find the position of the parameter
                pos = strfind(inputfooter,txt);

                if ~isempty(pos)
                    
                    % Determine which part should be replaced
                    oldtxtlength = strfind(inputfooter(pos+length(txt):pos+length(txt)+12),newline)-1;

                    % Slice thickness is a special case
                    if contains(txt,'SLICE_THICKNESS')
                        commapos = [];
                        commapos = strfind(inputfooter(pos+length(txt):pos+length(txt)+8),',');
                        inputfooter = insertAfter(inputfooter,pos+length(txt)+commapos,'      ');
                        pos = pos+commapos;
                        oldtxtlength = oldtxtlength + 1;
                    end

                    try
                        % Replace the values with the new ones
                        newtext = strcat(num2str(var));
                        inputfooter = replaceBetween(inputfooter,pos+length(txt),pos+length(txt)+oldtxtlength-1,newtext);
                    catch
                    end

                end

            end

            % Return the new MRD footer object
            obj.newMrdFooter  = inputfooter;

        end % makeMrdFooter




        % ---------------------------------------------------------------------------------
        % Read SQL file
        % ---------------------------------------------------------------------------------
        function obj = readSQLfile(obj, app, filename)
            
            try
                fid = fopen(filename,'r');
                obj.sqlFile = char(fread(fid,Inf,'uchar')');
                fclose(fid);
                obj.sqlFlag = true;
            catch
                obj.sqlFile = '';
                obj.sqlFlag = false;
                app.TextMessage('WARNING: SQL file not found ...');
            end

        end % readSQLfile




        % ---------------------------------------------------------------------------------
        % Get some parameters from SQL file
        % ---------------------------------------------------------------------------------
        function obj = sqlParameters(obj, app)

            if obj.sqlFlag

                if ~isempty(obj.sqlFile)

                    sqlData = obj.sqlFile;

                    try

                        % Group settings
                        groupSettings = strfind(sqlData,'[GROUP SETTINGS]');
                        posStart = strfind(sqlData(groupSettings:end),'VALUES(');
                        posStart = posStart(1)+groupSettings+6;
                        posEnd = strfind(sqlData(posStart:end),')');
                        posEnd = posEnd(1)+posStart-2;
                        groupData = sqlData(posStart:posEnd);
                        values = textscan(groupData, '%f %s %f %f %f %f %f %f %f %f %f %f','Delimiter',',');

                        obj.SQLnumberOfSlices = values{4};
                        obj.SQLsliceGap = values{5};
                        obj.SQLangleX = values{6};
                        obj.SQLangleY = values{7};
                        obj.SQLangleZ = values{8};
                        obj.SQLoffsetX = values{9};
                        obj.SQLoffsetY = values{10};
                        obj.SQLoffsetZ = values{11};


                    catch ME

                        app.TextMessage(ME.message);
                        app.TextMessage('WARNING: Something went wrong analyzing SQL file group settings ...');
                        app.SetStatus(1);

                        obj.sqlFlag = false;

                    end

                end

            end

        end % sqlParameters


        % ---------------------------------------------------------------------------------
        % Calculate image orientation labels
        % ---------------------------------------------------------------------------------
        function obj = imageOrientLabels(obj, app)

            obj.leftLabel   = ' ';
            obj.rightLabel  = ' ';
            obj.topLabel    = ' ';
            obj.bottomLabel = ' ';
       
            try

                if ismember(app.OrientationSpinner.Value,[1 7 10])

                    % Start from axial orientation, head first, supine
                    obj.LRvec = [ 1  0  0 ]';
                    obj.APvec = [ 0  1  0 ]';
                    obj.HFvec = [ 0  0  1 ]';
                  
                    % Rotate the vectors according to the angle values
                    % Add a tiny angle to make the chance of hitting 45 degree angles for which orientation is indetermined very unlikely
                    tinyAngle = 0.00001;
                    obj.LRvec = rotz(obj.SQLangleZ+tinyAngle)*roty(obj.SQLangleY+tinyAngle)*rotx(obj.SQLangleX+tinyAngle)*obj.LRvec;
                    obj.APvec = rotz(obj.SQLangleZ+tinyAngle)*roty(obj.SQLangleY+tinyAngle)*rotx(obj.SQLangleX+tinyAngle)*obj.APvec;
                    obj.HFvec = rotz(obj.SQLangleZ+tinyAngle)*roty(obj.SQLangleY+tinyAngle)*rotx(obj.SQLangleX+tinyAngle)*obj.HFvec;

                    % Determine the orientation combination
                    % This is done by determining the main direction of the vectors
                    [~, indxLR1] = max(abs(obj.LRvec(:)));
                    [~, indxAP1] = max(abs(obj.APvec(:)));
                    [~, indxHF1] = max(abs(obj.HFvec(:)));
                    indxLR2 = sign(obj.LRvec(indxLR1));
                    indxAP2 = sign(obj.APvec(indxAP1));
                    indxHF2 = sign(obj.HFvec(indxHF1));
                    indxLR2(indxLR2 == -1) = 2;
                    indxAP2(indxAP2 == -1) = 2;
                    indxHF2(indxHF2 == -1) = 2;

                    labelsPrimary   = [ 'R','L' ; 'A','P' ; 'F','H'];
                    labelsSecondary = [ 'L','R' ; 'P','A' ; 'H','F'];
               
                    % Sort the labels according to the starting orientation
                    labelsPrimary   = [labelsPrimary(indxLR1,indxLR2),labelsPrimary(indxAP1,indxAP2),labelsPrimary(indxHF1,indxHF2)];
                    labelsSecondary = [labelsSecondary(indxLR1,indxLR2),labelsSecondary(indxAP1,indxAP2),labelsSecondary(indxHF1,indxHF2)];

                    % Which dimensions are displayed
                    ov1 = app.imageOrient(app.OrientationSpinner.Value,1);
                    ov2 = app.imageOrient(app.OrientationSpinner.Value,2);

                    % Assign the labels
                    obj.rightLabel   = labelsPrimary(ov1);
                    obj.leftLabel  = labelsSecondary(ov1);
                    obj.topLabel    = labelsPrimary(ov2);
                    obj.bottomLabel = labelsSecondary(ov2);

                end

            catch ME

                app.TextMessage(ME.message);

            end

        end % imageOrient




        % ---------------------------------------------------------------------------------
        % Read RPR 
        % ---------------------------------------------------------------------------------
        function obj = readRprFile(obj, app, fn)

            % Read the RPR file data

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

            % Write the new RPR file to disk

            fid = fopen(filename,'wb');
            fwrite(fid,obj.newRprFile,'int8');
            fclose(fid);

        end % writeToRprFile




        % ---------------------------------------------------------------------------------
        % Make RPR file
        % ---------------------------------------------------------------------------------
        function obj = makeRprFile(obj, par)

            % Makes a new RPR file by replacing old values with new ones
            % The RPR file will be used by the MR Solutions software to make a reconstruction 
            % and import the data into preclinical

            inputrpr = obj.rprFile;

            % Parameter names
            parameters = {
                ':EDITTEXT LAST_ECHO ',':EDITTEXT MAX_ECHO ', ...
                ':EDITTEXT LAST_EXPT ',':EDITTEXT MAX_EXPT ', ...
                ':EDITTEXT SAMPLES_DIM1 ',':EDITTEXT DATA_LENGTH1 ', ':EDITTEXT OUTPUT_SIZE1 ', ...
                ':EDITTEXT SAMPLES_DIM2 ',':EDITTEXT DATA_LENGTH2 ', ':EDITTEXT OUTPUT_SIZE2 ', ...
                ':EDITTEXT SAMPLES_DIM3 ',':EDITTEXT DATA_LENGTH3 ', ':EDITTEXT OUTPUT_SIZE3 ', ...
                ':EDITTEXT LAST_SLICE ',':EDITTEXT MAX_SLICE ', ...
                ':COMBOBOX FFT_DIM1 ',':COMBOBOX FFT_DIM2 ',':COMBOBOX FFT_DIM3 ', ...
                ':RADIOBUTTON VIEW_ORDER_1',':RADIOBUTTON VIEW_ORDER_2', ...
                ':EDITTEXT VIEWS_PER_SEGMENT ', ...
                ':COMBOBOX RECON_METHOD ' ...
                };

            % New parameter values
            replacepars = {par.NoEchoes,par.NoEchoes, ...
                par.NoExperiments, par.NoExperiments, ...
                par.NoSamples, par.NoSamples, par.NoSamples, ...
                par.NoViews, par.NoViews, par.NoViews, ...
                par.NoViews2, par.NoViews2, par.NoViews2, ...
                par.NoSlices, par.NoSlices, ...
                par.NoSamples, par.NoViews, par.NoViews2, ...
                par.View1order, par.View2order, ...
                par.viewspersegment, ...
                par.reconmethod ...
                };

            % Loop over all parameters
            for i = 1:length(parameters)

                txt = parameters{i};
                var = replacepars{i};

                % Find the position of the parameter name
                pos = strfind(inputrpr,txt);

                if ~isempty(pos)
              
                    if ~isstring(var)
                        % Numeric values
                        oldtxtlength = strfind(inputrpr(pos+length(txt):pos+length(txt)+15),char(13))-1;
                        newtext = [num2str(var),'     '];
                        newtext = newtext(1:6);
                        inputrpr = replaceBetween(inputrpr,pos+length(txt),pos+length(txt)+oldtxtlength-1,newtext);

                    else
                        % String-based values
                        oldtxtlength = strfind(inputrpr(pos+length(txt):pos+length(txt)+15),char(13))-1;
                        newtext = strcat(" ",var,"           ");
                        newtext = extractBefore(newtext,12);
                        inputrpr = replaceBetween(inputrpr,pos+length(txt),pos+length(txt)+oldtxtlength-1,newtext);

                    end

                end

            end

            % Return the new RPR file object
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

            data = obj.mrdKspace;               % New MRD data
            footer = obj.newMrdFooter;          % New MRD footer

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

            fwrite(fid1,newline);
         
            % Write the footer
            fwrite(fid1,footer,'int8');

            % Close file
            fclose(fid1);

        end % writeDataToMrd




        % ---------------------------------------------------------------------------------
        % Set data type parameters
        % ---------------------------------------------------------------------------------
        function obj = setDataParameters(obj, app)

            % Determine which type of k-space data is available

            if obj.NO_VIEWS_2 > 1
                % 3D data
                obj.dataType = "3D";
                app.TextMessage('3D data detected ...');
                obj.multiSlab_flag = false;
                if obj.NO_SLICES > 1
                    % Multiple slabs which need to be stitched together
                    app.TextMessage('Multi-slab data detected ...');
                    obj.multiSlab_flag = true;
                    app.SlabOverlapEditField.Value = 1;
                end
            elseif obj.NO_VIEWS == 1 && obj.NO_VIEWS_2 == 1 && obj.EXPERIMENT_ARRAY > 1000
                % 3D UTE data
                obj.dataType = "3Dute";
                app.TextMessage('3D UTE data detected ...');
            else
                % Regular 2D multi-slice data
                obj.dataType = "2D";
                app.TextMessage('2D data detected ...');
                if obj.lines_per_segment > 1
                    obj.segmentedData_flag = true;
                end
            end

            % Check for radial data acquisition
            if obj.radial_on == 1
                % 2D radial acquisition
                obj.dataType = "2Dradial";
                app.TextMessage('Radial data detected ...');
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
                    % Multiple repetitions = multiple flip angles
                    obj.EXPERIMENT_ARRAY = obj.EXPERIMENT_ARRAY/obj.VFA_size;
                end
                if obj.EXPERIMENT_ARRAY > 1
                    % Regular multiple repetition experiment
                    obj.multiRepetitions_flag = true;
                    app.TextMessage('Multi-dynamic data detected ...');
                end
            end

            % EPI // under construction //
            if contains(obj.PPL,"epi")
                app.TextMessage('EPI sequence detected ...');
                obj.dataType = "2Depi";
            end

        end % setDataParameters




        % ---------------------------------------------------------------------------------
        % Permute 3D k-space data
        % ---------------------------------------------------------------------------------
        function obj = permute3Dkspace(obj)

            % The P2ROUD app sorts the 3D data and images into the following order:
            %
            % data = X, Y, Z, dynamics, flip-angles, echoes, slabs
            %
            % -----------------------------------------------------------------------------

            switch obj.dataType

                case "3D"

                    for i = 1:obj.nrCoils

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
                    for i = 1:obj.nrCoils

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


                case "3Dute"

                    for i = 1:obj.nrCoils

                        obj.rawKspace{i} = permute(obj.rawKspace{i},[2,1]);

                    end

                    obj.NO_SAMPLES = size(obj.rawKspace{1},1);
                    obj.NO_VIEWS = size(obj.rawKspace{1},2);
                    obj.NO_VIEWS_2 = 1;
                    obj.NO_ECHOES = 1;
                    obj.NO_VIEWS_ORIG = size(obj.rawKspace{1},2);
                    obj.NO_VIEWS_2_ORIG = 1;
                    obj.nr_repetitions = 1;

                    obj.trajType = "3Dute";

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

            % EPI // Under construction //
            if obj.dataType == "2Depi"
                for i = 1:obj.nrCoils
                    obj.rawKspace{i} = reshape(obj.rawKspace{i},[obj.NO_SAMPLES,obj.NO_VIEWS,obj.NO_SLICES,obj.nr_repetitions]);
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

                % Navigator yes or no, for RARE echo train correction
                firsty = 0;
                if obj.nav_on == 1
                    firsty = obj.VIEWS_PER_SEGMENT;
                end

                % Dimensions
                [dimx,dimy,dimz,nrrep,nrfa,nrte] = size(kSpaceRaw);
                kSpace = zeros(size(kSpaceRaw));
                trajectory2D = ones(dimx*dimy*dimz*nrrep*nrfa*nrte,7);

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
                                        navecho1 = squeeze(kSpaceRaw(round(dimx/2)+1, 1 ,z,repCounter,faCounter,teCounter));
                                        navecho2 = squeeze(kSpaceRaw(round(dimx/2)+1,nav,z,repCounter,faCounter,teCounter));
                                        PHshift(nav) = phase(navecho2) - phase(navecho1);
                                    end

                                    % Sorting including phase correction based on navigator
                                    for j = firsty+1:dimy

                                        idx = mod(j-firsty+1,firsty)+1;
                                        y = kTable(j)+round(firsty/2);
                                   
                                        kSpace(:,y,z,repCounter,faCounter,teCounter) = kSpaceRaw(:,j,z,repCounter,faCounter,teCounter);%.*exp(-1i*PHshift(idx));

                                        for x = 1:dimx

                                            % Fill the k-space trajectory array
                                            trajectory2D(tcnt,1) = x;
                                            trajectory2D(tcnt,2) = y;
                                            trajectory2D(tcnt,3) = z;
                                            trajectory2D(tcnt,4) = repCounter;
                                            trajectory2D(tcnt,5) = faCounter;
                                            trajectory2D(tcnt,6) = teCounter;
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
                                            trajectory2D(tcnt,1) = x;
                                            trajectory2D(tcnt,2) = y;
                                            trajectory2D(tcnt,3) = z;
                                            trajectory2D(tcnt,4) = repCounter;
                                            trajectory2D(tcnt,5) = faCounter;
                                            trajectory2D(tcnt,6) = teCounter;
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
            obj.seqTrajectory = trajectory2D;
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
        % Sort 2D segmented k-space data
        % ---------------------------------------------------------------------------------
        function obj = sort2DsegmKspaceMRD(obj, app)

            app.TextMessage('Segmented k-space data ...');

            % PPL version
            version = regexp(obj.PPL,'\d*','Match');
            version = str2num(cell2mat(version(end)));
            crit1 = version > 634;

            % FLASH yes or no ?
            crit2 = contains(obj.PPL,"flash");

            if crit1 && crit2

                [dimx, dimy, dimz, nrd, nfa, ne] = size(obj.rawKspace{1});

                nrLines = obj.lines_per_segment;
                nrc = obj.nrCoils;

                for coil = 1:nrc

                    for slices = 1:dimz

                        for flipAngle = 1:nfa

                            for dynamic = 1:nrd

                                ks = squeeze(obj.rawKspace{coil}(:,:,slices,dynamic,flipAngle,:));
                                ks = permute(ks,[3 2 1]);
                                ks = reshape(ks(:),[nrLines ne dimy/nrLines dimx]);
                                ks = permute(ks,[2 1 3 4]);
                                ks = reshape(ks(:),[ne dimx dimy]);
                                ks = permute(ks,[3 2 1]);
                                obj.rawKspace{coil}(:,:,slices,dynamic,flipAngle,:) = ks(:,:,:);

                            end

                        end

                    end

                end

            end

        end % sort2DsegmKspaceMRD





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
                trajectoryGpVarMul = ones(dimx * arrayLength * nrSlices * nrRep, 7);

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
                                trajectoryGpVarMul(cnt,1) = x;
                                trajectoryGpVarMul(cnt,2) = ky(w);
                                trajectoryGpVarMul(cnt,3) = slice;
                                trajectoryGpVarMul(cnt,4) = dynamic;

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
            obj.seqTrajectory = trajectoryGpVarMul;

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
            dimyOrig = obj.NO_VIEWS_ORIG;
            dimz = obj.NO_VIEWS_2;
            nRep = obj.EXPERIMENT_ARRAY;                % Number of acquired repetitions/dynamics
            nDyn = app.NREditField.Value;               % Number of reconstructed dynamics
            nFA = app.NFAViewField.Value;               % Number of flip angles
            arrayLength = obj.NO_VIEWS_ORIG*dimz;

            % For multiple flip-angles
            if nFA > 1
                nRep = nFA;
                nDyn = nFA;
                app.NREditField.Value = 1;
            end
        
            for coil = 1:obj.nrCoils

                app.TextMessage(strcat('Sorting coil',{' '},num2str(coil),' ...'));

                % Unsorted k-space for each coil
                unsortedKspace = obj.unsKspace{coil};
                unsortedKspace = reshape(unsortedKspace,dimx,dimy,dimz,nTE,nRep);
                unsortedKspace = permute(unsortedKspace,[1,4,2,3,5]);
                unsortedKspace = unsortedKspace(:);

                % Preallocate memory for the matrices
                kSpace = zeros(dimx, dimy, dimz, nDyn, 1, nTE);
                avgSpace = zeros(dimx, dimy, dimz, nDyn, 1, nTE);
                trajectory3D = ones(mtx*nRep,7);

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
                kcnt = 1;
                ky = zeros(arrayLength,1);
                kz = zeros(arrayLength,1);
                for i = 1:arrayLength
                    ky(i) = round(int16(parameters.gp_var_mul(cnt1)) + dimy/2 + 1);
                    kz(i) = kzp(kcnt);
                    kcnt = kcnt + 1;
                    if kcnt > dimz
                        kcnt = 1;
                        cnt1 = cnt1 + 1;
                        cnt1(cnt1 > dimyOrig) = 1;
                    end
                end

                % Some checks to keep k-space points within dimensions
                ky(ky>dimy) = dimy;
                ky(ky<1) = 1;
                kz(kz>dimz) = dimz;
                kz(kz<1) = 1;

                % Duplicate for multiple acquired repetitions
                ky = repmat(ky,1,nRep+1);
                kz = repmat(kz,1,nRep+1);
                ky = ky(:);
                kz = kz(:);

                % Number of k-space points per frame
                kPointsPerFrame = round(dimyOrig * dimz * nRep / nDyn);
                app.TextMessage(strcat('k-lines per dynamic =',{' '},num2str(kPointsPerFrame),' ...'));

                % Trajectory counter
                kcnt = 1;

                % Loop over desired number of frames
                for dynamic = 1:nDyn

                    if nFA>1
                        app.TextMessage(strcat('Sorting flip-angle #',num2str(dynamic),' ...'));
                    else
                        app.TextMessage(strcat('Sorting dynamic #',num2str(dynamic),' ...'));
                    end

                    wStart = (dynamic - 1) * kPointsPerFrame + 1; % starting k-line for specific frame
                    wEnd = dynamic * kPointsPerFrame;             % ending k-line for specific frame
                    wEnd(wEnd > arrayLength*nRep) = arrayLength * nRep;

                    % Loop over y-dimension (views)
                    for pcnt = wStart:wEnd

                        % Loop over x-dimension (readout)
                        for x = 1:dimx

                            % Loop over gradient-echoes
                            for echo = 1:nTE

                                % Fill the k-space and signal averages matrix
                                if mod(echo,2)
                                    kSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) = kSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) + unsortedKspace((pcnt-1)*nTE*dimx + (echo-1)*dimx + kx);
                                else
                                    kSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) = kSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) + unsortedKspace((pcnt-1)*nTE*dimx + (echo-1)*dimx + (dimx-kx+1)); % reverse even echoes
                                end

                                % Fill averages space
                                avgSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) = avgSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) + 1;
                            
                            end

                            % Fill the k-space trajectory array
                            trajectory3D(kcnt,1) = x;
                            trajectory3D(kcnt,2) = ky(pcnt);
                            trajectory3D(kcnt,3) = kz(pcnt);
                            trajectory3D(kcnt,4) = dynamic;
                            trajectory3D(kcnt,4) = dynamic;
                            trajectory3D(kcnt,5) = dynamic;
                            kcnt = kcnt + 1;

                        end

                    end

                end

                % Normalize by dividing through number of averages
                kSpace = kSpace./avgSpace;
                kSpace(isnan(kSpace)) = complex(0);
                obj.rawKspace{coil} = kSpace(:,:,:,:,1,:);

                % For multiple flip-angles
                if nFA>1 
                    obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1 2 3 5 4 6]);
                end

            end
            
            % For k-space filling visualization
            obj.nsaSpace = avgSpace(:,:,:,:,1,:);
            fillkSpace = avgSpace./avgSpace;
            fillkSpace(isnan(fillkSpace)) = 0;
            obj.fillingSpace = fillkSpace(:,:,:,:,1,:);

            % For multiple flip-angles
            if nFA>1
                obj.nsaSpace = permute(obj.nsaSpace,[1 2 3 5 4 6]);
                obj.fillingSpace = permute(obj.fillingSpace,[1 2 3 5 4 6]);
            end

            % Trajectory
            obj.seqTrajectory = trajectory3D;

        end % sort3DKspaceMRD




        % ---------------------------------------------------------------------------------
        % Sort 3D P2ROUD k-space data
        % ---------------------------------------------------------------------------------
        function obj = sort3DProudKspaceMRD(obj, app)

            app.TextMessage('Sorting 3D P2ROUD k-space ...');

            obj.rawKspace = {};
            obj.nsaSpace = [];
            obj.fillingSpace = [];

            % Size of the image matrix (X, Y, Z, NR, NFA, NE)
            dimx = obj.NO_SAMPLES;
            dimy = obj.NO_VIEWS;
            dimz = obj.NO_VIEWS_2;
            nRep = obj.EXPERIMENT_ARRAY;        % Number of acquired dynamics
            nDyn = app.NREditField.Value;       % Number of reconstructed dynamics
            nTE = app.NEViewField.Value;        % Number of echo times
            nFA = app.NFAViewField.Value;       % Number of flip angles
            mtx = dimy*dimz*dimx;

            % For multiple flip-angles
            if nFA > 1
                nRep = nFA;
                nDyn = nFA;
                app.NREditField.Value = 1;
            end

            for coil = 1:obj.nrCoils

                app.TextMessage(strcat('Sorting coil',{' '},num2str(coil),' ...'));

                % Unsorted k-space for each coil
                unsortedKspace = obj.unsKspace{coil};
                unsortedKspace = reshape(unsortedKspace,dimx,dimy,dimz,nTE,nRep);
                unsortedKspace = permute(unsortedKspace,[1,4,2,3,5]);
                unsortedKspace = unsortedKspace(:);

                % Preallocate memory for the matrices
                kSpace = zeros(dimx, dimy, dimz, nDyn, 1, nTE);
                avgSpace = zeros(dimx, dimy, dimz, nDyn, 1, nTE);
                trajectoryProud = ones(mtx*nRep,7);

                % Fill the ky and kz k-space locations
                ky = round(obj.proudArray(1,:) + dimy/2 + 1);      % contains the y-coordinates of the custom k-space sequentially
                kz = round(obj.proudArray(2,:) + dimz/2 + 1);      % contains the z-coordinates of the custom k-space sequentially
                
                % Some checks to keep k-space points within dimensions
                ky(ky>dimy) = dimy;
                ky(ky<1) = 1;
                kz(kz>dimz) = dimz;
                kz(kz<1) = 1;
               
                % Duplicate for multiple acquired repetitions
                ky = repmat(ky,1,nRep+1);
                kz = repmat(kz,1,nRep+1);
                ky = ky(:);
                kz = kz(:);

                % Number of k-space points per frame
                kLinesPerFrame = round(dimy*dimz*nRep/nDyn);
                app.TextMessage(strcat('k-lines per frame =',{' '},num2str(kLinesPerFrame),' ...'));

                % Trajectory counter
                kcnt = 1;   % k-point counter
      
                % Loop over desired number of frames
                for dynamic = 1:nDyn

                    if nFA>1
                        app.TextMessage(strcat('Sorting flip-angle #',num2str(dynamic),' ...'));
                    else
                        app.TextMessage(strcat('Sorting dynamic #',num2str(dynamic),' ...'));
                    end

                    wStart = (dynamic - 1) * kLinesPerFrame + 1;      % Starting k-line for specific frame
                    wEnd = dynamic * kLinesPerFrame;                  % Ending k-line for specific frame
                    wEnd(wEnd > dimy*dimz*nRep) = dimy*dimz*nRep;

                    % Loop over y- and z-dimensions (views and views2)
                    for pcnt = wStart:wEnd

                        % Loop over x-dimension (readout)
                        for kx = 1:dimx

                            % Loop over gradient-echoes
                            for echo = 1:nTE

                                % Fill the k-space and signal averages matrix
                                if mod(echo,2)
                                    kSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) = kSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) + unsortedKspace((pcnt-1)*nTE*dimx + (echo-1)*dimx + kx);
                                else
                                    kSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) = kSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) + unsortedKspace((pcnt-1)*nTE*dimx + (echo-1)*dimx + (dimx-kx+1)); % reverse even echoes
                                end

                                % Fill averages space
                                avgSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) = avgSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) + 1;
                            
                            end

                            % Fill the k-space trajectory array
                            trajectoryProud(kcnt,1) = kx;
                            trajectoryProud(kcnt,2) = ky(pcnt);
                            trajectoryProud(kcnt,3) = kz(pcnt);
                            trajectoryProud(kcnt,4) = dynamic;
                            trajectoryProud(kcnt,5) = dynamic;
                            kcnt = kcnt + 1;

                        end

                    end

                end

                % Normalize by dividing through number of averages
                kSpace = kSpace./avgSpace;
                kSpace(isnan(kSpace)) = complex(0);
                obj.rawKspace{coil} = kSpace(:,:,:,:,1,:);
                
                % For multiple flip-angles
                if nFA>1 
                    obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1 2 3 5 4 6]);
                end

            end

            % For k-space filling visualization
            obj.nsaSpace = avgSpace(:,:,:,:,1,:);
            fillingkSpace = avgSpace./avgSpace;
            fillingkSpace(isnan(fillingkSpace)) = 0;
            obj.fillingSpace = fillingkSpace(:,:,:,:,1,:);

            % For multiple flip-angles
            if nFA>1
                obj.nsaSpace = permute(obj.nsaSpace,[1 2 3 5 4 6]);
                obj.fillingSpace = permute(obj.fillingSpace,[1 2 3 5 4 6]);
            end

            % Trajectory
            obj.seqTrajectory = trajectoryProud;

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
        % Version: February 2023
        % ---------------------------------------------------------------------------------
        function obj = applyTukey(obj)

            filterWidth = 0.25;
            dimx = size(obj.rawKspace{1},1);
            dimy = size(obj.rawKspace{1},2);
            dimz = size(obj.rawKspace{1},3);

            % Normalize k-space to convenient range
            for i = 1:obj.nrCoils
                m(i) = max(abs(obj.rawKspace{i}(:)));
            end
            for i = 1:obj.nrCoils
                obj.rawKspace{i} = 16383*obj.rawKspace{i}/max(m);
            end
            
            if ~obj.halfFourier_flag

                switch obj.dataType

                    case {"2D","2Depi"}

                        kSpaceSum = zeros(dimx,dimy);
                        for i = 1:obj.nrCoils
                            kSpaceSum = kSpaceSum + squeeze(sum(obj.rawKspace{i},[3 4 5 6 7 8]));
                        end
                        [row, col] = find(ismember(kSpaceSum, max(kSpaceSum(:))));
                        for i = 1:obj.nrCoils
                            flt = proudData.circTukey2D(dimx,dimy,row,col,filterWidth);
                            tukeyFilter(:,:,1,1,1,1) = flt;
                            obj.rawKspace{i} = obj.rawKspace{i}.*tukeyFilter;
                        end

                    case "2Dradial"

                        % Probably better to apply after center shift

                        % tmpFilter = tukeywin(dimx,filterWidth);
                        % for i = 1:obj.nrCoils
                        %   tukeyFilter(:,1,1,1,1,1) = tmpFilter;
                        %   obj.rawKspace{i} = obj.rawKspace{i}.*tukeyFilter;
                        % end

                    case "3D"

                        kSpaceSum = zeros(dimx,dimy,dimz);
                        for i = 1:obj.nrCoils
                            kSpaceSum = kSpaceSum + squeeze(sum(obj.rawKspace{i},[4 5 6 7 8]));
                        end
                        [~,idx] = max(kSpaceSum(:));
                        [lev, row, col] = ind2sub(size(kSpaceSum),idx);
                        for i=1:obj.nrCoils
                            flt = proudData.circTukey3D(dimx,dimy,dimz,lev,row,col,filterWidth);
                            tukeyFilter(:,:,:,1,1,1) = flt;
                            obj.rawKspace{i} = obj.rawKspace{i}.*tukeyFilter;
                        end

                    case "3Dute"

                        tmpFilter = tukeywin(2*dimx,filterWidth/2);
                        tmpFilter = tmpFilter(dimx+1:end);
                        for i = 1:obj.nrCoils
                            tukeyFilter(:,1,1,1,1,1) = tmpFilter;
                            obj.rawKspace{i} = obj.rawKspace{i}.*tukeyFilter;
                        end

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

            %                            1  2  3  4  5  6  7  8  9  10 11 12 13 14
            kSpacePics = permute(kSpace,[7 ,2 ,1 ,8 ,9 ,6 ,5 ,10,11,12,4 ,13,14,3 ]);

            % wavelet in y and x spatial dimensions 2^1 + 2^2 = 6
            % total variation in y and x spatial dimensions 2^1 + 2^2 = 6
            % total variation in TE and dynamic dimension 2^5 + 2^10 = 1056

            if obj.nrCoils>1 && app.AutoSensitivityCheckBox.Value==1

                % ESPIRiT reconstruction
                TextMessage(app,'ESPIRiT reconstruction ...');

                % Calculate coil sensitivity maps with ecalib bart function
                sensitivities = bart(app,'ecalib -S -I -a', kSpacePics);      % ecalib with softsense

            end

            if obj.nrCoils==1 || app.AutoSensitivityCheckBox.Value==0

                % Sensitivity correction
                sensitivities = ones(1,dimy,dimx,obj.nrCoils,1,1,1,1,1,1,1,1,1,dimz);
                for i = 1:obj.nrCoils
                    sensitivities(:,:,:,i,:) = sensitivities(:,:,:,i,:)*obj.coilSensitivities(i)*obj.coilActive_flag(i);
                end

            end

            % Pics reconstuction
            picsCommand = 'pics -S';
            if LW>0
                picsCommand = [picsCommand,' -RW:6:0:',num2str(LW)];
            end
            if TVxy>0
                picsCommand = [picsCommand,' -R',obj.totalVariation,':6:0:',num2str(TVxy)];
            end
            if LR>0
                % Locally low-rank in the spatial domain
                blocksize = round(max([dimx dimy])/16);  % Block size
                app.TextMessage(strcat('Low-rank block size =',{' '},num2str(blocksize)));
                picsCommand = [picsCommand,' -RL:6:6:',num2str(LR),' -b',num2str(blocksize)];
            end
            if TVd>0
                picsCommand = [picsCommand,' -R',obj.totalVariation,':1056:0:',num2str(TVd)];
            end
            imageTmp = bart(app,picsCommand,kSpacePics,sensitivities);

            % Sum of squares reconstruction
            imageTmp = abs(bart(app,'rss 24', imageTmp));

            % Phase images
            phaseImageReg = angle(imageTmp(:,:,:,:,1,:));

            % Rearrange to correct orientation: x, y, slices, dynamics, flip-angle, TE (cine)
            imageReg = permute(imageTmp,[3 2 14 11 4 6 1 5 7 8 9 10 12 13 15]);
            phaseImageReg = permute(phaseImageReg,[3 2 14 11 4 6 1 5 7 8 9 10 12 13 15]);

            % Flip dimensions where needed
            if obj.PHASE_ORIENTATION == 1
                imagesOut = flip(imageReg,2);
                phaseImagesOut = flip(phaseImageReg,2);
            else
                imagesOut = flip(flip(imageReg,2),1);
                phaseImagesOut = flip(flip(phaseImageReg,2),1);
            end

            % Return the images object
            for i = 1:dimd
                for echo = 1:dimte
                    obj.images(:,:,:,i,flipAngle,echo) = imagesOut(:,:,:,i,1,echo);
                    obj.phaseImages(:,:,:,i,flipAngle,echo) = phaseImagesOut(:,:,:,i,1,echo);
                    obj.phaseImagesOrig(:,:,:,i,flipAngle,echo) = phaseImagesOut(:,:,:,i,1,echo);
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

                %                            0  1  2  3  4  5  6  7  8  9  10 11 12 13
                %                            1  2  3  4  5  6  7  8  9  10 11 12 13 14
                kSpacePics = permute(kSpace,[5 ,2 ,1 ,6 ,7 ,8 ,9 ,10,11,12,4 ,13,14,3 ]);

                % wavelet in y and x spatial dimensions 2^1+2^2=6
                % total variation in y and x spatial dimensions 2^1+2^2=6
                % total variation in dynamic dimension 2^10 = 1024

                if obj.nrCoils>1 && app.AutoSensitivityCheckBox.Value==1

                    % ESPIRiT reconstruction
                    TextMessage(app,'ESPIRiT reconstruction ...');

                    % Calculate coil sensitivity maps with ecalib bart function
                    sensitivities = bart(app,'ecalib -S -I -m2', kSpacePics);      % ecalib with softsense

                end

                if obj.nrCoils==1 || app.AutoSensitivityCheckBox.Value==0

                    % Sensitivity correction
                    sensitivities = ones(1,dimy,dimx,obj.nrCoils,1,1,1,1,1,1,1,1,1,dimz);
                    for i = 1:obj.nrCoils
                        sensitivities(:,:,:,i,:) = sensitivities(:,:,:,i,:)*obj.coilSensitivities(i)*obj.coilActive_flag(i);
                    end

                end

                % Pics reconstuction
                picsCommand = 'pics -S';
                if LW>0
                    picsCommand = [picsCommand,' -RW:6:0:',num2str(LW)];
                end
                if TVxy>0
                    picsCommand = [picsCommand,' -R',obj.totalVariation,':6:0:',num2str(TVxy)];
                end
                if LR>0
                    % Locally low-rank in the spatial domain
                    blocksize = round(max([dimx dimy])/16);  % Block size
                    app.TextMessage(strcat('Low-rank block size =',{' '},num2str(blocksize)));
                    picsCommand = [picsCommand,' -RL:6:6:',num2str(LR),' -b',num2str(blocksize)];
                end
                if TVd>0
                    picsCommand = [picsCommand,' -R',obj.totalVariation,':1024:0:',num2str(TVd)];
                end
                imageTmp = bart(app,picsCommand,kSpacePics,sensitivities);

                % Sum of squares reconstruction
                imageTmp = abs(bart(app,'rss 24', imageTmp));

                % Modulus image
                imageReg = abs(imageTmp);

                % Phase image
                phaseImageReg = angle(imageTmp);

                % Rearrange to correct orientation: x, y, slices, dynamics,
                imageReg = reshape(imageReg,[dimy,dimx,dimd,dimz]);
                phaseImageReg = reshape(phaseImageReg,[dimy,dimx,dimd,dimz]);

                imagesOut = permute(imageReg,[2,1,4,3]);
                phaseImagesOut = permute(phaseImageReg,[2,1,4,3]);

                % Flip dimensions where needed
                if obj.PHASE_ORIENTATION == 1
                    imagesOut = flip(imagesOut,2);
                    phaseImagesOut = flip(phaseImagesOut,2);
                else
                    imagesOut = flip(flip(imagesOut,2),1);
                    phaseImagesOut = flip(flip(phaseImagesOut,2),1);
                end

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

                % Flip dimensions if required
                if obj.PHASE_ORIENTATION == 1
                    imagesOut = flip(imagesOut,1);
                    phaseImagesOut = flip(phaseImagesOut,1);
                end

                % There seems to be a 1 pixel shift with this reco, correct for this:
                imagesOut = circshift(imagesOut,-1,2);
                imagesOut = circshift(imagesOut,1,1);
                phaseImagesOut = circshift(phaseImagesOut,-1,2);
                phaseImagesOut = circshift(phaseImagesOut,1,1);

                % Return the images object
                obj.images(:,:,:,:,flipAngle,echoTime) = imagesOut;
                obj.phaseImages(:,:,:,:,flipAngle,echoTime) = phaseImagesOut;
                obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = phaseImagesOut;

            end

        end % csReco2D





        % ---------------------------------------------------------------------------------
        % Image reconstruction: FFT 2D 
        % Version February 2023
        % ---------------------------------------------------------------------------------
        function obj = fftReco2D(obj,app,flipAngle,echoTime)

            kSpaceRaw = cell(obj.nrCoils);
            kSpaceRawOrig = cell(obj.nrCoils);
            for i=1:obj.nrCoils
                kSpaceRaw{i} = obj.rawKspace{i}(:,:,:,:,flipAngle,echoTime);
            end

            % kSpaceRaw = {coil}[X Y slices dynamics]
            %                    1 2    3      4
            dimx = size(kSpaceRaw{1},1);
            dimy = size(kSpaceRaw{1},2);
            dimz = size(kSpaceRaw{1},3);
            dimd = size(kSpaceRaw{1},4);
            dimc = obj.nrCoils;

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
            kSpace = zeros(dimx,dimy,ndimd,ndimz,dimc);
       
            if app.AutoSensitivityCheckBox.Value == 1
                for i = 1:dimc
                    kSpace(:,:,:,:,i) = kSpaceRaw{i}*obj.coilActive_flag(i);
                end
            else
                for i = 1:dimc
                    kSpace(:,:,:,:,i) = kSpaceRaw{i}*obj.coilSensitivities(i)*obj.coilActive_flag(i);
                end
            end

            % Preallocate
            imagesOut = zeros(ndimx,ndimy,ndimz,ndimd,dimc);

            % Message
            if obj.halfFourier_flag
                app.TextMessage('Homodyne FFT reconstruction ...');
            else
                app.TextMessage('Standard FFT reconstruction ...');
            end

            % Slice and dynamic loop
            for slice = 1:ndimz

                for dynamic = 1:ndimd

                    % Homodyne / normal FFT
                    if obj.halfFourier_flag
                        kdatai = squeeze(kSpace(:,:,dynamic,slice,:));
                        image2D = zeros(dimx,dimy,nnz(obj.coilActive_flag));
                        imageIn(:,:,1,:) = kdatai(:,:,obj.coilActive_flag);
                        image2D(:,:,:) = squeeze(homodyne(imageIn,app));
                    else
                        kdatai = squeeze(kSpace(:,:,dynamic,slice,:));
                        image2D = zeros(dimx,dimy,dimc);
                        for coil = 1:dimc
                            image2D(:,:,coil) = proudData.fft2Dmri(squeeze(kdatai(:,:,coil)));
                        end
                    end

                    % Zero-fill or crop x-dimension and/or y-dimension
                    if (ndimx~=dimx) || (ndimy~=dimy)

                        % Back to k-space
                        kdatai = obj.fft2Dmri(image2D);

                        if ndimx > dimx
                            padsizex = round((ndimx - dimx)/2);
                            kdatai = padarray(kdatai,[padsizex,0,0],'both');
                        else
                            cropsize = round((dimx - ndimx)/2)-1;
                            cropsize(cropsize<0)=0;
                            kdatai = kdatai(cropsize+1:end-cropsize,:,:);
                        end

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

                        % Back to image space
                        image2D = obj.ifft2Dmri(kdatai);
             
                    end

                    % Return the image
                    imagesOut(:,:,slice,dynamic,:) = image2D;
           
                end

            end

            % Flip dimensions if required
            if obj.PHASE_ORIENTATION == 1
                imagesOut = flip(imagesOut,2);
            else
                imagesOut = flip(flip(imagesOut,2),1);
            end

            % Return the images object
            obj.images(:,:,:,:,flipAngle,echoTime) = abs(rssq(imagesOut,5));
            obj.phaseImages(:,:,:,:,flipAngle,echoTime) = mean(angle(imagesOut),5);
            obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = mean(angle(imagesOut),5);

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

                % Use total variation (TGV takes too long)
                obj.totalVariation = 'T';

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
                    sensitivities = bart(app,'ecalib -I -S -m2', kSpacePics);

                end

                if obj.nrCoils==1 || app.AutoSensitivityCheckBox.Value==0

                    % Sensitivity correction
                    sensitivities = ones(dimz,dimy,dimx,obj.nrCoils,1,1,1,1,1,1,dimd,1,1,dims);
                    for i = 1:obj.nrCoils
                        sensitivities(:,:,:,i,:) = sensitivities(:,:,:,i,:)*obj.coilSensitivities(i)*obj.coilActive_flag(i);
                    end

                end

                % Wavelet and TV in spatial dimensions 2^0+2^1+2^2=7, total variation in time 2^10 = 1024
                picsCommand = 'pics -S';
                if LambdaWavelet>0
                    picsCommand = [picsCommand, ' -RW:7:0:',num2str(LambdaWavelet)];
                end
                if TVxyz>0
                    picsCommand = [picsCommand, ' -R',obj.totalVariation,':7:0:',num2str(TVxyz)];
                end
                if LR>0
                    % Locally low-rank in the spatial domain
                    blockSize = round(max([dimx dimy dimz])/16);  % Block size
                    app.TextMessage(strcat('Low-rank block size =',{' '},num2str(blockSize)));
                    picsCommand = [picsCommand, ' -RL:7:7:',num2str(LR)];
                end
                if TVd>0
                    picsCommand = [picsCommand, ' -R',obj.totalVariation,':1024:0:',num2str(TVd)];
                end
                imagesTmp = bart(app,picsCommand,kSpacePics,sensitivities);

                % Sum of squares
                imagesTmp = abs(bart(app,'rss 24', imagesTmp));

                % Modulus and phase image
                imagesReg = abs(imagesTmp);
                phaseImagesReg = angle(imagesTmp);

                % Rearrange to correct orientation: x, y, z, dynamics, slab
                imagesReg = reshape(imagesReg,[dimz,dimy,dimx,dimd,dims]);
                imageSlab = permute(imagesReg,[3,2,1,4,5]);
            
                phaseImagesReg = reshape(phaseImagesReg,[dimz,dimy,dimx,dimd,dims]);
                phaseImageSlab = permute(phaseImagesReg,[3,2,1,4,5]);

                % Flip dimensions to correct orientation
                if obj.PHASE_ORIENTATION == 1
                    imageSlab = flip(flip(imageSlab,3),2);
                    phaseImageSlab = flip(flip(phaseImageSlab,3),2);
                else
                    imageSlab = flip(flip(flip(imageSlab,3),2),1);
                    phaseImageSlab = flip(flip(flip(phaseImageSlab,3),2),1);
                end

                % Slab ratio + discard
                if dims>1
                    nrDiscard = round(-0.5*dimz*obj.SQLsliceGap/obj.SLICE_THICKNESS);
                    if nrDiscard>0
                        imageSlab(:,:,dimz-nrDiscard+1:dimz,:,:) = [];
                        imageSlab(:,:,1:nrDiscard,:,:) = [];
                        phaseImageSlab(:,:,dimz-nrDiscard+1:dimz,:,:) = [];
                        phaseImageSlab(:,:,1:nrDiscard,:,:) = [];
                    end
                end

                % Concatenate multislab data
                imageMultiSlab = imageSlab(:,:,:,:,1);
                phaseImageMultiSlab = phaseImageSlab(:,:,:,:,1);

                if dims>1
                    for i = 2:dims
                        imageMultiSlab = cat(3,imageMultiSlab,imageSlab(:,:,:,:,i));
                        phaseImageMultiSlab = cat(3,phaseImageMultiSlab,phaseImageSlab(:,:,:,:,i));
                    end
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
                    maski(isnan(maski)) = 0;
                    maski = logical(maski);

                    % Normalize the data in the range of approx 0 - 1 for better numerical stability
                    kdatai = kdatai/max(abs(kdatai(:)));

                    % Coil sensitivity map
                    [nx,ny,nz,~,nc] = size(kdatai);
                    b1 = ones(nx,ny,nz,nc);

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

                    % Flip dimensions to correct orientation
                    if obj.PHASE_ORIENTATION == 1
                        imageOut = flip(imageOut,1);
                        phaseImageOut = flip(phaseImageOut,1);
                    end

                    % Images are shifted by 1 pixel in each dimension,
                    % could use tweaking
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

                % Combine slabs with overlap if present
                if dims>1

                    nrDiscard = round(-0.5*ndimz*obj.SQLsliceGap/obj.SLICE_THICKNESS);

                    overlap = app.SlabOverlapEditField.Value;
                    if overlap > nrDiscard
                        overlap = nrDiscard;
                        app.SlabOverlapEditField.Value = overlap;
                        app.TextMessage(sprintf('WARNING: Max slab overlap = %d pixels ...',overlap));
                    end
                    nrDiscard = nrDiscard - overlap;

                    imageSlab(:,:,ndimz-nrDiscard+1:ndimz,:,:) = [];
                    imageSlab(:,:,1:nrDiscard,:,:) = [];
                    phaseImageSlab(:,:,ndimz-nrDiscard+1:ndimz,:,:) = [];
                    phaseImageSlab(:,:,1:nrDiscard,:,:) = [];
                    avgSlab = ones(size(imageSlab));

                    % Resulting image size + 2 * overlap on the image borders
                    dimzs = size(imageSlab,3);
                    totaldimzs = dims*dimzs - 2*dims*overlap + 2*overlap;

                    imageMultiSlab = zeros(ndimx,ndimy,totaldimzs,ndimd);
                    phaseImageMultiSlab = zeros(ndimx,ndimy,totaldimzs,ndimd);
                    avgMultiSlab = zeros(ndimx,ndimy,totaldimzs,ndimd);

                    % Concatenate the overlapping matrices
                    z1 = 1;
                    for i = 1:dims

                        z2 = z1 + dimzs;

                        imageMultiSlab(:,:,z1:z2-1,:) = imageMultiSlab(:,:,z1:z2-1,:) + imageSlab(:,:,:,:,i);
                        phaseImageMultiSlab(:,:,z1:z2-1,:) = phaseImageMultiSlab(:,:,z1:z2-1,:) + phaseImageSlab(:,:,:,:,i);
                        avgMultiSlab(:,:,z1:z2-1,:) = avgMultiSlab(:,:,z1:z2-1,:) + avgSlab(:,:,:,:,i);

                        z1 = z2 - 2*overlap;

                    end

                    % Average the overlap
                    imageMultiSlab = imageMultiSlab./avgMultiSlab;

                    % Remove the overlap on the multi-slab beginning and end
                    imageMultiSlabOutput = imageMultiSlab(:,:,overlap+1:end-overlap,:);
                    phaseImageMultiSlabOutput = phaseImageMultiSlab(:,:,overlap+1:end-overlap,:);


                else

                    % Only 1 image slab
                    imageMultiSlabOutput = imageSlab(:,:,:,:,1);
                    phaseImageMultiSlabOutput = phaseImageSlab(:,:,:,:,1);

                end

                % Return the image object
                obj.images(:,:,:,:,flipAngle,echoTime) = imageMultiSlabOutput;
                obj.phaseImages(:,:,:,:,flipAngle,echoTime) = phaseImageMultiSlabOutput;
                obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = phaseImageMultiSlabOutput;

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
                        padSizex = round((ndimx - dimx)/2);
                        kDatai = padarray(kData,[padSizex,0,0],'both');
                    else
                        cropSize = round((dimx - ndimx)/2)-1;
                        cropSize(cropSize<0)=0;
                        kDatai = kData(cropSize+1:end-cropSize,:,:,:);
                    end

                    % Zero-fill or crop y-dimension
                    if ndimy > dimy
                        padSizey = round((ndimy - dimy)/2);
                        kDatai = padarray(kDatai,[0,padSizey,0],'both');
                    else
                        cropSize = round((dimy - ndimy)/2)-1;
                        cropSize(cropSize<0)=0;
                        kDatai = kDatai(:,cropSize+1:end-cropSize,:,:);
                    end

                    % Zero-fill or crop z-dimension
                    if ndimz > dimz
                        padSizez = round((ndimz - dimz)/2);
                        kDatai = padarray(kDatai,[0,0,padSizez],'both');
                    else
                        cropSize = round((dimz - ndimz)/2)-1;
                        cropSize(cropSize<0)=0;
                        kDatai = kDatai(:,:,cropSize+1:end-cropSize,:);
                    end

                    % Make sure dimensions are exactly ndimx, ndimy, coils
                    kDatai = kDatai(1:ndimx,1:ndimy,1:ndimz,:);

                    % FFT
                    imageIm = zeros(ndimx,ndimy,ndimz,obj.nrCoils);
                    for coil = 1:obj.nrCoils
                        imageIm(:,:,:,coil) = proudData.fft3Dmri(squeeze(kDatai(:,:,:,coil)));
                    end

                    % Root sum of squares
                    image3D = rssq(imageIm,4);

                    % Phase images (mean of coils)
                    image3Dphase = mean(angle(imageIm),4);
                
                    % Return the image
                    imageSlab(:,:,:,dynamic,slab) = image3D;
                    phaseImageSlab(:,:,:,dynamic,slab) = image3Dphase;

                end

            end

            % Flip dimensions to correct orientation
            if obj.PHASE_ORIENTATION == 1
                imageSlab = flip(flip(imageSlab,3),2);
                phaseImageSlab = flip(flip(phaseImageSlab,3),2);
            else
                imageSlab = flip(flip(flip(imageSlab,3),2),1);
                phaseImageSlab = flip(flip(flip(phaseImageSlab,3),2),1);
            end

            % Combine slabs with overlap if present
            if dims > 1

                nrDiscard = round(-0.5*ndimz*obj.SQLsliceGap/obj.SLICE_THICKNESS);
                
                overlap = app.SlabOverlapEditField.Value;
                if overlap > nrDiscard
                    overlap = nrDiscard;
                    app.SlabOverlapEditField.Value = overlap;
                    app.TextMessage(sprintf('WARNING: Max slab overlap = %d pixels ...',overlap));
                end
                nrDiscard = nrDiscard - overlap;

                imageSlab(:,:,ndimz-nrDiscard+1:ndimz,:,:) = [];
                imageSlab(:,:,1:nrDiscard,:,:) = [];
                phaseImageSlab(:,:,ndimz-nrDiscard+1:ndimz,:,:) = [];
                phaseImageSlab(:,:,1:nrDiscard,:,:) = [];
                avgSlab = ones(size(imageSlab));
                
                % Resulting image size + 2 * overlap on the image borders
                dimzs = size(imageSlab,3);
                totalDimzs = dims*dimzs - 2*dims*overlap + 2*overlap;

                imageMultiSlab = zeros(ndimx,ndimy,totalDimzs,ndimd);
                phaseImageMultiSlab = zeros(ndimx,ndimy,totalDimzs,ndimd);
                avgMultiSlab = zeros(ndimx,ndimy,totalDimzs,ndimd);
    
                % Concatenate the overlapping matrices
                z1 = 1;
                for i = 1:dims
                    
                    z2 = z1 + dimzs;
                    
                    imageMultiSlab(:,:,z1:z2-1,:) = imageMultiSlab(:,:,z1:z2-1,:) + imageSlab(:,:,:,:,i);
                    phaseImageMultiSlab(:,:,z1:z2-1,:) = phaseImageMultiSlab(:,:,z1:z2-1,:) + phaseImageSlab(:,:,:,:,i);
                    avgMultiSlab(:,:,z1:z2-1,:) = avgMultiSlab(:,:,z1:z2-1,:) + avgSlab(:,:,:,:,i);

                    z1 = z2 - 2*overlap;

                end

                % Average the overlap
                imageMultiSlab = imageMultiSlab./avgMultiSlab;

                % Remove the overlap on the multi-slab beginning and end
                imageMultiSlabOutput = imageMultiSlab(:,:,overlap+1:end-overlap,:);
                phaseImageMultiSlabOutput = phaseImageMultiSlab(:,:,overlap+1:end-overlap,:);


            else

                % Only 1 image slab
                imageMultiSlabOutput = imageSlab(:,:,:,:,1);
                phaseImageMultiSlabOutput = phaseImageSlab(:,:,:,:,1);
            
            end

            % Return the image object
            obj.images(:,:,:,:,flipAngle,echoTime) = imageMultiSlabOutput;
            obj.phaseImages(:,:,:,:,flipAngle,echoTime) = phaseImageMultiSlabOutput;
            obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = phaseImageMultiSlabOutput;

        end % fftReco3D




        % ---------------------------------------------------------------------------------
        % Image reconstruction: compressed sensing 2D Radial
        % ---------------------------------------------------------------------------------
        function obj = Reco2DRadialCS(obj,app,flipAngle,echoTime)

            % CS regularization parameters
            LW = app.WVxyzEditField.Value;
            TVxyz = app.TVxyzEditField.Value;
            LR = app.LRxyzEditField.Value;
            TVd = app.TVtimeEditField.Value;
            dimc = obj.nrCoils;

            % Original kx, ky, slices, dynamics  (X, Y, Z, NR, NFA, NE) 
            kSpaceRaw = cell(dimc);
            for i=1:dimc
                kSpaceRaw{i} = obj.rawKspace{i}(:,:,:,:,flipAngle,echoTime);
            end

            % Averages
            averages = obj.nsaSpace;

            % Center echo and/or phase correction
            interpFactor = 16;
            dimx = size(kSpaceRaw{1},1);
            for coil = 1:dimc
                for dimy = 1:size(kSpaceRaw{coil},2)
                    for slice = 1:size(kSpaceRaw{coil},3)
                        for dynamic = 1:size(kSpaceRaw{coil},4)
                            if app.CenterEchoCheckBox.Value
                                tmpKline1 = kSpaceRaw{coil}(:,dimy,slice,dynamic);
                                tmpKline2 = interp(tmpKline1,interpFactor);
                                [~,kCenter] = max(abs(tmpKline2));
                                kShift = floor(dimx/2)-kCenter/interpFactor;
                                tmpKline1 = fraccircshift(tmpKline1,kShift);
                                kSpaceRaw{coil}(:,dimy,slice,dynamic) = tmpKline1;
                            end
                            if app.PhaseCorrectCheckBox.Value
                                tmpKline1 = kSpaceRaw{coil}(:,dimy,slice,dynamic);
                                kCenterPhase = angle(tmpKline1(floor(dimx/2)+1));
                                tmpKline1 = tmpKline1.*exp(-1j.*kCenterPhase);
                                kSpaceRaw{coil}(:,dimy,slice,dynamic) = tmpKline1;
                            end
                        end
                    end
                end
            end

            % Apply Tukey filter (again, after shift)
            filterWidth = 0.25;
            tmpFilter = tukeywin(dimx,filterWidth);
            for coil = 1:dimc
                tukeyFilter(:,1,1,1) = tmpFilter;
                kSpaceRaw{coil} = kSpaceRaw{coil}.*tukeyFilter;
            end
        
            % Requested sizes
            dimx = app.XEditField.Value;
            dimy = size(obj.rawKspace{1},2); % original value for now, later interpolated
            dimz = app.ZEditField.Value;
            dimd = app.NREditField.Value;

            % Resize k-space to requested size (kx, ky, slice, nr) by interpolation
            for i=1:dimc
                kSpaceRaw{i} = bart(app,['resize -c 0 ',num2str(dimx),' 2 ',num2str(dimz),' 3 ',num2str(dimd)],kSpaceRaw{i});
            end
            averages = bart(app,['resize -c 0 ',num2str(dimx),' 2 ',num2str(dimz),' 3 ',num2str(dimd)],averages);

            % kx, ky, slices, dynamics, coils
            for i = 1:dimc
                kSpace(:,:,:,:,i) = kSpaceRaw{i};
            end

            % Calibration and density correction size
            kdim = round(dimx/2);
            if mod(kdim,2) == 1
                kdim = kdim + 1;
            end
            kdim(kdim < 32) = 32;
            kdim(kdim > dimx) = dimx;
            calibSize = [kdim, kdim, 1];
            cSize = ['-d',num2str(calibSize(1)),':',num2str(calibSize(2)),':1'];
            app.TextMessage(strcat('Calibration size = ',{' '},num2str(kdim)));

            % Make the radial trajectory 0-180 degrees
            % Could be extended with different trajectories if available
            traj = proudData.twoDradialTrajectory(dimx, dimy, dimz, dimd, dimc);

            % Bart dimensions  Bart   Matlab
            % 	READ_DIM,       0       1   x
            % 	PHS1_DIM,       1       2   y
            % 	PHS2_DIM,       2       3   z
            % 	COIL_DIM,       3       4   coils
            % 	MAPS_DIM,       4       5   sense maps
            % 	TE_DIM,         5       6
            % 	COEFF_DIM,      6       7
            % 	COEFF2_DIM,     7       8
            % 	ITER_DIM,       8       9
            % 	CSHIFT_DIM,     9       10
            % 	TIME_DIM,       10      11  cardiac / respiratory CINE frames
            % 	TIME2_DIM,      11      12  dynamics
            % 	LEVEL_DIM,      12      13
            % 	SLICE_DIM,      13      14  slices
            % 	AVG_DIM,        14      15

            %           1      2        3        4       5
            % Initially x, y(spokes), slices, dynamics, coils

            %                            1 readout spokes
            % Rearrange for BART         1  2  3  4  5  6  7  8  9 10 11 12 13 14
            kSpacePics = permute(kSpace,[6, 1, 2, 5, 7, 8, 9,10,11,12,13, 4,14, 3]);

            % Rearrange for BART        1  2  3  4  5  6  7  8  9 10 11 12 13 14
            avgPics = permute(averages,[6, 1, 2, 5, 7, 8, 9,10,11,12,13, 4,14, 3]);

            % Rearrange for BART     1  2  3  4  5  6  7  8  9 10 11 12 13 14
            trajPics = permute(traj,[1, 2, 3, 6, 7, 8, 9,10,11,12,13, 5,14, 4]);

            % Gradient delay vector from app
            dTotal(1) = app.GxDelayEditField.Value;
            dTotal(2) = app.GyDelayEditField.Value;
            dTotal(3) = app.GzDelayEditField.Value;
            app.DataOffsetRadialEditField.Value = 0;

            % Gradient delay calibration
            if app.GradDelayCalibrationCheckBox.Value

                % Calculate k-space and trajectory sum of all frames
                % and dynamics, remove all zero values
                kSpacePicsSum = sum(kSpacePics(:,:,:,:,:,:,:,:,:,:,:,:,:,floor(dimz/2)+1),[11,12]);
                trajPicsSum = sum(trajPics(:,:,:,:,:,:,:,:,:,:,:,:,:,floor(dimz/2)+1),[11,12]);

                % Ring method
                if app.RingMethodCheckBox.Value

                    % Sent gradient delay vector back to app
                    app.GxDelayEditField.Value = 0;
                    app.GyDelayEditField.Value = 0;
                    app.GzDelayEditField.Value = 0;

                    % Ring method using estdelay in Bart
                    try

                        dTotal = [];

                        delaysBart = bart(app,'estdelay -r4 ',trajPicsSum,kSpacePicsSum);
                        
                        % Remove unkown warning
                        ff = strfind(delaysBart,"[0m");
                        if ~isempty(ff)
                            delaysBart = delaysBart(ff:end);
                            delaysBart = erase(delaysBart,"[0m");
                            delaysBart = erase(delaysBart,newline);
                        end

                        delaysBart = strrep(delaysBart,':',',');
                        dTotal = str2num(delaysBart); 
                        dTotal(1) = - dTotal(1); % It seems this correction should be the inverted

                    catch ME

                        app.TextMessage(ME.message);
                        app.TextMessage('Ring gradient delay estimation failed ...');
                        app.TextMessage('Trying iterative method ...');
                        app.SetStatus(1);
                        app.RingMethodCheckBox.Value = false;
                        dTotal = zeros(3,1);

                    end 

                    % Sent gradient delay vector back to app
                    if ~isempty(dTotal)

                        app.GxDelayEditField.Value = double(round(dTotal(1),5));
                        app.GyDelayEditField.Value = double(round(dTotal(2),5));
                        app.GzDelayEditField.Value = double(round(dTotal(3),5));

                    else

                        app.TextMessage('Ring gradient delay estimation failed ...');
                        app.TextMessage('Trying iterative method ...');
                        app.SetStatus(1);
                        app.RingMethodCheckBox.Value = false;
                        dTotal = zeros(3,1);

                    end

                end % Ring method

                % Iterative method
                if ~app.RingMethodCheckBox.Value

                    try

                        % Calibration size
                        kSize = [6,6];
                        kSkip = round(length(kSpacePicsSum)/2000);
                        kSkip(kSkip < 1) = 1;

                        % M1:M2 = indices in trajectory for which k-space value <= calibSize
                        [~,zm] = find(squeeze(trajPicsSum(1,:,:)) == max(trajPicsSum(:)),1,'first');
                        if isempty(zm)
                            [~,zm] = find(squeeze(trajPicsSum(2,:,:)) == max(trajPicsSum(:)),1,'first');
                        end
                        M = find(sqrt(trajPicsSum(1,:,zm).^2+trajPicsSum(2,:,zm).^2) <= calibSize(1)/2);
                        M1 = M(1);
                        M2 = M(end);

                        % Reduce size for gradient calibration
                        kTrajCalib = trajPicsSum(:,M1:M2,1:kSkip:end);
                        dataCalib = kSpacePicsSum(1,M1:M2,1:kSkip:end);
                        app.TextMessage(strcat('Calibration trajectory length = ',{' '},num2str(length(kTrajCalib))));

                        % Set initial delays to zero
                        app.GzDelayEditField.Value = 0;
                        dTotal = zeros(3,1);
                        kTraj = kTrajCalib;

                        % Initial image
                        imCalib = bart(app,['bart nufft -i -l 0.01 ',cSize,' -t'],kTrajCalib,dataCalib);

                        % Initialization
                        iteration = 0;
                        incre = 10;
                        kCalib = obj.fft2Dmri(imCalib);
                        wnRank = 0.4;
                        rank = floor(wnRank*prod(kSize));
                        app.TextMessage(strcat('Rank = ',{' '},num2str(rank)));

                        % Data consistency
                        y = squeeze(dataCalib);
                        xOld = kCalib;

                        % Prepare for manual stop
                        app.stopGradCal_flag = false;

                        % Iterative method with Bart
                        while  (iteration<300) && (incre>0.001) && ~app.stopGradCal_flag

                            % Iteration number
                            iteration = iteration + 1;
                            app.TextMessage(strcat('Iteration:',{' '},num2str(iteration)));

                            % Solve for X
                            rank(rank>prod(kSize)) = prod(kSize);
                            xNew = obj.lowRankThresh2D(xOld,kSize,rank);
                            % rank = rank+0.05;
                            % app.TextMessage(strcat('Rank :',{' '},num2str(rank)));

                            % NUFFT to get updated k-space data
                            kNew = obj.ifft2Dmri(xNew);
                            dataCalib = bart(app,'bart nufft -l 0.01',kTraj,kNew);
                            kNew  = reshape(dataCalib,[M2-M1+1 size(kTrajCalib,3) dimc]);

                            % Partial derivatives
                            [dydtx,dydty] = obj.partialDerivative2D(app,kTraj,xNew,calibSize);

                            % Direct solver
                            dydt = [real(obj.vec(dydtx)) real(obj.vec(dydty)) ; imag(obj.vec(dydtx)) imag(obj.vec(dydty))];
                            dStep = ((dydt)'*dydt)\(dydt' * [real(obj.vec(kNew - y)) ; imag(obj.vec(kNew - y))]);
                            dStep(isnan(dStep)) = 0;

                            % The accumalated delays
                            dTotal(1) = dTotal(1) + real(dStep(1));
                            dTotal(2) = dTotal(2) + real(dStep(2));
                            dTotal(dTotal > 10) = 10;
                            dTotal(dTotal < -10) = -10;

                            % Conversion criterium
                            incre = norm(real(dStep));

                            % Message
                            app.TextMessage(strcat('Estimated delays:',{' '},num2str(dTotal(1)),':',num2str(dTotal(2))));

                            % Sent gradient delay vector back to app
                            app.GxDelayEditField.Value = double(round(dTotal(1),5));
                            app.GyDelayEditField.Value = double(round(dTotal(2),5));
                            app.GzDelayEditField.Value = 0;

                            % Interpolation to update trajectory with new delays
                            kTraj = obj.trajInterpolation(kTrajCalib,dTotal);

                            % The new image with k-space updated for gradient delays
                            imCalib = bart(app,['bart nufft -i -l 0.01 ',cSize,' -t'],kTraj,reshape(y,[1 M2-M1+1 size(kTrajCalib,3) dimc]));

                            % Show image
                            im = squeeze(abs(imCalib(:,:)));
                            if obj.PHASE_ORIENTATION
                                im = rot90(im,-1);
                                daspect(app.RecoFig,[1 1 1]);
                            else
                                daspect(app.RecoFig,[1 1 1]);
                            end
                            xlim(app.RecoFig, [0 size(im,2)+1]);
                            ylim(app.RecoFig, [0 size(im,1)+1]);
                            imshow(rot90(im),[],'Parent',app.RecoFig);

                            % Calculate k-space from new image
                            xOld = obj.fft2Dmri(squeeze(imCalib));

                        end

                    catch ME

                        app.TextMessage(ME.message);
                        app.TextMessage('Gradient delay estimation failed ...');
                        app.SetStatus(1);
                        dTotal = zeros(3,1);
                        app.GxDelayEditField.Value = double(dTotal(1));
                        app.GyDelayEditField.Value = double(dTotal(2));
                        app.GzDelayEditField.Value = double(dTotal(3));
                        
                    end

                end

                % Reset calibration button
                app.GradDelayCalibrationCheckBox.Value = 0;
                app.stopGradCal_flag = true;

            end % Gradient calibration

            % Final gradient delay correction from optimization or values from app
            trajPics = permute(trajPics,[1 2 3 11 12 14 4 5 6 7 8 9 10 13]);
            trajPics = obj.trajInterpolation(trajPics,dTotal);
            trajPics = ipermute(trajPics,[1 2 3 11 12 14 4 5 6 7 8 9 10 13]);

            % Sensitivity maps
            if dimc > 1 
                kSpacePicsSum = sum(kSpacePics,[11,12]);
                trajPicsSum = sum(trajPics,[11,12]);
                ze = squeeze(abs(kSpacePicsSum(1,end,:))) > 0;
                kSpacePicsSum = kSpacePicsSum(:,:,ze);
                trajPicsSum = trajPicsSum(:,:,ze);
                app.TextMessage('Calculating coil sensitivity maps ...');
                lowResImage = bart(app,['nufft -i -l2 ',cSize,' -t'], trajPicsSum, kSpacePicsSum);
                lowResKspace = bart(app,'fft -u 7', lowResImage);
                kSpaceZeroFilled = bart(app,['resize -c 0 ',num2str(dimy),' 1 ',num2str(dimx)], lowResKspace);
                sensitivities = bart(app,'ecalib -t0.002 -m1', kSpaceZeroFilled);
            else
                sensitivities = ones(dimx,dimy,1,dimc,1,1,1,1,1,1,1,1,1,dimz);
            end

            % Density correction
            if app.DensityCorrectCheckBox.Value
                app.TextMessage('Calculating density correction ...');
                densityOnes = ones(size(kSpacePics));
                densityOnes = densityOnes.*avgPics; % Make sure densityOnes contains only 1's when data is available
                densityOnes(densityOnes > 1) = 1;
                densityTmp = bart(app,strcat('nufft -d',num2str(dimx),':',num2str(dimy),':1 -a'),trajPics,densityOnes);
                densityPics = bart(app,'nufft ',trajPics,densityTmp);
                densityPics = densityPics.^(-1/2);
                densityPics(isnan(densityPics)) = 0;
                densityPics(isinf(densityPics)) = 0;
            end

            % Prepare the 2D radial PICS reconstruction
            app.TextMessage('PICS reconstruction ...');
            picsCommand = 'pics -i20 -e ';
            if LW>0
                picsCommand = [picsCommand,' -RW:6:0:',num2str(LW)];
            end
            if TVxyz>0
                picsCommand = [picsCommand,' -R',obj.totalVariation,':6:0:',num2str(TVxyz)];
            end
            if LR>0
                % Locally low-rank in the spatial domain
                blockSize = round(dimx/16);  % Block size
                blockSize(blockSize<8) = 8;
                picsCommand = [picsCommand,' -RL:6:6:',num2str(LR),' -b',num2str(blockSize),' -N '];
            end
            if TVd>0
                picsCommand = [picsCommand,' -R',obj.totalVariation,':2048:0:',num2str(TVd)];
            end

            % The actual reconstruction
            if app.DensityCorrectCheckBox.Value
                igrid = bart(app,picsCommand,'-p',densityPics,'-t',trajPics,kSpacePics,sensitivities);
            else
                igrid = bart(app,picsCommand,'-t',trajPics,kSpacePics,sensitivities);
            end

            % Root sum of squares over all coils
            recoImage = bart(app,'rss 16', igrid);

            % Interpolate to desired dimy if necessary
            if dimy ~= size(igrid,3)
                dimy = app.YEditField.Value;
                fiGrid = bart(app,'fft 2',recoImage);
                fiGrid = bart(app,['resize -c 1 ',num2str(dimy)],fiGrid);
                igrid = bart(app,'fft -i 2',fiGrid);
            end
     
            % Rearrange to orientation: x, y, slices, dynamics
            imageOut = permute(igrid,[1, 2, 14, 12, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13]);

            % Flip for phase-orientation is vertical
            if obj.PHASE_ORIENTATION == 0
                imageOut = flip(flip(imageOut,2),1);
            end

            % Get the in-plane image shift
            obj = obj.get2DimageShift(imageOut, app);

            % Apply the shift on sub-pixel level
            for dyn = 1:size(imageOut,4)
                for slice = 1:size(imageOut,3)
                    imageOut(:,:,slice,dyn) = proudData.image2Dshift(squeeze(imageOut(:,:,slice,dyn)),obj.yShift,obj.xShift);
                end
            end

            % Absolute value and phase image
            imagesReg = abs(imageOut);
            phaseImagesReg = angle(imageOut);

            % Return the image objects
            obj.images(:,:,:,:,flipAngle,echoTime) = imagesReg;
            obj.phaseImages(:,:,:,:,flipAngle,echoTime) = phaseImagesReg;
            obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = phaseImagesReg;

        end % csRecoRadial




        % ---------------------------------------------------------------------------------
        % Image reconstruction: NUFFT 2D Radial
        % ---------------------------------------------------------------------------------
        function obj = Reco2DRadialNUFFT(obj,app,flipAngle,echoTime)

            % Original kx, ky, slices, dynamics
            kSpaceRaw = cell(obj.nrCoils);
            for i=1:obj.nrCoils
                kSpaceRaw{i} = obj.rawKspace{i}(:,:,:,:,flipAngle,echoTime);
            end

            % Image dimensions
            [dimx, dimy, dimz, dimd] = size(kSpaceRaw{1});

            % Requested dimensions
            % Slice and dynamic dimensions are put back to original values
            ndimx = app.XEditField.Value;
            ndimy = app.YEditField.Value;
            app.ZEditField.Value = dimz;
            app.NREditField.Value = dimd;

            % Center echo and/or phase correction
            interpFactor = 16;
            for coil = 1:obj.nrCoils
                for spokes = 1:size(kSpaceRaw{coil},2)
                    for slice = 1:size(kSpaceRaw{coil},3)
                        for dynamic = 1:size(kSpaceRaw{coil},4)
                            if app.CenterEchoCheckBox.Value
                                tmpKline1 = kSpaceRaw{coil}(:,spokes,slice,dynamic);
                                tmpKline2 = interp(tmpKline1,interpFactor);
                                [~,kCenter] = max(abs(tmpKline2));
                                kShift = floor(dimx/2)-kCenter/interpFactor;
                                tmpKline1 = fraccircshift(tmpKline1,kShift);
                                kSpaceRaw{coil}(:,spokes,slice,dynamic) = tmpKline1;
                            end
                            if app.PhaseCorrectCheckBox.Value
                                tmpKline1 = kSpaceRaw{coil}(:,spokes,slice,dynamic);
                                kCenterPhase = angle(tmpKline1(floor(dimx/2)+1));
                                tmpKline1 = tmpKline1.*exp(-1j.*kCenterPhase);
                                kSpaceRaw{coil}(:,spokes,slice,dynamic) = tmpKline1;
                            end
                        end
                    end
                end
            end

            % Apply Tukey filter (again, after shift)
            filterWidth = 0.25;
            tmpFilter = tukeywin(dimx,filterWidth);
            for coil = 1:obj.nrCoils
                tukeyFilter(:,1,1,1) = tmpFilter;
                kSpaceRaw{coil} = kSpaceRaw{coil}.*tukeyFilter;
            end
        
            % Make the radial trajectory 0-180 degrees
            % Could be extended with different trajectories if available
            fullAngle = 180;
            for j = 1:dimy
                % crds, x, y(spoke)
                traj(1,:,j) = (-floor(dimx/2)+0.5:floor(dimx/2)-0.5)*cos((pi/180)*(j-1)*fullAngle/dimy);
                traj(2,:,j) = (-floor(dimx/2)+0.5:floor(dimx/2)-0.5)*sin((pi/180)*(j-1)*fullAngle/dimy);
                traj(3,:,j) = 0;
            end

            % Gradient delays from app
            dTotal(1) = app.GxDelayEditField.Value;
            dTotal(2) = app.GyDelayEditField.Value;
            dTotal(3) = app.GzDelayEditField.Value;
            app.DataOffsetRadialEditField.Value = 0;

            % Prepare the trajectory with the gradient delay values
            traj = obj.trajInterpolation(traj,dTotal);

            % Initialization
            maxit = 5;      % 0 or 1 for gridding, higher values for conjugate gradient
            damp = 0;       % Tikhonov penalty on ||x||
            weight = [];    % data weighting (optional)
            partial = 0.5;  % Tikhobov penalty on ||imag(x))||

            % Progress gauge
            loops = dimz*dimd*obj.nrCoils;
            app.RecoProgressGauge.Value = 0;

            cnt = 1;
            
            for slice = 1:dimz

                for dynamic = 1:dimd

                    % NOTE: coils can be incorporated in the NUFFT, need data first
                    for coil = 1:obj.nrCoils
                        
                        objn = nufft_3d(traj,dimx,app);

                        data = kSpaceRaw{coil}(:,:,slice,dynamic);
                        data = data(:);

                        reco = squeeze(objn.iNUFT(data,maxit,damp,weight,'phase-constraint',partial,app));
                      
                        reco = imresize(reco,[ndimy ndimx]);

                        image(:,:,slice,dynamic,coil) = reco;

                        app.RecoProgressGauge.Value = round(100*cnt/loops);
                        drawnow;

                    end

                    cnt = cnt + 1;

                end

            end         

            % Root sum of squares coil dimension
            imageOut = rssq(image,5);

            % Flip for phase-orientation is vertical
            if obj.PHASE_ORIENTATION == 0
                imageOut = flip(flip(imageOut,2),1);
            end

             % Get the in-plane image shift
            obj = obj.get2DimageShift(imageOut, app);

            % Apply the shift on sub-pixel level
            for dyn = 1:size(imageOut,4)
                for slice = 1:size(imageOut,3)
                    imageOut(:,:,slice,dyn) = proudData.image2Dshift(squeeze(imageOut(:,:,slice,dyn)),obj.yShift,obj.xShift);
                end
            end

            % Absolute value and phase image
            imagesReg = abs(imageOut);
            phaseImagesReg = angle(imageOut);

            % Return the image objects
            obj.images(:,:,:,:,flipAngle,echoTime) = imagesReg;
            obj.phaseImages(:,:,:,:,flipAngle,echoTime) = phaseImagesReg;
            obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = phaseImagesReg;

        end % Reco2DRadialNUFFT





        % ---------------------------------------------------------------------------------
        % Image reconstruction: CS 3D UTE with BART
        % ---------------------------------------------------------------------------------
        function obj = Reco3DuteCS(obj,app,flipAngle,echoTime)

            % CS regularization parameters
            LW = app.WVxyzEditField.Value;
            TVxyz = app.TVxyzEditField.Value;
            LR = app.LRxyzEditField.Value;
            TVd = app.TVtimeEditField.Value;
            dimc = obj.nrCoils;
            obj.totalVariation = 'T'; % Use total variation, instead of TGV 

            % Original kx(readout), ky(spokes), 1, dynamics, flip-angle, echo-time
            kSpaceRaw = cell(dimc);
            for i=1:dimc
                kSpaceRaw{i} = obj.rawKspace{i}(:,:,:,:,flipAngle,echoTime);
            end

            % Averages
            averages = obj.nsaSpace;

            % Gradient delays from app
            dTotal(1) = app.GxDelayEditField.Value;
            dTotal(2) = app.GyDelayEditField.Value;
            dTotal(3) = app.GzDelayEditField.Value;
            offset = app.DataOffsetRadialEditField.Value;

            % Data size
            dimx = size(obj.rawKspace{1},1);
            dimy = size(obj.rawKspace{1},2);
            dimd = app.NREditField.Value;

            % K-space radial spokes
            dims = length(obj.gradTrajectory);
            traj = zeros(3,dims,dimy,dimd);
            for i=1:dimc
                for g = 1:dimd
                    for cnt = 1:dimy
                        traj(1,:,cnt,g,i) = dims*(obj.seqTrajectory(1,cnt)/32767)*obj.gradTrajectory(:);
                        traj(2,:,cnt,g,i) = dims*(obj.seqTrajectory(2,cnt)/32767)*obj.gradTrajectory(:);
                        traj(3,:,cnt,g,i) = dims*(obj.seqTrajectory(3,cnt)/32767)*obj.gradTrajectory(:);
                    end
                end
            end

            % Check if offset is not too large, if so reduce size
            offset(offset < 0) = 0;
            offset(offset > (dimx - dims)) = dimx - dims;
            app.DataOffsetRadialEditField.Value = offset;

            % Resize k-space and remove offset
            for i = 1:dimc
                kSpace{i}(:,:,:,:) = kSpaceRaw{i}(1+offset:dims+offset,:,:,:);
            end
            averages = averages(1+offset:dims+offset,:,:,:);

            % Resize k-space to requested dynamic size by interpolation
            for i=1:dimc
                kSpace{i} = bart(app,['resize -c 3 ',num2str(dimd)],kSpace{i});
            end
            averages = bart(app,['resize -c 3 ',num2str(dimd)],averages);
            traj = bart(app,['resize -c 3 ',num2str(dimd)],traj);
 
            % Auto shift to maximum intensity at first data point
            if app.CenterEchoCheckBox.Value
                interpFactor = 16;
                for coil = 1:dimc
                    for dynamic = 1:dimd
                        for spoke = 1:dimy
                            tmpKline1 = kSpace{coil}(:,spoke,1,dynamic);
                            tmpKline2 = interp(tmpKline1,interpFactor);
                            [~,kCenter] = max(abs(tmpKline2));
                            kShift = 1-kCenter/interpFactor;
                            discard = ceil(abs(kShift));
                            tmpKline1 = fraccircshift(tmpKline1,kShift);
                            tmpKline1(end-discard:end) = 0;
                            kSpace{coil}(:,spoke,1,dynamic) = tmpKline1;
                        end
                    end
                end
            end

            % Phase correction
            if app.PhaseCorrectCheckBox.Value
                interpFactor = 16;
                for coil = 1:dimc
                    for dynamic = 1:dimd
                        for spoke = 1:dimy
                            tmpKline1 = kSpace{coil}(:,spoke,1,dynamic);
                            kCenterPhase = angle(tmpKline1(1));
                            tmpKline1 = tmpKline1.*exp(-1j.*kCenterPhase);
                            kSpace{coil}(:,spoke,1,dynamic) = tmpKline1;
                        end
                    end
                end
            end

            % kx(readout), ky(spokes), 1, dynamics, coils
            for i = 1:dimc
                kSpacePics(:,:,1,:,i) = kSpace{i};
            end

            % Bart dimensions  Bart   Matlab
            % 	READ_DIM,       0       1   x
            % 	PHS1_DIM,       1       2   y
            % 	PHS2_DIM,       2       3   z
            % 	COIL_DIM,       3       4   coils
            % 	MAPS_DIM,       4       5   sense maps
            % 	TE_DIM,         5       6
            % 	COEFF_DIM,      6       7
            % 	COEFF2_DIM,     7       8
            % 	ITER_DIM,       8       9
            % 	CSHIFT_DIM,     9       10
            % 	TIME_DIM,       10      11  cardiac / respiratory CINE frames
            % 	TIME2_DIM,      11      12  dynamics
            % 	LEVEL_DIM,      12      13
            % 	SLICE_DIM,      13      14  slices
            % 	AVG_DIM,        14      15

            %           1      2        3        4       5
            % Initially x, y(spokes),   1,    dynamics, coils

            %                                1 readout spokes coils .....    dynamics
            % Rearrange for BART             1  2  3  4  5  6  7  8  9 10 11 12 13 14
            kSpacePics = permute(kSpacePics,[6, 1, 2, 5, 3, 7, 8, 9,10,11,12, 4,13,14]);

            % Rearrange for BART        1  2  3  4  5  6  7  8  9 10 11 12 13 14
            avgPics = permute(averages,[6, 1, 2, 5, 3, 7, 8, 9,10,11,12, 4,13,14]);

            % Rearrange for BART     1  2  3  4  5  6  7  8  9 10 11 12 13 14
            trajPics = permute(traj,[1, 2, 3, 5, 6, 7, 8, 9,10,11,12, 4,13,14]);

            % Calibration and density correction size
            kdim = round(dims/3);
            if mod(kdim,2) == 1
                kdim = kdim + 1;
            end
            kdim(kdim < 32) = 32;
            kdim(kdim > dimx) = dimx;
            calibSize = [kdim, kdim, kdim];
            cSize = ['-d',num2str(calibSize(1)),':',num2str(calibSize(2)),':',num2str(calibSize(3))];
            app.TextMessage(strcat('Calibration size = ',{' '},num2str(kdim)));
     
            % Gradient delay calibration
            if app.GradDelayCalibrationCheckBox.Value

                % K-space and trajectory sum
                kSpacePicsSum = sum(kSpacePics,[11,12]);
                trajPicsSum = sum(trajPics,[11,12]);

                % Calibration size
                kSize = [6,6,6];
                kSkip = round(length(kSpacePicsSum)/2000);
                kSkip(kSkip < 1) = 1;

                % M = index in trajectory for which k-space value >= calibSize
                [~,zm] = find(squeeze(trajPicsSum(1,:,:)) == max(trajPicsSum(:)),1,'first');
                if isempty(zm)
                    [~,zm] = find(squeeze(trajPicsSum(2,:,:)) == max(trajPicsSum(:)),1,'first');
                end
                if isempty(zm)
                    [~,zm] = find(squeeze(trajPicsSum(3,:,:)) == max(trajPicsSum(:)),1,'first');
                end
                M = find(sqrt(trajPicsSum(1,:,zm).^2+trajPicsSum(2,:,zm).^2+trajPicsSum(3,:,zm).^2) >= calibSize(1,1)/2,1);

                % Reduce size for gradient calibration
                kTrajCalib = trajPicsSum(:,1:M,1:kSkip:end);
                dataCalib = kSpacePicsSum(1,1:M,1:kSkip:end);
                ze = squeeze(abs(dataCalib(1,1,:))) > 0;
                kTrajCalib = kTrajCalib(:,:,ze);
                app.TextMessage(strcat('Calibration trajectory length = ',{' '},num2str(length(kTrajCalib))));

                % Interpolation to update trajectory with initial delays
                kTrajCalib = proudData.trajInterpolation(kTrajCalib,dTotal);
                kTraj = kTrajCalib;

                % Initial image
                dataCalib = dataCalib(:,:,ze);
                imCalib = bart(app,['bart nufft -i -l 0.01 ',cSize,' -t'],kTrajCalib,dataCalib);

                % Initialization
                iteration = 0;
                incre = 10;
                kCalib = proudData.fft3Dmri(imCalib);
                wnRank = 0.8;
                rank = floor(wnRank*prod(kSize));
                app.TextMessage(strcat('Rank = ',{' '},num2str(rank)));

                % Data consistency
                y = squeeze(dataCalib);
                xOld = kCalib;

                % Prepare for manual stop
                app.stopGradCal_flag = false;

                % Reset delay values
                dTotal = zeros(3,1);

                % Calibration
                while  (iteration<300)  && (incre>0.001) && ~app.stopGradCal_flag

                    % Iteration number
                    iteration = iteration + 1;
                    app.TextMessage(strcat('Iteration:',{' '},num2str(iteration)));

                    % Solve for X
                    xNew = proudData.lowRankThresh3D(xOld,kSize,rank);
                    rank = rank+0.2;
                    rank(rank>prod(kSize)) = prod(kSize);

                    % NUFFT to get updated k-space data
                    kNew = proudData.ifft3Dmri(xNew);
                    dataCalib = bart(app,'bart nufft',kTraj,kNew);
                    kNew  = reshape(dataCalib,[M size(kTrajCalib,3) dimc]);

                    % Partial derivatives
                    [dydtx,dydty,dydtz] = proudData.partialDerivative3D(app,kTraj,xNew,calibSize);

                    % Direct solver
                    dydt = [real(proudData.vec(dydtx)) real(proudData.vec(dydty)) real(proudData.vec(dydtz)) ; imag(proudData.vec(dydtx)) imag(proudData.vec(dydty)) imag(proudData.vec(dydtz))];
                    dStep = ((dydt)'*dydt)\(dydt' * [real(proudData.vec(kNew - y)) ; imag(proudData.vec(kNew - y))]);
                    dStep(isnan(dStep)) = 0;

                    % The accumalated delays
                    dTotal = dTotal + real(dStep);
                    dTotal(dTotal > 10) = 10;
                    dTotal(dTotal < -10) = -10;

                    % Conversion criterium
                    incre = norm(real(dStep));

                    % Message
                    app.TextMessage(strcat('Estimated delays:',{' '},num2str(dTotal(1)),':',num2str(dTotal(2)),':',num2str(dTotal(3))));

                    % Sent gradient delay vector back to app
                    app.GxDelayEditField.Value = double(dTotal(1));
                    app.GyDelayEditField.Value = double(dTotal(2));
                    app.GzDelayEditField.Value = double(dTotal(3));

                    % Interpolation to update trajectory with new delays
                    kTraj = proudData.trajInterpolation(kTrajCalib,dTotal);

                    % The new image with k-space updated for gradient delays
                    imCalib = bart(app,['bart nufft -i -l 0.01 ',cSize,' -t'],kTraj,reshape(y,[1 M size(kTrajCalib,3) dimc]));

                    % Show image
                    im = squeeze(abs(imCalib(:,:,round(calibSize(3)/2),1)));
                    im = flip(flip(im,1),2);
                    if obj.PHASE_ORIENTATION
                        im = rot90(im,-1);
                        daspect(app.RecoFig,[1 1 1]);
                    else
                        daspect(app.RecoFig,[1 1 1]);
                    end
                    xlim(app.RecoFig, [0 size(im,2)+1]);
                    ylim(app.RecoFig, [0 size(im,1)+1]);
                    imshow(rot90(im),[],'Parent',app.RecoFig);

                    % Calculate k-space from new image
                    xOld = proudData.fft3Dmri(squeeze(imCalib));

                end

                app.GradDelayCalibrationCheckBox.Value = 0;

            end % Gradient calibration

            % Final gradient delay correction from optimization or values from app
            trajPics = permute(trajPics,[1 2 3 11 12 14 4 5 6 7 8 9 10 13]);
            trajPics = obj.trajInterpolation(trajPics,dTotal);
            trajPics = ipermute(trajPics,[1 2 3 11 12 14 4 5 6 7 8 9 10 13]);

            % Coil sensitivities from sum of all frames and dynamics
            if dimc > 1
                kSpacePicsSum = sum(kSpacePics,[11,12]);
                trajPicsSum = sum(trajPics,[11,12]);
                ze = squeeze(abs(kSpacePicsSum(1,end,:))) > 0;
                kSpacePicsSum = kSpacePicsSum(:,:,ze);
                trajPicsSum = trajPicsSum(:,:,ze);
                app.TextMessage('Calculating coil sensitivity maps ...');
                lowResImage = bart(app,['nufft -i ',cSize,' -t'], trajPicsSum, kSpacePicsSum);
                lowResKspace = bart(app,'fft -u 7', lowResImage);
                kSpaceZeroFilled = bart(app,['resize -c 0 ',num2str(dims),' 1 ',num2str(dims),' 2 ',num2str(dims)], lowResKspace);
                sensitivities = bart(app,'ecalib -S -t0.0005 -m1', kSpaceZeroFilled);
            else
                sensitivities = ones(dims,dims,dims,dimc,1,1,1,1,1,1,1,1,1,1);
            end

            % Density correction
            if app.DensityCorrectCheckBox.Value
                app.TextMessage('Calculating density correction ...');
                densityOnes = ones(size(kSpacePics));
                densityOnes = densityOnes.*avgPics; % Make sure densityOnes contains only 1's when data is available
                densityOnes(densityOnes > 1) = 1;
                densityTmp = bart(app,strcat('nufft -d',num2str(dims),':',num2str(dims),':',num2str(dims),' -a'),trajPics,densityOnes);
                densityPics = bart(app,'nufft ',trajPics,densityTmp);
                densityPics = densityPics.^(-1/3);
                densityPics(isnan(densityPics)) = 0;
                densityPics(isinf(densityPics)) = 0;
            end

            % Prepare the PICS reconstruction
            app.TextMessage('PICS reconstruction ...');
            picsCommand = 'pics -i10 ';
            if LW>0
                picsCommand = [picsCommand,' -RW:7:0:',num2str(LW)];
            end
            if TVxyz>0
                picsCommand = [picsCommand,' -R',obj.totalVariation,':7:0:',num2str(TVxyz)];
            end
            if LR>0
                % Locally low-rank in the spatial domain
                blockSize = round(dims/16);  % Block size
                blockSize(blockSize<8) = 8;
                picsCommand = [picsCommand,' -RL:7:7:',num2str(LR),' -b',num2str(blockSize)];
            end
            if TVd>0
                picsCommand = [picsCommand,' -R',obj.totalVariation,':2048:0:',num2str(TVd)];
            end

            % Do the Bart reco
            if app.DensityCorrectCheckBox.Value
                igrid = bart(app,picsCommand,'-t',trajPics,'-p',densityPics,kSpacePics,sensitivities);
            else
                igrid = bart(app,picsCommand,'-t',trajPics,kSpacePics,sensitivities);
            end

            % Root sum of squares over all coils
            recoImage = bart(app,'rss 16', igrid);

            % Interpolate to desired dimensions if requested
            ndimx = app.XEditField.Value;
            ndimy = app.YEditField.Value;
            ndimz = app.ZEditField.Value;
            [dimx, dimy, dimz, ~ ] = size(obj.images);
            if (ndimx ~= dimx) || (ndimy ~= dimy) || (ndimz ~= dimz)
                fiGrid = bart(app,'fft 7',recoImage);
                fiGrid = bart(app,['resize -c 0 ',num2str(ndimx),' 1 ',num2str(ndimy),' 2 ',num2str(ndimz)],fiGrid);
                recoImage = bart(app,'fft -i 7',fiGrid);
            end

            % Absolute value and phase image
            imagesReg = abs(recoImage);
            phaseImagesReg = angle(recoImage);

            % Flip dimensions to correct orientation
            if obj.PHASE_ORIENTATION == 1
                imagesReg = flip(imagesReg,3);
                phaseImagesReg = flip(phaseImagesReg,3);
            else
                imagesReg = flip(flip(imagesReg,3),1);
                phaseImagesReg = flip(flip(phaseImagesReg,3),1);
            end

            % Return the image objects
            obj.images(:,:,:,:,flipAngle,echoTime) = imagesReg;
            obj.phaseImages(:,:,:,:,flipAngle,echoTime) = phaseImagesReg;
            obj.phaseImagesOrig(:,:,:,:,flipAngle,echoTime) = phaseImagesReg;

        end % Reco3DuteCS





        % ---------------------------------------------------------------------------------
        % Image reconstruction: NUFFT 3D UTE with Matlab
        % ---------------------------------------------------------------------------------
        function obj = Reco3DuteNUFFT(obj,app,flipAngle,echoTime)

            % Original kx(readout), ky(spokes)
            kSpaceRaw = cell(obj.nrCoils);
            for i=1:obj.nrCoils
                kSpaceRaw{i} = obj.rawKspace{i}(:,:,:,1,flipAngle,echoTime);
            end

            % Gradient delays from app
            dTotal(1) = app.GxDelayEditField.Value;
            dTotal(2) = app.GyDelayEditField.Value;
            dTotal(3) = app.GzDelayEditField.Value;
            offset = app.DataOffsetRadialEditField.Value;

            % Data dimensions
            [dimx, dimy] = size(kSpaceRaw{1});

            % K-space radial spokes
            dims = length(obj.gradTrajectory);
            traj = zeros(3,dims,dimy);
            for cnt = 1:dimy
                traj(1,:,cnt) = dims*(obj.seqTrajectory(1,cnt)/32767)*obj.gradTrajectory(:);
                traj(2,:,cnt) = dims*(obj.seqTrajectory(2,cnt)/32767)*obj.gradTrajectory(:);
                traj(3,:,cnt) = dims*(obj.seqTrajectory(3,cnt)/32767)*obj.gradTrajectory(:);
            end

            % Check if offset is not too large, if so reduce size
            offset(offset < 0) = 0;
            offset(offset > (dimx - dims)) = dimx - dims;
            app.DataOffsetRadialEditField.Value = offset;

            % Resize k-space and remove offset
            for i = 1:obj.nrCoils
                kSpace{i}(:,:) = kSpaceRaw{i}(1+offset:dims+offset,:);
            end

            % Auto shift to maximum intensity at first data point
            if app.CenterEchoCheckBox.Value
                interpFactor = 16;
                for coil = 1:obj.nrCoils
                    for spoke = 1:dimy
                        tmpKline1 = kSpace{coil}(:,spoke);
                        tmpKline2 = interp(tmpKline1,interpFactor);
                        [~,kCenter] = max(abs(tmpKline2));
                        kShift = 1-kCenter/interpFactor;
                        discard = ceil(abs(kShift));
                        tmpKline1 = fraccircshift(tmpKline1,kShift);
                        tmpKline1(end-discard:end) = 0;
                        kSpace{coil}(:,spoke) = tmpKline1;
                    end
                end
            end

            % Phase correction
            if app.PhaseCorrectCheckBox.Value
                interpFactor = 16;
                for coil = 1:obj.nrCoils
                    for spoke = 1:dimy
                        tmpKline1 = kSpace{coil}(:,spoke);
                        kCenterPhase = angle(tmpKline1(1));
                        tmpKline1 = tmpKline1.*exp(-1j.*kCenterPhase);
                        kSpace{coil}(:,spoke) = tmpKline1;
                    end
                end
            end

            % Prepare the trajectory with the gradient delay values
            traj = obj.trajInterpolation(traj,dTotal);

            % Initialization
            maxit = 5;      % 0 or 1 for gridding, higher values for conjugate gradient
            damp = 0;       % Tikhonov penalty on ||x||
            weight = [];    % data weighting (optional)
            partial = 0.5;  % Tikhobov penalty on ||imag(x))||

            % Progress gauge
            loops = obj.nrCoils;
            app.RecoProgressGauge.Value = 0;

            cnt = 1;

            % Reco
            for coil = 1:obj.nrCoils

                objn = nufft_3d(traj,dims,app);

                data = kSpace{coil}(:);

                reco = squeeze(objn.iNUFT(data,maxit,damp,weight,'phase-constraint',partial,app));

                image(:,:,:,coil) = reco;

                app.RecoProgressGauge.Value = round(100*cnt/loops);
                drawnow;

                cnt = cnt + 1;

            end

            % Root sum of squares coil dimension
            imageOut = rssq(image,4);

            % Flip dimensions to correct orientation
            if obj.PHASE_ORIENTATION == 1
                imageOut = flip(imageOut,3);
            else
                imageOut = flip(flip(imageOut,3),1);
            end

            % Absolute value and phase image
            imagesReg = abs(imageOut);
            phaseImagesReg = angle(imageOut);

            % Return the image objects
            obj.images(:,:,:,1,flipAngle,echoTime) = imagesReg;
            obj.phaseImages(:,:,:,1,flipAngle,echoTime) = phaseImagesReg;
            obj.phaseImagesOrig(:,:,:,1,flipAngle,echoTime) = phaseImagesReg;

            % At this moment the datasize will be that of the original data
            app.XEditField.Value = size(obj.images,1);
            app.YEditField.Value = size(obj.images,2);
            app.ZEditField.Value = size(obj.images,3);
            app.NREditField.Value = 1;

        end % Reco3DuteNUFFT





        % ---------------------------------------------------------------------------------
        % PCA denoising
        % ---------------------------------------------------------------------------------
        function obj = PCAdenoise(obj,app)

            try

                if app.DeNoiseCheckBox.Value

                    app.TextMessage('PCA image denoising ...');

                    % Images
                    im = obj.images;

                    % Image dimensions (X, Y, Z, NR, NFA, NE)
                    nSlices = size(im,3);
                    nDyn = size(im,4);
                    nFA = size(im,5);
                    nTE = size(im,6);

                    % Denoising window
                    w = app.DeNoiseWindowEditField.Value;
                    window = [w w];
                    if window(1) > size(im,1)/2
                        window(1) = round(size(im,1)/2);
                    end
                    if window(2) > size(im,2)/2
                        window(2) = round(size(im,2)/2);
                    end
                 
                    % Loop over all slices, dynamics, flip angles, echo times
                    % Choose 2-dim image + extra dimension
                    if nTE > 1

                        for slice = 1:nSlices
                            for dyn = 1:nDyn
                                for fas = 1:nFA
                                    im(:,:,slice,dyn,fas,:) = denoise(double(squeeze(im(:,:,slice,dyn,fas,:))),window);
                                end
                            end
                        end

                    elseif nFA > 1

                        for slice = 1:nSlices
                            for dyn = 1:nDyn
                                im(:,:,slice,dyn,:,1) = denoise(double(squeeze(im(:,:,slice,dyn,:,1))),window);
                            end
                        end

                    elseif nDyn > 1

                        for slice = 1:nSlices
                            im(:,:,slice,:,1,1) = denoise(double(squeeze(im(:,:,slice,:,1,1))),window);
                        end

                    else

                        % nTE, nFA, nDyn = 1
                        im(:,:,:,1,1,1) = denoise(double(squeeze(im(:,:,:,1,1,1))),window);

                    end

                    % Return the images object
                    obj.images = im;

                end

            catch ME

                app.TextMessage(ME.message);

            end

        end % PCAdenoise





        % ---------------------------------------------------------------------------------
        % Suppress Gibbs ringing
        % ---------------------------------------------------------------------------------
        function obj = unRing(obj,app)

            try

                app.TextMessage('Gibbs ringing suppression ...');

                im = obj.images;

                % params - 3x1 array with [minW maxW nsh]
                % nsh discretization of subpixel spaceing (default 20)
                % minW  left border of window used for TV computation (default 1)
                % maxW  right border of window used for TV computation (default 3)
                params = [1 3 20];

                % image dimensions (X, Y, Z, NR, NFA, NE)
                nDyn = size(im,4);
                nFA = size(im,5);
                nTE = size(im,6);

                % unRing
                for dyn = 1:nDyn
                    for fas = 1:nFA
                        for tes = 1:nTE
                            im(:,:,:,dyn,fas,tes) = ringRm(double(squeeze(im(:,:,:,dyn,fas,tes))),params);
                        end
                    end
                end

                obj.images = im;

            catch ME

                app.TextMessage(ME.message);

            end

        end % unRing
        



        % ---------------------------------------------------------------------------------
        % Image reconstruction: scale images
        % ---------------------------------------------------------------------------------
        function obj = scaleImages(obj)

            % Scale
            obj.images = round(4095*obj.images/max(obj.images(:)));
            obj.images(isnan(obj.images)) = 0;
            obj.images(isinf(obj.images)) = 0;

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

                case {"2D","2Dradial","2Depi"}

                    % Images = (X, Y, slices, NR, NFA, NE)
                    [~, ~, slices, NR, NFA, NE] = size(im);

                    % Shift image to prevent pixel-shift after FFT
                    if obj.PHASE_ORIENTATION == 1
                        im = circshift(im,1,2); 
                    else
                        im = circshift(im,1,1); 
                        im = circshift(im,1,2); 
                    end

                    kSpace = zeros(size(im));
                    for i = 1:slices
                        for j = 1:NR
                            for k = 1:NFA
                                for w = 1:NE
                                    kSpace(:,:,i,j,k,w) = proudData.fft2Dmri(squeeze(im(:,:,i,j,k,w)));
                                end
                            end
                        end
                    end

                    % Samples, views, views2, slices, echoes (frames), experiments, flip-angles
                    kSpace = permute(kSpace,[1,2,7,3,6,4,5]);
                    if obj.PHASE_ORIENTATION == 1
                        kSpace = flip(kSpace,1);
                    end
                   
                    % Return the object
                    obj.mrdKspace = kSpace;

                case {"3D","3Dute"}

                    % Images = (X, Y, Z, NR, NFA, NE)
                    [~, ~, ~, NR, NFA, NE] = size(im);

                    % Shift image to prevent pixel-shift after FFT
                    if obj.PHASE_ORIENTATION == 1
                        im = circshift(im,1,2); 
                        im = circshift(im,1,3); 
                    else
                        im = circshift(im,1,1); 
                        im = circshift(im,1,2); 
                        im = circshift(im,1,3);
                    end

                    kSpace = zeros(size(im));
                    for j = 1:NR
                        for k = 1:NFA
                            for w = 1:NE
                                kSpace(:,:,:,j,k,w) = proudData.fft3Dmri(squeeze(im(:,:,:,j,k,w)));
                            end
                        end
                    end

                    % Samples, views, views2, slices, echoes (frames), experiments, flip-angles
                    kSpace = permute(kSpace,[1,2,3,7,6,4,5]);
                    if obj.PHASE_ORIENTATION == 1
                        kSpace = flip(flip(kSpace,3),1);
                    else
                        kSpace = flip(kSpace,3);
                    end
             
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

        end % unwrap3D



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

        end % calcFlow



        % Export the reconstruction settings
        function obj = ExportRecoParametersFcn(obj, app, exportdir)

            pars = strcat(...
                "------------------------- \n\n", ...
                "P2ROUD ", app.appVersion,"\n\n", ...
                "Gustav Strijkers\n", ...
                "Amsterdam UMC\n", ...
                "g.j.strijkers@amsterdamumc.nl\n\n", ...
                "------------------------- \n", ...
                "\nDATA \n\n", ...
                "datafile = ", app.MRDfileViewField.Value, "\n", ...
                "sequence = ", app.SequenceViewField.Value, "\n\n",...
                "\nDIMENSIONS \n\n", ...
                "dim_x = ", num2str(size(app.proudDataPars.images,1)), "\n", ...
                "dim_y = ", num2str(size(app.proudDataPars.images,2)), "\n", ...
                "dim_z = ", num2str(size(app.proudDataPars.images,3)) , "\n", ...
                "FOV_x = ", num2str(app.FOVViewField1.Value), " mm \n", ...
                "FOV_y = ", num2str(app.FOVViewField2.Value), " mm \n", ...
                "FOV_z = ", num2str(app.FOVViewField3.Value), " mm \n", ...
                "k_x = ", num2str(app.KMatrixViewField1.Value), "\n", ...
                "k_y = ", num2str(app.KMatrixViewField2.Value), "\n", ...
                "k_z = ", num2str(app.KMatrixViewField3.Value), "\n", ...
                "#slabs = ", num2str(size(app.proudDataPars.rawKspace{1},7)), "\n\n", ...
                "\nSCAN PARAMETERS\n\n", ...
                "scan time = ", app.ScanTimeViewField.Value, "\n", ...
                "time per dynamic = ", app.TimeDynViewField.Value, "\n", ...
                "TR = ", num2str(app.TRViewField.Value), " ms \n", ...
                "TE = ", num2str(app.TEViewField.Value), " ms \n", ...
                "#echoes = ", num2str(app.NEViewField.Value), "\n", ...
                "#averages = ", num2str(app.NAViewField.Value), "\n", ...
                "#flip angles = ", num2str(app.NFAViewField.Value), "\n", ...
                "flip angle(s) = ", app.FAViewField.Value, "\n", ...
                "#repetitions = ", num2str(app.NRViewField.Value), "\n", ...
                "trajectory = ", app.TrajectoryViewField.Value, "\n\n", ...
                "\nRECONSTRUCTION PARAMETERS\n\n", ...
                "Wavelet = ",num2str(app.WVxyzEditField.Value), "\n", ...
                "TVxyz = ",num2str(app.TVxyzEditField.Value), "\n", ...
                "LRxyz = ",num2str(app.LRxyzEditField.Value), "\n", ...
                "TVtime = ",num2str(app.TVtimeEditField.Value), "\n", ...
                "CSreco = ",num2str(app.CSRecoCheckBox.Value), "\n\n" ...
                );

            if strcmp(app.proudDataPars.dataType,'2Dradial')
                pars = strcat(pars,...
                    "\n2D radial\n\n", ...
                    "Gx delay = ",num2str(app.GxDelayEditField.Value),"\n",...
                    "Gy delay = ",num2str(app.GyDelayEditField.Value),"\n",...
                    "Gz delay = ",num2str(app.GzDelayEditField.Value),"\n",...
                    "center echo = ",num2str(app.CenterEchoCheckBox.Value),"\n", ...
                    "phase correction = ",num2str(app.PhaseCorrectCheckBox.Value),"\n", ...
                    "density correction = ",num2str(app.DensityCorrectCheckBox.Value),"\n" ...
                    );
            end

            if strcmp(app.proudDataPars.dataType,'3Dute')
                pars = strcat(pars,...
                    "\n2D radial\n\n", ...
                    "Gx delay = ",num2str(app.GxDelayEditField.Value),"\n",...
                    "Gy delay = ",num2str(app.GyDelayEditField.Value),"\n",...
                    "Gz delay = ",num2str(app.GzDelayEditField.Value),"\n",...
                    "data offset = ",num2str(app.DataOffsetRadialEditField.Value),"\n",...
                    "center echo = ",num2str(app.CenterEchoCheckBox.Value),"\n", ...
                    "phase correction = ",num2str(app.PhaseCorrectCheckBox.Value),"\n", ...
                    "density correction = ",num2str(app.DensityCorrectCheckBox.Value),"\n" ...
                    );
            end

            fid = fopen(strcat(exportdir,filesep,'recoparameters_',app.tag,'.txt'),'wt');
            fprintf(fid,pars);
            fclose(fid);

        end



        % ---------------------------------------------------------------------------------
        % Retrieve the 2D image shift for off-center and oblique Radial sequence
        % ---------------------------------------------------------------------------------
        function obj = get2DimageShift(obj, image, app)

            % Image dimensions in pixels
            dimx = size(image,1);
            dimy = size(image,2);
     
            % Calculate the shift
            for i = 1:length(obj.fov_read_off)
                relShiftX = dimx*obj.fov_read_off(i)/4000;
                relShiftY = dimy*obj.fov_phase_off(i)/4000;
            end
       
            % Different readout / phase depending on phase_orientation value
            if obj.PHASE_ORIENTATION

                shiftInX =  relShiftX; 
                shiftInY =  -relShiftY; 

            else

                shiftInX =   -relShiftX; 
                shiftInY =   -relShiftY; 

            end

            % Report the values back / return the object
            obj.xShift = shiftInX;
            obj.yShift = shiftInY;

            app.TextMessage(sprintf('Image shift ΔX = %.2f, ΔY = %.2f pixels ...',shiftInX(1),shiftInY(1)));

        end % get2DimageShift



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

            x = ((x-m).^2) ./ (s.^2);
            s = sqrt(2*pi) * s;
            y = exp(-x) ./ s;

        end % gauss




        % ---------------------------------------------------------------------------------
        % Read MRD file
        % ---------------------------------------------------------------------------------
        function [im,dim,par,unsortedKspace] = importMRD(filename, reordering1, reordering2)

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
            dataType = fread(fid,1, 'uint16');
            dataType = dec2hex(dataType);
            fseek(fid,48,'bof');
            scaling = fread(fid,1, 'float32');
            bitsPerPixel = fread(fid,1, 'uchar');
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

            if size(dataType,2)>1
                onlyDataType = dataType(2);
                isComplex = 2;
            else
                onlyDataType = dataType(1);
                isComplex = 1;
            end
            switch onlyDataType
                case '0'
                    dataFormat = 'uchar';   
                case '1'
                    dataFormat = 'schar';   
                case '2'
                    dataFormat = 'short';   
                case '3'
                    dataFormat = 'int16';   
                case '4'
                    dataFormat = 'int32';   
                case '5'
                    dataFormat = 'float32'; 
                case '6'
                    dataFormat = 'double';  
                otherwise
                    dataFormat = 'int32';   
            end

            % Try to read the expected amount of data at once
            num2Read = no_expts*no_echoes*no_slices*no_views_2*no_views*no_samples*isComplex;
            [m_total, count] = fread(fid,num2Read,dataFormat);

            % Check if expected size of data was read
            % If not, this means that the acquisition was prematurely stopped
            % and only part of the data is available
            if count < num2Read
    
                % Find the end of the data by looking for :PPL string
                textData = fileread(filename);
                targetText = ":PPL";
                amountOfData = strfind(textData,targetText);

                % Number of floats to read
                newNum2Read = (amountOfData-4)/4 - 512;    

                % Reset the file position indicator to beginning of the data
                fseek(fid,512,'bof');

                % Read the data again
                [m_total, count] = fread(fid,newNum2Read ,dataFormat);
        
            end

            if isComplex == 2
                a=1:floor(count/2);
                m_real = m_total(2*a-1);
                m_imag = m_total(2*a);
                clear m_total;
                m_C_tmp = m_real+m_imag*1i;
                clear m_real m_imag;
            else
                m_C_tmp = m_total;
                clear m_total;
            end

            % Pre-allocate the expected size of m_C, in case of missing data
            m_C = zeros(num2Read/isComplex,1);
            m_C(1:length(m_C_tmp)) = m_C_tmp;

            % The unsorted k-space
            unsortedKspace = m_C;

            % Shaping the data manually:
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
           
            n=0;
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
            fseek(fid,-120,'cof');
            ppr_text = char(fread(fid,Inf,'uchar')');
            fclose(fid);

            % Locate the first entry = :PPL
            pos1 = strfind(ppr_text,':PPL');
            ppr_text = ppr_text(pos1(1):end);

            % Parse fields in ppr section of the MRD file
            if numel(ppr_text)>0
                cell_text = textscan(ppr_text,'%s','delimiter',char(13));
                PPR_keywords = {'BUFFER_SIZE','DATA_TYPE','DECOUPLE_FREQUENCY','DISCARD','DSP_ROUTINE','EDITTEXT','EXPERIMENT_ARRAY','FOV','FOV_READ_OFF','FOV_PHASE_OFF','FOV_SLICE_OFF','GRADIENT_STRENGTH','MULTI_ORIENTATION','Multiple Receivers','NO_AVERAGES','NO_ECHOES','NO_RECEIVERS','NO_SAMPLES','NO_SLICES','NO_VIEWS','NO_VIEWS_2','OBLIQUE_ORIENTATION','OBSERVE_FREQUENCY','ORIENTATION','PHASE_CYCLE','READ/PHASE/SLICE_SELECTION','RECEIVER_FILTER','SAMPLE_PERIOD','SAMPLE_PERIOD_2','SCROLLBAR','SLICE_BLOCK','SLICE_FOV','SLICE_INTERLEAVE','SLICE_THICKNESS','SLICE_SEPARATION','SPECTRAL_WIDTH','SWEEP_WIDTH','SWEEP_WIDTH_2','VAR_ARRAY','VIEW_BLOCK','VIEWS_PER_SEGMENT','SMX','SMY','SWX','SWY','SMZ','SWZ','VAR','PHASE_ORIENTATION','X_ANGLE','Y_ANGLE','Z_ANGLE','PPL','IM_ORIENTATION','IM_OFFSETS','lines_per_segment'};
                % PPR_type_0 keywords have text fields only, e.g. ":PPL C:\ppl\smisim\1ge_tagging2_1.PPL"
                PPR_type_0 = [23 53];
                % PPR_type_1 keywords have single value, e.g. ":FOV 300"
                PPR_type_1 = [8 42:47];
                % PPR_type_2 keywords have single variable and single value, e.g. ":NO_SAMPLES no_samples, 16"
                PPR_type_2 = [4 7  15:21 25 31 33 41 49 50];
                PPR_type_3 = 48; % VAR keyword only (syntax same as above)
                PPR_type_4 = [28 29]; % :SAMPLE_PERIOD sample_period, 300, 19, "33.3 KHz  30 ?s" and SAMPLE_PERIOD_2 - read the first number=timeincrement in 100ns
                % PPR_type_5 keywords have single variable and two values, e.g. ":SLICE_THICKNESS gs_var, -799, 100"
                PPR_type_5 = [34 35];
                % KEYWORD [pre-prompt,] [post-prompt,] [min,] [max,] default, variable [,scale] [,further parameters ...];
                PPR_type_6 = [39 9:11 50:52]; % VAR_ARRAY and angles keywords
                PPR_type_7 = [54 55]; % IM_ORIENTATION and IM_OFFSETS (SUR only)

                par = struct('filename',filename);
                for j=1:size(cell_text{1},1)
                    char1 = char(cell_text{1}(j,:));
                    field_ = '';
                    if ~isempty(char1)
                        C = textscan(char1, '%*c%s %s', 1);
                        field_ = char(C{1});
                    end
                    % Find matching number in PPR_keyword array:
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
                            text_field = char(C{1}); 
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
                par.datatype = dataType;
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
                                    paramname(findstr(paramname,'_')+2:length(paramname)) '= paramvalue;']); %#ok<*DATST,*FSTR>
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
            xNewFFT = 1j*proudData.ifft3Dmri(xNew);

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

            tmp =(1j*proudData.ifft2Dmri(Xnew).*repmat([0:(calibSize(1)/2-1), 0, -calibSize(1)/2+1:-1]'/calibSize(1),[1 calibSize(2) nCoils]));
            tmpCalib = bart(app,'bart nufft',kTraj,reshape(tmp,[calibSize 1 nCoils]));
            dydkx = reshape(tmpCalib,[size(kx) nCoils]);

            tmp = (1j*proudData.ifft2Dmri(Xnew).*repmat([0:(calibSize(1)/2-1), 0, -calibSize(1)/2+1:-1]/calibSize(1),[calibSize(1) 1 nCoils]));
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
        function Xnew = lowRankThresh3D(Xold, kSize, thresh)

            % Apply low rank thresholding to 3D data

            % Round the threshold to the nearest integer value
            thresh = round(thresh);

            % Define indices of the singular values to keep
            keep = 1:thresh;

            % Get the size of the input data
            [sx, sy, sz, ~] = size(Xold);

            % Convert the input data into a 2D matrix
            tmp = proudData.im2row3D(Xold, kSize);
            [tsx, tsy, Nc] = size(tmp);
            A = reshape(proudData.im2row3D(Xold, kSize), tsx, tsy*Nc);

            % Perform singular value decomposition and keep only the top k singular values
            [U, S, V] = svd(A, 'econ');
            A = U(:, keep)*S(keep, keep)*V(:, keep)';

            % Reshape the data and convert it back to 3D
            A = reshape(A, tsx, tsy*Nc);
            Xnew = proudData.row2im3D(A, [sx, sy, sz, Nc], kSize);

        end % lowRankThresh3D




        % ---------------------------------------------------------------------------------
        % Low rank threshold 2D
        % ---------------------------------------------------------------------------------
        function Xnew = lowRankThresh2D(Xold,kSize,thresh)

            % Apply low rank thresholding to 2D data

            % Round threshold to nearest integer
            thresh = round(thresh);

            % Define indices of the singular values to keep
            keep = 1:thresh;

            % Get size of input matrix
            [sx,sy,Nc] = size(Xold);

            % Convert the 3D matrix to a 2D matrix, where each row corresponds to a window
            tmp = proudData.im2row2D(Xold,kSize);

            % Get size of temporary matrix
            [tsx,tsy,tsz] = size(tmp);

            % Apply SVD to temporary matrix
            A = reshape(proudData.im2row2D(Xold,kSize),tsx,tsy*tsz);
            [U,S,V] = svd(A,'econ');

            % Perform low-rank approximation by keeping only the first 'thresh' singular values
            A = U(:,keep)*S(keep,keep)*V(:,keep)';

            % Reshape the data and convert it back to 2D
            A = reshape(A,tsx,tsy,tsz);
            Xnew = proudData.row2im2D(A,[sx,sy,Nc],kSize);

        end % lowRankThresh2D




        % ---------------------------------------------------------------------------------
        % Trajectory interpolation 
        % ---------------------------------------------------------------------------------
        function kSpaceNew = trajInterpolation(kSpaceOld,dShift)

            kSpaceNew = zeros(size(kSpaceOld));

            % Loop over many dimensions
            for idx7 = 1:size(kSpaceOld,7) 

                for idx6 = 1:size(kSpaceOld,6) 

                    for idx5 = 1:size(kSpaceOld,5)

                        for idx4 = 1:size(kSpaceOld,4) 

                            for idx3 = 1:size(kSpaceOld,3) 

                                kx = interp1((1:size(kSpaceOld,2))+dShift(1),kSpaceOld(1,:,idx3,idx4,idx5,idx6,idx7),1:size(kSpaceOld,2),'linear'); % Kx
                                ky = interp1((1:size(kSpaceOld,2))+dShift(2),kSpaceOld(2,:,idx3,idx4,idx5,idx6,idx7),1:size(kSpaceOld,2),'linear'); % Ky
                                kz = interp1((1:size(kSpaceOld,2))+dShift(3),kSpaceOld(3,:,idx3,idx4,idx5,idx6,idx7),1:size(kSpaceOld,2),'linear'); % Kz

                                if dShift(1) > 0
                                    kx(isnan(kx)) = 0;
                                else
                                    kx(isnan(kx)) = kSpaceOld(1,isnan(kx),idx3,idx4,idx5,idx6,idx7);
                                end

                                if dShift(2) > 0
                                    ky(isnan(ky)) = 0;
                                else
                                    ky(isnan(ky)) = kSpaceOld(2,isnan(ky),idx3,idx4,idx5,idx6,idx7);
                                end

                                if dShift(3) > 0
                                    kz(isnan(kz)) = 0;
                                else
                                    kz(isnan(kz)) = kSpaceOld(3,isnan(kz),idx3,idx4,idx5,idx6,idx7);
                                end

                                kSpaceNew(1,:,idx3,idx4,idx5,idx6,idx7) = kx(:);
                                kSpaceNew(2,:,idx3,idx4,idx5,idx6,idx7) = ky(:);
                                kSpaceNew(3,:,idx3,idx4,idx5,idx6,idx7) = kz(:);

                            end

                        end

                    end

                end

            end

        end % kSpaceInterpolation




        % ---------------------------------------------------------------------------------
        % image to rows 3D
        % ---------------------------------------------------------------------------------
        function res = im2row3D(im, winSize)

            % This function converts an input 3D image into a 2D matrix
            % with each column being a vectorized patch of the image
            % using a sliding window approach.

            % Get the size of the input image
            [sx,sy,sz,nc] = size(im);

            % Allocate memory for the output matrix
            res = zeros((sx-winSize(1)+1)*(sy-winSize(2)+1)*(sz-winSize(3)+1),prod(winSize),nc);

            % Initialize counter
            count=0;

            % Slide a window over the image
            for z=1:winSize(3)
                for y=1:winSize(2)
                    for x=1:winSize(1)
                        % Increment counter
                        count = count+1;
                        % Extract and reshape each patch of the image and store it in a column of the output matrix
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

            % This function converts a 2D image to a matrix of overlapping patches of
            % size winSize
            %
            % Input:
            %   - im: the input image
            %   - winSize: the size of the sliding window
            %
            % Output:
            %   - res: a matrix containing overlapping patches from the input image

            % Get the dimensions of the input image
            [sx,sy,sz] = size(im);

            % Compute the size of the output matrix
            res = zeros((sx-winSize(1)+1)*(sy-winSize(2)+1),prod(winSize),sz);

            % Counter variable to keep track of the column in the output matrix
            count=0;

            % Loop over the rows and columns of the sliding window
            for y=1:winSize(2)
                for x=1:winSize(1)
                    count = count+1;
                    % Extract the patches from the input image and reshape them
                    % into columns of the output matrix
                    res(:,count,:) = reshape(im(x:sx-winSize(1)+x,y:sy-winSize(2)+y,:),...
                        (sx-winSize(1)+1)*(sy-winSize(2)+1),1,sz);
                end
            end

        end % im2row2D



        % ---------------------------------------------------------------------------------
        % rows to image 3D
        % ---------------------------------------------------------------------------------
        function [res,W] = row2im3D(mtx, imSize, winSize)
            
            % This function reconstructs an image from a matrix of overlapping patches.
            % It operates in 3D, allowing for multi-coil MRI data.
            %
            % INPUTS:
            %   mtx - matrix of overlapping patches (output of im2row3D)
            %   imSize - size of the output image [x, y, z]
            %   winSize - size of the window used to extract patches [x, y, z]
            %
            % OUTPUTS:
            %   res - reconstructed image
            %   W - weight matrix used for normalization

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
            
            % This function reshapes a 3D matrix of row vectors into a 2D image of size imSize,
            % using a sliding window of size winSize to combine the rows.
            %
            % Inputs:
            % - mtx: a 3D matrix of size (winSize(1)*winSize(2), sz, channels)
            % - imSize: a vector [sx, sy] representing the size of the output image
            % - winSize: a vector [wx, wy] representing the size of the sliding window
            %
            % Outputs:
            % - res: a 3D matrix representing the reshaped image of size (sx, sy, channels)
            % - W: a 3D matrix representing the weight matrix of size (sx, sy, channels)

            sx = imSize(1);
            sy = imSize(2);
            sz = size(mtx,3);

            % Initialize res and W as 3D matrices of zeros
            res = zeros(imSize(1),imSize(2),sz);
            W = res;

            count=0;
            for y=1:winSize(2)
                for x=1:winSize(1)
                    count = count+1;
                    % Update res with the current window and mtx count
                    res(x:sx-winSize(1)+x,y:sy-winSize(2)+y,:) = res(x:sx-winSize(1)+x,y:sy-winSize(2)+y,:) + reshape(mtx(:,count,:),(sx-winSize(1)+1),(sy-winSize(2)+1),sz);
                    % Update W with the weight of the current window
                    W(x:sx-winSize(1)+x,y:sy-winSize(2)+y,:) = W(x:sx-winSize(1)+x,y:sy-winSize(2)+y,:)+1;
                end
            end

            % Divide res by W to get the final image
            res = res./W;

        end % row2im



        % ---------------------------------------------------------------------------------
        % Vectorize
        % ---------------------------------------------------------------------------------
        function v = vec(x)

            % VEC   Vectorize.
            % VEC(X), where X is a vector, matrix, or N-D array, returns a column vector
            % Containing all of the elements of X; i.e., VEC(X) = X(:).

            v = reshape(x, numel(x), 1);

        end % vec



        % ---------------------------------------------------------------------------------
        % FFT 3D
        % ---------------------------------------------------------------------------------
        function X = fft3Dmri(x)

            X = fftshift(ifft(fftshift(x,1),[],1),1)*sqrt(size(x,1));
            X = fftshift(ifft(fftshift(X,2),[],2),2)*sqrt(size(x,2));
            X = fftshift(ifft(fftshift(X,3),[],3),3)*sqrt(size(x,3));

        end % FFT 3D



        % ---------------------------------------------------------------------------------
        % iFFT 3D
        % ---------------------------------------------------------------------------------
        function x = ifft3Dmri(X)

            x = fftshift(fft(fftshift(X,1),[],1),1)/sqrt(size(X,1));
            x = fftshift(fft(fftshift(x,2),[],2),2)/sqrt(size(X,2));
            x = fftshift(fft(fftshift(x,3),[],3),3)/sqrt(size(X,3));

        end


       
        % ---------------------------------------------------------------------------------
        % FFT 2D
        % ---------------------------------------------------------------------------------
        function X = fft2Dmri(x)

            X = fftshift(ifft(fftshift(x,1),[],1),1)*sqrt(size(x,1));
            X = fftshift(ifft(fftshift(X,2),[],2),2)*sqrt(size(x,2));
        
        end % FFT 2D



        % ---------------------------------------------------------------------------------
        % iFFT 2D
        % ---------------------------------------------------------------------------------
        function x = ifft2Dmri(X)

            x = fftshift(fft(fftshift(X,1),[],1),1)/sqrt(size(X,1));
            x = fftshift(fft(fftshift(x,2),[],2),2)/sqrt(size(X,2));
   
        end



        % ---------------------------------------------------------------------------------
        % 2D radial 0 - 180 trajectory
        % ---------------------------------------------------------------------------------
        function traj = twoDradialTrajectory(dimx, dimy, dimz, dimd, dims)

            % Make the radial trajectory 0-180 degrees
            % Could be extended with different trajectories if available

            fullAngle = 180;
            for c = 1:dims
                for d = 1:dimd
                    for z = 1:dimz
                        for j = 1:dimy
                            % crds, x, y(spoke), slice, repetitions, coils
                            traj(1,:,j,z,d,c) = (-floor(dimx/2)+0.5:floor(dimx/2)-0.5)*cos((pi/180)*(j-1)*fullAngle/dimy);
                            traj(2,:,j,z,d,c) = (-floor(dimx/2)+0.5:floor(dimx/2)-0.5)*sin((pi/180)*(j-1)*fullAngle/dimy);
                            traj(3,:,j,z,d,c) = 0;
                        end
                    end
                end
            end

        end % twoDradialTrajectory



        % ---------------------------------------------------------------------------------
        % Fractional 2D image shift
        % ---------------------------------------------------------------------------------
        function imOut = image2Dshift(imIn, xShift, yShift)
            
            % Shift image on sub-pixel level in x- and y-directions

            % Transform image to k-space
            H = proudData.ifft2Dmri(imIn);

            % Create linear grid
            [xF,yF] = meshgrid(-size(imIn,2)/2:size(imIn,2)/2-1,-size(imIn,1)/2:size(imIn,1)/2-1);

            % Perform the shift in k-space
            H = H.*exp(-1i*2*pi.*(xF*xShift/size(imIn,2)+yF*yShift/size(imIn,1)));
            
            % Transform image back from k-space
            % Note: this is a complex image now
            imOut = proudData.fft2Dmri(H);

        end % image2Dshift




    end % Static methods




end % proudData Class

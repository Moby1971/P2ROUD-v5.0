classdef proudData

    % Data and parameter class for P2ROUD app
    %
    % Gustav Strijkers
    % g.j.strijkers@amsterdamumc.nl
    % Nov 2023
    %

    properties

        % Data
        rawKspace = {}                                      % raw k-space data
        unsKspace = {}                                      % unsorted k-space data
        mrdKspace = []                                      % k-space data from MRD file
        images = []                                         % magnitude images
        complexImages = []                                  % complex images
        sensitivityMaps = {}                                % sensitivity maps
        phaseImages = []                                    % phase images
        phaseImagesOrig = []                                % original phase images (without unwrapping)
        flowImages = []                                     % flow images
        mask = []                                           % image mask
        epiMask = []                                        % mask for epi images
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
        maxKspace = 16384                                   % max k-space value
        maxImage = 16384                                    % max image value
        maxCoils = 8                                        % max number of coils
        tukeyFilterWidth = 0.1                              % k-space Tukey filter width
        coilSensitivityCalibSize = 8                        % coil sensitivity k-space calibration size

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
        NO_SLICES_DCM = 1;                                  % number of slices for dicom export
        NO_ECHOES = 1                                       % number of echoes
        nav_on = 0                                          % navigator on (1) / off (0)
        no_navs = 1                                         % number of navigators
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
        alpha = 20                                          % flip-angle
        te = 2                                              % integer echo-time (ms)
        te_us = 0                                           % additional echo-time (us)
        TE                                                  % echo-time TE = te + te_us
        tr = 10                                             % integer TR time (ms)
        tr_extra_us = 0                                     % additional TR time (us)
        TR                                                  % repitition time TR = tr + tr_extra_us
        ti = 1000                                           % inversion time
        VFA_angles = []                                     % MRD file flip-angles
        VFA_size = 0                                        % flip-angle array size (0 = no array = 1 flip-angle)
        flipAngleArray = []                                 % array of flip-angles
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
        multiFlipAngles_flag = false                        % multiple flip-angles true/false
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
        zShift = 0                                          % image shift in Z direction
        fov_read_off = 0                                    % read-offset from MRD file
        fov_phase_off = 0                                   % phase-offset from MRD file
        fov_slice_off = 0                                   % slice-offset from MRD file
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
    % obj = estimateCoilSensitivies(obj, app)
    % obj = csReco2DCine(obj,app,flipAngle)
    % obj = csReco2D(obj,app,flipAngle,echoTime)
    % obj = fftReco2D(obj,app,flipAngle,echoTime)
    % obj = csReco3D(obj,app,flipAngle,echoTime)
    % obj = fftReco3D(obj,app,flipAngle,echoTime)
    % obj = Reco2DRadialCS(obj,app,flipAngle,echoTime)
    % obj = Reco2DRadialNUFFT(obj,app,flipAngle,echoTime)
    % obj = unRing(obj,app)
    % obj = scaleImages(obj)
    % obj = scaleKspace(obj)
    % obj = calcPixelSize(obj,app)
    % obj = backToKspace(obj)
    % obj = recoSurFiles(obj, surpath, suffix, mrdfilename, rprfilename)
    % obj = unwrap3D(obj)
    % obj = calcFlow(obj)
    % obj = ExportRecoParametersFcn(obj, app, exportdir)
    % obj = get3DimageShift(obj, image, app)
    % obj = shiftImages2D(obj, app)
    % obj = shiftImages3D(obj, app)
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
    % outputMatrix = matrixInterpolate(inputMatrix, scaling, varargin)
    %
    %
    %
    %
    % ----------------------------------------------------------------------
    % Methods, GUI elements & variables from the P2ROUD app
    % that are used in the class
    % ----------------------------------------------------------------------
    %
    % app.TextMessage
    % app.SetStatus
    %
    % app.OrientationSpinner.Value
    % app.SlabOverlapEditField.Value
    % app.NREditField.Value
    % app.NFAViewField.Value
    % app.NAViewField.Value
    % app.NEViewField.Value
    % app.FAViewField.Value
    % app.XEditField.Value
    % app.YEditField.Value
    % app.ZEditField.Value
    % app.KMatrixViewField1.Value
    % app.KMatrixViewField2.Value
    % app.KMatrixViewField3.Value
    % app.WVxyzEditField.Value
    % app.TVxyzEditField.Value
    % app.LRxyzEditField.Value
    % app.TVtimeEditField.Value
    % app.CSRecoCheckBox.Value
    % app.AutoSensitivityCheckBox.Value
    % app.RecoProgressGauge.Value
    % app.CenterEchoCheckBox.Value
    % app.PhaseCorrectCheckBox.Value
    % app.GxDelayEditField.Value
    % app.GyDelayEditField.Value
    % app.GzDelayEditField.Value
    % app.DataOffsetRadialEditField.Value
    % app.GradDelayCalibrationCheckBox.Value
    % app.RingMethodCheckBox.Value
    % app.DeNoiseCheckBox.Value
    % app.DeNoiseWindowEditField.Value
    % app.FOVViewField1.Value
    % app.FOVViewField2.Value
    % app.FOVViewField3.Value
    % app.MRDfileViewField.Value
    % app.SequenceViewField.Value
    % app.ScanTimeViewField.Value
    % app.TimeDynViewField.Value
    % app.TRViewField.Value
    % app.TEViewField.Value
    % app.TrajectoryViewField.Value
    %
    % app.appVersion
    % app.tag
    % app.imageOrient
    % app.bartDetected_flag
    % app.stopGradCal_flag
    % app.RecoFig
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

            obj.rawKspace = {};         % raw k-space data already (pre-)sorted by importMRD function
            obj.unsKspace = {};         % unsorted k-space data
            obj.sensitivityMaps = {};   % sensitivity maps

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

            if isfield(parameters,'no_navs')
                obj.no_navs = parameters.no_navs;
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

            if isfield(parameters,'fov_slice_off')
                obj.fov_slice_off = parameters.fov_slice_off;
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
            dimX = val(1);
            dimY = val(2);
            dimZ = val(3);
            dim4 = val(4);
            fseek(fid,18,'bof');
            datatype=fread(fid,1, 'uint16');
            datatype = dec2hex(datatype);
            fseek(fid,152,'bof');
            val = fread(fid,2, 'int32');
            dim5 = val(1);
            dim6 = val(2);
            no_samples = dimX;
            no_views = dimY;
            no_views_2 = dimZ;
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

            inputFooter = obj.mrdFooter;

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
                pos = strfind(inputFooter,txt);

                if ~isempty(pos)

                    try

                        % Determine which part should be replaced
                        oldTxtLength = strfind(inputFooter(pos+length(txt):pos+length(txt)+12),newline)-1;

                        if contains(txt,'SLICE_THICKNESS')
                            % Slice thickness is a special case
                            commaPos = [];
                            commaPos = strfind(inputFooter(pos+length(txt):pos+length(txt)+12),',');
                            newText = strcat(num2str(var));
                            inputFooter = replaceBetween(inputFooter,pos+length(txt)+commaPos(1),pos+length(txt)+oldTxtLength-1,newText);
                        else
                            % Replace the values with the new ones
                            newText = strcat(num2str(var));
                            inputFooter = replaceBetween(inputFooter,pos+length(txt),pos+length(txt)+oldTxtLength-1,newText);
                        end

                    catch
                    end

                end

            end

            % Return the new MRD footer object
            obj.newMrdFooter  = inputFooter;


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

        end % imageOrientLabels




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

            inputRpr = obj.rprFile;

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
                ':COMBOBOX RECON_METHOD ', ...
                ':EDITTEXT CHANNEL_COUNT ', ...
                ':EDITTEXT CHANNEL_WEIGHTS ' ...
                };

            % New parameter values
            replacePars = {par.NoEchoes,par.NoEchoes, ...
                par.NoExperiments, par.NoExperiments, ...
                par.NoSamples, par.NoSamples, par.NoSamples, ...
                par.NoViews, par.NoViews, par.NoViews, ...
                par.NoViews2, par.NoViews2, par.NoViews2, ...
                par.NoSlices, par.NoSlices, ...
                par.NoSamples, par.NoViews, par.NoViews2, ...
                par.View1order, par.View2order, ...
                par.viewspersegment, ...
                par.reconmethod, ...
                par.channelCount, ...
                par.channelWeights ...
                };

            % Loop over all parameters
            for i = 1:length(parameters)

                txt = parameters{i};
                var = replacePars{i};

                % Find the position of the parameter name
                pos = strfind(inputRpr,txt);

                if ~isempty(pos)

                    if ~isstring(var)

                        % Numeric values
                        oldTxtLength = strfind(inputRpr(pos+length(txt):pos+length(txt)+20),char(13))-1;
                        if isempty(oldTxtLength)
                            oldTxtLength = strfind(inputRpr(pos+length(txt):pos+length(txt)+20),newline)-1;
                        end
                        newText = [num2str(var),'     '];
                        newText = newText(1:6);
                        inputRpr = replaceBetween(inputRpr,pos+length(txt),pos+length(txt)+oldTxtLength-1,newText);

                    else

                        % String-based values
                        oldTxtLength = strfind(inputRpr(pos+length(txt):pos+length(txt)+15),char(13))-1;
                        if isempty(oldTxtLength)
                            oldTxtLength = strfind(inputRpr(pos+length(txt):pos+length(txt)+20),newline)-1;
                        end
                        newText = strcat(" ",var,"           ");
                        newText = extractBefore(newText,12);
                        inputRpr = replaceBetween(inputRpr,pos+length(txt),pos+length(txt)+oldTxtLength-1,newText);

                    end

                end

            end

            % Return the new RPR file object
            obj.newRprFile = inputRpr;

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

            % More than 1 flip-angle
            flipAngles = obj.alpha;
            if obj.VFA_size > 0
                obj.multiFlipAngles_flag = true;
                obj.setVariableFlipAngles;
                flipAngles = obj.VFA_angles(1:obj.VFA_size);
                app.TextMessage('Multi-flip-angle data detected ...');
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
                    % Multiple repetitions = multiple flip-angles
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
        % Set the variable flip angles, sort the angles in groups
        % ---------------------------------------------------------------------------------
        function obj = setVariableFlipAngles(obj)

            % The different flip angles in a variable flip-angle experiment can be ordered in different ways
            % Here they are sorted, such that they can be combined
            a = obj.VFA_size;
            b = unique(obj.VFA_angles(1:obj.VFA_size),'Stable');
            c = length(b);
            d = obj.VFA_angles(1:obj.VFA_size);
            if a == c
                nrFlipAngles = a;     % FA1, FA2, FA3, FA4, .... = dyn1, dyn2, dyn3, dyn4, ...
                lsFlipAngles = b;
            elseif mod(a,c) == 0
                nrFlipAngles = c;     % FA1, FA1, ..., FA2, FA2, ..., FA3, FA3, ... = dyn1, dyn2, dyn3, dyn4, ...
                lsFlipAngles = b;
            else
                nrFlipAngles = a;     % Each dynamic has its own flip-angle
                lsFlipAngles = d;
            end
            obj.VFA_size = nrFlipAngles;
            obj.VFA_angles = lsFlipAngles;

        end % setVariableFlipAngles




        % ---------------------------------------------------------------------------------
        % Permute 3D k-space data
        % ---------------------------------------------------------------------------------
        function obj = permute3Dkspace(obj)

            % The P2ROUD app sorts the 3D data and images into the following order:
            %
            % data = X, Y, Z, dynamics, flip-angles, echo-times, slabs
            %
            % -----------------------------------------------------------------------------
            
            dimC = obj.nrCoils;

            switch obj.dataType

                case "3D"

                    for coil = 1:dimC 

                        switch ndims(obj.rawKspace{coil})

                            case 3
                                obj.rawKspace{coil} = permute(obj.rawKspace{coil},[3,1,2]);

                            case 4
                                obj.rawKspace{coil} = permute(obj.rawKspace{coil},[4,2,3,1]);

                            case 5
                                obj.rawKspace{coil} = permute(obj.rawKspace{coil},[5,3,4,1,2]);

                            case 6
                                obj.rawKspace{coil} = permute(obj.rawKspace{coil},[6,4,5,1,2,3]);

                        end

                    end

                    % Permute data to (X, Y, Z, NR, NFA, NE, SLAB)    ---- NOT FULLY TESTED -----
                    for coil = 1:dimC 

                        if ndims(obj.rawKspace{coil})==4 && obj.multiFlipAngles_flag
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1,2,3,5,4,6,7]);
                        end
                        if ndims(obj.rawKspace{coil})==4 && obj.multiEchoes_flag
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1,2,3,5,6,4,7]);
                        end
                        if ndims(obj.rawKspace{coil})==4 && obj.multiSlab_flag
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1,2,3,5,6,7,4]);
                        end
                        if ndims(obj.rawKspace{coil})==5 && obj.multiEchoes_flag && obj.multiFlipAngles_flag
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1,2,3,6,4,5,7]);
                        end
                        if ndims(obj.rawKspace{coil})==5 && obj.multiEchoes_flag && obj.multiRepetitions_flag
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1,2,3,4,6,5,7]);
                        end
                        if ndims(obj.rawKspace{coil})==5 && obj.multiRepetitions_flag && obj.multiFlipAngles_flag
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1,2,3,4,5,6,7]);
                        end

                    end

                    % Flip odd echoes for multi-echo T2*
                    if contains(obj.PPL,'flash') && ~(obj.retroRecoScan_flag == true || obj.proudRecoScan_flag == true)
                        if obj.NO_ECHOES > 1
                            for echo = 2:2:obj.NO_ECHOES
                                for coil = 1:dimC 
                                    obj.rawKspace{coil}(:,:,:,:,:,echo,:) = flip(obj.rawKspace{coil}(:,:,:,:,:,echo,:),1);
                                end
                            end
                        end
                    end


                case "3Dute"

                    for coil = 1:dimC 
                        obj.rawKspace{coil} = permute(obj.rawKspace{coil},[2,1]);
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

            dimC = obj.nrCoils;

            for coil = 1:dimC

                switch ndims(obj.rawKspace{coil})

                    case 2
                        obj.rawKspace{coil} = permute(obj.rawKspace{coil},[2,1]);

                    case 3
                        if obj.NO_SLICES > 1
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[3,2,1]);
                        else
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[3,2,4,1]);
                        end

                    case 4
                        if obj.NO_SLICES > 1
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[4,3,2,1]);
                        else
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[4,3,5,1,2]);
                        end

                    case 5
                        if obj.NO_SLICES > 1
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[5,4,3,1,2]);
                        else
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[5,4,6,1,2,3]);
                        end

                    case 6
                        if obj.NO_SLICES > 1
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[6,5,4,1,2,3]);
                        else
                            obj.rawKspace{coil} = permute(obj.rawKspace{coil},[6,5,7,1,2,3,4]);
                        end

                end

            end

            % Permute data to (X, Y, Z, NR, NFA, NE)    ---- NOT FULLY TESTED -----
            if obj.VFA_size > 1
                obj.nr_repetitions = obj.nr_repetitions/obj.VFA_size;
            end
            for coil = 1:dimC

                if ndims(obj.rawKspace{coil})==4 && obj.multiFlipAngles_flag
                    obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1,2,3,5,4,6]);
                end
                if ndims(obj.rawKspace{coil})==4 && obj.multiEchoes_flag
                    obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1,2,3,5,6,4]);
                end
                if ndims(obj.rawKspace{coil})==5 && obj.multiEchoes_flag && obj.multiFlipAngles_flag
                    obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1,2,3,6,4,5]);
                end
                if ndims(obj.rawKspace{coil})==5 && obj.multiEchoes_flag && obj.multiRepetitions_flag
                    obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1,2,3,4,6,5]);
                end
                if ndims(obj.rawKspace{coil})==5 && obj.multiRepetitions_flag && obj.multiFlipAngles_flag
                    [dimx,dimy,dimz,~,~,dime] = size(obj.rawKspace{coil});
                    obj.rawKspace{coil} = reshape(obj.rawKspace{coil},[dimx,dimy,dimz,obj.nr_repetitions,obj.VFA_size,dime]);
                end

            end

            % Flip odd echoes for multi-echo T2*
            if contains(obj.PPL,'flash') && ~(obj.retroRecoScan_flag == true || obj.proudRecoScan_flag == true || obj.frame_loop_on == true)
                if obj.NO_ECHOES > 1
                    for echo = 2:2:obj.NO_ECHOES
                        for coil = 1:dimC
                            obj.rawKspace{coil}(:,:,:,:,:,echo) = flip(obj.rawKspace{coil}(:,:,:,:,:,echo),1);
                        end
                    end
                end
            end

            % EPI // Under construction //
            if obj.dataType == "2Depi"
                for coil = 1:dimC
                    obj.rawKspace{coil} = reshape(obj.rawKspace{coil},[obj.NO_SAMPLES,obj.NO_VIEWS,obj.NO_SLICES,obj.nr_repetitions]);
                end
            end
      
        end % permute2DKspace




        % ---------------------------------------------------------------------------------
        % Sort 2D k-space data based on scanner k-space rtable.rtv
        % ---------------------------------------------------------------------------------
        function obj = sortScanner2DKspaceMRD(obj, app, kTable)

            app.TextMessage('Sorting k-space ...');

            dimC = obj.nrCoils;

            for coil = 1:dimC 

                app.TextMessage(strcat('Sorting coil',{' '},num2str(coil),' ...'));

                % Coil data
                kSpaceRaw = obj.rawKspace{coil};

                % Navigator yes or no, for RARE echo train correction
                firsty = 0;
                if obj.nav_on == 1
                    firsty = obj.VIEWS_PER_SEGMENT;
                end

                % Dimensions
                [dimX, dimY, dimZ, dimD, dimF, dimE] = size(kSpaceRaw);
                kSpace = zeros(size(kSpaceRaw));
                trajectory2D = ones(dimX*dimY*dimZ*dimD*dimF*dimE,7);

                % Counter
                tcnt = 1;

                % Loop over all dimensions
                for echo = 1:dimE

                    for fa = 1:dimF

                        for dynamic = 1:dimD

                            app.TextMessage(strcat('Sorting dynamic',{' '},num2str(dimD),' ...'));

                            for slice = 1:dimZ

                                % Determine shift of echoes based on navigator echoes
                                if firsty>0

                                    % Calculate phase difference between even and odd echoes
                                    PHshift = zeros(firsty,1);
                                    for nav=1:firsty
                                        navecho1 = squeeze(kSpaceRaw(round(dimX/2)+1, 1 ,slice,dynamic,fa,echo));
                                        navecho2 = squeeze(kSpaceRaw(round(dimX/2)+1,nav,slice,dynamic,fa,echo));
                                        PHshift(nav) = angle(navecho2) - angle(navecho1);
                                    end

                                    % Sorting including phase correction based on navigator
                                    for j = firsty+1:dimY

                                        idx = mod(j-firsty+1,firsty)+1;
                                        y = kTable(j)+round(firsty/2);

                                        kSpace(:,y,slice,dynamic,fa,echo) = kSpaceRaw(:,j,slice,dynamic,fa,echo);%.*exp(-1i*PHshift(idx));

                                        for x = 1:dimX

                                            % Fill the k-space trajectory array
                                            trajectory2D(tcnt,1) = x;
                                            trajectory2D(tcnt,2) = y;
                                            trajectory2D(tcnt,3) = slice;
                                            trajectory2D(tcnt,4) = dynamic;
                                            trajectory2D(tcnt,5) = fa;
                                            trajectory2D(tcnt,6) = echo;
                                            tcnt = tcnt + 1;

                                        end

                                    end

                                else

                                    % Sorting without phase correction
                                    for j = firsty+1:dimY
                                        y = kTable(j)+round(firsty/2);
                                        kSpace(:,y,slice,dynamic,fa,echo) = kSpaceRaw(:,j,slice,dynamic,fa,echo);

                                        for x = 1:dimX

                                            % Fill the k-space trajectory array
                                            trajectory2D(tcnt,1) = x;
                                            trajectory2D(tcnt,2) = y;
                                            trajectory2D(tcnt,3) = slice;
                                            trajectory2D(tcnt,4) = dynamic;
                                            trajectory2D(tcnt,5) = fa;
                                            trajectory2D(tcnt,6) = echo;
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

            dimC = obj.nrCoils;

            for coil = 1:dimC

                app.TextMessage(strcat('Sorting coil',{' '},num2str(coil),' ...'));

                % Coil data
                kSpaceRaw = obj.rawKspace{coil};

                % Dimensions
                [dimX, dimY, dimZ, dimD, dimF, dimE] = size(kSpaceRaw);
                kSpace = zeros(size(kSpaceRaw));
                trajectory = ones(dimX*dimY*dimZ*dimD*dimF*dimE,7);

                % Navigator yes or no, for RARE echo train correction
                firsty = 0;
                if obj.nav_on == 1
                    firsty = obj.VIEWS_PER_SEGMENT;
                end

                % Counter
                tcnt = 1;

                % Loop over all dimensions
                for echo = 1:dimE

                    for fa = 1:dimF

                        for dynamic = 1:dimD

                            app.TextMessage(strcat('Sorting dynamic',{' '},num2str(dimD),' ...'));

                            for z = 1:dimZ

                                for j = firsty+1:dimY

                                    y = kTable(j)+round(firsty/2);

                                    kSpace(:,y,z,dynamic,fa,echo) = kSpaceRaw(:,j,z,dynamic,fa,echo);

                                    for x = 1:dimX

                                        % Fill the k-space trajectory array
                                        trajectory(tcnt,1) = x;
                                        trajectory(tcnt,2) = y;
                                        trajectory(tcnt,3) = z;
                                        trajectory(tcnt,4) = dynamic;
                                        trajectory(tcnt,5) = fa;
                                        trajectory(tcnt,6) = echo;
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

                [dimX, dimY, dimZ, dimD, dimF, dimE] = size(obj.rawKspace{1});

                nrLines = obj.lines_per_segment;
                dimC = obj.nrCoils;

                for coil = 1:dimC

                    for slice = 1:dimZ

                        for fa = 1:dimF

                            for dynamic = 1:dimD

                                ks = squeeze(obj.rawKspace{coil}(:,:,slice,dynamic,fa,:));
                                ks = permute(ks,[3 2 1]);
                                ks = reshape(ks(:),[nrLines dimE dimY/nrLines dimX]);
                                ks = permute(ks,[2 1 3 4]);
                                ks = reshape(ks(:),[dimE dimX dimY]);
                                ks = permute(ks,[3 2 1]);
                                obj.rawKspace{coil}(:,:,slice,dynamic,fa,:) = ks(:,:,:);

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
            dimX = obj.NO_SAMPLES_ORIG;
            dimY = obj.NO_VIEWS;
            dimZ = obj.NO_SLICES;
            dimN = obj.EXPERIMENT_ARRAY;
            dimYO = obj.NO_VIEWS_ORIG;
            dimD = app.NREditField.Value;
            dimC = obj.nrCoils;

            for coil = 1:dimC

                app.TextMessage(strcat("Sorting coil ",num2str(coil)," ..."));

                % Unsorted k-space for each coil
                ukspace = obj.unsKspace{coil};

                % Pre-allocate large matrices
                aframes = dimD;
                aframes(aframes==1) = 2; % allocate at least 2 frames, because preallocating 1 does not work
                kSpace = zeros(dimX, dimY, dimZ, aframes);
                avgSpace = zeros(dimX, dimY, dimZ, aframes);
                trajectoryGpVarMul = ones(dimX * dimYO * dimZ * dimN, 7);

                % Fill the ky-space locations
                ky = zeros(dimYO, 1);
                i = 1:dimYO;
                ky(i) = int16(obj.gp_var_mul(i)) + round(dimY/2) + 1;     % contains the y-coordinates of the custom k-space sequentially

                % Duplicate for multiple acquired repetitions
                ky = repmat(ky,1,dimN * dimZ);

                % Number of k-space points per frame
                kPointsPerFrame = round(dimYO * dimN / dimD);

                % Trajectory counter
                cnt = 0;

                % Loop over slices
                for slice = 1:dimZ

                    % Loop over desired number of frames
                    for dynamic = 1:dimD

                        app.TextMessage(strcat("Sorting dynamic ",num2str(dynamic)," ..."));

                        % Code below not correct for slices !!!!
                        wStart = (dynamic - 1) * kPointsPerFrame + 1; % starting k-line for specific frame
                        wEnd = dynamic * kPointsPerFrame;             % ending k-line for specific frame
                        if wEnd > dimYO * dimN
                            wEnd = dimYO * dimN;
                        end

                        for w = wStart:wEnd

                            for x = 1:dimX

                                kSpace(x,ky(w),slice,dynamic) = kSpace(x,ky(w),slice,dynamic) + ukspace((w - 1) * dimX + x);
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
                kSpace = kSpace(:,:,:,1:dimD);

                % Return the object
                obj.rawKspace{coil} = kSpace(:,:,:,1:dimD);

            end

            % For k-space filling visualization
            obj.nsaSpace = avgSpace(:,:,:,1:dimD);
            fillingKSpace = avgSpace./avgSpace;
            fillingKSpace(isnan(fillingKSpace)) = 0;
            obj.fillingSpace = fillingKSpace(:,:,:,1:dimD);

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
            dimX = obj.NO_SAMPLES_ORIG;
            dimY = obj.NO_VIEWS;
            dimYO = obj.NO_VIEWS_ORIG;
            dimZ = obj.NO_VIEWS_2;
            dimN = obj.EXPERIMENT_ARRAY;                % Number of acquired repetitions/dynamics
            dimD = app.NREditField.Value;               % Number of reconstructed dynamics
            dimF = app.NFAViewField.Value;               % Number of flip-angles
            arrayLength = obj.NO_VIEWS_ORIG*dimZ;

            % For multiple flip-angles
            if dimF > 1
                dimN = dimF;
                dimD = dimF;
                app.NREditField.Value = 1;
            end

            for coil = 1:obj.nrCoils

                app.TextMessage(strcat("Sorting coil ",num2str(coil)," ..."));

                % Unsorted k-space for each coil
                unsortedKspace = obj.unsKspace{coil};
                unsortedKspace = reshape(unsortedKspace,dimX,dimY,dimZ,nTE,dimN);
                unsortedKspace = permute(unsortedKspace,[1,4,2,3,5]);
                unsortedKspace = unsortedKspace(:);

                % Preallocate memory for the matrices
                kSpace = zeros(dimX, dimY, dimZ, dimD, 1, nTE);
                avgSpace = zeros(dimX, dimY, dimZ, dimD, 1, nTE);
                trajectory3D = ones(mtx*dimN,7);

                % Centric or linear k-space ordering for views2
                kzp = zeros(dimZ,1);
                if parameters.pe2_centric_on == 1
                    kzp(1) = 0;
                    for i = 1:dimZ-1
                        kzp(i+1) = (-1)^i * round(i/2);
                    end
                    kzp = kzp - min(kzp) + 1;
                else
                    kzp = 1:dimZ;
                end

                % Fill the ky-space locations
                cnt1 = 1;
                kcnt = 1;
                ky = zeros(arrayLength,1);
                kz = zeros(arrayLength,1);
                for i = 1:arrayLength
                    ky(i) = round(int16(parameters.gp_var_mul(cnt1)) + dimY/2 + 1);
                    kz(i) = kzp(kcnt);
                    kcnt = kcnt + 1;
                    if kcnt > dimZ
                        kcnt = 1;
                        cnt1 = cnt1 + 1;
                        cnt1(cnt1 > dimYO) = 1;
                    end
                end

                % Some checks to keep k-space points within dimensions
                ky(ky>dimY) = dimY;
                ky(ky<1) = 1;
                kz(kz>dimZ) = dimZ;
                kz(kz<1) = 1;

                % Duplicate for multiple acquired repetitions
                ky = repmat(ky,1,dimN+1);
                kz = repmat(kz,1,dimN+1);
                ky = ky(:);
                kz = kz(:);

                % Number of k-space points per frame
                kPointsPerFrame = round(dimYO * dimZ * dimN / dimD);
                app.TextMessage(strcat("K-lines per dynamic = ",num2str(kPointsPerFrame)," ..."));

                % Trajectory counter
                kcnt = 1;

                % Loop over desired number of frames
                for dynamic = 1:dimD

                    if dimF>1
                        app.TextMessage(strcat("Sorting flip-angle #",num2str(dynamic)," ..."));
                    else
                        app.TextMessage(strcat("Sorting dynamic #",num2str(dynamic)," ..."));
                    end

                    wStart = (dynamic - 1) * kPointsPerFrame + 1; % starting k-line for specific frame
                    wEnd = dynamic * kPointsPerFrame;             % ending k-line for specific frame
                    wEnd(wEnd > arrayLength*dimN) = arrayLength * dimN;

                    % Loop over y-dimension (views)
                    for pcnt = wStart:wEnd

                        % X-dimension (readout)
                        kx = 1:dimX;

                        % Loop over gradient-echoes
                        for echo = 1:dimE

                            % Odd or even gradient echo
                            isOdd = mod(echo,2);
                            readout = (pcnt-1)*dimE*dimX + (echo-1)*dimX + kx*isOdd + (dimX+1-kx)*(1-isOdd);

                            % Fill the k-space points
                            kSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) = kSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) + unsortedKspace(readout);

                            % Fill averages space
                            avgSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) = avgSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) + 1;

                        end

                        % Fill the k-space trajectory array
                        trajectoryProud(kcnt:kcnt+dimX-1,1) = kx';
                        trajectoryProud(kcnt:kcnt+dimX-1,2) = ky(pcnt);
                        trajectoryProud(kcnt:kcnt+dimX-1,3) = kz(pcnt);
                        trajectoryProud(kcnt:kcnt+dimX-1,4:5) = dynamic;
                        kcnt = kcnt + dimX;

                    end

                end

                % Normalize by dividing through number of averages
                kSpace = kSpace./avgSpace;
                kSpace(isnan(kSpace)) = complex(0);
                obj.rawKspace{coil} = kSpace(:,:,:,:,1,:);

                % For multiple flip-angles
                if dimF>1
                    obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1 2 3 5 4 6]);
                end

            end

            % For k-space filling visualization
            obj.nsaSpace = avgSpace(:,:,:,:,1,:);
            fillkSpace = avgSpace./avgSpace;
            fillkSpace(isnan(fillkSpace)) = 0;
            obj.fillingSpace = fillkSpace(:,:,:,:,1,:);

            % For multiple flip-angles
            if dimF>1
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
            dimX = obj.NO_SAMPLES;
            dimY = obj.NO_VIEWS;
            dimZ = obj.NO_VIEWS_2;
            dimN = obj.EXPERIMENT_ARRAY;            % Number of acquired dynamics
            dimD = app.NREditField.Value;           % Number of reconstructed dynamics
            dimE = app.NEViewField.Value;           % Number of echo-times
            dimF = app.NFAViewField.Value;          % Number of flip-angles
            dimC = obj.nrCoils;                     % Number of coils                     
            mtx = dimY*dimZ*dimX;

            % ALERT NEEDS REVISION
            % For multiple flip-angles
            if dimF > 1
                dimN = dimF;
                dimD = dimF;
                app.NREditField.Value = 1;
            end

            for coil = 1:dimC

                app.TextMessage(strcat("Sorting coil ",num2str(coil)," ..."));

                % Unsorted k-space for each coil
                unsortedKspace = obj.unsKspace{coil};
                unsortedKspace = reshape(unsortedKspace,dimX,[],dimZ,dimE,dimN);
                dimYL = size(unsortedKspace,2); % The real size of no_views
                unsortedKspace = permute(unsortedKspace,[1,4,2,3,5]);
                unsortedKspace = unsortedKspace(:);
                
                % Preallocate memory for the matrices
                kSpace = zeros(dimX, dimY, dimZ, dimD, 1, dimE);
                avgSpace = zeros(dimX, dimY, dimZ, dimD, 1, dimE);
                trajectoryProud = ones(length(unsortedKspace),7);

                % Fill the ky and kz k-space locations
                ky = round(obj.proudArray(1,:) + dimY/2 + 1);      % contains the y-coordinates of the custom k-space sequentially
                kz = round(obj.proudArray(2,:) + dimZ/2 + 1);      % contains the z-coordinates of the custom k-space sequentially

                % Some checks to keep k-space points within dimensions
                ky(ky>dimY) = dimY;
                ky(ky<1) = 1;
                kz(kz>dimZ) = dimZ;
                kz(kz<1) = 1;

                % Duplicate for multiple acquired repetitions
                ky = repmat(ky,1,dimN+1);
                kz = repmat(kz,1,dimN+1);
                ky = ky(:);
                kz = kz(:);

                % Number of k-space points per frame
                kLinesPerDynamic = round(dimYL*dimZ*dimN/dimD);
                app.TextMessage(strcat("K-lines per dynamic = ",num2str(kLinesPerDynamic)," ..."));

                % Trajectory counter
                kcnt = 1;   % k-point counter

                % Loop over desired number of frames
                for dynamic = 1:dimD

                    if dimF>1
                        app.TextMessage(strcat('Sorting flip-angle #',num2str(dynamic),' ...'));
                    else
                        app.TextMessage(strcat('Sorting dynamic #',num2str(dynamic),' ...'));
                    end
                    drawnow;

                    wStart = (dynamic - 1) * kLinesPerDynamic + 1;      % Starting k-line for specific frame
                    wEnd = dynamic * kLinesPerDynamic;                  % Ending k-line for specific frame
                    wEnd(wEnd > dimYL*dimZ*dimN) = dimYL*dimZ*dimN;

                    % Loop over y- and z-dimensions (views and views2)
                    for pcnt = wStart:wEnd

                        % X-dimension (readout)
                        kx = 1:dimX;

                        % Loop over gradient-echoes
                        for echo = 1:dimE

                            % Odd or even gradient echo
                            isOdd = mod(echo,2);
                            readout = (pcnt-1)*dimE*dimX + (echo-1)*dimX + kx*isOdd + (dimX+1-kx)*(1-isOdd);

                            % Fill the k-space points
                            kSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) = kSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) + unsortedKspace(readout);

                            % Fill averages space
                            avgSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) = avgSpace(kx,ky(pcnt),kz(pcnt),dynamic,1,echo) + 1;

                        end

                        % Fill the k-space trajectory array
                        trajectoryProud(kcnt:kcnt+dimX-1,1) = kx';
                        trajectoryProud(kcnt:kcnt+dimX-1,2) = ky(pcnt);
                        trajectoryProud(kcnt:kcnt+dimX-1,3) = kz(pcnt);
                        trajectoryProud(kcnt:kcnt+dimX-1,4:5) = dynamic;
                        kcnt = kcnt + dimX;

                    end

                end

                % Normalize by dividing through number of averages
                kSpace = kSpace./avgSpace;
                kSpace(isnan(kSpace)) = complex(0);
                obj.rawKspace{coil} = kSpace(:,:,:,:,1,:);

                % ALERT NEEDS REVISION
                % For multiple flip-angles
                if dimF>1
                    obj.rawKspace{coil} = permute(obj.rawKspace{coil},[1 2 3 5 4 6]);
                end

            end

            % For k-space filling visualization
            obj.nsaSpace = avgSpace(:,:,:,:,1,:);
            fillingkSpace = avgSpace./avgSpace;
            fillingkSpace(isnan(fillingkSpace)) = 0;
            obj.fillingSpace = fillingkSpace(:,:,:,:,1,:);

            % ALERT NEEDS REVISION
            % For multiple flip-angles
            if dimF>1
                obj.nsaSpace = permute(obj.nsaSpace,[1 2 3 5 4 6]);
                obj.fillingSpace = permute(obj.fillingSpace,[1 2 3 5 4 6]);
            end

            % Trajectory
            obj.seqTrajectory = trajectoryProud;

        end % sortProudKspaceMRD




        % ---------------------------------------------------------------------------------
        % Remove navigator if present
        % ---------------------------------------------------------------------------------
        function obj = chopNav(obj, app)

            % Chop of the navigator if present
            if obj.slice_nav == 1

                app.TextMessage('INFO: Removing navigator ...');
                app.TextMessage('Use RETROSPECTIVE app for navigator analysis ...');
                discard = obj.no_samples_discard + obj.no_samples_nav;
                for i=1:obj.nrCoils
                    obj.rawKspace{i} = obj.rawKspace{i}(discard+1:end,:,:,:,:,:);
                end
                obj.nsaSpace = obj.nsaSpace(discard+1:end,:,:,:,:,:);
                obj.fillingSpace = obj.fillingSpace(discard+1:end,:,:,:,:,:);
                obj.NO_SAMPLES = obj.NO_SAMPLES - discard;
                app.XEditField.Value = obj.NO_SAMPLES;
                app.KMatrixViewField1.Value = obj.NO_SAMPLES;

            end

        end % chopNav




        % ---------------------------------------------------------------------------------
        % Perform some EPI corrections
        % Aug 2023
        % ---------------------------------------------------------------------------------
        function [obj, kSpace] = epiCorr(obj, app, kSpace)

            app.TextMessage('Performing EPI corrections ...');

            [~,~,dimZ,dimD,dimC] = size(kSpace);

            % Parameters
            kCenter = 0.5;
            pCenter = 0.1;
            method = 'Gh/Ob'; % options: ent, entSmooth, svd, Gh/Ob

            % Calculate Ghost corrections
            dynamic = 0;
            while (dynamic<dimD) && ~app.stopReco_flag
                dynamic = dynamic + 1;
                app.TextMessage(strcat("Ghost corrections dynamic ",num2str(dynamic)," ..."));
                slice = 0;
                while (slice<dimZ) && ~app.stopReco_flag
                    slice = slice + 1;
                    for coil = 1:dimC
                        kSpaceGhost = squeeze(kSpace(:,:,slice,dynamic,coil));
                        try
                            kSpaceCorrected = applyEPIcorrection_mex(kSpaceGhost, kCenter, pCenter, method);
                        catch
                            kSpaceCorrected = applyEPIcorrection(kSpaceGhost, kCenter, pCenter, method);
                        end
                        kSpace(:,:,slice,dynamic,coil) = kSpaceCorrected;
                    end
                    drawnow;
                end
            end


            % Retrieving EPI mask, if present
            obj.epiMask = [];
            for coil = 1:obj.nrCoils
                obj.epiMask(:,:,:,coil) = ones(size(kSpace(:,:,:,1,coil)));
            end

            try
                if obj.rprFile_flag

                    idx1 = strfind(obj.rprFile,'MaskImageDirectory=');

                    if ~isempty(idx1)

                        idx1 = idx1 + 20;
                        idx2 = idx1 + strfind(obj.rprFile(idx1(1):idx1(1)+60),'Image\\') + 6;
                        idx3 = idx2 + strfind(obj.rprFile(idx2(1):idx2(1)+10),'\\') - 2;
                        scanNumber = obj.rprFile(idx2(1):idx3(1));
                        slocs = strfind(app.mrdImportPath,filesep);
                        scanMask = strcat(app.mrdImportPath(1:slocs(end-1)),scanNumber,filesep);
                        fList = dir(fullfile(strcat(scanMask,'*.MRD')));
                        app.TextMessage(strcat("EPI mask image scan = ",fList(1).name," ..."));

                        % Load masking k-space data
                        for i=1:obj.nrCoils
                            [kSpaceMask{i},~,~,~] = proudData.importMRD(fullfile(fList(i).folder,fList(i).name),'seq','cen');
                            kSpaceMask{i} = permute(kSpaceMask{i},[3 2 1]);
                        end

                        % Reconstruct mask images
                        imageMask = zeros(size(kSpaceMask{1}));
                        for i=1:obj.nrCoils
                            imageMask = imageMask + abs(obj.fft2Dmri(kSpaceMask{i})).^2;
                        end

                        % Copy mask to different coils
                        for i=1:obj.nrCoils
                            imageMask(:,:,:,i) = imageMask(:,:,:,1);
                        end

                        % Threshold to binary mask
                        obj.epiMask = ones(size(imageMask));
                        thr = 0.15 * double(graythresh(mat2gray(imageMask(:)))) * max(imageMask(:));
                        obj.epiMask(imageMask < thr) = 0;

                    end
                end

            catch ME

                app.TextMessage(ME.message);
                app.TextMessage('Warning: something went wrong during EPI mask construction ...');

            end

        end % epiCorr




        % ---------------------------------------------------------------------------------
        % Apply Tukey k-space filter
        % Version: February 2023
        % ---------------------------------------------------------------------------------
        function obj = applyTukey(obj)

            dimX = size(obj.rawKspace{1},1);
            dimY = size(obj.rawKspace{1},2);
            dimZ = size(obj.rawKspace{1},3);
            dimC = obj.nrCoils;

            % Normalize k-space to convenient range
            for coil = 1:dimC 
                maxPerCoil(coil) = max(abs(obj.rawKspace{coil}(:)));
            end
            for coil = 1:dimC 
                obj.rawKspace{coil} = obj.maxKspace*obj.rawKspace{coil}/max(maxPerCoil);
            end

            if ~obj.halfFourier_flag

                switch obj.dataType

                    case {"2D","2Depi"}

                        kSpaceSum = zeros(dimX,dimY);
                        for coil = 1:dimC 
                            kSpaceSum = kSpaceSum + squeeze(sum(obj.rawKspace{coil},[3 4 5 6 7 8]));
                        end
                        [row, col] = find(ismember(kSpaceSum, max(kSpaceSum(:))));
                        for coil = 1:dimC 
                            flt = proudData.circTukey2D(dimX,dimY,row,col,obj.tukeyFilterWidth);
                            tukeyFilter(:,:,1,1,1,1) = flt;
                            obj.rawKspace{coil} = obj.rawKspace{coil}.*tukeyFilter;
                        end
                
                    case "3D"

                        kSpaceSum = zeros(dimX,dimY,dimZ);
                        for coil = 1:dimC 
                            kSpaceSum = kSpaceSum + squeeze(sum(obj.rawKspace{coil},[4 5 6 7 8]));
                        end
                        [~,idx] = max(kSpaceSum(:));
                        [lev, row, col] = ind2sub(size(kSpaceSum),idx);
                        for coil=1:dimC 
                            flt = proudData.circTukey3D(dimX,dimY,dimZ,lev,row,col,obj.tukeyFilterWidth);
                            tukeyFilter(:,:,:,1,1,1) = flt;
                            obj.rawKspace{coil} = obj.rawKspace{coil}.*tukeyFilter;
                        end
      
                end

            end

        end % applyTukey



        % ---------------------------------------------------------------------------------
        % Estimate coil sensitivities
        % Oct 2023
        % ---------------------------------------------------------------------------------
        function obj = estimateCoilSensitivies(obj, app)

            dimM = obj.maxCoils;
            dimC = obj.nrCoils;
            dimX = size(obj.rawKspace{1},1);
            dimY = size(obj.rawKspace{1},2);
            dimZ = size(obj.rawKspace{1},3);
            calibSize = obj.coilSensitivityCalibSize;
            minSense = 0.01;

            obj.coilSensitivities(1:dimM) = 1;
            relativeCoilSensitivity = ones(1,dimM);

            if dimC > 1

                for coil = 1:dimC

                    switch obj.dataType

                        case {"2D","2Depi"}

                            tmpKspace = sum(abs(obj.rawKspace{coil}),[3,4,5,6]);
                            [~,mIdx] = max(tmpKspace,[],"all","linear");
                            [x,y] = ind2sub(size(tmpKspace),mIdx);
                            xmin = x-calibSize+1;
                            xmin(xmin<1) = 1;
                            xmax = x+calibSize;
                            xmax(xmax>dimX) = dimX;
                            ymin = y-calibSize+1;
                            ymin(ymin<1) = 1;
                            ymax = y+calibSize;
                            ymax(ymax>dimY) = dimY;
                            lowResKspace = tmpKspace(xmin:xmax,ymin:ymax);
                            relativeCoilSensitivity(coil) = mean(lowResKspace(:));

                        case "3D"

                            tmpKspace = sum(abs(obj.rawKspace{coil}),[4,5,6]);
                            [~,mIdx] = max(tmpKspace,[],"all","linear");
                            [x,y,z] = ind2sub(size(tmpKspace),mIdx);
                            xmin = x-calibSize+1;
                            xmin(xmin<1) = 1;
                            xmax = x+calibSize;
                            xmax(xmax>dimX) = dimX;
                            ymin = y-calibSize+1;
                            ymin(ymin<1) = 1;
                            ymax = y+calibSize;
                            ymax(ymax>dimY) = dimY;
                            zmin = z-calibSize+1;
                            zmin(zmin<1) = 1;
                            zmax = z+calibSize;
                            zmax(zmax>dimZ) = dimZ;
                            lowResKspace = tmpKspace(xmin:xmax,ymin:ymax,zmin:zmax);
                            relativeCoilSensitivity(coil) = mean(lowResKspace(:));

                        case {"2Dradial","3Dute"}

                            tmpKspace = sum(abs(obj.rawKspace{coil}),[2,3,4,5,6]);
                            [~,mIdx] = max(tmpKspace,[],"all","linear");
                            x = ind2sub(size(tmpKspace),mIdx);
                            xmin = x-calibSize+1;
                            xmin(xmin<1) = 1;
                            xmax = x+calibSize;
                            xmax(xmax>dimX) = dimX;
                            lowResKspace = tmpKspace(xmin:xmax);
                            relativeCoilSensitivity(coil) = mean(lowResKspace(:));

                    end

                end

                relativeCoilSensitivity(1:dimC) = relativeCoilSensitivity(1:dimC) / max(relativeCoilSensitivity(1:dimC));
                relativeCoilSensitivity(relativeCoilSensitivity<minSense) = minSense;

            end

            obj.coilSensitivities = round(relativeCoilSensitivity,3);

            app.S1EditField.Value = obj.coilSensitivities(1);
            app.S2EditField.Value = obj.coilSensitivities(2);
            app.S3EditField.Value = obj.coilSensitivities(3);
            app.S4EditField.Value = obj.coilSensitivities(4);
            app.S5EditField.Value = obj.coilSensitivities(5);
            app.S6EditField.Value = obj.coilSensitivities(6);
            app.S7EditField.Value = obj.coilSensitivities(7);
            app.S8EditField.Value = obj.coilSensitivities(8);
      
        end % estimateCoilSensitivies






        % ---------------------------------------------------------------------------------
        % Image reconstruction: compressed sensing 2D
        % Oct 2023
        % ---------------------------------------------------------------------------------
        function obj = csReco2D(obj, app)

            % CS regularization parameters
            LW = app.WVxyzEditField.Value;
            TVxy = app.TVxyzEditField.Value;
            LR = app.LRxyzEditField.Value;
            TVd = app.TVtimeEditField.Value;

            % Input k-space dimensions
            dimX = size(obj.rawKspace{1},1);
            dimY = size(obj.rawKspace{1},2);
            dimZ = size(obj.rawKspace{1},3);
            app.ZEditField.Value = dimZ;
            dimD = size(obj.rawKspace{1},4);
            dimF = size(obj.rawKspace{1},5);
            dimE = size(obj.rawKspace{1},6);
            dimC = obj.nrCoils;

            % Requested image dimensions
            ndimX = app.XEditField.Value;
            ndimY = app.YEditField.Value;
            ndimD = dimD;
            if dimD > 1
                ndimD = app.NREditField.Value;
            else
                app.NREditField.Value = 1;
            end

            % Kspace data x,y,slice,dynamic,flipangle,echotime,coils
            kSpace = zeros(dimX,dimY,dimZ,dimD,dimF,dimE,dimC);

            % Fill k-space for reconstruction
            for coil = 1:dimC
                kSpace(:,:,:,:,:,:,coil) = obj.rawKspace{coil}*obj.coilActive_flag(coil)/obj.coilSensitivities(coil);
            end

            % For EPI data
            if strcmp(obj.dataType,'2Depi')
                [obj, kSpace] = obj.epiCorr(app, kSpace);
            end

            if app.bartDetected_flag

                % CS reco with BART

                % Resize k-space to requested dimensions [ndimx ndimy slices ndimd]
                kSpace = bart(app,['resize -c 0 ',num2str(ndimX),' 1 ',num2str(ndimY),' 3 ',num2str(ndimD)],kSpace);

                % Bart dimensions
                % 	READ_DIM,       1   z
                % 	PHS1_DIM,       2   y
                % 	PHS2_DIM,       3   x
                % 	COIL_DIM,       4   coils
                % 	MAPS_DIM,       5   sense maps
                % 	TE_DIM,         6   echo-time
                % 	COEFF_DIM,      7   flip-angle
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
                kSpacePics = permute(kSpace,[8 ,2 ,1 ,7 ,9 ,6 ,5 ,10,11,12,4 ,13,14,3 ]);


                if (nnz(obj.coilActive_flag) > 1) && (app.AutoSensitivityCheckBox.Value == 1)

                    % ESPIRiT reconstruction
                    TextMessage(app,'ESPIRiT reconstruction ...');

                    % Calculate coil sensitivity maps with ecalib bart function, per slice, per dynamic
                    sensitivities = zeros(1,ndimY,ndimX,dimC,1,1,1,1,1,1,ndimD,1,1,dimZ);
                    for slice = 1:dimZ
                        app.TextMessage(strcat("Ecalib coil sensitivity estimation, slice ",num2str(slice)," ..."));
                        sensitivities(1,:,:,logical(obj.coilActive_flag),1,1,1,1,1,1,:,1,1,slice) = bart(app,'ecalib -d1 -S -I -a -m1', kSpacePics(1,:,:,logical(obj.coilActive_flag),1,1,1,1,1,1,:,1,1,slice));
                    end

                else

                    sensitivities = zeros(1,ndimY,ndimX,dimC,1,1,1,1,1,1,ndimD,1,1,dimZ);
                    for coil = 1:obj.maxCoils
                        if logical(obj.coilActive_flag(coil))
                            sensitivities(1,:,:,coil,1,1,1,1,1,1,:,1,1,:) = obj.coilSensitivities(coil);
                        end
                    end

                end

                % Construct the sensitivity maps for the app {coil} x, y, slices, dynamics, flip-angle, echo-time ...
                senseMap = permute(abs(sensitivities),[3 2 14 11 4 6 5 1 7 8 9 10 12 13 15]);
                senseMap = senseMap/max(senseMap(:));
                senseMap = flip(senseMap,2);
                if obj.PHASE_ORIENTATION == 0
                    senseMap = flip(senseMap,1);
                end
                for coil = 1:obj.maxCoils
                    for echo = 1:dimE
                        for fa = 1:dimF
                            if (logical(obj.coilActive_flag(coil)) == 1) && (coil <= dimC)
                                obj.sensitivityMaps{coil}(:,:,:,:,fa,echo) = senseMap(:,:,:,:,coil,1,1,1,1,1,1,1,1,1,1);
                            else
                                obj.sensitivityMaps{coil}(:,:,:,:,fa,echo) = zeros(size(senseMap(:,:,:,:,1,1,1,1,1,1,1,1,1,1,1)));
                            end
                        end
                    end
                end

                % wavelet in y and x spatial dimensions 2^1+2^2=6
                % total variation in y and x spatial dimensions 2^1+2^2=6
                % total variation in dynamic dimension 2^10 = 1024

                % PICS command
                picsCommand = 'pics -S';
                if LW>0
                    picsCommand = [picsCommand,' -RW:6:0:',num2str(LW)];
                end
                if TVxy>0
                    picsCommand = [picsCommand,' -R',obj.totalVariation,':6:0:',num2str(TVxy)];
                end
                if LR>0
                    % Locally low-rank in the spatial domain
                    blocksize = round(max([ndimX ndimY])/16);  % Block size
                    app.TextMessage(strcat('Low-rank block size =',{' '},num2str(blocksize)));
                    picsCommand = [picsCommand,' -RL:6:6:',num2str(LR),' -b',num2str(blocksize)];
                end
                if TVd>0
                    picsCommand = [picsCommand,' -R',obj.totalVariation,':1024:0:',num2str(TVd)];
                end

                % PICS reconstruction
                imageReco = zeros(ndimY,ndimX,1,1,1,dimE,dimF,1,1,1,ndimD,1,1,dimZ);

                % Initialize progress counter
                app.totalCounter = dimE*dimF*dimZ;
                app.progressCounter = 0;

                echo = 0;
                while (echo < dimE) && ~app.stopReco_flag
                    echo = echo + 1;

                    fa = 0;
                    while (fa < dimF) && ~app.stopReco_flag
                        fa = fa + 1;

                        slice = 0;
                        while (slice < dimZ) && ~app.stopReco_flag
                            slice = slice + 1;

                            % Bart reco
                            k = kSpacePics(1,:,:,:,1,echo,fa,1,1,1,:,1,1,slice);
                            s = sensitivities(1,:,:,:,1,1,1,1,1,1,:,1,1,slice);
                            imageReco(:,:,1,1,1,echo,fa,1,1,1,:,1,1,slice) = bart(app,picsCommand,k,s);

                            % Report on progress
                            app.progressCounter = app.progressCounter + 1;
                            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                            drawnow;

                        end

                    end

                end

                % Permute to [X Y slice dynamics]
                imagesOut = permute(imageReco,[2,1,14,11,7,6,3,4,5,8,9,10,12,13]);

                % Flip dimensions if needed
                imagesOut = flip(imagesOut,2);
                if obj.PHASE_ORIENTATION == 0
                    imagesOut = flip(imagesOut,1);
                end

                % Masking of EPI data
                if strcmp(obj.dataType,'2Depi')
                    for dynamic = 1:ndimD
                        for slice = 1:dimZ
                            msk(:,:,slice,dynamic) = imresize(squeeze(obj.epiMask(:,:,slice,1)),[ndimX ndimY]);
                        end
                    end
                    imagesOut = imagesOut.*flip(msk,2);
                end

            else

                % 2D CS reco in MATLAB

                app.TextMessage('WARNING: Bart toolbox not available, slow reconstruction ...');

                % k-space for reconstruction [X Y slices dynamics coils]

                % Interpolate in the dynamics dimension
                if ndimD ~= dimD
                    kSpace = obj.matrixInterpolate(kSpace,[1 1 1 ndimD/dimD 1 1 1],'cubic');
                    ndimD = size(kSpace,4);
                    app.NREditField.Value = ndimD;
                end

                % Preallocate
                imagesOut = zeros(ndimX,ndimY,dimZ,ndimD,dimF,dimE);

                % Initialize progress counter
                app.totalCounter = dimE*dimF*dimZ;
                app.progressCounter = 0;

                echo = 0;
                while (echo < dimE) && ~app.stopReco_flag
                    echo = echo + 1;

                    fa = 0;
                    while (fa < dimF) && ~app.stopReco_flag
                        fa = fa + 1;

                        slice = 0;
                        while (slice < dimZ) && ~app.stopReco_flag
                            slice = slice + 1;

                            % Fool the reco if dimd = 1, it needs at least 2 dynamics
                            if ndimD == 1
                                kSpace(:,:,slice,2,fa,echo,:) = kSpace(:,:,slice,1,fa,echo,:);
                                kData = zeros(dimX,dimY,2,dimC);
                                kMask = zeros(dimX,dimY,2);
                            else
                                kData = zeros(dimX,dimY,ndimD,dimC);
                                kMask = zeros(dimX,dimY,ndimD);
                            end

                            % Kspace of slice
                            kData(:,:,:,:) = kSpace(:,:,slice,:,fa,echo,:);
                            kMask(:,:,:) = logical(abs(kSpace(:,:,slice,:,fa,echo,1)));

                            % Zero-fill or crop x-dimension
                            if ndimX > dimX
                                padsizex = round((ndimX - dimX)/2);
                                kdatai = padarray(kData,[padsizex,0,0,0],'both');
                                maski = padarray(kMask,[padsizex,0,0],'both');
                            else
                                cropsize = round((dimX - ndimX)/2)-1;
                                cropsize(cropsize<0)=0;
                                kdatai = kData(cropsize+1:end-cropsize,:,:,:);
                                maski = kMask(cropsize+1:end-cropsize,:,:);
                            end

                            % Zero-fill or crop y-dimension
                            if ndimY > dimY
                                padsizey = round((ndimY - dimY)/2);
                                kdatai = padarray(kdatai,[0,padsizey,0,0],'both');
                                maski = padarray(maski,[0,padsizey,0],'both');
                            else
                                cropsize = round((dimY - ndimY)/2)-1;
                                cropsize(cropsize<0)=0;
                                kdatai = kdatai(:,cropsize+1:end-cropsize,:,:);
                                maski = maski(:,cropsize+1:end-cropsize,:);
                            end

                            % Make sure dimensions are exactly ndimx, ndimy
                            kdatai = kdatai(1:ndimX,1:ndimY,:,:);
                            maski = maski(1:ndimX,1:ndimY,:);

                            % Normalize the data in the range of approx 0 - 1 for better numerical stability
                            kdatai = kdatai/max(abs(kdatai(:)));

                            % Coil sensitivity map
                            for coil = 1:dimC
                                b1(:,:,coil) = ones(ndimX,ndimY)*obj.coilSensitivities(coil);
                            end

                            % Data
                            param.y = kdatai;

                            % Reconstruction design matrix
                            param.E = Emat_yxt(maski,b1);

                            % Total variation (TV) constraint in the temporal domain & Wavelet in spatial domain
                            param.TV = TVOP;
                            param.TVWeight = TVd/10;

                            % Wavelet
                            param.W = Wavelet('Daubechies',12,12);
                            param.L1Weight = LW;

                            % Number of iterations, 2 x 5 iterations
                            param.nite = 5;
                            param.nouter = 2;

                            % Linear reconstruction
                            nrd = size(kdatai,3);
                            kdata1 = squeeze(randn(ndimX,ndimY,nrd,dimC))/2000 + kdatai;  % add a little bit of randomness, such that linear reco is not exactly right
                            recon_dft = param.E'*kdata1;

                            % Iterative reconstruction
                            recon_cs = recon_dft;
                            for n = 1:param.nouter
                                recon_cs = CSL1NlCg(recon_cs,param);
                            end
                            imageReco = recon_cs;

                            % Output reconstructed image
                            if dimD == 1
                                imagesOut(:,:,slice,:,fa,echo) = imageReco(:,:,1);
                            else
                                imagesOut(:,:,slice,:,fa,echo) = imageReco;
                            end

                            % Masking of EPI data
                            if strcmp(obj.dataType,'2Depi')
                                for dynamic = 1:ndimD
                                    msk(:,:,1,dynamic,fa,echo) = imresize(squeeze(obj.epiMask(:,:,slice,1)),[size(imagesOut,1) size(imagesOut,2)]);
                                end
                                imagesOut(:,:,slice,:,fa,echo) = imagesOut(:,:,slice,:,fa,echo).*flip(msk,2);
                            end

                            % Report on progress
                            app.progressCounter = app.progressCounter + 1;
                            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                            drawnow;

                        end

                    end

                end

                % Flip dimensions if required
                if obj.PHASE_ORIENTATION == 1
                    imagesOut = flip(imagesOut,1);
                end

                % There seems to be a 1 pixel shift with this reco, correct for this:
                imagesOut = circshift(imagesOut,-1,2);
                imagesOut = circshift(imagesOut,1,1);

                % Make coil sensitivity maps
                for coil = 1:obj.maxCoils
                    if logical(obj.coilActive_flag(coil)) == 1 && coil <= dimC
                        obj.sensitivityMaps{coil} = ones(size(obj.rawKspace{coil}))*obj.coilSensitivities(coil);
                    else
                        obj.sensitivityMaps{coil} = zeros(size(obj.rawKspace{1}));
                    end
                end

            end

            % Return the image objects
            obj.complexImages = imagesOut;
            obj.images = abs(imagesOut);
            obj.phaseImages = angle(imagesOut);
            obj.phaseImagesOrig = angle(imagesOut);

        end % csReco2D





        % ---------------------------------------------------------------------------------
        % Image reconstruction: FFT 2D
        % Oct 2023
        % ---------------------------------------------------------------------------------
        function obj = fftReco2D(obj, app)

            % Dimensions
            dimX = size(obj.rawKspace{1},1);
            dimY = size(obj.rawKspace{1},2);
            dimZ = size(obj.rawKspace{1},3);
            dimD = size(obj.rawKspace{1},4);
            dimF = size(obj.rawKspace{1},5);
            dimE = size(obj.rawKspace{1},6);
            dimC = obj.nrCoils;

            % Requested new dimensions
            ndimx = app.XEditField.Value;
            ndimy = app.YEditField.Value;
            ndimd = dimD;
            if dimD > 1
                ndimd = app.NREditField.Value;
            else
                app.NREditField.Value = 1;
            end

            % Slice interpolation not implemented
            app.ZEditField.Value = dimZ;

            % Kspace data x,y,slice,dynamic,flipangle,echotime,coils
            kSpace = zeros(dimX,dimY,dimZ,dimD,dimF,dimE,dimC);

            % Fill k-space for reconstruction
            for coil = 1:dimC
                kSpace(:,:,:,:,:,:,coil) = obj.rawKspace{coil}*obj.coilActive_flag(coil)/obj.coilSensitivities(coil);
            end

            % Interpolate in the dynamics dimension
            if ndimd ~= dimD
                kSpace = obj.matrixInterpolate(kSpace,[1 1 1 ndimd/dimD 1 1 1],'cubic');
                ndimd = size(kSpace,4);
                app.NREditField.Value = ndimd;
            end

            % Preallocate output images
            imagesOut = zeros(ndimx,ndimy,dimZ,ndimd,dimF,dimE);

            % For EPI data
            if strcmp(obj.dataType,'2Depi')
                [obj, kSpace] = obj.epiCorr(app, kSpace);
            end

            % Initialize progress counter
            app.totalCounter = dimE*dimF*ndimd*dimZ;
            app.progressCounter = 0;

            % Echo loop
            echo = 0;
            while (echo < dimE) && ~app.stopReco_flag
                echo = echo + 1;

                % flip-angle loop
                fa = 0;
                while (fa < dimF) && ~app.stopReco_flag
                    fa = fa + 1;

                    % Dynamic loop
                    dynamic = 0;
                    while (dynamic < ndimd) && ~app.stopReco_flag
                        dynamic = dynamic + 1;

                        % Slice loop
                        slice = 0;
                        while (slice<dimZ) && ~app.stopReco_flag
                            slice = slice + 1;

                            % Input K-space
                            kDataIn = squeeze(kSpace(:,:,slice,dynamic,fa,echo,:));

                            % Homodyne / normal FFT
                            if obj.halfFourier_flag
                                [image2Dhom, phase2Dhom] = homodyne(app,kDataIn,'homodyne');
                            else
                                [image2Dhom, phase2Dhom] = homodyne(app,kDataIn,'none');
                            end

                            % Reintroduce the phase
                            image2D = image2Dhom.*exp(-1i*phase2Dhom);

                            % Zero-fill or crop x-dimension and/or y-dimension
                            if (ndimx ~= dimX) || (ndimy ~= dimY)

                                % Back to k-space
                                kDatai = obj.fft2Dmri(image2D);

                                if ndimx > dimX
                                    padsizex = round((ndimx - dimX)/2);
                                    kDatai = padarray(kDatai,[padsizex,0,0],'both');
                                else
                                    cropsize = round((dimX - ndimx)/2)-1;
                                    cropsize(cropsize<0)=0;
                                    kDatai = kDatai(cropsize+1:end-cropsize,:,:);
                                end

                                if ndimy > dimY
                                    padsizey = round((ndimy - dimY)/2);
                                    kDatai = padarray(kDatai,[0,padsizey,0],'both');
                                else
                                    cropsize = round((dimY - ndimy)/2)-1;
                                    cropsize(cropsize<0)=0;
                                    kDatai = kDatai(:,cropsize+1:end-cropsize,:);
                                end

                                % Make sure dimensions are exactly ndimx, ndimy, coils
                                kDatai = kDatai(1:ndimx,1:ndimy,:);

                                % Back to image space
                                image2D = obj.ifft2Dmri(kDatai);

                            end

                            % Masking of EPI data
                            if strcmp(obj.dataType,'2Depi')
                                for coil = 1:size(image2D,4)
                                    msk(:,:,coil) = imresize(squeeze(obj.epiMask(:,:,slice,coil)),[size(image2D,1) size(image2D,2)]);
                                end
                                image2D = image2D.*msk;
                            end

                            % Coil combine
                            if dimC>1
                                imageTmp(:,:,1,1,:) = image2D;
                                try
                                    image2D = coilCombine_mex(imageTmp);
                                catch
                                    image2D = coilCombine(imagesTmp);
                                end
                             end

                            % Return the image
                            imagesOut(:,:,slice,dynamic,fa,echo) = image2D;

                            % Report on progress
                            app.progressCounter = app.progressCounter + 1;
                            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                            drawnow;

                        end % slice loop

                    end % dynamic loop

                end % flip-angle loop

            end % echo-time loop

            % Flip dimensions if required
            imagesOut = flip(imagesOut,2);
            if obj.PHASE_ORIENTATION == 0
                imagesOut = flip(imagesOut,1);
            end

            % Make coil sensitivity maps
            for coil = 1:obj.maxCoils
                if logical(obj.coilActive_flag(coil)) == 1 && coil <= dimC
                    obj.sensitivityMaps{coil} = ones(size(obj.rawKspace{coil}))*obj.coilSensitivities(coil);
                else
                    obj.sensitivityMaps{coil} = zeros(size(obj.rawKspace{1}));
                end
            end

            % Return the image objects
            obj.complexImages = imagesOut;
            obj.images = abs(imagesOut);
            obj.phaseImages = angle(imagesOut);
            obj.phaseImagesOrig = angle(imagesOut);

        end %fftReco2D




        % ---------------------------------------------------------------------------------
        % Image reconstruction: compressed sensing 3D
        % ---------------------------------------------------------------------------------
        function obj = csReco3D(obj, app)

            % CS regularization parameters
            LambdaWavelet = app.WVxyzEditField.Value;
            TVxyz = app.TVxyzEditField.Value;
            LR = app.LRxyzEditField.Value;
            TVd = app.TVtimeEditField.Value;

            % Dimensions = [X Y slices dynamics, flipangle , echo, slab]
            %               1 2    3      4          5         6     7
            dimX = size(obj.rawKspace{1},1);
            dimY = size(obj.rawKspace{1},2);
            dimZ = size(obj.rawKspace{1},3);
            dimD = size(obj.rawKspace{1},4);
            dimF = size(obj.rawKspace{1},5);
            dimE = size(obj.rawKspace{1},6);
            dimS = size(obj.rawKspace{1},7);
            dimC = obj.nrCoils;

            % Requested dimensions, dimz and dimd can only be interpolated when > 1
            ndimX = app.XEditField.Value;
            ndimY = app.YEditField.Value;
            ndimZ = dimZ;
            if dimZ > 1
                ndimZ = app.ZEditField.Value;
            else
                app.ZEditField.Value = 1;
            end
            ndimD = dimD;
            if dimD > 1
                ndimD = app.NREditField.Value;
            else
                app.NREditField.Value = 1;
            end

            % K-space data x,y,z,dynamics,flip-angles, echo-times, slabs, coils
            kSpace = zeros(dimX,dimY,dimZ,dimD,dimF,dimE,dimS,dimC);

            % Fill k-space for reconstruction
            for coil = 1:dimC
                kSpace(:,:,:,:,:,:,:,coil) = obj.rawKspace{coil}*obj.coilActive_flag(coil)/obj.coilSensitivities(coil);
            end

            if app.bartDetected_flag

                % 3D CS reco with BART

                % Use total variation (TGV takes too long)
                obj.totalVariation = 'T';

                % Resize k-space (kx, ky, kz, dynamics, slab)
                for i=1:obj.nrCoils
                    kSpace = bart(app,['resize -c 0 ',num2str(ndimX),' 1 ',num2str(ndimY),' 2 ',num2str(ndimZ),' 3 ',num2str(ndimD)],kSpace);
                end

                % Bart dimensions
                % 	READ_DIM,       1   z
                % 	PHS1_DIM,       2   y
                % 	PHS2_DIM,       3   x
                % 	COIL_DIM,       4   coils      (8)
                % 	MAPS_DIM,       5   sense maps
                % 	TE_DIM,         6   echo-time  (6)
                % 	COEFF_DIM,      7   flip-angle (5)
                % 	COEFF2_DIM,     8   slab       (7)
                % 	ITER_DIM,       9
                % 	CSHIFT_DIM,     10
                % 	TIME_DIM,       11  dynamics   (4)
                % 	TIME2_DIM,      12
                % 	LEVEL_DIM,      13
                % 	SLICE_DIM,      14  slices
                % 	AVG_DIM,        15

                %         BART index         0  1  2  3  4  5  6  7  8  9  10 11 12 13
                %         Matlab index       1  2  3  4  5  6  7  8  9  10 11 12 13 14
                kSpacePics = permute(kSpace,[3  2  1  8  10 6  5  7  9  11 4  12 13 14]);

                if (nnz(obj.coilActive_flag) > 1) && (app.AutoSensitivityCheckBox.Value == 1)

                    % ESPIRiT reconstruction
                    TextMessage(app,'ESPIRiT reconstruction ...');

                    % Calculate coil sensitivity maps with ecalib bart function, per slice, per dynamic
                    app.TextMessage("Ecalib coil sensitivity estimation ...");
                    sensitivities = zeros(ndimZ,ndimY,ndimX,dimC,1,1,1,1,1,1,ndimD,1,1,1);
                    sensitivities(:,:,:,logical(obj.coilActive_flag),1,1,1,1,1,1,:,1,1,1) = bart(app,'ecalib -d1 -S -I -a -m1', kSpacePics(:,:,:,logical(obj.coilActive_flag),1,1,1,1,1,1,:,1,1,1));

                else

                    sensitivities = zeros(ndimZ,ndimY,ndimX,dimC,1,1,1,1,1,1,ndimD,1,1,1);
                    for coil = 1:obj.maxCoils
                        if logical(obj.coilActive_flag(coil))
                            sensitivities(:,:,:,coil,1,1,1,1,1,1,:,1,1,1) = obj.coilSensitivities(coil);
                        end
                    end

                end

                % Construct the sensitivity maps for the app {coil} x, y, z, dynamics, flip-angle, echo-time, slab, coils ...
                senseMap = permute(abs(sensitivities),[3 2 1 11 7 6 8 4 5 9 10 12 13 14]);
                senseMap = senseMap/max(senseMap(:));
                senseMap = flip(flip(senseMap,3),2);
                if obj.PHASE_ORIENTATION == 0
                    senseMap = flip(senseMap,1);
                end
                for coil = 1:obj.maxCoils
                    for echo = 1:dimE
                        for fa = 1:dimF
                            if (logical(obj.coilActive_flag(coil)) == 1) && (coil <= dimC)
                                obj.sensitivityMaps{coil}(:,:,:,:,fa,echo) = senseMap(:,:,:,:,1,1,1,coil,1,1,1,1,1,1);
                            else
                                obj.sensitivityMaps{coil}(:,:,:,:,fa,echo) = zeros(size(senseMap(:,:,:,:,1,1,1,1,1,1,1,1,1,1,1)));
                            end
                        end
                    end
                end

                % Wavelet and TV in spatial dimensions 2^0+2^1+2^2=7
                % total variation in time 2^10 = 1024

                % PICS command
                picsCommand = 'pics -S';
                if LambdaWavelet>0
                    picsCommand = [picsCommand, ' -RW:7:0:',num2str(LambdaWavelet)];
                end
                if TVxyz>0
                    picsCommand = [picsCommand, ' -R',obj.totalVariation,':7:0:',num2str(TVxyz)];
                end
                if LR>0
                    % Locally low-rank in the spatial domain
                    blockSize = round(max([dimX dimY dimZ])/16);  % Block size
                    app.TextMessage(strcat('Low-rank block size =',{' '},num2str(blockSize)));
                    picsCommand = [picsCommand, ' -RL:7:7:',num2str(LR)];
                end
                if TVd>0
                    picsCommand = [picsCommand, ' -R',obj.totalVariation,':1024:0:',num2str(TVd)];
                end

                % PICS reconstruction
                imageReco = zeros(ndimZ,ndimY,ndimX,1,1,dimE,dimF,dimS,1,1,ndimD,1,1,1);

                app.TextMessage("PICS reconstruction ...");

                % Initialize progress counter
                app.totalCounter = dimE*dimF*dimS;
                app.progressCounter = 0;

                slab = 0;
                while (slab < dimS) && ~app.stopReco_flag
                    slab = slab + 1;

                    echo = 0;
                    while (echo < dimE) && ~app.stopReco_flag
                        echo = echo + 1;

                        fa = 0;
                        while (fa < dimF) && ~app.stopReco_flag
                            fa = fa + 1;

                            % Bart reco
                            k = kSpacePics(:,:,:,:,1,echo,fa,slab,1,1,:,1,1,1);
                            s = sensitivities(:,:,:,:,1,1,1,1,1,1,:,1,1,1);
                            imageReco(:,:,:,1,1,echo,fa,slab,1,1,:,1,1,1) = bart(app,picsCommand,k,s);

                            % Report on progress
                            app.progressCounter = app.progressCounter + 1;
                            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                            drawnow;

                        end

                    end

                end

                % Rearrange to correct orientation: x, y, z, dynamics, flip-angle, echo-time, slab
                imageSlab = permute(imageReco,[3 2 1 11 7 6 8 4 5 9 10 12 13 14]);

                % Flip dimensions to correct orientation
                imageSlab = flip(flip(imageSlab,3),2);
                if obj.PHASE_ORIENTATION == 0
                    imageSlab = flip(imageSlab,1);
                end

            else

                % 3D CS reco in MATLAB

                app.TextMessage('WARNING: Bart toolbox not available, slow reconstruction ...');

                % Interpolate in the dynamics dimension
                if ndimD ~= dimD
                    kSpace = obj.matrixInterpolate(kSpace,[1 1 1 ndimD/dimD 1 1 1 1],'cubic');
                    ndimD = size(kSpace,4);
                    app.NREditField.Value = ndimD;
                end

                % Preallocate output images
                imageSlab = zeros(ndimX,ndimY,ndimZ,ndimD,dimF,dimE,dimS);

                % Initialize progress counter
                app.totalCounter = dimS*dimE*dimF;
                app.progressCounter = 0;

                % Slab loop
                slab = 0;
                while (slab < dimS) && ~app.stopReco_flag
                    slab = slab + 1;

                    % Echo loop
                    echo = 0;
                    while (echo < dimE) && ~app.stopReco_flag
                        echo = echo + 1;

                        % flip-angle loop
                        fa = 0;
                        while (fa < dimF) && ~app.stopReco_flag
                            fa = fa + 1;

                            % Fool the reco if dimd = 1, it needs at least 2 dynamics
                            if ndimD == 1
                                kSpace(:,:,:,2,fa,echo,slab,:) = kSpace(:,:,:,1,fa,echo,slab,:);
                                kData = zeros(dimX,dimY,dimZ,2,dimC);
                                kMask = zeros(dimX,dimY,dimZ,2);
                            else
                                kData = zeros(dimX,dimY,ndimD,dimC);
                                kMask = zeros(dimX,dimY,ndimD);
                            end

                            % Kspace of slab
                            kData(:,:,:,:,:) = kSpace(:,:,:,:,fa,echo,slab,:);
                            kMask(:,:,:,:) = logical(abs(kSpace(:,:,:,:,fa,echo,slab,1)));

                            % Zero-fill or crop x-dimension
                            if ndimX > dimX
                                padSizeX = round((ndimX - dimX)/2);
                                kDatai = padarray(kData,[padSizeX,0,0,0,0],'both');
                                maski = padarray(kMask,[padSizeX,0,0,0],'both');
                            else
                                cropSize = round((dimX - ndimX)/2)-1;
                                cropSize(cropSize<0)=0;
                                kDatai = kData(cropSize+1:end-cropSize,:,:,:,:);
                                maski = kMask(cropSize+1:end-cropSize,:,:,:);
                            end

                            % Zero-fill or crop y-dimension
                            if ndimY > dimY
                                padSizeY = round((ndimY - dimY)/2);
                                kDatai = padarray(kDatai,[0,padSizeY,0,0,0],'both');
                                maski = padarray(maski,[0,padSizeY,0,0],'both');
                            else
                                cropSize = round((dimY - ndimY)/2)-1;
                                cropSize(cropSize<0)=0;
                                kDatai = kDatai(:,cropSize+1:end-cropSize,:,:,:);
                                maski = maski(:,cropSize+1:end-cropSize,:,:);
                            end

                            % Zero-fill or crop z-dimension
                            if ndimZ > dimZ
                                padSizeZ = round((ndimZ - dimZ)/2);
                                kDatai = padarray(kDatai,[0,0,padSizeZ,0,0],'both');
                                maski = padarray(maski,[0,0,padSizeZ,0],'both');
                            else
                                cropSize = round((dimZ - ndimZ)/2)-1;
                                cropSize(cropSize<0)=0;
                                kDatai = kDatai(:,:,cropSize+1:end-cropSize,:,:);
                                maski = maski(:,:,cropSize+1:end-cropSize,:);
                            end

                            % Make sure dimensions are exactly ndimx, ndimy, ndimz
                            kDatai = kDatai(1:ndimX,1:ndimY,1:ndimZ,:,:);
                            maski = maski(1:ndimX,1:ndimY,1:ndimZ,:);

                            % Normalize the data in the range of approx 0 - 1 for better numerical stability
                            kDatai = kDatai/max(abs(kDatai(:)));

                            % Coil sensitivity map
                            for coil = 1:dimC
                                b1(:,:,:,coil) = ones(ndimX,ndimY,ndimZ)*obj.coilSensitivities(coil);
                            end

                            % Data
                            param.y = kDatai;

                            % Reconstruction design matrix
                            param.E = Emat_zyxt(maski,b1);

                            % Total variation (TV) constraint in the temporal domain & Wavelet in spatial domain
                            param.TV = TVOP3D;
                            param.TVWeight = TVd/10;

                            % Wavelet
                            param.W = Wavelet('Daubechies',12,12);
                            param.L1Weight = LambdaWavelet;

                            % Number of iterations, 2 x 5 iterations
                            param.nite = 5;
                            param.nouter = 1;

                            % Linear reconstruction
                            kDataLin = randn(size(kDatai))/2000 + kDatai;  % add a little bit of randomness, such that linear reco is not exactly right
                            reconDFT = param.E'*kDataLin;

                            % Iterative reconstruction
                            reconCS = reconDFT;
                            for n = 1:param.nouter
                                reconCS = CSL1NlCg(reconCS,param);
                            end
                            imageTmp = reconCS;

                            % Output reconstructed image
                            if dimD == 1
                                imageOut(:,:,:,:,fa,echo,slab) = imageTmp(:,:,:,1);
                            else
                                imageOut(:,:,:,:,fa,echo,slab) = imageTmp(:,:,:,:);
                            end

                            % Flip dimensions to correct orientation
                            if obj.PHASE_ORIENTATION == 1
                                imageOut = flip(imageOut,1);
                            end

                            % Images are shifted by 1 pixel in each dimension,
                            % could use tweaking
                            imageOut = circshift(imageOut,1,1);
                            imageOut = circshift(imageOut,-1,2);
                            imageOut = circshift(imageOut,1,3);

                            % Return the images object
                            imageSlab(:,:,:,:,fa,echo,slab) = imageOut(:,:,:,:,fa,echo,slab);

                            % Report on progress
                            app.progressCounter = app.progressCounter + 1;
                            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                            drawnow;

                        end % flip-angle loop

                    end % echo-time loop

                end % slab loop

                % Make coil sensitivity maps
                for coil = 1:obj.maxCoils
                    if logical(obj.coilActive_flag(coil)) == 1 && coil <= dimC
                        obj.sensitivityMaps{coil} = ones(size(imageSlab))*obj.coilSensitivities(coil);
                    else
                        obj.sensitivityMaps{coil} = zeros(size(imageSlab));
                    end
                end

            end % bart/matlab reco

            % Combine slabs with overlap if present
            if dimS > 1

                nrDiscard = round(-0.5*ndimZ*obj.SQLsliceGap/obj.SLICE_THICKNESS);
                overlap = app.SlabOverlapEditField.Value;
                if overlap > nrDiscard
                    overlap = nrDiscard;
                    app.SlabOverlapEditField.Value = overlap;
                    app.TextMessage(sprintf('WARNING: Max slab overlap = %d pixels ...',overlap));
                end
                nrDiscard = nrDiscard - overlap;

                imageSlab(:,:,ndimZ-nrDiscard+1:ndimZ,:,:,:,:) = [];
                imageSlab(:,:,1:nrDiscard,:,:,:,:) = [];
                avgSlab = ones(size(imageSlab));

                % Resulting image size + 2 * overlap on the image borders
                dimzs = size(imageSlab,3);
                totalDimzs = dimS*dimzs - 2*dimS*overlap + 2*overlap;

                imageMultiSlab = zeros(ndimX,ndimY,totalDimzs,ndimD,dimF,dimE);
                avgMultiSlab = zeros(ndimX,ndimY,totalDimzs,ndimD,dimF,dimE);

                % Concatenate the overlapping matrices
                z1 = 1;
                for slab = 1:dimS
                    z2 = z1 + dimzs;
                    imageMultiSlab(:,:,z1:z2-1,:,:,:) = imageMultiSlab(:,:,z1:z2-1,:,:,:) + imageSlab(:,:,:,:,:,:,slab);
                    avgMultiSlab(:,:,z1:z2-1,:,:,:) = avgMultiSlab(:,:,z1:z2-1,:,:,:) + avgSlab(:,:,:,:,:,:,slab);
                    z1 = z2 - 2*overlap;
                end

                % Average the overlap
                imageMultiSlab = imageMultiSlab./avgMultiSlab;

                % Remove the overlap on the multi-slab beginning and end
                imagesOut = imageMultiSlab(:,:,overlap+1:end-overlap,:,:,:);

            else

                % Only 1 image slab
                imagesOut = imageSlab(:,:,:,:,:,:,1);

            end

            % Return the image objects
            obj.complexImages = imagesOut;
            obj.images = abs(imagesOut);
            obj.phaseImages = angle(imagesOut);
            obj.phaseImagesOrig = angle(imagesOut);

        end % csReco3D






        % ---------------------------------------------------------------------------------
        % Image reconstruction: FFT 3D
        % ---------------------------------------------------------------------------------
        function obj = fftReco3D(obj, app)

            % Dimensions = {coil}[X Y slices dynamics, flip-angle , echo-time, slab]
            %                     1 2    3      4         5            6         7
            dimX = size(obj.rawKspace{1},1);
            dimY = size(obj.rawKspace{1},2);
            dimZ = size(obj.rawKspace{1},3);
            dimD = size(obj.rawKspace{1},4);
            dimF = size(obj.rawKspace{1},5);
            dimE = size(obj.rawKspace{1},6);
            dimS = size(obj.rawKspace{1},7);
            dimC = obj.nrCoils;

            % Requested dimensions
            ndimX = app.XEditField.Value;
            ndimY = app.YEditField.Value;
            ndimZ = dimZ;
            if dimZ > 1
                ndimZ = app.ZEditField.Value;
            else
                app.ZEditField.Value = 1;
            end
            ndimd = dimD;
            if dimD > 1
                ndimd = app.NREditField.Value;
            else
                app.NREditField.Value = 1;
            end

            % K-space data x,y,z,dynamics,flip-angles, echo-times, slabs, coils
            kSpace = zeros(dimX,dimY,dimZ,dimD,dimF,dimE,dimS,dimC);

            % Fill k-space for reconstruction
            for coil = 1:dimC
                kSpace(:,:,:,:,:,:,:,coil) = obj.rawKspace{coil}*obj.coilActive_flag(coil)/obj.coilSensitivities(coil);
            end

            % Interpolate in the dynamics dimension
            if ndimd ~= dimD
                kSpace = obj.matrixInterpolate(kSpace,[1 1 1 ndimd/dimD 1 1 1 1],'cubic');
                ndimd = size(kSpace,4);
                app.NREditField.Value = ndimd;
            end

            % Preallocate output images
            imageSlab = zeros(ndimX,ndimY,ndimZ,ndimd,dimF,dimE,dimS);

            % Initialize progress counter
            app.totalCounter = dimS*dimE*dimF*ndimd;
            app.progressCounter = 0;

            % Slab loop
            slab = 0;
            while (slab < dimS) && ~app.stopReco_flag
                slab = slab + 1;

                % Echo loop
                echo = 0;
                while (echo < dimE) && ~app.stopReco_flag
                    echo = echo + 1;

                    % flip-angle loop
                    fa = 0;
                    while (fa < dimF) && ~app.stopReco_flag
                        fa = fa + 1;

                        % Dynamic loop
                        dynamic = 0;
                        while (dynamic < ndimd) && ~app.stopReco_flag
                            dynamic = dynamic + 1;

                            % Kspace of dynamic
                            kDataIn = squeeze(kSpace(:,:,:,dynamic,fa,echo,slab,:));

                            % Zero-fill or crop x-dimension
                            if ndimX > dimX
                                padSizex = round((ndimX - dimX)/2);
                                kDatai = padarray(kDataIn,[padSizex,0,0],'both');
                            else
                                cropSize = round((dimX - ndimX)/2)-1;
                                cropSize(cropSize<0)=0;
                                kDatai = kDataIn(cropSize+1:end-cropSize,:,:,:);
                            end

                            % Zero-fill or crop y-dimension
                            if ndimY > dimY
                                padSizey = round((ndimY - dimY)/2);
                                kDatai = padarray(kDatai,[0,padSizey,0],'both');
                            else
                                cropSize = round((dimY - ndimY)/2)-1;
                                cropSize(cropSize<0)=0;
                                kDatai = kDatai(:,cropSize+1:end-cropSize,:,:);
                            end

                            % Zero-fill or crop z-dimension
                            if ndimZ > dimZ
                                padSizez = round((ndimZ - dimZ)/2);
                                kDatai = padarray(kDatai,[0,0,padSizez],'both');
                            else
                                cropSize = round((dimZ - ndimZ)/2)-1;
                                cropSize(cropSize<0)=0;
                                kDatai = kDatai(:,:,cropSize+1:end-cropSize,:);
                            end

                            % Make sure dimensions are exactly ndimx, ndimy, coils
                            kDatai = kDatai(1:ndimX,1:ndimY,1:ndimZ,:);

                            % 3D FFT
                            image3D = obj.fft3Dmri(kDatai);

                            % Sum of squares coil dimension
                            image3D = rssq(image3D,4);

                            % Return the image
                            imageSlab(:,:,:,dynamic,fa,echo,slab) = image3D;

                            % Report on progress
                            app.progressCounter = app.progressCounter + 1;
                            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                            drawnow;

                        end % dynamic loop

                    end % flip-angle loop

                end % echo-time loop

            end % slab loop

            % Flip dimensions to correct orientation
            imageSlab = flip(flip(imageSlab,3),2);
            if obj.PHASE_ORIENTATION == 0
                imageSlab = flip(imageSlab,1);
            end

            % Combine slabs with overlap if present
            if dimS > 1

                nrDiscard = round(-0.5*ndimZ*obj.SQLsliceGap/obj.SLICE_THICKNESS);
                overlap = app.SlabOverlapEditField.Value;
                if overlap > nrDiscard
                    overlap = nrDiscard;
                    app.SlabOverlapEditField.Value = overlap;
                    app.TextMessage(sprintf('WARNING: Max slab overlap = %d pixels ...',overlap));
                end
                nrDiscard = nrDiscard - overlap;

                imageSlab(:,:,ndimZ-nrDiscard+1:ndimZ,:,:,:,:) = [];
                imageSlab(:,:,1:nrDiscard,:,:,:,:) = [];
                avgSlab = ones(size(imageSlab));

                % Resulting image size + 2 * overlap on the image borders
                dimzs = size(imageSlab,3);
                totalDimzs = dimS*dimzs - 2*dimS*overlap + 2*overlap;

                imageMultiSlab = zeros(ndimX,ndimY,totalDimzs,ndimd,dimF,dimE);
                avgMultiSlab = zeros(ndimX,ndimY,totalDimzs,ndimd,dimF,dimE);

                % Concatenate the overlapping matrices
                z1 = 1;
                for slab = 1:dimS
                    z2 = z1 + dimzs;
                    imageMultiSlab(:,:,z1:z2-1,:,:,:) = imageMultiSlab(:,:,z1:z2-1,:,:,:) + imageSlab(:,:,:,:,:,:,slab);
                    avgMultiSlab(:,:,z1:z2-1,:,:,:) = avgMultiSlab(:,:,z1:z2-1,:,:,:) + avgSlab(:,:,:,:,:,:,slab);
                    z1 = z2 - 2*overlap;
                end

                % Average the overlap
                imageMultiSlab = imageMultiSlab./avgMultiSlab;

                % Remove the overlap on the multi-slab beginning and end
                imagesOut = imageMultiSlab(:,:,overlap+1:end-overlap,:,:,:);

            else

                % Only 1 image slab
                imagesOut = imageSlab(:,:,:,:,:,:,1);

            end

            % Make coil sensitivity maps
            for coil = 1:obj.maxCoils
                if logical(obj.coilActive_flag(coil)) == 1 && coil <= dimC
                    obj.sensitivityMaps{coil} = ones(size(obj.rawKspace{coil}))*obj.coilSensitivities(coil);
                else
                    obj.sensitivityMaps{coil} = zeros(size(obj.rawKspace{1}));
                end
            end

            % Return the image objects
            obj.complexImages = imagesOut;
            obj.images = abs(imagesOut);
            obj.phaseImages = angle(imagesOut);
            obj.phaseImagesOrig = angle(imagesOut);

        end % fftReco3D




        % ---------------------------------------------------------------------------------
        % Image reconstruction: compressed sensing 2D Radial
        % ---------------------------------------------------------------------------------
        function obj = Reco2DRadialCS(obj, app)

            % CS regularization parameters
            LW = app.WVxyzEditField.Value;
            TVxyz = app.TVxyzEditField.Value;
            LR = app.LRxyzEditField.Value;
            TVd = app.TVtimeEditField.Value;
         
            % Dimensions
            dimR = size(obj.rawKspace{1},1);    % Readout
            dimS = size(obj.rawKspace{1},2);    % Spokes
            dimZ = size(obj.rawKspace{1},3);    % Slices
            dimD = size(obj.rawKspace{1},4);    % Dynamics
            dimF = size(obj.rawKspace{1},5);    % Flip-angles
            dimE = size(obj.rawKspace{1},6);    % Echo-times
            dimC = obj.nrCoils;                 % Coils

            % Requested new dimensions
            ndimX = app.XEditField.Value;
            if rem(ndimX,2)
                ndimX = ndimX + 1;
                app.XEditField.Value = ndimX;
            end
            ndimY = app.YEditField.Value;
            if rem(ndimY,2)
                ndimY = ndimY + 1;
                app.YEditField.Value = ndimY;
            end
            ndimD = dimD;
            if dimD > 1
                ndimD = app.NREditField.Value;
            else
                app.NREditField.Value = 1;
            end

            % Slice interpolation not implemented
            app.ZEditField.Value = dimZ;

            % Kspace data x,y,slice,dynamic,flipangle,echotime,coils
            kSpace = zeros(dimR,dimS,dimZ,dimD,dimF,dimE,dimC);

            % Fill k-space for reconstruction
            for coil = 1:dimC
                kSpace(:,:,:,:,:,:,coil) = obj.rawKspace{coil};
            end

            % Averages
            averages = obj.nsaSpace;
         
            % Initialize progress counter
            app.RecoProgressGauge.Value = 0;
            app.totalCounter = dimE*dimF*dimD*dimZ + 5*dimE*dimF*dimZ + app.DensityCorrectCheckBox.Value*dimE*dimF*dimD*dimZ + ...
                (nnz(obj.coilActive_flag)>1)*app.AutoSensitivityCheckBox.Value*dimZ;
            app.progressCounter = 0;

            % Center echo and/or phase correction, tukey filter
            app.TextMessage("Preparing data for reconstruction ....");
            tukFilter = tukeywin(dimR,2*obj.tukeyFilterWidth);
            interpFactor = 4;
            centerEchoFlag = app.CenterEchoCheckBox.Value;
            phaseCorrectionFlag = app.PhaseCorrectCheckBox.Value;
            amplitudeFlag = app.AmplitudeCorrectionCheckBox.Value;
            tukeyFlag = app.TukeyFilterCheckBox.Value;
            middle = floor(dimR/2);

            for echo = 1:dimE

                for fa = 1:dimF

                    for dynamic = 1:dimD

                        for slice = 1:dimZ

                            meanKspace = 1; % otherwise parfor does not start
                            if amplitudeFlag
                                mm1 = abs(kSpace(:,:,slice,dynamic,fa,echo,:));
                                mm2 = max(mm1);
                                meanKspace = mean(mm2(:));
                            end
               
                            for coil = 1:dimC

                                parfor spoke = 1:dimS

                                    if centerEchoFlag
                                        tmpKline1 = kSpace(:,spoke,slice,dynamic,fa,echo,coil);
                                        tmpKline2 = interp(tmpKline1,interpFactor);
                                        [~,kCenter] = max(abs(tmpKline2));
                                        kShift = middle-kCenter/interpFactor;
                                        kSpace(:,spoke,slice,dynamic,fa,echo,coil) = fraccircshift(tmpKline1,kShift);
                                    end

                                    if phaseCorrectionFlag
                                        tmpKline1 = kSpace(:,spoke,slice,dynamic,fa,echo,coil);
                                        kCenterPhase = angle(tmpKline1(middle+1));
                                        tmpKline1 = tmpKline1.*exp(-1j.*kCenterPhase);
                                        kSpace(:,spoke,slice,dynamic,fa,echo,coil) = tmpKline1;
                                    end

                                    if amplitudeFlag
                                        tmpKline1 = kSpace(:,spoke,slice,dynamic,fa,echo,coil);
                                        kSpace(:,spoke,slice,dynamic,fa,echo,coil) = meanKspace*tmpKline1/max(abs(tmpKline1(:)));
                                    end

                                    if tukeyFlag
                                        kSpace(:,spoke,slice,dynamic,fa,echo,coil) = kSpace(:,spoke,slice,dynamic,fa,echo,coil).*tukFilter;
                                    end

                                end

                            end

                            % Report on progress
                            app.progressCounter = app.progressCounter + 1;
                            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                            drawnow;

                        end

                    end

                end

            end

            % Corrected k-space
            for coil = 1:dimC
                obj.rawKspace{coil} = kSpace(:,:,:,:,:,:,coil);
            end
            obj = obj.scaleKspace;

            % Re-estimate global coil sensitivities
            if (nnz(obj.coilActive_flag) > 1) && (app.AutoSensitivityCheckBox.Value == 1)
                obj = obj.estimateCoilSensitivies(app);
            end

            % Apply global coil sensitivity correction
            for coil = 1:dimC
                kSpace(:,:,:,:,:,:,coil) = obj.rawKspace{coil}*obj.coilActive_flag(coil)/obj.coilSensitivities(coil);
            end

            % Calibration and density correction size
            kdim = round(dimR/2);
            kdim(kdim < 32) = 32;
            calibSize = [kdim, kdim, 1];
            cSize = ['-d',num2str(calibSize(1)),':',num2str(calibSize(2)),':1'];
            app.TextMessage(strcat("K-space calibration size = ",num2str(kdim),"x",num2str(kdim)," ..."));

            % Make the radial trajectory 0-180 degrees
            % Could be extended with different trajectories if available
            traj = obj.twoDradialTrajectory(dimR, dimS, dimZ, dimD, dimF, dimE);

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

            %           1      2        3        4          5           6        7
            % Initially x, y(spokes), slices, dynamics, flip-angle, echo-time, coils

            %                            1 readout spokes
            % Rearrange for BART         1  2  3  4  5  6  7  8  9 10 11 12 13 14
            kSpacePics = permute(kSpace,[8, 1, 2, 7, 9, 6, 5,10,11,12,13,4 ,14, 3]);

            % Rearrange for BART        1  2  3  4  5  6  7  8  9 10 11 12 13 14
            avgPics = permute(averages,[8, 1, 2, 7, 9, 6, 5,10,11,12,13,4, 14, 3]);

            % Rearrange for BART     1  2  3  4  5  6  7  8  9 10 11 12 13 14
            trajPics = permute(traj,[1, 2, 3, 8, 9, 7, 6,10,11,12,13, 5,14,4]);

            % Gradient delay vector from app
            dTotal(1) = app.GxDelayEditField.Value;
            dTotal(2) = app.GyDelayEditField.Value;
            dTotal(3) = app.GzDelayEditField.Value;
            app.DataOffsetRadialEditField.Value = 0;

            % Gradient delay calibration
            if app.GradDelayCalibrationCheckBox.Value
          
                kSpacePicsRing = kSpacePics(1,:,:,:,1,1,1,1,1,1,1,floor(dimD/2)+1,1,floor(dimZ/2)+1);
                trajPicsRing = trajPics(:,:,:,1,1,1,1,1,1,1,1,floor(dimD/2)+1,1,floor(dimZ/2)+1);

                % Ring method
                if app.RingMethodCheckBox.Value

                    % Sent gradient delay vector back to app
                    app.GxDelayEditField.Value = 0;
                    app.GyDelayEditField.Value = 0;
                    app.GzDelayEditField.Value = 0;

                    % Ring method using estdelay in Bart
                    try

                        dTotal = [];

                        delaysBart = bart(app,'estdelay -r5 ',trajPicsRing,kSpacePicsRing);

                        % Remove unkown warning
                        ff = strfind(delaysBart,"[0m");
                        if ~isempty(ff)
                            delaysBart = delaysBart(ff:end);
                            delaysBart = erase(delaysBart,"[0m");
                            delaysBart = erase(delaysBart,newline);
                        end

                        delaysBart = strrep(delaysBart,':',',');
                        dTotal = -str2num(delaysBart);

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
                        kSize = [10,10];
                        kSkip = round(length(kSpacePicsRing)/2000);
                        kSkip(kSkip < 1) = 1;

                        % M1:M2 = indices in trajectory for which k-space value <= calibSize
                        [~,zm] = find(squeeze(trajPicsRing(1,:,:)) == max(trajPicsRing(:)),1,'first');
                        if isempty(zm)
                            [~,zm] = find(squeeze(trajPicsRing(2,:,:)) == max(trajPicsRing(:)),1,'first');
                        end
                        M = find(sqrt(trajPicsRing(1,:,zm).^2+trajPicsRing(2,:,zm).^2) <= calibSize(1)/2);
                        M1 = M(1);
                        M2 = M(end);

                        % Reduce size for gradient calibration
                        kTrajCalib = trajPicsRing(:,M1:M2,1:kSkip:end);
                        dataCalib = kSpacePicsRing(1,M1:M2,1:kSkip:end);
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
                        app.TextMessage(strcat("Rank = ",num2str(rank)));

                        % Data consistency
                        spoke = squeeze(dataCalib);
                        xOld = kCalib;

                        % Prepare for manual stop
                        app.stopGradCal_flag = false;

                        % Iterative method with Bart
                        while  (iteration<50) && (incre>0.001) && ~app.stopGradCal_flag

                            % Iteration number
                            iteration = iteration + 1;
                            app.TextMessage(strcat('Iteration:',{' '},num2str(iteration)));

                            % Solve for X
                            rank(rank>prod(kSize)) = prod(kSize);
                            xNew = obj.lowRankThresh2D(xOld,kSize,rank);
                            rank = rank+0.05;
                            % app.TextMessage(strcat('Rank :',{' '},num2str(rank)));

                            % NUFFT to get updated k-space data
                            kNew = obj.ifft2Dmri(xNew);
                            dataCalib = bart(app,'bart nufft -l 0.05',kTraj,kNew);
                            kNew  = reshape(dataCalib,[M2-M1+1 size(kTrajCalib,3) 1]);

                            % Partial derivatives
                            [dydtx,dydty] = obj.partialDerivative2D(app,kTraj,xNew,calibSize);

                            % Direct solver
                            dydt = [real(obj.vec(dydtx)) real(obj.vec(dydty)) ; imag(obj.vec(dydtx)) imag(obj.vec(dydty))];
                            dStep = ((dydt)'*dydt)\(dydt' * [real(obj.vec(kNew - spoke)) ; imag(obj.vec(kNew - spoke))]);
                            dStep(isnan(dStep)) = 0;

                            % The accumalated delays
                            dTotal(1) = dTotal(1) + real(dStep(1));
                            dTotal(2) = dTotal(2) + real(dStep(2));
                            dTotal(dTotal > 10) = 10;
                            dTotal(dTotal < -10) = -10;

                            % Conversion criterium
                            incre = norm(real(dStep));

                            % Message
                            app.TextMessage(strcat("Estimated delays ",num2str(dTotal(1))," : ",num2str(dTotal(2))));

                            % Sent gradient delay vector back to app
                            app.GxDelayEditField.Value = double(round(dTotal(1),5));
                            app.GyDelayEditField.Value = double(round(dTotal(2),5));
                            app.GzDelayEditField.Value = 0;
                            drawnow;

                            % Interpolation to update trajectory with new delays
                            kTraj = obj.trajInterpolation(kTrajCalib,dTotal);

                            % The new image with k-space updated for gradient delays
                            imCalib = bart(app,['bart nufft -i -l 0.05 ',cSize,' -t'],kTraj,reshape(spoke,[1 M2-M1+1 size(kTrajCalib,3) 1]));

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
                        app.GxDelayEditField.Value = double(round(dTotal(1),5));
                        app.GyDelayEditField.Value = double(round(dTotal(2),5));
                        app.GzDelayEditField.Value = double(round(dTotal(3),5));

                    end

                end

                % Reset calibration button
                app.GradDelayCalibrationCheckBox.Value = 0;
                app.stopGradCal_flag = true;

            end % Gradient calibration

            % Final gradient delay correction from optimization or values from app
            trajPics = permute(trajPics,[1 2 3 12 14 6 7 4 5 8 9 10 11 13]);
            trajPics = obj.trajInterpolation(trajPics,dTotal);
            trajPics = ipermute(trajPics,[1 2 3 12 14 6 7 4 5 8 9 10 11 13]);

            % Density correction
            if app.DensityCorrectCheckBox.Value

                app.TextMessage('Calculating density correction ...');

                % Make sure densityOnes contains only 1's when data is available
                densityOnes = ones(size(kSpacePics));
                densityOnes = densityOnes(:,:,:,1,:,:,:,:,:,:,:,:,:,:).*avgPics(:,:,:,1,:,:,:,:,:,:,:,:,:,:);
                densityOnes(densityOnes > 1) = 1;

                for echo = 1:dimE
                    for fa = 1:dimF
                        for dynamic = 1:dimD
                            for slice = 1:dimZ

                                d = densityOnes(:,:,:,1,1,echo,fa,1,1,1,1,dynamic,1,slice);
                                t = trajPics(:,:,:,1,1,echo,fa,1,1,1,1,dynamic,1,slice);

                                densityTmp = bart(app,strcat('nufft -d',num2str(dimR),':',num2str(dimS),':1 -a'),t,d);
                                densityTmp = bart(app,'nufft ',t,densityTmp);
                                densityTmp = densityTmp.^(-1/2);
                                densityTmp(isnan(densityTmp)) = 0;
                                densityTmp(isinf(densityTmp)) = 0;
                                densityPics(:,:,:,1,1,echo,fa,1,1,1,1,dynamic,1,slice) = densityTmp;

                                % Report on progress
                                app.progressCounter = app.progressCounter + 1;
                                app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                                drawnow;

                            end
                        end
                    end
                end

            end

            % Coils sensitivity maps
            if (nnz(obj.coilActive_flag) > 1) && (app.AutoSensitivityCheckBox.Value == 1)

                % ESPIRiT reconstruction
                TextMessage(app,'ESPIRiT reconstruction ...');

                % Calculate coil sensitivity maps with ecalib bart function, per slice
                app.TextMessage('Calculating coil sensitivity maps ...');
           
                % Pre-allocate
                sensitivities = ones(dimR,dimR,1,dimC,1,1,1,1,1,1,1,dimD,1,dimZ);
           
                for slice = 1:dimZ

                    kSpacePicsSense = kSpacePics(:,:,:,:,:,1,1,:,:,:,:,end,:,slice);
                    trajPicsSense = trajPics(:,:,:,:,:,1,1,:,:,:,:,end,:,slice);

                    try

                        % Convert to cartesian k-space by nufft reconstruction
                        for coil = 1:dimC
                            lowResImage = bart(app,['nufft -i -l2 ',cSize,' -t'], trajPicsSense, kSpacePicsSense(1,:,:,coil));
                            lowResKspace = bart(app,'fft -u 7', lowResImage);
                            kSpaceZeroFilled(1,:,:,coil) = bart(app,['resize -c 0 ',num2str(dimR),' 1 ',num2str(dimR)], lowResKspace);
                        end

                        % Calculate the senstivity maps
                        sense = bart(app,'ecalib -d2 -S -I -a -m1', kSpaceZeroFilled);

                    catch ME
                        
                        app.TextMessage(ME.message);
                        app.TextMessage("Coil sensitivity error, using uniform sensitivities ...");
                        sense = zeros(1,dimR,dimR,dimC);
                        for coil = 1:obj.maxCoils
                            if logical(obj.coilActive_flag(coil))
                                sense(1,:,:,coil) = obj.coilSensitivities(coil);
                            end
                        end

                    end

                    for dynamic = 1:dimD
                        sensitivities(:,:,1,:,1,1,1,1,1,1,1,dynamic,1,slice) = sense(1,:,:,:);
                    end

                    % Report on progress
                    app.progressCounter = app.progressCounter + 1;
                    app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                    drawnow;

                end

            else

                sensitivities = zeros(dimR,dimR,1,dimC,1,1,1,1,1,1,1,dimD,1,dimZ);
                for coil = 1:obj.maxCoils
                    if logical(obj.coilActive_flag(coil))
                        sensitivities(:,:,1,coil,1,1,1,1,1,1,1,:,1,:) = obj.coilSensitivities(coil);
                    end
                end

            end
       
            % Construct the sensitivity maps for the app {coil} x, y, slices, dynamics, fa, echo ...
            senseMap = abs(sensitivities);
            senseMap = senseMap/max(senseMap(:));
            if obj.PHASE_ORIENTATION == 0
                senseMap = flip(flip(senseMap,2),1);
            end

            for coil = 1:obj.maxCoils
                for echo = 1:dimE
                    for fa = 1:dimF
                        for dynamic = 1:dimD
                            for slice = 1:dimZ
                                if (logical(obj.coilActive_flag(coil)) == 1) && (coil <= dimC) && (dynamic <= dimD)
                                    obj.sensitivityMaps{coil}(:,:,slice,dynamic,fa,echo) = senseMap(:,:,1,coil,1,1,1,1,1,1,1,1,1,slice);
                                else
                                    obj.sensitivityMaps{coil}(:,:,slice,dynamic,fa,echo) = zeros(size(senseMap(:,:,1,1,1,1,1,1,1,1,1,1,1,slice)));
                                end
                            end
                        end
                    end
                end
            end
            
         
            % Prepare the 2D radial PICS reconstruction
            app.TextMessage('PICS reconstruction ...');
            picsCommand = 'pics -S -i24 -e -d2 ';
            if LW>0
                picsCommand = [picsCommand,' -RW:6:0:',num2str(LW)];
            end
            if TVxyz>0
                picsCommand = [picsCommand,' -R',obj.totalVariation,':6:0:',num2str(TVxyz)];
            end
            if LR>0
                % Locally low-rank in the spatial domain
                blockSize = round(dimR/16);  % Block size
                blockSize(blockSize<8) = 8;
                picsCommand = [picsCommand,' -RL:6:6:',num2str(LR),' -b',num2str(blockSize),' -N '];
            end
            if TVd>0
                picsCommand = [picsCommand,' -R',obj.totalVariation,':2048:0:',num2str(TVd)];
            end

            % Actual reconstruction
            echo = 0;
            while (echo < dimE) && ~app.stopReco_flag
                echo = echo + 1;

                fa = 0;
                while (fa < dimF) && ~app.stopReco_flag
                    fa = fa + 1;

                    slice = 0;
                    while (slice < dimZ) && ~app.stopReco_flag
                        slice = slice + 1;

                        if app.DensityCorrectCheckBox.Value

                                % [1 dimx spokes 1 1 1 1 1 1 1 1 dynamics 1 1]
                                d = densityPics(:,:,:,1,1,echo,fa,1,1,1,1,:,1,slice);
                                % [1 dimx spokes coils 1 1 1 1 1 1 1 dynamics 1 1]
                                k = kSpacePics(:,:,:,logical(obj.coilActive_flag),1,echo,fa,1,1,1,1,:,1,slice);
                                 % [3 dimx spokes coils 1 1 1 1 1 1 1 dynamics 1 1]
                                t = trajPics(:,:,:,1,1,echo,fa,1,1,1,1,:,1,slice);
                                % [dimx dimy 1 coils 1 1 1 1 1 1 1 1 1 1]
                                s = sensitivities(:,:,1,logical(obj.coilActive_flag),1,1,1,1,1,1,:,1,slice);

                                reco = bart(app,picsCommand,'-p',d,'-t',t,k,s);
                                iGrid(:,:,1,1,1,echo,fa,1,1,1,1,:,1,slice) = reco;
                         
                        else

                                % [1 dimx spokes coils 1 1 1 1 1 1 1 dynamics 1 1]
                                k = kSpacePics(:,:,:,logical(obj.coilActive_flag),1,echo,fa,1,1,1,1,:,1,slice);
                                % [3 dimx spokes 1 1 1 1 1 1 1 1 dynamics 1 1]
                                t = trajPics(:,:,:,1,1,echo,fa,1,1,1,1,:,1,slice);
                                % [dimx dimy 1 coils 1 1 1 1 1 1 1 1 1 1]
                                s = sensitivities(:,:,1,logical(obj.coilActive_flag),1,1,1,1,1,1,1,:,1,slice);

                                reco = bart(app,picsCommand,'-t',t,k,s);
                                iGrid(:,:,1,1,1,echo,fa,1,1,1,1,:,1,slice) =  squeeze(reco);
                            
                        end

                        % Report on progress
                        app.progressCounter = app.progressCounter + 5;
                        app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                        drawnow;

                    end
                end
            end

            % Rearrange to orientation: x, y, slices, dynamics, flip-angle, echo-time
            imagesOut = permute(iGrid,[1, 2, 14, 12, 7, 6, 3, 4, 5, 8, 9, 10, 11, 13]);

            % Interpolate to requested dimensions
            if ndimX ~= dimR || ndimY ~= dimR || ndimD ~= dimD
                imagesOut = obj.matrixInterpolate(imagesOut,[ndimX/dimR ndimY/dimR 1 ndimD/dimD 1 1 1],'cubic');
                ndimX = size(imagesOut,1);
                ndimY = size(imagesOut,2);
                ndimD = size(imagesOut,4);
                app.XEditField.Value = ndimX;
                app.YEditField.Value = ndimY;
                app.NREditField.Value = ndimD;
            end
     
            % Flip for phase-orientation is vertical
            if obj.PHASE_ORIENTATION == 0
                imagesOut = flip(flip(imagesOut,2),1);
            end

            % Return the image objects
            obj.complexImages = imagesOut;
            obj.images = abs(imagesOut);
            obj.phaseImages = angle(imagesOut);
            obj.phaseImagesOrig = angle(imagesOut);

        end % csRecoRadial




        % ---------------------------------------------------------------------------------
        % Image reconstruction: NUFFT 2D Radial
        % ---------------------------------------------------------------------------------
        function obj = Reco2DRadialNUFFT(obj, app)

            % Dimensions
            dimR = size(obj.rawKspace{1},1);        % Readout
            dimS = size(obj.rawKspace{1},2);        % Spokes
            dimZ = size(obj.rawKspace{1},3);        % Slices
            app.ZEditField.Value = dimZ;
            dimD = size(obj.rawKspace{1},4);        % Dynamics
            dimF = size(obj.rawKspace{1},5);        % Flip-angles
            dimE = size(obj.rawKspace{1},6);        % Echo-times
            dimC = obj.nrCoils;                     % Coils

            % Requested sizes
            ndimX = app.XEditField.Value;
            if rem(ndimX,2)
                ndimX = ndimX + 1;
                app.XEditField.Value = ndimX;
            end
            ndimY = app.YEditField.Value;
            if rem(ndimY,2)
                ndimY = ndimY + 1;
                app.YEditField.Value = ndimY;
            end
            ndimD = dimD;
            if dimD > 1
                ndimD = app.NREditField.Value;
            else
                app.NREditField.Value = 1;
            end
          
            % K-space data readout,spokes,slices,dynamics,flip-angles,echo-times,coils
            kSpace = zeros(dimR,dimS,dimZ,dimD,dimF,dimE,dimC);

            % Fill k-space for reconstruction
            for coil = 1:dimC
                kSpace(:,:,:,:,:,:,coil) = obj.rawKspace{coil};
            end

            % Averages
            averages = obj.nsaSpace;

            % Initialize progress counter
            app.RecoProgressGauge.Value = 0;
            app.totalCounter = dimE*dimF*dimD*dimZ + dimZ*dimD*dimE*dimF;
            app.progressCounter = 0;

            % Center echo and/or phase correction, tukey filter
            app.TextMessage("Preparing data for reconstruction ....");
            tukFilter = tukeywin(dimR,2*obj.tukeyFilterWidth);
            interpFactor = 4;
            centerEchoFlag = app.CenterEchoCheckBox.Value;
            phaseCorrectionFlag = app.PhaseCorrectCheckBox.Value;
            amplitudeFlag = app.AmplitudeCorrectionCheckBox.Value;
            tukeyFlag = app.TukeyFilterCheckBox.Value;
            middle = floor(dimR/2);

            for echo = 1:dimE

                for fa = 1:dimF

                    for dynamic = 1:dimD

                        for slice = 1:dimZ

                            meanKspace = 1; % otherwise parfor does not start
                            if amplitudeFlag
                                mm1 = abs(kSpace(:,:,slice,dynamic,fa,echo,:));
                                mm2 = max(mm1);
                                meanKspace = mean(mm2(:));
                            end
             
                            for coil = 1:dimC

                                parfor spoke = 1:dimS
  
                                    if centerEchoFlag
                                        tmpKline1 = kSpace(:,spoke,slice,dynamic,fa,echo,coil);
                                        tmpKline2 = interp(tmpKline1,interpFactor);
                                        [~,kCenter] = max(abs(tmpKline2));
                                        kShift = middle-kCenter/interpFactor;
                                        kSpace(:,spoke,slice,dynamic,fa,echo,coil) = fraccircshift(tmpKline1,kShift);
                                    end

                                    if phaseCorrectionFlag
                                        tmpKline1 = kSpace(:,spoke,slice,dynamic,fa,echo,coil);
                                        kCenterPhase = angle(tmpKline1(middle+1));
                                        tmpKline1 = tmpKline1.*exp(-1j.*kCenterPhase);
                                        kSpace(:,spoke,slice,dynamic,fa,echo,coil) = tmpKline1;
                                    end

                                    if amplitudeFlag
                                        tmpKline1 = kSpace(:,spoke,slice,dynamic,fa,echo,coil);
                                        kSpace(:,spoke,slice,dynamic,fa,echo,coil) = meanKspace*tmpKline1/max(abs(tmpKline1(:)));
                                    end

                                    if tukeyFlag
                                        kSpace(:,spoke,slice,dynamic,fa,echo,coil) = kSpace(:,spoke,slice,dynamic,fa,echo,coil).*tukFilter;
                                    end

                                end

                            end

                            % Report on progress
                            app.progressCounter = app.progressCounter + 1;
                            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                            drawnow;

                        end

                    end

                end

            end

            % Corrected k-space
            for coil = 1:dimC
                obj.rawKspace{coil} = kSpace(:,:,:,:,:,:,coil);
            end
            obj = obj.scaleKspace;

            % Re-estimate global coil sensitivities
            if (nnz(obj.coilActive_flag) > 1) && (app.AutoSensitivityCheckBox.Value == 1)
                obj = obj.estimateCoilSensitivies(app);
            end

            % Apply global coil sensitivity correction
            for coil = 1:dimC
                kSpace(:,:,:,:,:,:,coil) = obj.rawKspace{coil}*obj.coilActive_flag(coil)/obj.coilSensitivities(coil);
            end

            % Make the radial trajectory 0-180 degrees
            % Could be extended with different trajectories if available
            fullAngle = 180;
            for spoke = 1:dimS
                % crds, x, y(spoke)
                traj(1,:,spoke) = (-floor(dimR/2)+0.5:floor(dimR/2)-0.5)*cos((pi/180)*(spoke-1)*fullAngle/dimS);
                traj(2,:,spoke) = (-floor(dimR/2)+0.5:floor(dimR/2)-0.5)*sin((pi/180)*(spoke-1)*fullAngle/dimS);
                traj(3,:,spoke) = 0;
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

            % Pre-allocate image
            imagesOut = zeros(dimR,dimR,dimZ,dimD,dimF,dimE);

            % Actual reconstruction
            echo = 0;
            while (echo < dimE) && ~app.stopReco_flag
                echo = echo + 1;

                fa = 0;
                while (fa < dimF) && ~app.stopReco_flag
                    fa = fa + 1;

                    dynamic = 0;
                    while (dynamic < dimD) && ~app.stopReco_flag
                        dynamic = dynamic + 1;

                        slice = 0;
                        while (slice < dimZ) && ~app.stopReco_flag
                            slice = slice + 1;

                            objNufft = nufft_3d(traj,dimR,app);

                            data = kSpace(:,:,slice,dynamic,fa,echo,logical(obj.coilActive_flag));
                            data = reshape(data,dimR*dimS,nnz(obj.coilActive_flag));

                            image2D = squeeze(objNufft.iNUFT(data,maxit,damp,weight,'phase-constraint',partial,app));

                            % Report on progress
                            app.progressCounter = app.progressCounter + 1;
                            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                            drawnow;

                            % Coil combine
                            if dimC>1
                                imageTmp(:,:,1,1,:) = image2D;
                                try
                                    reco = coilCombine_mex(imageTmp);
                                catch
                                    reco = coilCombine(imagesTmp);
                                end
                            else
                                reco = image2D;
                            end

                            % Resized image
                            imagesOut(:,:,slice,dynamic,fa,echo) = reco;

                        end

                    end

                end

            end

            % Interpolate to requested dimensions
            if ndimX ~= dimR || ndimY ~= dimR || ndimD ~= dimD
                imagesOut = obj.matrixInterpolate(imagesOut,[ndimX/dimR ndimY/dimR 1 ndimD/dimD 1 1 1],'cubic');
                ndimX = size(imagesOut,1);
                ndimY = size(imagesOut,2);
                ndimD = size(imagesOut,4);
                app.XEditField.Value = ndimX;
                app.YEditField.Value = ndimY;
                app.NREditField.Value = ndimD;
            end

            % Flip for phase-orientation is vertical
            if obj.PHASE_ORIENTATION == 0
                imagesOut = flip(flip(imagesOut,2),1);
            end

            % Make coil sensitivities
            for coil = 1:obj.maxCoils
                if logical(obj.coilActive_flag(coil)) == 1 && coil <= dimC
                    obj.sensitivityMaps{coil} = ones(dimR,dimR,dimZ,dimD,dimF,dimE)*obj.coilSensitivities(coil);
                else
                    obj.sensitivityMaps{coil} = zeros(dimR,dimR,dimZ,dimD,dimF,dimE);
                end
            end

            % Return the image objects
            obj.complexImages = imagesOut;
            obj.images = abs(imagesOut);
            obj.phaseImages = angle(imagesOut);
            obj.phaseImagesOrig = angle(imagesOut);

        end % Reco2DRadialNUFFT





        % ---------------------------------------------------------------------------------
        % Image reconstruction: CS 3D UTE with BART
        % ---------------------------------------------------------------------------------
        function obj = Reco3DuteCS(obj, app)

            % CS regularization parameters
            LW = app.WVxyzEditField.Value;
            TVxyz = app.TVxyzEditField.Value;
            LR = app.LRxyzEditField.Value;
            TVd = app.TVtimeEditField.Value;
            dimc = obj.nrCoils;
            TVtype = 'T'; % Use total variation, instead of TGV

            % Gradient delays from app
            dTotal(1) = app.GxDelayEditField.Value;
            dTotal(2) = app.GyDelayEditField.Value;
            dTotal(3) = app.GzDelayEditField.Value;
            offset = app.DataOffsetRadialEditField.Value;

            % Data dimensions
            dimX = size(obj.rawKspace{1},1);    % spoke readout
            dimS = size(obj.rawKspace{1},2);    % number of spokes
            dimD = size(obj.rawKspace{1},4);    % dynamics
            dimF = size(obj.rawKspace{1},5);    % flip-angles
            dimE = size(obj.rawKspace{1},6);    % echo times
            dimC = obj.nrCoils;                 % coils

            % Requested dimensions
            ndimX = app.XEditField.Value;
            ndimY = app.YEditField.Value;
            ndimZ = app.ZEditField.Value;
            ndimD = dimD;
            if dimD > 1
                ndimD = app.NREditField.Value;
            else
                app.NREditField.Value = 1;
            end
          
            % K-space radial spokes
            dimT = length(obj.gradTrajectory);
            traj = zeros(3,dimT,dimS);
            for cnt = 1:dimS
                traj(1,:,cnt) = dimT*(obj.seqTrajectory(1,cnt)/32767)*obj.gradTrajectory(:);
                traj(2,:,cnt) = dimT*(obj.seqTrajectory(2,cnt)/32767)*obj.gradTrajectory(:);
                traj(3,:,cnt) = dimT*(obj.seqTrajectory(3,cnt)/32767)*obj.gradTrajectory(:);
            end

            % Check if offset is not too large, if so reduce size
            offset(offset < 0) = 0;
            offset(offset > (dimX - dimT)) = dimX - dimT;
            app.DataOffsetRadialEditField.Value = offset;

            % Fill k-space for reconstruction
            for coil = 1:dimC
                kSpace(:,:,:,:,:,:,coil) = obj.rawKspace{coil};
            end

            % Averages
            averages = obj.nsaSpace;

            % Remove data offset
            kSpace = kSpace(1+offset:dimT+offset,:,:,:,:,:,:);
            averages = averages(1+offset:dimT+offset,:,:,:);

            % Initialize progress counter
            app.RecoProgressGauge.Value = 0;
            app.totalCounter = 1 + app.GradDelayCalibrationCheckBox.Value + dimE*dimF*dimD*app.DensityCorrectCheckBox.Value + 1 + dimE*dimF;
            app.progressCounter = 0;

            % Corrections
            app.TextMessage("Preparing data for reconstruction ....");
            tukFilter = tukeywin(2*dimT,obj.tukeyFilterWidth);
            tukFilter = tukFilter(dimT+1:2*dimT);
            interpFactor = 4;
            centerEchoFlag = app.CenterEchoCheckBox.Value;
            phaseCorrectionFlag = app.PhaseCorrectCheckBox.Value;
            amplitudeFlag = app.AmplitudeCorrectionCheckBox.Value;
            tukeyFlag = app.TukeyFilterCheckBox.Value;

            for echo = 1:dimE

                for fa = 1:dimF

                    for dynamic = 1:dimD

                        meanKspace = 1; % otherwise parfor does not start
                        if amplitudeFlag
                            mm1 = abs(kSpace(:,:,1,dynamic,fa,echo,:));
                            mm2 = max(mm1);
                            meanKspace = mean(mm2(:));
                        end

                        for coil = 1:dimC

                            parfor spoke = 1:dimS

                                if centerEchoFlag
                                    % Auto shift to maximum intensity at first data point
                                    tmpKline1 = kSpace(:,spoke,1,dynamic,fa,echo,coil);
                                    tmpKline2 = interp(tmpKline1,interpFactor);
                                    [~,kCenter] = max(abs(tmpKline2));
                                    kShift = 1-kCenter/interpFactor;
                                    discard = ceil(abs(kShift));
                                    tmpKline1 = fraccircshift(tmpKline1,kShift);
                                    tmpKline1(end-discard:end) = 0;
                                    kSpace(:,spoke,1,dynamic,fa,echo,coil) = tmpKline1;
                                end

                                if phaseCorrectionFlag
                                    % Phase correction and normalize
                                    tmpKline1 = kSpace(:,spoke,1,dynamic,fa,echo,coil);
                                    kCenterPhase = angle(tmpKline1(1));
                                    tmpKline1 = tmpKline1.*exp(-1j.*kCenterPhase);
                                    kSpace(:,spoke,1,dynamic,fa,echo,coil) = tmpKline1;
                                end

                                if amplitudeFlag
                                    % Amplitude correction
                                    tmpKline1 = kSpace(:,spoke,1,dynamic,fa,echo,coil);
                                    kSpace(:,spoke,1,dynamic,fa,echo,coil) = meanKspace*tmpKline1/max(abs(tmpKline1(:)));
                                end

                                if tukeyFlag
                                    % Tukey filter
                                    kSpace(:,spoke,1,dynamic,fa,echo,coil) = kSpace(:,spoke,1,dynamic,fa,echo,coil).*tukFilter;
                                end

                            end

                        end

                    end

                end

            end

            % Corrected k-space
            for coil = 1:dimC
                obj.rawKspace{coil} = kSpace(:,:,:,:,:,:,coil);
            end
            obj = obj.scaleKspace;

            % Re-estimate global coil sensitivities
            if (nnz(obj.coilActive_flag) > 1) && (app.AutoSensitivityCheckBox.Value == 1)
                obj = obj.estimateCoilSensitivies(app);
            end

            % Apply global coil sensitivity correction
            for coil = 1:dimC
                kSpace(:,:,:,:,:,:,coil) = obj.rawKspace{coil}*obj.coilActive_flag(coil)/obj.coilSensitivities(coil);
            end

            % Report on progress
            app.progressCounter = app.progressCounter + 1;
            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
            drawnow;
    
            % Bart dimensions  Bart   Matlab
            % 	READ_DIM,       0       1   x
            % 	PHS1_DIM,       1       2   y
            % 	PHS2_DIM,       2       3   z
            % 	COIL_DIM,       3       4   coils
            % 	MAPS_DIM,       4       5   sense maps
            % 	TE_DIM,         5       6   echo time
            % 	COEFF_DIM,      6       7   flip angle
            % 	COEFF2_DIM,     7       8
            % 	ITER_DIM,       8       9
            % 	CSHIFT_DIM,     9       10
            % 	TIME_DIM,       10      11  cardiac / respiratory CINE frames
            % 	TIME2_DIM,      11      12  dynamics
            % 	LEVEL_DIM,      12      13
            % 	SLICE_DIM,      13      14  slices
            % 	AVG_DIM,        14      15

            %           1      2        3        4          5           6        7
            % Initially x, y(spokes),   1,    dynamics, flip-angle, echo-times, coils

            %                            1 readout spokes coils 1 echo flip angle 1 1 1 dynamics 1 1
            % Rearrange for BART         1  2  3  4  5  6  7  8  9 10 11 12 13 14
            kSpacePics = permute(kSpace,[3, 1, 2, 7, 8, 6, 5, 9,10,11,12, 4,13,14]);

            % Rearrange for BART        1  2  3  4  5  6  7  8  9 10 11 12 13 14
            avgPics = permute(averages,[3, 1, 2, 7, 8, 6, 5, 9,10,11,12, 4,13,14]);

            % Rearrange for BART     1  2  3  4  5  6  7  8  9 10 11 12 13 14
            trajPics = permute(traj,[1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14]);

            % Calibration and density correction size
            kdim = round(dimT/3);
            if mod(kdim,2) == 1
                kdim = kdim + 1;
            end
            kdim(kdim < 32) = 32;
            kdim(kdim > dimT) = dimT;
            calibSize = [kdim, kdim, kdim];
            cSize = ['-d',num2str(calibSize(1)),':',num2str(calibSize(2)),':',num2str(calibSize(3))];
            app.TextMessage(strcat("Calibration size = ",num2str(kdim)));

            % Gradient delay calibration
            if app.GradDelayCalibrationCheckBox.Value

                % Find the k-space for which signal is maximal, for best coil sensitivity estimation
                ks = abs(kSpacePics);
                [~,indx] = max(ks(:));
                [~,~,~,cIdx,~,teIdx,faIdx,~,~,~,~,dynIdx,~,~] = ind2sub(size(ks),indx);
                kSpacePicsRing = kSpacePics(1,:,:,cIdx,1,teIdx,faIdx,1,1,1,1,dynIdx,1,1);
                trajPicsRing = trajPics(:,:,:,1,1,teIdx,faIdx,1,1,1,1,dynIdx,1,1);

                % Calibration size
                kSize = [6,6,6];
                kSkip = round(length(kSpacePicsRing)/2000);
                kSkip(kSkip < 1) = 1;

                % M = index in trajectory for which k-space value >= calibSize
                [~,zm] = find(squeeze(trajPicsRing(1,:,:)) == max(trajPicsRing(:)),1,'first');
                if isempty(zm)
                    [~,zm] = find(squeeze(trajPicsRing(2,:,:)) == max(trajPicsRing(:)),1,'first');
                end
                if isempty(zm)
                    [~,zm] = find(squeeze(trajPicsRing(3,:,:)) == max(trajPicsRing(:)),1,'first');
                end
                M = find(sqrt(trajPicsRing(1,:,zm).^2+trajPicsRing(2,:,zm).^2+trajPicsRing(3,:,zm).^2) >= calibSize(1,1)/2,1);

                % Reduce size for gradient calibration
                kTrajCalib = trajPicsRing(:,1:M,1:kSkip:end);
                dataCalib = kSpacePicsRing(1,1:M,1:kSkip:end);
                ze = squeeze(abs(dataCalib(1,1,:))) > 0;
                kTrajCalib = kTrajCalib(:,:,ze);
                app.TextMessage(strcat("Calibration trajectory length = ",num2str(length(kTrajCalib))," ..."));

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
                app.TextMessage(strcat("Rank = ",num2str(rank)," ..."));

                % Data consistency
                y = squeeze(dataCalib);
                xOld = kCalib;

                % Prepare for manual stop
                app.stopGradCal_flag = false;

                % Reset delay values
                dTotal = zeros(3,1);

                % Calibration
                while  (iteration<20)  && (incre>0.001) && ~app.stopGradCal_flag

                    % Iteration number
                    iteration = iteration + 1;
                    app.TextMessage(strcat("Iteration: ",num2str(iteration)));

                    % Solve for X
                    xNew = proudData.lowRankThresh3D(xOld,kSize,rank);
                    % rank = rank+0.2;
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
                    app.TextMessage(strcat("Estimated delays: ",num2str(dTotal(1)),":",num2str(dTotal(2)),":",num2str(dTotal(3))));

                    % Sent gradient delay vector back to app
                    app.GxDelayEditField.Value = double(round(dTotal(1),5));
                    app.GyDelayEditField.Value = double(round(dTotal(2),5));
                    app.GzDelayEditField.Value = double(round(dTotal(3),5));

                    % Interpolation to update trajectory with new delays
                    kTraj = proudData.trajInterpolation(kTrajCalib,dTotal);

                    % The new image with k-space updated for gradient delays
                    imCalib = bart(app,['bart nufft -i -l 0.01 ',cSize,' -t'],kTraj,reshape(y,[1 M size(kTrajCalib,3) dimc]));

                    % Show image
                    im = squeeze(abs(imCalib(:,:,round(calibSize(3)/2),1)));
                    im = flip(im,3);
                    if obj.PHASE_ORIENTATION
                        im = rot90(im,-1);
                    else
                        im = flip(im,1);
                    end
                    xlim(app.RecoFig, [0 size(im,2)+1]);
                    ylim(app.RecoFig, [0 size(im,1)+1]);
                    daspect(app.RecoFig,[1 1 1]);
                    imshow(rot90(im),[],'Parent',app.RecoFig);

                    % Calculate k-space from new image
                    xOld = proudData.fft3Dmri(squeeze(imCalib));

                end

                app.GradDelayCalibrationCheckBox.Value = 0;

                % Report on progress
                app.progressCounter = app.progressCounter + 1;
                app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                drawnow;

            end % Gradient calibration

            % Final gradient delay correction from optimization or values from app
            trajPics = permute(trajPics,[1 2 3 12 14 6 7 4 5 8 9 10 11 13]);
            trajPics = obj.trajInterpolation(trajPics,dTotal);
            trajPics = ipermute(trajPics,[1 2 3 12 14 6 7 4 5 8 9 10 11 13]);

            % Density correction
            if app.DensityCorrectCheckBox.Value

                app.TextMessage('Calculating density correction ...');

                % Make sure densityOnes contains only 1's when data is available
                densityOnes = ones(size(kSpacePics));
                densityOnes = densityOnes(:,:,:,1,:,:,:,:,:,:,:,:,:,:).*avgPics(:,:,:,1,:,:,:,:,:,:,:,:,:,:);
                densityOnes(densityOnes > 1) = 1;

                for echo = 1:dimE
                    for fa = 1:dimF
                        for dynamic = 1:dimD

                            d = densityOnes(:,:,:,1,1,echo,fa,1,1,1,1,dynamic,1,1);
                            t = trajPics(:,:,:,1,1,echo,fa,1,1,1,1,dynamic,1,1);

                            densityTmp = bart(app,strcat('nufft -d',num2str(dimT),':',num2str(dimT),':',num2str(dimT),' -a'),t,d);
                            densityPics = bart(app,'nufft ',t,densityTmp);
                            densityTmp = bart(app,'nufft ',t,densityTmp);
                            densityTmp = densityTmp.^(-1/3);
                            densityTmp(isnan(densityTmp)) = 0;
                            densityTmp(isinf(densityTmp)) = 0;
                            densityPics(:,:,:,1,1,echo,fa,1,1,1,1,dynamic,1,1) = densityTmp;

                            % Report on progress
                            app.progressCounter = app.progressCounter + 1;
                            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                            drawnow;

                        end
                    end
                end

            end % Density correction

            % Coils sensitivity maps
            if (nnz(obj.coilActive_flag) > 1) && (app.AutoSensitivityCheckBox.Value == 1)

                % ESPIRiT reconstruction
                TextMessage(app,'ESPIRiT reconstruction ...');

                % Calculate coil sensitivity maps with ecalib bart function, per slice
                app.TextMessage('Calculating coil sensitivity maps ...');

                sensitivities = ones(dimT,dimT,dimT,dimC,1,1,1,1,1,1,1,dimD,1,1);

                % Find the k-space for which signal is maximal, for best coil sensitivity estimation
                ks = abs(kSpacePics);
                [~,indx] = max(ks(:));
                [~,~,~,~,~,teIdx,faIdx,~,~,~,~,dynIdx,~,~] = ind2sub(size(ks),indx);
                kSpacePicsSense = kSpacePics(:,:,:,:,:,teIdx,faIdx,:,:,:,:,dynIdx,:,:);
                trajPicsSense = trajPics(:,:,:,:,:,teIdx,faIdx,:,:,:,:,dynIdx,:,:);

                try

                    for coil = 1:dimC
                        lowResImage = bart(app,['nufft -i -l2 ',cSize,' -t'], trajPicsSense, kSpacePicsSense(:,:,:,coil));
                        lowResKspace = bart(app,'fft -u 7', lowResImage);
                        kSpaceZeroFilled(:,:,:,coil) = bart(app,['resize -c 0 ',num2str(dimT),' 1 ',num2str(dimT),' 2 ',num2str(dimT)], lowResKspace);
                    end

                    sense = bart(app,'ecalib -d1 -S -I -a -m1', kSpaceZeroFilled);

                catch ME

                    app.TextMessage(ME.message);
                    app.TextMessage("Coil sensitivity error, using uniform sensitivities ...");
                    sense = zeros(dimT,dimT,dimT,dimC);
                    for coil = 1:obj.maxCoils
                        if logical(obj.coilActive_flag(coil))
                            sense(:,:,:,coil) = obj.coilSensitivities(coil);
                        end
                    end

                end

                for dynamic = 1:dimD
                    sensitivities(:,:,:,:,1,1,1,1,1,1,1,dynamic,1,1) = sense;
                end

            else

                sensitivities = zeros(dimT,dimT,dimT,dimC,1,1,1,1,1,1,1,ndimD,1,1);
                for coil = 1:obj.maxCoils
                    if logical(obj.coilActive_flag(coil))
                        sensitivities(:,:,:,coil,1,1,1,1,1,1,1,:,1,1) = obj.coilSensitivities(coil);
                    end
                end

            end

            % Construct the sensitivity maps for the app {coil} x, y, slices, dynamics, fa, echo ...
            senseMap = abs(sensitivities);
            senseMap = senseMap/max(senseMap(:));
            senseMap = flip(senseMap,3);
            if obj.PHASE_ORIENTATION == 0
                senseMap = flip(senseMap,1);
            end
            for coil = 1:obj.maxCoils
                for echo = 1:dimE
                    for fa = 1:dimF
                        for dynamic = 1:dimD
                            if (logical(obj.coilActive_flag(coil)) == 1) && (coil <= dimC) && (dynamic <= dimD)
                                obj.sensitivityMaps{coil}(:,:,:,dynamic,fa,echo) = senseMap(:,:,:,coil,1,1,1,1,1,1,1,1,1,1);
                            else
                                obj.sensitivityMaps{coil}(:,:,:,dynamic,fa,echo) = zeros(size(senseMap(:,:,:,1,1,1,1,1,1,1,1,1,1,1)));
                            end
                        end
                    end
                end
            end

            % Report on progress
            app.progressCounter = app.progressCounter + 1;
            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
            drawnow;

            % Pre-allocate
            imagesOut = zeros(dimT,dimT,dimT,dimD,dimF,dimE);

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
                blockSize = round(dimT/16);  % Block size
                blockSize(blockSize<8) = 8;
                picsCommand = [picsCommand,' -RL:7:7:',num2str(LR),' -b',num2str(blockSize)];
            end
            if TVd>0
                picsCommand = [picsCommand,' -R',obj.totalVariation,':2048:0:',num2str(TVd)];
            end

            % Actual reconstruction
            echo = 0;
            while (echo < dimE) && ~app.stopReco_flag
                echo = echo + 1;

                fa = 0;
                while (fa < dimF) && ~app.stopReco_flag
                    fa = fa + 1;

                    if app.DensityCorrectCheckBox.Value

                        % [1 dimx spokes 1 1 1 1 1 1 1 1 dynamics 1 1]
                        d = densityPics(:,:,:,1,1,echo,fa,1,1,1,1,:,1,1);
                        % [1 dimx spokes coils 1 1 1 1 1 1 1 dynamics 1 1]
                        k = kSpacePics(:,:,:,logical(obj.coilActive_flag),1,echo,fa,1,1,1,1,:,1,1);
                        % [3 dimx spokes coils 1 1 1 1 1 1 1 dynamics 1 1]
                        t = trajPics(:,:,:,1,1,echo,fa,1,1,1,1,:,1,1);
                        % [dimx dimy 1 coils 1 1 1 1 1 1 1 1 1 1]
                        s = sensitivities(:,:,:,logical(obj.coilActive_flag),1,1,1,1,1,1,:,1,1);

                        reco = bart(app,picsCommand,'-p',d,'-t',t,k,s);
                        imagesOut(:,:,:,1,1,echo,fa,1,1,1,1,:,1,1) = reco;

                    else

                        % [1 dimx spokes coils 1 1 1 1 1 1 1 dynamics 1 1]
                        k = kSpacePics(:,:,:,logical(obj.coilActive_flag),1,echo,fa,1,1,1,1,:,1,1);
                        % [3 dimx spokes 1 1 1 1 1 1 1 1 dynamics 1 1]
                        t = trajPics(:,:,:,1,1,echo,fa,1,1,1,1,:,1,1);
                        % [dimx dimy 1 coils 1 1 1 1 1 1 1 1 1 1]
                        s = sensitivities(:,:,:,logical(obj.coilActive_flag),1,1,1,1,1,1,1,:,1,1);

                        reco = bart(app,picsCommand,'-t',t,k,s);
                        imagesOut(:,:,:,1,1,echo,fa,1,1,1,1,:,1,1) =  squeeze(reco);

                    end

                    % Report on progress
                    app.progressCounter = app.progressCounter + 1;
                    app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                    drawnow;

                end
            end

            % Flip dimensions to correct orientation
            imagesOut = flip(imagesOut,3);
            if obj.PHASE_ORIENTATION == 0
                imagesOut = flip(imagesOut,1);
            end

            % Interpolate to requested dimensions
            if ndimX ~= dimT || ndimY ~= dimT || ndimZ ~= dimT || ndimD ~= dimD
                imagesOut = obj.matrixInterpolate(imagesOut,[ndimX/dimT ndimY/dimT ndimZ/dimT ndimD/dimD 1 1 1],'cubic');
                ndimX = size(imagesOut,1);
                ndimY = size(imagesOut,2);
                ndimZ = size(imagesOut,3);
                ndimD = size(imagesOut,4);
                app.XEditField.Value = ndimX;
                app.YEditField.Value = ndimY;
                app.ZEditField.Value = ndimZ;
                app.NREditField.Value = ndimD;
            end

            % Return the image objects
            obj.complexImages = imagesOut;
            obj.images = abs(imagesOut);
            obj.phaseImages = angle(imagesOut);
            obj.phaseImagesOrig = angle(imagesOut);

        end % Reco3DuteCS





        % ---------------------------------------------------------------------------------
        % Image reconstruction: NUFFT 3D UTE with Matlab
        % ---------------------------------------------------------------------------------
        function obj = Reco3DuteNUFFT(obj, app)
       
            % Gradient delays from app
            dTotal(1) = app.GxDelayEditField.Value;
            dTotal(2) = app.GyDelayEditField.Value;
            dTotal(3) = app.GzDelayEditField.Value;
            offset = app.DataOffsetRadialEditField.Value;

            % Data dimensions
            dimX = size(obj.rawKspace{1},1);    % spoke readout
            dimS = size(obj.rawKspace{1},2);    % number of spokes
            dimD = size(obj.rawKspace{1},4);    % dynamics
            dimF = size(obj.rawKspace{1},5);    % flip-angles
            dimE = size(obj.rawKspace{1},6);    % echo times
            dimC = obj.nrCoils;                 % coils

            % Requested dimensions
            ndimX = app.XEditField.Value;
            ndimY = app.YEditField.Value;
            ndimZ = app.ZEditField.Value;
            ndimD = dimD;
            if dimD > 1
                ndimD = app.NREditField.Value;
            else
                app.NREditField.Value = 1;
            end
          
            % K-space radial spokes
            dimT = length(obj.gradTrajectory);
            traj = zeros(3,dimT,dimS);
            for cnt = 1:dimS
                traj(1,:,cnt) = dimT*(obj.seqTrajectory(1,cnt)/32767)*obj.gradTrajectory(:);
                traj(2,:,cnt) = dimT*(obj.seqTrajectory(2,cnt)/32767)*obj.gradTrajectory(:);
                traj(3,:,cnt) = dimT*(obj.seqTrajectory(3,cnt)/32767)*obj.gradTrajectory(:);
            end

            % Check if offset is not too large, if so reduce size
            offset(offset < 0) = 0;
            offset(offset > (dimX - dimT)) = dimX - dimT;
            app.DataOffsetRadialEditField.Value = offset;

            % Fill k-space for reconstruction
            for coil = 1:dimC
                kSpace(:,:,:,:,:,:,coil) = obj.rawKspace{coil};
            end

            % Resize k-space and remove offset
            kSpace = kSpace(1+offset:dimT+offset,:,:,:,:,:,:);

            % Initialize progress counter
            app.RecoProgressGauge.Value = 0;
            app.totalCounter = 1 + 3*dimD*dimE*dimF;
            app.progressCounter = 0;

            % Corrections
            app.TextMessage("Preparing data for reconstruction ....");
            tukFilter = tukeywin(2*dimT,2*obj.tukeyFilterWidth);
            tukFilter = tukFilter(dimT+1:2*dimT);
            interpFactor = 4;
            centerEchoFlag = app.CenterEchoCheckBox.Value;
            phaseCorrectionFlag = app.PhaseCorrectCheckBox.Value;
            amplitudeFlag = app.AmplitudeCorrectionCheckBox.Value;
            tukeyFlag = app.TukeyFilterCheckBox.Value;

            for echo = 1:dimE

                for fa = 1:dimF

                    for dynamic = 1:dimD

                        meanKspace = 1; % otherwise parfor does not start
                        if amplitudeFlag
                            mm1 = abs(kSpace(:,:,1,dynamic,fa,echo,:));
                            mm2 = max(mm1);
                            meanKspace = mean(mm2(:));
                        end

                        for coil = 1:dimC

                            parfor spoke = 1:dimS

                                if centerEchoFlag
                                    % Auto shift to maximum intensity at first data point
                                    tmpKline1 = kSpace(:,spoke,1,dynamic,fa,echo,coil);
                                    tmpKline2 = interp(tmpKline1,interpFactor);
                                    [~,kCenter] = max(abs(tmpKline2));
                                    kShift = 1-kCenter/interpFactor;
                                    discard = ceil(abs(kShift));
                                    tmpKline1 = fraccircshift(tmpKline1,kShift);
                                    tmpKline1(end-discard:end) = 0;
                                    kSpace(:,spoke,1,dynamic,fa,echo,coil) = tmpKline1;
                                end

                                if phaseCorrectionFlag
                                    % Phase correction and normalize
                                    tmpKline1 = kSpace(:,spoke,1,dynamic,fa,echo,coil);
                                    kCenterPhase = angle(tmpKline1(1));
                                    tmpKline1 = tmpKline1.*exp(-1j.*kCenterPhase);
                                    kSpace(:,spoke,1,dynamic,fa,echo,coil) = tmpKline1;
                                end

                                if amplitudeFlag
                                    % Amplitude correction
                                    tmpKline1 = kSpace(:,spoke,1,dynamic,fa,echo,coil);
                                    kSpace(:,spoke,1,dynamic,fa,echo,coil) = meanKspace*tmpKline1/max(abs(tmpKline1(:)));
                                end

                                if tukeyFlag
                                    % Tukey filter
                                    kSpace(:,spoke,1,dynamic,fa,echo,coil) = kSpace(:,spoke,1,dynamic,fa,echo,coil).*tukFilter;
                                end

                            end

                        end

                    end

                end

            end

            % Corrected k-space
            for coil = 1:dimC
                obj.rawKspace{coil} = kSpace(:,:,:,:,:,:,coil);
            end
            obj = obj.scaleKspace;

            % Re-estimate global coil sensitivities
            if (nnz(obj.coilActive_flag) > 1) && (app.AutoSensitivityCheckBox.Value == 1)
                obj = obj.estimateCoilSensitivies(app);
            end

            % Apply global coil sensitivity correction
            for coil = 1:dimC
                kSpace(:,:,:,:,:,:,coil) = obj.rawKspace{coil}*obj.coilActive_flag(coil)/obj.coilSensitivities(coil);
            end

            % Prepare the trajectory with the gradient delay values
            traj = obj.trajInterpolation(traj,dTotal);

            % Report on progress
            app.progressCounter = app.progressCounter + 1;
            app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
            drawnow;

            % Initialization
            maxit = 5;      % 0 or 1 for gridding, higher values for conjugate gradient
            damp = 0;       % Tikhonov penalty on ||x||
            weight = [];    % data weighting (optional)
            partial = 0.5;  % Tikhobov penalty on ||imag(x))||

            % Pre-allocate
            imagesOut = zeros(dimT,dimT,dimT,dimD,dimF,dimE);

            % Reco
            echo = 0;
            while (echo < dimE) && ~app.stopReco_flag
                echo = echo + 1;

                fa = 0;
                while (fa < dimF) && ~app.stopReco_flag
                    fa = fa + 1;

                    dynamic = 0;
                    while (dynamic < ndimD) && ~app.stopReco_flag
                        dynamic = dynamic + 1;

                        objNufft = nufft_3d(traj,dimT,app);

                        % Report on progress
                        app.progressCounter = app.progressCounter + 1;
                        app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                        drawnow;

                        data = kSpace(:,:,1,dynamic,fa,echo,logical(obj.coilActive_flag));
                        data = reshape(data,dimT*dimS,nnz(obj.coilActive_flag));

                        image3D = squeeze(objNufft.iNUFT(data,maxit,damp,weight,'phase-constraint',partial,app));

                        % Report on progress
                        app.progressCounter = app.progressCounter + 1;
                        app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                        drawnow;

                        % Coil combine
                        if dimC>1
                            imageTmp(:,:,:,1,:) = image3D;
                            try
                                reco = coilCombine_mex(imageTmp);
                            catch
                                reco = coilCombine(imagesTmp);
                            end
                        else
                            reco = image3D;
                        end

                        % Report on progress
                        app.progressCounter = app.progressCounter + 1;
                        app.RecoProgressGauge.Value = round(100*app.progressCounter/app.totalCounter);
                        drawnow;

                        % Image out
                        imagesOut(:,:,:,dynamic,fa,echo) = image3D;

                    end
                end
            end

            % Flip dimensions to correct orientation
            imagesOut = flip(imagesOut,3);
            if obj.PHASE_ORIENTATION == 0
                imagesOut = flip(imagesOut,1);
            end

            % Interpolate to requested dimensions
            if ndimX ~= dimT || ndimY ~= dimT || ndimZ ~= dimT || ndimD ~= dimD
                imagesOut = obj.matrixInterpolate(imagesOut,[ndimX/dimT ndimY/dimT ndimZ/dimT ndimD/dimD 1 1 1],'cubic');
                ndimX = size(imagesOut,1);
                ndimY = size(imagesOut,2);
                ndimZ = size(imagesOut,3);
                ndimD = size(imagesOut,4);
                app.XEditField.Value = ndimX;
                app.YEditField.Value = ndimY;
                app.ZEditField.Value = ndimZ;
                app.NREditField.Value = ndimD;
            end

            % Make coil sensitivities
            for coil = 1:obj.maxCoils
                if logical(obj.coilActive_flag(coil)) == 1 && coil <= dimC
                    obj.sensitivityMaps{coil} = ones(dimT,dimT,dimT,dimD,dimF,dimE)*obj.coilSensitivities(coil);
                else
                    obj.sensitivityMaps{coil} = zeros(dimT,dimT,dimT,ndimZ,dimD,dimF,dimE);
                end
            end

            % Return the image objects
            obj.complexImages = imagesOut;
            obj.images = abs(imagesOut);
            obj.phaseImages = angle(imagesOut);
            obj.phaseImagesOrig = angle(imagesOut);

        end % Reco3DuteNUFFT





        % ---------------------------------------------------------------------------------
        % PCA denoising
        % ---------------------------------------------------------------------------------
        function obj = PCAdenoise(obj, app)

            try

                if app.DeNoiseCheckBox.Value

                    app.TextMessage('PCA image denoising ...');

                    % Images
                    im = obj.images;

                    % Image dimensions (X, Y, Z, NR, NFA, NE)
                    dimZ = size(im,3);
                    dimD = size(im,4);
                    dimF = size(im,5);
                    dimE = size(im,6);

                    % Denoising window
                    w = app.DeNoiseWindowEditField.Value;
                    window = [w w];
                    if window(1) > size(im,1)/2
                        window(1) = round(size(im,1)/2);
                    end
                    if window(2) > size(im,2)/2
                        window(2) = round(size(im,2)/2);
                    end

                    % Loop over all slices, dynamics, flip-angles, echo-times
                    % Choose 2-dim image + extra dimension
                    if dimE > 1

                        for slice = 1:dimZ
                            for dynamic = 1:dimD
                                for fa = 1:dimF
                                    im(:,:,slice,dynamic,fa,:) = denoise(double(squeeze(im(:,:,slice,dynamic,fa,:))),window);
                                end
                            end
                        end

                    elseif dimF > 1

                        for slice = 1:dimZ
                            for dynamic = 1:dimD
                                im(:,:,slice,dynamic,:,1) = denoise(double(squeeze(im(:,:,slice,dynamic,:,1))),window);
                            end
                        end

                    elseif dimD > 1

                        for slice = 1:dimZ
                            im(:,:,slice,:,1,1) = denoise(double(squeeze(im(:,:,slice,:,1,1))),window);
                        end

                    else

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
        function obj = unRing(obj, app)

            try

                app.TextMessage('Gibbs ringing suppression ...');

                im = obj.images;

                % params - 3x1 array with [minW maxW nsh]
                % nsh discretization of subpixel spaceing (default 20)
                % minW  left border of window used for TV computation (default 1)
                % maxW  right border of window used for TV computation (default 3)
                params = [1 3 20];

                % image dimensions (X, Y, Z, NR, NFA, NE)
                dimD = size(im,4);
                dimF = size(im,5);
                dimE = size(im,6);

                % unRing
                for dynamic = 1:dimD
                    for fa = 1:dimF
                        for echo = 1:dimE
                            im(:,:,:,dynamic,fa,echo) = ringRm(double(squeeze(im(:,:,:,dynamic,fa,echo))),params);
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
            obj.images = round(obj.maxImage*obj.images/max(obj.images(:)));
            obj.images(isnan(obj.images)) = 0;
            obj.images(isinf(obj.images)) = 0;

        end % scaleImages




        % ---------------------------------------------------------------------------------
        % Scale k-space
        % ---------------------------------------------------------------------------------
        function obj = scaleKspace(obj)

            dimC = obj.nrCoils;

            % Determine max abs(kSpace) value
            mx1 = zeros(obj.nrCoils,1);
            for coil = 1:dimC
                mx1(coil) = max(abs(obj.rawKspace{coil}(:)));
            end
            mx = double(round(max(mx1(:))));

            % Scale
            for coil = 1:dimC
                obj.rawKspace{coil} = obj.maxKspace*obj.rawKspace{coil}/mx;
            end

        end % scaleImages




        % ---------------------------------------------------------------------------------
        % Image resolution
        % ---------------------------------------------------------------------------------
        function obj = calcPixelSize(obj, app)

            % Calculate pixel size in different dimensions

            [dimX, dimY, dimZ, dimD, dimF, dimE] = size(obj.images);

            fovX = app.FOVViewField1.Value;
            fovY = app.FOVViewField2.Value;
            if contains(obj.dataType,'3D')
                fovZ = app.FOVViewField3.Value;
            else
                fovZ = app.FOVViewField3.Value*dimZ;
            end
            meanFov = mean([fovX fovY fovZ]); % not really a physical dimension, but average of x,y and z

            resX = fovX/dimX;
            resY = fovY/dimY;
            resZ = fovZ/dimZ;
            resD = meanFov/dimD;
            resF = meanFov/dimF;
            resE = meanFov/dimE;

            obj.pixelSize = [resX resY resZ resD resF resE 1];

        end % calcPixelSize




        % ---------------------------------------------------------------------------------
        % Image reconstruction: backToKspace
        % ---------------------------------------------------------------------------------
        function obj = backToKspace(obj)

            im = obj.images;

            switch obj.dataType

                case {"2D","2Dradial","2Depi"}

                    % Images = (X, Y, slices, NR, NFA, NE)
                    [~, ~, dimZ, dimD, dimF, dimE] = size(im);

                    % Shift image to prevent pixel-shift after FFT
                    if obj.PHASE_ORIENTATION == 1
                        im = circshift(im,1,2);
                    else
                        im = circshift(im,1,1);
                        im = circshift(im,1,2);
                    end

                    kSpace = zeros(size(im));
                    for slice = 1:dimZ
                        for dynamic = 1:dimD
                            for fa = 1:dimF
                                for echo = 1:dimE
                                    kSpace(:,:,slice,dynamic,fa,echo) = proudData.fft2Dmri(squeeze(im(:,:,slice,dynamic,fa,echo)));
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
                    [~, ~, ~, dimD, dimF, dimE] = size(im);

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
                    for dynamic = 1:dimD
                        for fa = 1:dimF
                            for echo = 1:dimE
                                kSpace(:,:,:,dynamic,fa,echo) = proudData.fft3Dmri(squeeze(im(:,:,:,dynamic,fa,echo)));
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

            dimZ = size(obj.phaseImages,3);
            dimD = size(obj.phaseImages,4);
            dimF = size(obj.phaseImages,5);
            dimE = size(obj.phaseImages,6);

            if dimZ > 1
                % 3D or multi-slice
                for dynamic = 1:dimD
                    for fa = 1:dimF
                        for echo = 1:dimE
                            obj.phaseImages(:,:,:,dynamic,fa,echo) = unwrap3(squeeze(obj.phaseImages(:,:,:,dynamic,fa,echo)),squeeze(obj.mask(:,:,:,dynamic,fa,echo)));
                        end
                    end
                end
            elseif dimE > 1
                % Single slice with multiple echoes
                for dynamic = 1:dimD
                    for fa = 1:dimF
                        obj.phaseImages(:,:,1,dynamic,fa,:) = unwrap3(squeeze(obj.phaseImages(:,:,1,dynamic,fa,:)),squeeze(obj.mask(:,:,1,dynamic,fa,:)));
                    end
                end
            elseif dimD > 1
                % Single slice with multiple dynamics
                for fa = 1:dimF
                    for echo = 1:dimE
                        obj.phaseImages(:,:,1,:,fa,echo) = unwrap3(squeeze(obj.phaseImages(:,:,1,:,fa,echo)),squeeze(obj.mask(:,:,1,:,fa,echo)));
                    end
                end
            else
                % 2D single slice
                for dynamic = 1:dimD
                    for fa = 1:dimF
                        for echo = 1:dimE
                            obj.phaseImages(:,:,1,dynamic,fa,echo) = unwrap2(squeeze(obj.phaseImages(:,:,1,dynamic,fa,echo)),squeeze(obj.mask(:,:,1,dynamic,fa,echo)));
                        end
                    end
                end
            end

        end % unwrap3D



        % ---------------------------------------------------------------------------------
        % Flow calculation
        % ---------------------------------------------------------------------------------
        function obj = calcFlow(obj, app)

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
                "dim_x = ", num2str(size(obj.images,1)), "\n", ...
                "dim_y = ", num2str(size(obj.images,2)), "\n", ...
                "dim_z = ", num2str(size(obj.images,3)) , "\n", ...
                "FOV_x = ", num2str(app.FOVViewField1.Value), " mm \n", ...
                "FOV_y = ", num2str(app.FOVViewField2.Value), " mm \n", ...
                "FOV_z = ", num2str(app.FOVViewField3.Value), " mm \n", ...
                "k_x = ", num2str(app.KMatrixViewField1.Value), "\n", ...
                "k_y = ", num2str(app.KMatrixViewField2.Value), "\n", ...
                "k_z = ", num2str(app.KMatrixViewField3.Value), "\n", ...
                "#slabs = ", num2str(size(obj.rawKspace{1},7)), "\n\n", ...
                "\nSCAN PARAMETERS\n\n", ...
                "scan time = ", app.ScanTimeViewField.Value, "\n", ...
                "time per dynamic = ", app.TimeDynViewField.Value, "\n", ...
                "TR = ", num2str(app.TRViewField.Value), " ms \n", ...
                "TE = ", num2str(app.TEViewField.Value), " ms \n", ...
                "#echoes = ", num2str(app.NEViewField.Value), "\n", ...
                "#averages = ", num2str(app.NAViewField.Value), "\n", ...
                "#flip-angles = ", num2str(app.NFAViewField.Value), "\n", ...
                "flip-angle(s) = ", app.FAViewField.Value, "\n", ...
                "#repetitions = ", num2str(app.NREditField.Value), "\n", ...
                "trajectory = ", app.TrajectoryViewField.Value, "\n\n", ...
                "\nRECONSTRUCTION PARAMETERS\n\n", ...
                "Wavelet = ",num2str(app.WVxyzEditField.Value), "\n", ...
                "TVxyz = ",num2str(app.TVxyzEditField.Value), "\n", ...
                "LRxyz = ",num2str(app.LRxyzEditField.Value), "\n", ...
                "TVtime = ",num2str(app.TVtimeEditField.Value), "\n", ...
                "CSreco = ",num2str(app.CSRecoCheckBox.Value), "\n\n" ...
                );

            if strcmp(obj.dataType,'2Dradial')
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

            if strcmp(obj.dataType,'3Dute')
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
        % Retrieve the 3D image shift for off-center and oblique Radial and P2ROUD sequences
        % ---------------------------------------------------------------------------------
        function obj = get3DimageShift(obj, app, image)

            % Image dimensions in pixels  (x,y,z,nr,fa,ne)
            dimX = size(image,1);
            dimY = size(image,2);
            dimZ = size(image,3);

            % Calculate the shift
            relShiftX = dimX*obj.fov_read_off/4000;      % Relative offset, scaling from PPL file
            relShiftY = dimY*obj.fov_phase_off/4000;
            relShiftZ = dimZ*obj.fov_slice_off/400;

            % Different readout / phase depending on phase_orientation value
            if obj.PHASE_ORIENTATION

                shiftInX = +relShiftX;
                shiftInY = -relShiftY;
                shiftInZ = -relShiftZ;

            else

                shiftInX = -relShiftX;
                shiftInY = -relShiftY;
                shiftInZ = -relShiftZ;

            end

            % Report the values back / return the object
            obj.xShift = shiftInX;
            obj.yShift = shiftInY;
            obj.zShift = shiftInZ;

            % Readout shift already taken care of in PPL sequence
            if strcmp(obj.trajType,'P2ROUD')
                obj.xShift = 0;
            end

            % Textmessage
            app.TextMessage(sprintf('Image shift ΔX = %.2f, ΔY = %.2f pixels, ΔZ = %.2f pixels ...',obj.xShift(1),obj.yShift(1),obj.zShift(1)));

        end % get3DimageShift



        % ---------------------------------------------------------------------------------
        % Apply sub-pixel 2D image shift (2D radial)
        % ---------------------------------------------------------------------------------
        function obj = shiftImages2D(obj, app)

            % Retrieve the in-plane image shifts
            obj = obj.get3DimageShift(app, obj.images);

            [~,~,dimZ,dimD,dimF,dimE] = size(obj.images);

            % Apply the shift on sub-pixel level to the complex images
            for echo = 1:dimE
                for fa = 1:dimF
                    for dynamic = 1:dimD
                        for slice = 1:dimZ
                            obj.complexImages(:,:,slice,dynamic,fa,echo) = obj.image2Dshift(squeeze(obj.complexImages(:,:,slice,dynamic,fa,echo)),obj.yShift(slice),obj.xShift(slice));
                        end
                    end
                end
            end

            % Calculate mangitude and phase images
            obj.images = abs(obj.complexImages);
            obj.phaseImages = angle(obj.complexImages);
            obj.phaseImagesOrig = angle(obj.complexImages);

        end % shiftImages2D




        % ---------------------------------------------------------------------------------
        % Apply sub-pixel 3D image shift (3D P2ROUD trajectory)
        % ---------------------------------------------------------------------------------
        function obj = shiftImages3D(obj, app)

            % Retrieve the in-plane image shifts
            obj = obj.get3DimageShift(app, obj.images);

            [dimX,~,dimZ,dimD,dimF,dimE] = size(obj.images);

            % Apply the shift on sub-pixel level to the complex images
            for echo = 1:dimE
                for fa = 1:dimF
                    for dynamic = 1:dimD
                        for slice = 1:dimZ
                            obj.complexImages(:,:,slice,dynamic,fa,echo) = obj.image2Dshift(squeeze(obj.complexImages(:,:,slice,dynamic,fa,echo)),obj.yShift(1),obj.xShift(1));
                        end
                    end
                end
            end

            for echo = 1:dimE
                for fa = 1:dimF
                    for dynamic = 1:dimD
                        for x = 1:dimX
                            obj.complexImages(x,:,:,dynamic,fa,echo) = obj.image2Dshift(squeeze(obj.complexImages(x,:,:,dynamic,fa,echo)),obj.zShift(1),0);
                        end
                    end
                end
            end

            % Calculate mangitude and phase images
            obj.images = abs(obj.complexImages);
            obj.phaseImages = angle(obj.complexImages);
            obj.phaseImagesOrig = angle(obj.complexImages);

        end % shiftImages3D





    end % Public methods








    % ---------------------------------------------------------------------------------
    % Static methods
    % ---------------------------------------------------------------------------------
    methods (Static)


        % ---------------------------------------------------------------------------------
        % 2D Tukey filter
        % ---------------------------------------------------------------------------------
        function output = circTukey2D(dimY,dimX,row,col,filterwidth)

            domain = 256;
            base = zeros(domain,domain);

            tukey1 = tukeywin(domain,filterwidth);
            tukey1 = tukey1(domain/2+1:domain);

            shiftY = (row-dimY/2)*domain/dimY;
            shiftX = (col-dimX/2)*domain/dimX;

            y = linspace(-domain/2, domain/2, domain);
            x = linspace(-domain/2, domain/2, domain);

            for i = 1:domain

                for j = 1:domain

                    rad = round(sqrt((shiftX-x(i))^2 + (shiftY-y(j))^2));

                    if (rad <= domain/2) && (rad > 0)

                        base(j,i) = tukey1(rad);

                    end

                end

            end

            output = imresize(base,[dimY dimX]);

        end



        % ---------------------------------------------------------------------------------
        % 3D Tukey filter
        % ---------------------------------------------------------------------------------
        function output = circTukey3D(dimZ,dimY,dimX,lev,row,col,filterwidth)

            domain = 256;

            base = zeros(domain,domain,domain);

            tukey1 = tukeywin(domain,filterwidth);
            tukey1 = tukey1(domain/2+1:domain);

            shiftZ = (lev-dimZ/2)*domain/dimZ;
            shiftY = (row-dimY/2)*domain/dimY;
            shiftX = (col-dimX/2)*domain/dimX;

            z = linspace(-domain/2, domain/2, domain);
            y = linspace(-domain/2, domain/2, domain);
            x = linspace(-domain/2, domain/2, domain);

            for i = 1:domain

                for j = 1:domain

                    for k = 1:domain

                        rad = round(sqrt((shiftX-x(i))^2 + (shiftY-y(j))^2 + (shiftZ-z(k))^2));

                        if (rad <= domain/2) && (rad > 0)

                            base(k,j,i) = tukey1(rad);

                        end

                    end

                end

            end

            output = imresize3(base,[dimZ dimY dimX]);

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
                                paramvalue = '';
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
            dydtz = dydkz.*repmat(dkz,[1 1 1 nCoils]); % positive does not converge

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
        function traj = twoDradialTrajectory(dimX, dimY, dimZ, dimD, dimF, dimE)

            % Make the radial trajectory 0-180 degrees
            % Could be extended with different trajectories if available

            fullAngle = 180;
            for echo = 1:dimE
                for fa = 1:dimF
                    for dynamic = 1:dimD
                        for slice = 1:dimZ
                            for y = 1:dimY
                                % crds, x, y(spoke), slice, repetitions, flip-anlge, echo-times
                                traj(1,:,y,slice,dynamic,fa,echo) = (-floor(dimX/2)+0.5:floor(dimX/2)-0.5)*cos((pi/180)*(y-1)*fullAngle/dimY);
                                traj(2,:,y,slice,dynamic,fa,echo) = (-floor(dimX/2)+0.5:floor(dimX/2)-0.5)*sin((pi/180)*(y-1)*fullAngle/dimY);
                                traj(3,:,y,slice,dynamic,fa,echo) = 0;
                            end
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



        % ---------------------------------------------------------------------------------
        % Resize an n-dimensional matrix
        % ---------------------------------------------------------------------------------
        function outputMatrix = matrixInterpolate(inputMatrix, scaling, varargin)

            % inputMatrx = n-dimensional matrix
            % scaling = scaling factor
            % varargin = 'linear', 'cubic' interpolation method

            N = ndims(inputMatrix);
            scaling = scaling(1:N);
            scaling(1,1:N) = scaling(:).';
            sz = size(inputMatrix);
            xvec = cell(1,N);
            yvec = cell(1,N);
            szy = nan(1,N);
            nonsing = true(1,N);

            for i = 1:N

                n = sz(i);

                if n==1 %for vector input
                    nonsing(i) = 0;
                    szy(i) = 1;
                    continue
                end

                szy(i) = round(sz(i)*scaling(i));
                m = szy(i);

                xax = linspace(1/n/2, 1-1/n/2 ,n);
                xax = xax-.5;

                yax = linspace(1/m/2, 1-1/m/2 ,m);
                yax = yax-.5;

                xvec{i} = xax;
                yvec{i} = yax;

            end

            xvec = xvec(nonsing);
            yvec = yvec(nonsing);
            F = griddedInterpolant(xvec,squeeze(inputMatrix),varargin{:});
            outputMatrix = reshape(F(yvec),szy);

        end % matrixInterpolate


    end % Static methods




end % proudData Class

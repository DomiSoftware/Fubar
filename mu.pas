unit mu;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.TabControl,
  FMX.StdCtrls, FMX.Gestures, FMX.Controls.Presentation, FMX.Media, FMX.Layouts,
  System.DateUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.FMXUI.Wait, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FMX.Memo.Types, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FMX.Edit,
  FMX.ScrollBox, FMX.Memo, FMX.DialogService, System.Notification,
  System.IOUtils, Math,
  FMX.TreeView;

type
  TCal = Record
    Date: TDate;
    Text: string;
    Bold: Boolean;
    FColor: TAlphaColor;
    PColor: TAlphaColor;
  end;

  TCiteRaw = Record
    zProject: string;
    zModule: string;
    zSubject: string;
    zCreated: string;
    zType: string;
    zBibOnly: string;
  end;

  TMyNode = record
    id: integer;
    nid: string;
    lbl: string;
    stm: string;
    txt: string;
  end;

  TfrmMain = class(TForm)
    HeaderToolBar: TToolBar;
    ToolBarLabel: TLabel;
    tcBook: TTabControl;
    tsBookP1: TTabItem;
    tsBookP2: TTabItem;
    tsBookP3: TTabItem;
    Outliner: TTabItem;
    GestMgr: TGestureManager;
    MediaP: TMediaPlayer;
    tbHead: TLabel;
    btnMatrix: TPanel;
    gpTimerSet: TGridPanelLayout;
    tb180: TButton;
    tb150: TButton;
    tb120: TButton;
    tb90: TButton;
    tb75: TButton;
    tb60: TButton;
    tb45: TButton;
    tb30: TButton;
    tb25: TButton;
    tb20: TButton;
    tb15: TButton;
    tb10: TButton;
    tb05: TButton;
    tb03: TButton;
    tb01: TButton;
    tb10s: TButton;
    tb20s: TButton;
    tb30s: TButton;
    tmr_go: TButton;
    tbTime: TLabel;
    Timer1: TTimer;
    DTA: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDT: TFDTransaction;
    FDT2: TFDTransaction;
    FDTU: TFDTransaction;
    GO: TFDCommand;
    QCite: TFDQuery;
    tcProj: TTabControl;
    tsCIView: TTabItem;
    pnlPICIOverview: TPanel;
    pnlCRQuote: TPanel;
    lblQuoteHead: TLabel;
    mCRQuote: TMemo;
    pnlCIRef: TPanel;
    lbCIHeader: TLabel;
    mCILong: TMemo;
    cbBibliogOnly: TCheckBox;
    CIR_ILR1: TEdit;
    lbCI1: TLabel;
    Panel3: TPanel;
    bCISave: TButton;
    bCIDel: TButton;
    bCIFirst: TButton;
    bCILast: TButton;
    bCINext: TButton;
    bCIPrev: TButton;
    lbCICount: TLabel;
    bCINew: TButton;
    bCIOutput: TButton;
    tsCRChooseType: TTabItem;
    pnlCIChooseType: TPanel;
    Apply: TButton;
    tcCiteType: TTabControl;
    tsBookJournal: TTabItem;
    GroupBox1: TGroupBox;
    rgBookAuth: TRadioButton;
    rgBookOrgAuth: TRadioButton;
    rgBookReprint: TRadioButton;
    rgBookNoAuth: TRadioButton;
    rgBookFacsimile: TRadioButton;
    rgBookChap: TRadioButton;
    rgBookCollected: TRadioButton;
    rgAnthology: TRadioButton;
    rgAnthologyLine: TRadioButton;
    rgReference: TRadioButton;
    rgBible: TRadioButton;
    rgJournalArt: TRadioButton;
    rgJournalWhole: TRadioButton;
    rgBookPartChap: TRadioButton;
    tsNewsMedia: TTabItem;
    GroupBox2: TGroupBox;
    rgWebAuth: TRadioButton;
    rgWebNoAuth: TRadioButton;
    rgWebOrg: TRadioButton;
    rgMovies: TRadioButton;
    rgPodcast: TRadioButton;
    rgRadio: TRadioButton;
    rgSocialMedia: TRadioButton;
    rgTVEpisodeSeries: TRadioButton;
    rgTVSingle: TRadioButton;
    rgNewsByline: TRadioButton;
    rgNewsNoByline: TRadioButton;
    rgWebMagNoPrint: TRadioButton;
    tsVLE: TTabItem;
    GroupBox3: TGroupBox;
    rgConfPaper: TRadioButton;
    rgVLELectureNotes: TRadioButton;
    rgVLEModule: TRadioButton;
    rgVLETutorHandout: TRadioButton;
    rgPainting: TRadioButton;
    rgPhotographicPrint: TRadioButton;
    rgPhotographWeb: TRadioButton;
    tsCREntry: TTabItem;
    pnlCREntry: TPanel;
    pnlCROptions: TPanel;
    lblCRHead: TLabel;
    eb01: TEdit;
    eb02: TEdit;
    eb03: TEdit;
    eb04: TEdit;
    eb08: TEdit;
    eb09: TEdit;
    eb10: TEdit;
    eb11: TEdit;
    EBOL02: TEdit;
    eb06: TEdit;
    eb05: TEdit;
    eb07: TEdit;
    EBOL01: TEdit;
    EBOL03: TEdit;
    bCRAccessed: TButton;
    lblCROnline: TLabel;
    bCRMake: TButton;
    bCRReset: TButton;
    TPrj: TFDTable;
    TPrjprojid: TFDAutoIncField;
    TPrjproj_name: TWideMemoField;
    TPrjproj_modl: TWideMemoField;
    TPrjproj_subj: TWideMemoField;
    TPrjproj_creat: TWideMemoField;
    NotifyMe: TNotificationCenter;
    pnlCalendar: TPanel;
    pnlMonth: TPanel;
    DomiNewCal: TPanel;
    nCal: TGridPanelLayout;
    cpd0: TPanel;
    lbd0: TLabel;
    cpd4: TPanel;
    lbd4: TLabel;
    cpd5: TPanel;
    lbd5: TLabel;
    cpd6: TPanel;
    lbd6: TLabel;
    cpd1: TPanel;
    lbd1: TLabel;
    cpd2: TPanel;
    lbd2: TLabel;
    cpd3: TPanel;
    lbd3: TLabel;
    cpv0x0: TPanel;
    lbv0x0: TLabel;
    cpv0x1: TPanel;
    lbv0x1: TLabel;
    cpv0x2: TPanel;
    lbv0x2: TLabel;
    cpv0x3: TPanel;
    lbv0x3: TLabel;
    cpv0x4: TPanel;
    lbv0x4: TLabel;
    cpv0x5: TPanel;
    lbv0x5: TLabel;
    cpv0x6: TPanel;
    lbv0x6: TLabel;
    cpv1x0: TPanel;
    lbv1x0: TLabel;
    cpv1x1: TPanel;
    lbv1x1: TLabel;
    cpv1x2: TPanel;
    lbv1x2: TLabel;
    cpv1x3: TPanel;
    lbv1x3: TLabel;
    cpv1x4: TPanel;
    lbv1x4: TLabel;
    cpv1x5: TPanel;
    lbv1x5: TLabel;
    cpv1x6: TPanel;
    lbv1x6: TLabel;
    cpv2x0: TPanel;
    lbv2x0: TLabel;
    cpv2x1: TPanel;
    lbv2x1: TLabel;
    cpv2x2: TPanel;
    lbv2x2: TLabel;
    cpv2x3: TPanel;
    lbv2x3: TLabel;
    cpv2x4: TPanel;
    lbv2x4: TLabel;
    cpv2x5: TPanel;
    lbv2x5: TLabel;
    cpv2x6: TPanel;
    lbv2x6: TLabel;
    cpv3x0: TPanel;
    lbv3x0: TLabel;
    cpv3x1: TPanel;
    lbv3x1: TLabel;
    cpv3x2: TPanel;
    lbv3x2: TLabel;
    cpv3x3: TPanel;
    lbv3x3: TLabel;
    cpv3x4: TPanel;
    lbv3x4: TLabel;
    cpv3x5: TPanel;
    lbv3x5: TLabel;
    cpv3x6: TPanel;
    lbv3x6: TLabel;
    cpv4x0: TPanel;
    lbv4x0: TLabel;
    cpv4x1: TPanel;
    lbv4x1: TLabel;
    cpv4x2: TPanel;
    lbv4x2: TLabel;
    cpv4x3: TPanel;
    lbv4x3: TLabel;
    cpv4x4: TPanel;
    lbv4x4: TLabel;
    cpv4x5: TPanel;
    lbv4x5: TLabel;
    cpv4x6: TPanel;
    lbv4x6: TLabel;
    cpv5x0: TPanel;
    lbv5x0: TLabel;
    cpv5x1: TPanel;
    lbv5x1: TLabel;
    cpv5x2: TPanel;
    lbv5x2: TLabel;
    cpv5x3: TPanel;
    lbv5x3: TLabel;
    cpv5x4: TPanel;
    lbv5x4: TLabel;
    cpv5x5: TPanel;
    lbv5x5: TLabel;
    cpv5x6: TPanel;
    lbv5x6: TLabel;
    nCalHeader: TPanel;
    cpnLM: TPanel;
    lbnLM: TLabel;
    cpnNM: TPanel;
    lbnNM: TLabel;
    cpnM: TPanel;
    lbnM: TLabel;
    pnlDay: TPanel;
    lblCalFlagNum: TLabel;
    lblCalFlagDay: TLabel;
    lblCalFlagMth: TLabel;
    lblCalFlagYear: TLabel;
    StatusBar1: TStatusBar;
    btnDayTextSave: TButton;
    Memo1: TMemo;
    QJnl: TFDQuery;
    BACKUP: TFDSQLiteBackup;
    ScaledLayout1: TScaledLayout;
    Panel1: TPanel;
    mShow: TMemo;
    eNodeLabel: TEdit;
    gpNode: TGridPanelLayout;
    btnAddNode: TButton;
    btnDelNode: TButton;
    btnAddSubNode: TButton;
    btnMoveNode: TButton;
    btnMoveNodetoRoot: TButton;
    GridPanelLayout2: TGridPanelLayout;
    btLoad: TButton;
    btSave: TButton;
    btOutp: TButton;
    btNew: TButton;
    QStry: TFDQuery;
    myTV: TTreeView;
    btnStorySaveFront: TButton;
    QOutl: TFDQuery;
    eOutlineTitle: TEdit;
    Panel4: TPanel;
    Panel5: TPanel;
    tsConfig: TTabItem;
    btnDBBackup: TButton;
    btnDBRestore: TButton;
    Panel2: TPanel;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    Label2: TLabel;
    Panel6: TPanel;
    Label3: TLabel;
    tsOProj: TTabItem;
    pnlPIView: TPanel;
    ebProject: TEdit;
    ebModule: TEdit;
    ebSubject: TEdit;
    Panel13: TPanel;
    bPISave: TButton;
    bPIDel: TButton;
    bPIFirst: TButton;
    bPILast: TButton;
    bPINext: TButton;
    bPIPrev: TButton;
    lblPICount: TLabel;
    lbPIHead: TLabel;
    Panel7: TPanel;
    Label4: TLabel;
    Panel8: TPanel;
    Label5: TLabel;
    Timer2: TTimer;
    OutMemAutoSave: TSwitch;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    Panel9: TPanel;
    GridPanelLayout1: TGridPanelLayout;
    cbCFGprCreate: TCheckBox;
    cbCFGprDelete: TCheckBox;
    cbCFGprChange: TCheckBox;
    Panel10: TPanel;
    GridPanelLayout3: TGridPanelLayout;
    cbCFGtiStart: TCheckBox;
    cbCFGtiEnd: TCheckBox;
    cbCFGtiPause: TCheckBox;
    Panel11: TPanel;
    V: TGridPanelLayout;
    cbCFGouNewNode: TCheckBox;
    cbCFGouMovedNode: TCheckBox;
    cbCFGouNewSubNode: TCheckBox;
    Panel12: TPanel;
    GridPanelLayout5: TGridPanelLayout;
    cbCFGciCreate: TCheckBox;
    cbCFGciUpdates: TCheckBox;
    cbCFGciDeleted: TCheckBox;
    Label11: TLabel;
    Panel14: TPanel;
    Label12: TLabel;
    TrackBar2: TTrackBar;
    Label13: TLabel;
    cbCFGouDeletedNode: TCheckBox;
    cbCFGouExport: TCheckBox;
    cbCFGouHousekeep: TCheckBox;
    Label14: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormGesture(Sender: TObject; const EventInfo: TGestureEventInfo;
      var Handled: Boolean);
    procedure btnDBBackupClick(Sender: TObject);
    procedure btnDBRestoreClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure tb180Click(Sender: TObject);
    procedure tb150Click(Sender: TObject);
    procedure tb120Click(Sender: TObject);
    procedure tb90Click(Sender: TObject);
    procedure tb75Click(Sender: TObject);
    procedure tb60Click(Sender: TObject);
    procedure tb45Click(Sender: TObject);
    procedure tb10sClick(Sender: TObject);
    procedure tb20sClick(Sender: TObject);
    procedure tb30sClick(Sender: TObject);
    procedure tb01Click(Sender: TObject);
    procedure tb03Click(Sender: TObject);
    procedure tb05Click(Sender: TObject);
    procedure tb10Click(Sender: TObject);
    procedure tb15Click(Sender: TObject);
    procedure tb20Click(Sender: TObject);
    procedure tb25Click(Sender: TObject);
    procedure tb30Click(Sender: TObject);
    procedure bPIPrevClick(Sender: TObject);
    procedure bPIDelClick(Sender: TObject);
    procedure bPINextClick(Sender: TObject);
    procedure bPILastClick(Sender: TObject);
    procedure bPISaveClick(Sender: TObject);
    procedure bCIFirstClick(Sender: TObject);
    procedure bCIPrevClick(Sender: TObject);
    procedure bCIDelClick(Sender: TObject);
    procedure bCINextClick(Sender: TObject);
    procedure bCILastClick(Sender: TObject);
    procedure bCINewClick(Sender: TObject);
    procedure bCISaveClick(Sender: TObject);
    procedure bCRResetClick(Sender: TObject);
    procedure bCRAccessedClick(Sender: TObject);
    procedure bCIOutputClick(Sender: TObject);
    procedure DTABeforeConnect(Sender: TObject);
    procedure DTAAfterConnect(Sender: TObject);
    procedure QCiteAfterOpen(DataSet: TDataSet);
    procedure QCiteAfterScroll(DataSet: TDataSet);
    procedure TPrjAfterOpen(DataSet: TDataSet);
    procedure TPrjAfterScroll(DataSet: TDataSet);
    procedure bPIFirstClick(Sender: TObject);
    procedure bCRMakeClick(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure lbv0x0Click(Sender: TObject);
    procedure btnDayTextSaveClick(Sender: TObject);
    procedure settimer(t_m, t_s: integer);
    procedure switchenable;
    procedure audioout(cfn: string; vol: integer);
    procedure applym;
    procedure BuildCIR(st: string);
    procedure CalDraw(Sender: TObject);
    procedure CalGetData(thissday: TDate);
    function CalHasdata(thissday: TDate): Boolean;
    procedure CalPrepare(dat: TDateTime);
    procedure backuprestore(dire: string);
    procedure DroidAlert(msg: string);
    procedure btLoadClick(Sender: TObject);
    procedure btNewClick(Sender: TObject);
    procedure btOutpClick(Sender: TObject);
    procedure btnAddNodeClick(Sender: TObject);
    procedure btnAddSubNodeClick(Sender: TObject);
    procedure btnDelNodeClick(Sender: TObject);
    procedure btnMoveNodeClick(Sender: TObject);
    procedure btnMoveNodetoRootClick(Sender: TObject);
    procedure tmr_goClick(Sender: TObject);
    procedure btnStorySaveFrontClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure QStryAfterOpen(DataSet: TDataSet);
    procedure QOutlAfterOpen(DataSet: TDataSet);
    procedure TPrjBeforeScroll(DataSet: TDataSet);
    procedure TrackBar1Change(Sender: TObject);
    procedure lbnMClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    procedure WasSelected(Sender: TObject);
    procedure addnode(BRoot: TTreeView; BNId: string; BText: String);
    procedure JnlAdd(jtxt: string);

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  dt, nw: TDateTime;
  //cite
  CIR: TCiteRaw;
  tmpCIRB, CIR_INL1, CIR_INL2, CIR_BIBLIO: string;
  gPRJ, gCITE: integer;
  isoup: Boolean;
  //daybook
  mycal: array [0 .. 42] of TCal;
  calDate, calStart, calEnd, calSelected: TDate;
  calStr: string;
  calTileNo: integer;
  calwD, calwM, calwY: Word;
  caloFColour: TColor;
  caloPColour: TColor;
  calDataware: Boolean;
  calHasDayPanel: Boolean;
  glob_mdb, glob_bdb: string;
  //outliner
  selobj: TFmxObject;
  selobjt: Text;
  g_text: string;
  g_daybook: string;
  g_label: string;
  g_mount: string;
  g_child: string;
  g_path: string;
  g_id: integer;
  g_noid: integer;
  g_node: array [0 .. 75] of TMyNode;
  t_orig: string;
  g_letcyc: integer;
  node_new: Boolean;
  node_moving: Boolean;
  node_old: string;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TfrmMain.DTABeforeConnect(Sender: TObject);

begin

  DTA.Params.Values['Database'] := glob_mdb;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  glob_mdb := '';
  glob_bdb := '';
{$IF DEFINED(mswindows)}
  g_path := ExtractFilePath(ParamStr(0));
  glob_mdb := TPath.Combine(g_path, 'fubar.sqlite');
  glob_bdb := TPath.Combine(g_path, 'fubar.backup');
{$ENDIF}
{$IF DEFINED(ANDROID)}
  g_path := TPath.GetDocumentsPath;
  glob_mdb := TPath.Combine(g_path, 'fubar.sqlite');
  glob_bdb := TPath.Combine(TPath.GetSharedDocumentsPath, 'fubar.backup');
{$ENDIF}
  g_letcyc := 1;
  g_id := 0;
  g_noid := 100;
  { This defines the default active tab at runtime }
  tcBook.ActiveTab := tsBookP3;
  isoup := false;
  if DTA.Connected = false then
    DTA.Connected := true;
  calHasDayPanel := true;
  calDataware := true;
  calDate := Date;
  CalPrepare(now);
  if calDataware = true then
    if CalHasdata(date) = true then
      CalGetData(date);
end;

procedure TfrmMain.FormGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
//{$IFDEF ANDROID}
//  case EventInfo.GestureID of
//    sgiLeft:
//      begin
//        if TabControl1.ActiveTab <> TabControl1.Tabs[TabControl1.TabCount - 1]
//        then
//          TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex + 1];
//        Handled := true;
//      end;
//
//    sgiRight:
//      begin
//        if TabControl1.ActiveTab <> TabControl1.Tabs[0] then
//          TabControl1.ActiveTab := TabControl1.Tabs[TabControl1.TabIndex - 1];
//        Handled := true;
//      end;
//  end;
//{$ENDIF}
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
 if frmMain.Width<376 then frmMain.Width:=376;

end;

procedure TfrmMain.QCiteAfterOpen(DataSet: TDataSet);
  procedure resetallrg();
  begin
    rgBookAuth.IsChecked := false;
    rgBookNoAuth.IsChecked := false;
    rgBookOrgAuth.IsChecked := false;
    rgBookReprint.IsChecked := false;
    rgBookFacsimile.IsChecked := false;
    rgAnthology.IsChecked := false;
    rgAnthologyLine.IsChecked := false;
    rgReference.IsChecked := false;
    rgBible.IsChecked := false;
    rgBookCollected.IsChecked := false;
    rgBookChap.IsChecked := false;
    rgBookPartChap.IsChecked := false;
    rgJournalArt.IsChecked := false;
    rgJournalWhole.IsChecked := false;
    rgWebAuth.IsChecked := false;
    rgWebOrg.IsChecked := false;
    rgWebNoAuth.IsChecked := false;
    rgSocialMedia.IsChecked := false;
    rgNewsByline.IsChecked := false;
    rgNewsNoByline.IsChecked := false;
    rgPainting.IsChecked := false;
    rgPhotographicPrint.IsChecked := false;
    rgPhotographWeb.IsChecked := false;
    rgPodcast.IsChecked := false;
    rgRadio.IsChecked := false;
    rgTVSingle.IsChecked := false;
    rgTVEpisodeSeries.IsChecked := false;
    rgMovies.IsChecked := false;
    rgVLELectureNotes.IsChecked := false;
    rgVLETutorHandout.IsChecked := false;
    rgConfPaper.IsChecked := false;
  end;

var
  t: string;
begin
  //  if isoup = true then
  //    exit;
  gCITE := 0;
  resetallrg;
  if QCite.FieldByName('biblio').AsString = 'BIBLIOGRAPHY' then
    cbBibliogOnly.IsChecked := true
  else
    cbBibliogOnly.IsChecked := false;
  // Typ
  t := QCite.FieldByName('typ').AsString;
  if t = 'BK:AUTH' then
    rgBookAuth.IsChecked := true;
  if t = 'BK:NOAUTH' then
    rgBookNoAuth.IsChecked := true;
  if t = 'BK:ORG' then
    rgBookOrgAuth.IsChecked := true;
  if t = 'BK:REPR' then
    rgBookReprint.IsChecked := true;
  if t = 'BK:FACS' then
    rgBookFacsimile.IsChecked := true;
  if t = 'BK:ANTH' then
    rgAnthology.IsChecked := true;
  if t = 'BK:ANLN' then
    rgAnthologyLine.IsChecked := true;
  if t = 'BK:REF' then
    rgReference.IsChecked := true;
  if t = 'BK:BIBL' then
    rgBible.IsChecked := true;
  if t = 'BK:COLL' then
    rgBookCollected.IsChecked := true;
  if t = 'BK:CHAP' then
    rgBookChap.IsChecked := true;
  if t = 'BK:CHPT' then
    rgBookPartChap.IsChecked := true;
  if t = 'JN:ART' then
    rgJournalArt.IsChecked := true;
  if t = 'JN:FULL' then
    rgJournalWhole.IsChecked := true;
  if t = 'WW:AUTH' then
    rgWebAuth.IsChecked := true;
  if t = 'WW:ORG' then
    rgWebOrg.IsChecked := true;
  if t = 'WW:NONE' then
    rgWebNoAuth.IsChecked := true;
  if t = 'SM:ALL' then
    rgSocialMedia.IsChecked := true;
  if t = 'NW:BYLN' then
    rgNewsByline.IsChecked := true;
  if t = 'NW:NOBY' then
    rgNewsNoByline.IsChecked := true;
  if t = 'AR:PNTG' then
    rgPainting.IsChecked := true;
  if t = 'AR:PHBK' then
    rgPhotographicPrint.IsChecked := true;
  if t = 'AR:PHWW' then
    rgPhotographWeb.IsChecked := true;
  if t = 'AV:PODC' then
    rgPodcast.IsChecked := true;
  if t = 'AV:RDIO' then
    rgRadio.IsChecked := true;
  if t = 'AV:TV' then
    rgTVSingle.IsChecked := true;
  if t = 'AV:TVSE' then
    rgTVEpisodeSeries.IsChecked := true;
  if t = 'AV:MOVI' then
    rgMovies.IsChecked := true;
  if t = 'VL:NTES' then
    rgVLELectureNotes.IsChecked := true;
  if t = 'VL:HAND' then
    rgVLETutorHandout.IsChecked := true;
  if t = 'CF:PAPR' then
    rgConfPaper.IsChecked := true;

  //     '[proj]='+inttostr(gPRJ)+','+
  CIR.zType := QCite.FieldByName('typ').AsString;
  eb01.Text := QCite.FieldByName('eb01').AsString;
  eb02.Text := QCite.FieldByName('eb02').AsString;
  eb03.Text := QCite.FieldByName('eb03').AsString;
  eb04.Text := QCite.FieldByName('eb04').AsString;
  eb05.Text := QCite.FieldByName('eb05').AsString;
  eb06.Text := QCite.FieldByName('eb06').AsString;
  eb07.Text := QCite.FieldByName('eb07').AsString;
  eb08.Text := QCite.FieldByName('eb08').AsString;
  eb09.Text := QCite.FieldByName('eb09').AsString;
  eb10.Text := QCite.FieldByName('eb10').AsString;
  eb11.Text := QCite.FieldByName('eb11').AsString;
  EBOL01.Text := QCite.FieldByName('ol1').AsString;
  EBOL02.Text := QCite.FieldByName('ol2').AsString;
  EBOL03.Text := QCite.FieldByName('ol3').AsString;
  CIR_ILR1.Text := QCite.FieldByName('inl1').AsString;
  mCRQuote.Lines.Clear;
  mCRQuote.Lines.Add(QCite.FieldByName('inl2').AsString);
  mCILong.Lines.Clear;
  mCILong.Lines.Add(QCite.FieldByName('ref').AsString);
  lbCICount.Text := IntToStr(QCite.RecNo) + '/' + IntToStr(QCite.RecordCount);
  gCITE := QCite.FieldByName('citeid').AsInteger;
  applym;
end;

procedure TfrmMain.QCiteAfterScroll(DataSet: TDataSet);
  procedure resetallrg();
  begin
    rgBookAuth.IsChecked := false;
    rgBookNoAuth.IsChecked := false;
    rgBookOrgAuth.IsChecked := false;
    rgBookReprint.IsChecked := false;
    rgBookFacsimile.IsChecked := false;
    rgAnthology.IsChecked := false;
    rgAnthologyLine.IsChecked := false;
    rgReference.IsChecked := false;
    rgBible.IsChecked := false;
    rgBookCollected.IsChecked := false;
    rgBookChap.IsChecked := false;
    rgBookPartChap.IsChecked := false;
    rgJournalArt.IsChecked := false;
    rgJournalWhole.IsChecked := false;
    rgWebAuth.IsChecked := false;
    rgWebOrg.IsChecked := false;
    rgWebNoAuth.IsChecked := false;
    rgSocialMedia.IsChecked := false;
    rgNewsByline.IsChecked := false;
    rgNewsNoByline.IsChecked := false;
    rgPainting.IsChecked := false;
    rgPhotographicPrint.IsChecked := false;
    rgPhotographWeb.IsChecked := false;
    rgPodcast.IsChecked := false;
    rgRadio.IsChecked := false;
    rgTVSingle.IsChecked := false;
    rgTVEpisodeSeries.IsChecked := false;
    rgMovies.IsChecked := false;
    rgVLELectureNotes.IsChecked := false;
    rgVLETutorHandout.IsChecked := false;
    rgConfPaper.IsChecked := false;
  end;

var
  t: string;
begin
  //  if isoup = true then
  //    exit;
  gCITE := 0;
  resetallrg;
  if QCite.FieldByName('biblio').AsString = 'BIBLIOGRAPHY' then
    cbBibliogOnly.IsChecked := true
  else
    cbBibliogOnly.IsChecked := false;
  // Typ
  t := QCite.FieldByName('typ').AsString;
  if t = 'BK:AUTH' then
    rgBookAuth.IsChecked := true;
  if t = 'BK:NOAUTH' then
    rgBookNoAuth.IsChecked := true;
  if t = 'BK:ORG' then
    rgBookOrgAuth.IsChecked := true;
  if t = 'BK:REPR' then
    rgBookReprint.IsChecked := true;
  if t = 'BK:FACS' then
    rgBookFacsimile.IsChecked := true;
  if t = 'BK:ANTH' then
    rgAnthology.IsChecked := true;
  if t = 'BK:ANLN' then
    rgAnthologyLine.IsChecked := true;
  if t = 'BK:REF' then
    rgReference.IsChecked := true;
  if t = 'BK:BIBL' then
    rgBible.IsChecked := true;
  if t = 'BK:COLL' then
    rgBookCollected.IsChecked := true;
  if t = 'BK:CHAP' then
    rgBookChap.IsChecked := true;
  if t = 'BK:CHPT' then
    rgBookPartChap.IsChecked := true;
  if t = 'JN:ART' then
    rgJournalArt.IsChecked := true;
  if t = 'JN:FULL' then
    rgJournalWhole.IsChecked := true;
  if t = 'WW:AUTH' then
    rgWebAuth.IsChecked := true;
  if t = 'WW:ORG' then
    rgWebOrg.IsChecked := true;
  if t = 'WW:NONE' then
    rgWebNoAuth.IsChecked := true;
  if t = 'SM:ALL' then
    rgSocialMedia.IsChecked := true;
  if t = 'NW:BYLN' then
    rgNewsByline.IsChecked := true;
  if t = 'NW:NOBY' then
    rgNewsNoByline.IsChecked := true;
  if t = 'AR:PNTG' then
    rgPainting.IsChecked := true;
  if t = 'AR:PHBK' then
    rgPhotographicPrint.IsChecked := true;
  if t = 'AR:PHWW' then
    rgPhotographWeb.IsChecked := true;
  if t = 'AV:PODC' then
    rgPodcast.IsChecked := true;
  if t = 'AV:RDIO' then
    rgRadio.IsChecked := true;
  if t = 'AV:TV' then
    rgTVSingle.IsChecked := true;
  if t = 'AV:TVSE' then
    rgTVEpisodeSeries.IsChecked := true;
  if t = 'AV:MOVI' then
    rgMovies.IsChecked := true;
  if t = 'VL:NTES' then
    rgVLELectureNotes.IsChecked := true;
  if t = 'VL:HAND' then
    rgVLETutorHandout.IsChecked := true;
  if t = 'CF:PAPR' then
    rgConfPaper.IsChecked := true;

  //     '[proj]='+inttostr(gPRJ)+','+
  CIR.zType := QCite.FieldByName('typ').AsString;
  eb01.Text := QCite.FieldByName('eb01').AsString;
  eb02.Text := QCite.FieldByName('eb02').AsString;
  eb03.Text := QCite.FieldByName('eb03').AsString;
  eb04.Text := QCite.FieldByName('eb04').AsString;
  eb05.Text := QCite.FieldByName('eb05').AsString;
  eb06.Text := QCite.FieldByName('eb06').AsString;
  eb07.Text := QCite.FieldByName('eb07').AsString;
  eb08.Text := QCite.FieldByName('eb08').AsString;
  eb09.Text := QCite.FieldByName('eb09').AsString;
  eb10.Text := QCite.FieldByName('eb10').AsString;
  eb11.Text := QCite.FieldByName('eb11').AsString;
  EBOL01.Text := QCite.FieldByName('ol1').AsString;
  EBOL02.Text := QCite.FieldByName('ol2').AsString;
  EBOL03.Text := QCite.FieldByName('ol3').AsString;
  CIR_ILR1.Text := QCite.FieldByName('inl1').AsString;
  mCRQuote.Lines.Clear;
  mCRQuote.Lines.Add(QCite.FieldByName('inl2').AsString);
  mCILong.Lines.Clear;
  mCILong.Lines.Add(QCite.FieldByName('ref').AsString);
  lbCICount.Text := IntToStr(QCite.RecNo) + '/' + IntToStr(QCite.RecordCount);
  gCITE := QCite.FieldByName('citeid').AsInteger;
  applym;
end;

procedure TfrmMain.QOutlAfterOpen(DataSet: TDataSet);
var
  i: integer;
  item1: TTreeViewItem;
  //  obj: TTreeViewItem;
begin
  //  obj:=TTreeViewItem.Create(self);
  //clear myTV
  myTV.Clear;
  //clear records and globals
  for i := 0 to 74 do
  begin
    g_node[i].id := i;
    g_node[i].nid := '';
    g_node[i].lbl := '';
    g_node[i].txt := '';
  end;
  eOutlineTitle.Text := '';
  g_letcyc := 1;
  g_id := 0;
  g_noid := 100;
  // is there data
  if QOutl.RecordCount > 0 then
  begin
    //preload globals
    eOutlineTitle.Text := QStry.FieldByName('title').AsString;
    g_letcyc := QStry.FieldByName('cLet').AsInteger;
    g_id := QStry.FieldByName('cNR').AsInteger;
    g_noid := QStry.FieldByName('cNode').AsInteger;
    //load items into records
    QOutl.First;
    i := 0;
    while not QOutl.eof do
    begin
      g_node[i].id := i; //QOutl.FieldByName('creord').AsInteger;
      g_node[i].nid := QOutl.FieldByName('nodeid').AsString;
      g_node[i].stm := QOutl.FieldByName('stemid').AsString;
      g_node[i].lbl := QOutl.FieldByName('nodelbl').AsString;
      g_node[i].txt := QOutl.FieldByName('nodetxt').AsString;
      //create branch
      item1 := TTreeViewItem.Create(Self);
      item1.OnClick := WasSelected;
      item1.Text := g_node[i].lbl;
      if g_node[i].stm <> 'myTV' then
      begin
        item1.Parent := TFmxObject(FindComponent(g_node[i].stm)
          as TTreeViewItem);
      end
      else
        item1.Parent := myTV;
      //
      eNodeLabel.Text := '';
      item1.Name := g_node[i].nid;
      i := i + 1;
      QOutl.Next;
      myTV.Repaint;
    end;
    g_id := i;
  end;
  //

  //  obj.Free;
end;

procedure TfrmMain.QStryAfterOpen(DataSet: TDataSet);
var
  s: string;
begin
  if QStry.RecordCount = 0 then
  begin
    eOutlineTitle.Text := '';
    g_letcyc := 1;
    g_id := 0;
    g_noid := 100;
  end
  else
  begin
    eOutlineTitle.Text := QStry.FieldByName('title').AsString;
    g_letcyc := QStry.FieldByName('cLet').AsInteger;
    g_id := QStry.FieldByName('cNR').AsInteger;
    g_noid := QStry.FieldByName('cNode').AsInteger;
  end;
end;

procedure TfrmMain.tb150Click(Sender: TObject);
begin
  settimer(150, 0);
end;

procedure TfrmMain.tb15Click(Sender: TObject);
begin
  settimer(15, 0);
end;

procedure TfrmMain.tb180Click(Sender: TObject);
begin
  settimer(180, 0);
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
var
  h, ms, tm, ts: Word;
  rd, lb: string;
begin
  if (now >= dt) then
  begin
    tbTime.Text := 'Time Elapsed';
    Timer1.Enabled := false;
    tbTime.Visible := false;
    tmr_go.Text := 'Time Elapsed';
    // beep;
    switchenable;
    audioout('mixkit-police-short-whistle-615b.mp3', 100);
    if cbCFGtiEnd.IsChecked then    
      JnlAdd('[Timer] Expired');
  end
  else
  begin
    DecodeTime((dt - now), h, tm, ts, ms);
    lb := '';
    if h > 0 then
      lb := lb + IntToStr(h)
    else
      lb := '0';
    if tm < 10 then
      lb := lb + 'h 0' + IntToStr(tm)
    else
      lb := lb + 'h ' + IntToStr(tm);
    if ts < 10 then
      lb := lb + 'm 0' + IntToStr(ts) + 's'
    else
      lb := lb + 'm ' + IntToStr(ts) + 's';
    tbTime.Text := lb;
    tbTime.Visible := true;
  end;
end;

procedure TfrmMain.Timer2Timer(Sender: TObject);
var
  rd: string;
begin
  if OutMemAutoSave.IsChecked then
  begin
    if Memo1.Text <> g_daybook then
    begin
      rd := calStr;
      QJnl.Active := false;
      QJnl.SQL.Clear;
      QJnl.SQL.Add('select * from jrnl where jid="' + rd + '"');
      QJnl.Active := true;
      GO.CommandText.Clear;
      if QJnl.RecordCount = 0 then
        GO.CommandText.Add('insert into jrnl(jid,jtxt) values ("' + rd + '",' +
          quotedstr(Memo1.Lines.Text) + ')')
      else
        GO.CommandText.Add('update jrnl set jtxt =' +
          quotedstr(Memo1.Lines.Text) + ' where jid="' + rd + '"');
      GO.Execute;
    end;
  end;
  g_daybook := Memo1.Lines.Text;
end;

procedure TfrmMain.tmr_goClick(Sender: TObject);
var
  dv: TDateTime;
begin
  if tmr_go.Text = 'STOP/PAUSE' then
  begin
    Timer1.Enabled := false;
    nw := now;
    tmr_go.Text := 'RESUME';
    if cbCFGtiPause.IsChecked then    
    JnlAdd('[Timer] Paused');
  end
  else
  begin
    if tmr_go.Text = 'RESUME' then
    begin
      dv := now - nw;
      dt := dt + dv;
      tmr_go.Text := 'STOP/PAUSE';
      Timer1.Enabled := true;
      if cbCFGtiPause.IsChecked then    
      JnlAdd('[Timer] Restarted');
    end;
  end;
  switchenable;
end;

procedure TfrmMain.TPrjAfterOpen(DataSet: TDataSet);
var
  s: string;
begin
  gPRJ := 0;
  if TPrj.RecordCount = 0 then
    exit;
  gPRJ := TPrj.FieldByName('projid').AsInteger;
  lbPIHead.Text := 'Project index (' + IntToStr(gPRJ) + ')';
  ebProject.Text := TPrj.FieldByName('proj_name').AsString;
  ebModule.Text := TPrj.FieldByName('proj_modl').AsString;
  ebSubject.Text := TPrj.FieldByName('proj_subj').AsString;
  QCite.Active := false;
  QCite.SQL.Clear;
  QCite.SQL.Add('select * from citeme where proj=' + IntToStr(gPRJ));
  QCite.Active := true;
  QStry.Active := false;
  QStry.SQL.Clear;
  QStry.SQL.Add('select * from story where proj=' + IntToStr(gPRJ));
  QStry.Active := true;
  QOutl.Active := false;
  QOutl.SQL.Clear;
  QOutl.SQL.Add('select * from outline where proj=' + IntToStr(gPRJ) +
    ' order by creord asc');
  QOutl.Active := true;
end;

procedure TfrmMain.TPrjAfterScroll(DataSet: TDataSet);
begin
  gPRJ := 0;
  if TPrj.RecordCount = 0 then
    exit;
  gPRJ := TPrj.FieldByName('projid').AsInteger;
  lbPIHead.Text := 'Project index (' + IntToStr(gPRJ) + ')';
  ebProject.Text := TPrj.FieldByName('proj_name').AsString;
  ebModule.Text := TPrj.FieldByName('proj_modl').AsString;
  ebSubject.Text := TPrj.FieldByName('proj_subj').AsString;
  QCite.Active := false;
  QCite.SQL.Clear;
  QCite.SQL.Add('select * from citeme where proj=' + IntToStr(gPRJ));
  QCite.Active := true;
  QStry.Active := false;
  QStry.SQL.Clear;
  QStry.SQL.Add('select * from story where proj=' + IntToStr(gPRJ));
  QStry.Active := true;
  QOutl.Active := false;
  QOutl.SQL.Clear;
  QOutl.SQL.Add('select * from outline where proj=' + IntToStr(gPRJ) +
    ' order by creord asc');
  QOutl.Active := true;
end;

procedure TfrmMain.TPrjBeforeScroll(DataSet: TDataSet);
var
  s: string;
  i: integer;
begin
  s := 'delete from outline where proj = ' + IntToStr(gPRJ);
  GO.Execute(s);
  // scroll through nodes and save to outline table
  if g_id > 0 then
  begin
    for i := 0 to g_id do
    begin
      //Only save active TreeViewItems
      if g_node[i].nid > ' ' then
      begin
        s := 'insert into outline ([proj],[creord],[nodeid],' +
          '[stemid],[nodelbl],[nodetxt]) values (' + IntToStr(gPRJ) + ',"' +
          IntToStr(g_node[i].id) + '","' + g_node[i].nid + '","' + g_node[i].stm
          + '","' + g_node[i].lbl + '","' + g_node[i].txt + '")';
        GO.Execute(s);
      end;
    end;
  end;
//    if cbCFGoltiPause.IsChecked then    
//  JnlAdd('Saved Outline: ' + eOutlineTitle.Text);
  //save any changes to the header file

end;

procedure TfrmMain.TrackBar1Change(Sender: TObject);
var
  i: integer;
begin
  i := Floor(TrackBar1.Value);
  Label2.Text := IntToStr(i);
  myTV.Height := TrackBar1.Value;
end;

procedure TfrmMain.TrackBar2Change(Sender: TObject);
var
  i: integer;
begin
  i := Floor(TrackBar2.Value);
  Label13.Text := IntToStr(i);
  (Memo1 as TMemo).Font.Size:=i;
  (mCRQuote as TMemo).Font.Size:=i;
  (mCILong as TMemo).Font.Size:=i;
  (CIR_ILR1 as TEdit).Font.Size:=i;
  (eNodeLabel as TEdit).Font.Size:=i;
  (eOutlineTitle as TEdit).Font.Size:=i;
  (mShow as TMemo).Font.Size:=i;
end;

procedure TfrmMain.settimer(t_m, t_s: integer);
var
  rd: string;
  m, s: integer;
begin
  rd := FormatDateTime('HH:MM', now);
  m := t_m;
  s := t_s;
  //
  dt := now;
  nw := dt;
  dt := IncMinute(dt, m);
  dt := IncSecond(dt, s);
  //
  Timer1.Enabled := true;
  tmr_go.Text := 'STOP/PAUSE';
  //  if s < 10 then
  //    tbTime.Text := IntToStr(m) + ':0' + IntToStr(s)
  //  else
  //    tbTime.Text := IntToStr(m) + ':' + IntToStr(s);
  tmr_go.Enabled := true;
  switchenable;
  if cbCFGtiStart.IsChecked then    
    JnlAdd('[Timer] Started: (' + IntToStr(t_m) + ' min '+ IntToStr(t_s)+' sec)');
end;

procedure TfrmMain.switchenable;
begin
  gpTimerSet.Enabled := not(gpTimerSet.Enabled)
end;

procedure TfrmMain.tb01Click(Sender: TObject);
begin
  settimer(1, 0);
end;

procedure TfrmMain.tb03Click(Sender: TObject);
begin
  settimer(3, 0);
end;

procedure TfrmMain.tb05Click(Sender: TObject);
begin
  settimer(5, 0);
end;

procedure TfrmMain.tb10Click(Sender: TObject);
begin
  settimer(10, 0);
end;

procedure TfrmMain.tb10sClick(Sender: TObject);
begin
  settimer(0, 10);
end;

procedure TfrmMain.tb120Click(Sender: TObject);
begin
  settimer(120, 0);
end;

procedure TfrmMain.tb20Click(Sender: TObject);
begin
  settimer(20, 0);
end;

procedure TfrmMain.tb20sClick(Sender: TObject);
begin
  settimer(0, 20);
end;

procedure TfrmMain.tb25Click(Sender: TObject);
begin
  settimer(25, 0);
end;

procedure TfrmMain.tb30Click(Sender: TObject);
begin
  settimer(30, 0);
end;

procedure TfrmMain.tb30sClick(Sender: TObject);
begin
  settimer(0, 30);
end;

procedure TfrmMain.tb45Click(Sender: TObject);
begin
  settimer(45, 0);
end;

procedure TfrmMain.tb60Click(Sender: TObject);
begin
  settimer(60, 0);
end;

procedure TfrmMain.tb75Click(Sender: TObject);
begin
  settimer(75, 0);
end;

procedure TfrmMain.tb90Click(Sender: TObject);
begin
  settimer(90, 0);
end;

procedure TfrmMain.audioout(cfn: string; vol: integer);
var
  mfn: string;
begin
{$IF DEFINED(mswindows)}
  mfn := ExtractFilePath(ParamStr(0)) + cfn;
{$ENDIF}
{$IF DEFINED (ANDROID)}
  mfn := TPath.Combine(TPath.GetDocumentsPath, cfn);
{$ENDIF}
  //  ShowMessage(mfn);
  MediaP.CurrentTime := 0;
  MediaP.FileName := mfn;
  MediaP.Volume := vol;
  MediaP.Play;
end;

// cite begin

procedure TfrmMain.bCIOutputClick(Sender: TObject);
var
  sg: TMemo;
begin
  sg := TMemo.Create(Self);
  sg.Lines.Clear;
  QCite.First;
  isoup := true;
  while not(QCite.eof) do
  begin
    sg.Lines.Add(QCite.FieldByName('ref').AsString);
    QCite.Next;
  end;
  isoup := false;
  sg.Lines.SaveToFile('CIR_' + ebProject.Text + '.txt');
  sg.Free;
  ShowMessage('file created');
end;

procedure TfrmMain.bPISaveClick(Sender: TObject);
var
  s: string;
begin
  s := 'insert into project([proj_name],[proj_modl],[proj_subj],[proj_creat]) '
    + 'values ("' + trim(ebProject.Text) + '","' + trim(ebModule.Text) + '","' +
    trim(ebSubject.Text) + '","' + FormatDateTime('yyyy/mm/dd', now) + '")';
  GO.Execute(s);
  TPrj.Refresh;
  TPrj.Last;
  lblPICount.Text := IntToStr(TPrj.RecNo) + '/' + IntToStr(TPrj.RecordCount);
  if cbCFGprCreate.IsChecked then
  JnlAdd('[Project] Created: '+trim(ebProject.Text));
end;

procedure TfrmMain.bCRAccessedClick(Sender: TObject);
begin
  EBOL03.Text := FormatDateTime('dd mmmm yyyy', now);
end;

procedure TfrmMain.bCRMakeClick(Sender: TObject);
begin
  CIR.zProject := ebProject.Text;
  CIR.zModule := ebModule.Text;
  CIR.zSubject := ebSubject.Text;
  CIR.zCreated := FormatDateTime('yyyy/mm/dd', now);
  if cbBibliogOnly.IsChecked = true then
    CIR.zBibOnly := 'BIBLIOGRAPHY'
  else
    CIR.zBibOnly := 'CITATION';
  BuildCIR(CIR.zType);
  tcBook.ActiveTab := tsCIView;
end;

procedure TfrmMain.bCRResetClick(Sender: TObject);
begin
  eb01.Text := '';
  eb02.Text := '';
  eb03.Text := '';
  eb04.Text := '';
  eb05.Text := '';
  eb06.Text := '';
  eb07.Text := '';
  eb08.Text := '';
  eb09.Text := '';
  eb10.Text := '';
  eb11.Text := '';
  EBOL01.Text := '';
  EBOL02.Text := '';
  EBOL03.Text := '';
  //  cbOnline.IsChecked := false;
  mCRQuote.Lines.Clear;
  CIR_ILR1.Text := '';
  mCILong.Lines.Clear;
  tcBook.ActiveTab := tsCRChooseType;
end;

procedure TfrmMain.DTAAfterConnect(Sender: TObject);
var
  s: string;
begin

  s := 'CREATE TABLE IF NOT EXISTS "project" (';
  s := s + '"projid"	INTEGER NOT NULL,';
  s := s + '"proj_name"	TEXT NOT NULL, ';
  s := s + '"proj_modl"	TEXT NOT NULL DEFAULT "-", ';
  s := s + '"proj_subj"	TEXT NOT NULL DEFAULT "-", ';
  s := s + '"proj_creat"	TEXT, ';
  s := s + 'PRIMARY KEY("projid" AUTOINCREMENT)';
  s := s + ')';
  GO.Execute(s);

  s := 'CREATE TABLE IF NOT EXISTS "citeme" (';
  s := s + '"citeid"	INTEGER NOT NULL,';
  s := s + '"proj"	INTEGER NOT NULL,';
  s := s + '"typ"	TEXT,';
  s := s + '"eb01"	TEXT,';
  s := s + '"eb02"	TEXT,';
  s := s + '"eb03"	TEXT,';
  s := s + '"eb04"	TEXT,';
  s := s + '"eb05"	TEXT,';
  s := s + '"eb06"	TEXT,';
  s := s + '"eb07"	TEXT,';
  s := s + '"eb08"	TEXT,';
  s := s + '"eb09"	TEXT,';
  s := s + '"eb10"	TEXT,';
  s := s + '"eb11"	TEXT,';
  s := s + '"ol1"	TEXT,';
  s := s + '"ol2"	TEXT,';
  s := s + '"ol3"	TEXT,';
  s := s + '"inl1"	TEXT,';
  s := s + '"inl2"	TEXT,';
  s := s + '"ref"	TEXT,';
  s := s + '"biblio"	TEXT,';
  s := s + '"created"	TEXT,';
  s := s + 'PRIMARY KEY("citeid" AUTOINCREMENT)';
  s := s + ')';
  GO.Execute(s);

  s := 'CREATE UNIQUE INDEX IF NOT EXISTS pidx ON project (';
  s := s + '"proj_name"	ASC, ';
  s := s + '"proj_modl"	ASC, ';
  s := s + '"proj_subj"	ASC)';

  s := 'CREATE TABLE IF NOT EXISTS "jrnl" (';
  s := s + '"jid"	TEXT NOT NULL,';
  s := s + '"jtxt"	TEXT , ';
  s := s + 'PRIMARY KEY("jid")';
  s := s + ')';
  GO.Execute(s);

  s := 'CREATE TABLE IF NOT EXISTS "story" (';
  s := s + '"id"	INTEGER NOT NULL,';
  s := s + '"proj"	INTEGER NOT NULL,';
  s := s + '"title"	TEXT NOT NULL DEFAULT "TBD",';
  s := s + '"cLet" INTEGER NOT NULL DEFAULT 0,';
  s := s + '"cNR" INTEGER NOT NULL DEFAULT 110,';
  s := s + '"cNode" INTEGER NOT NULL,';
  s := s + 'PRIMARY KEY("id" AUTOINCREMENT)';
  s := s + ')';
  GO.Execute(s);

  s := 'CREATE TABLE IF NOT EXISTS "outline" (';
  s := s + '"id"	INTEGER NOT NULL,';
  s := s + '"proj"	INTEGER NOT NULL,';
  s := s + '"creord" INTEGER NOT NULL,';
  s := s + '"nodeid" TEXT NOT NULL,';
  s := s + '"stemid" TEXT NOT NULL,';
  s := s + '"nodelbl"	TEXT NOT NULL, ';
  s := s + '"nodetxt"	TEXT NOT NULL, ';
  s := s + 'PRIMARY KEY("id" AUTOINCREMENT)';
  s := s + ')';
  GO.Execute(s);

  TPrj.Active := true;
  TPrj.First;

  lblPICount.Text := IntToStr(TPrj.RecNo) + '/' + IntToStr(TPrj.RecordCount);
end;

procedure TfrmMain.ApplyClick(Sender: TObject);
begin
  applym;
  tcProj.ActiveTab := tsCREntry;
end;

procedure TfrmMain.applym;
begin
  eb01.Enabled := true;
  eb02.Enabled := true;
  eb03.Enabled := true;
  eb04.Enabled := true;
  eb05.Enabled := true;
  eb06.Enabled := true;
  eb07.Enabled := true;
  eb08.Enabled := true;
  eb09.Enabled := true;
  eb10.Enabled := true;
  eb11.Enabled := true;
  EBOL01.Enabled := true;
  EBOL02.Enabled := true;
  EBOL03.Enabled := true;
  eb01.TextPrompt := ' ';
  eb02.TextPrompt := ' ';
  eb03.TextPrompt := ' ';
  eb04.TextPrompt := ' ';
  eb05.TextPrompt := ' ';
  eb06.TextPrompt := ' ';
  eb07.TextPrompt := ' ';
  eb08.TextPrompt := ' ';
  eb09.TextPrompt := ' ';
  eb10.TextPrompt := ' ';
  eb11.TextPrompt := ' ';
  EBOL01.TextPrompt := ' ';
  EBOL02.TextPrompt := ' ';
  EBOL03.TextPrompt := ' ';
  CIR.zProject := ebProject.Text;
  CIR.zModule := ebModule.Text;
  CIR.zSubject := ebSubject.Text;
  CIR.zCreated := FormatDateTime('yyyy/mm/dd', now);
  CIR.zType := '';

  if rgWebMagNoPrint.IsChecked then
  begin
    CIR.zType := 'WW:MAGNP';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Article';
    eb04.TextPrompt := 'Title of Publication';
    eb05.TextPrompt := 'Volume';
    eb06.TextPrompt := 'Issue';
    eb07.TextPrompt := 'Page: X or X-Y';
    eb08.TextPrompt := ' ';
    eb09.TextPrompt := ' ';
    eb10.TextPrompt := ' ';
    eb11.TextPrompt := ' ';
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgBookAuth.IsChecked then
  begin
    CIR.zType := 'BK:AUTH';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Publication';
    eb04.TextPrompt := 'Edition';
    eb05.TextPrompt := 'Place of Publication';
    eb06.TextPrompt := 'Publisher Name';
    eb07.TextPrompt := 'Edited by: Init. Surname';
    eb08.TextPrompt := 'Volumes: (x Volumes)';
    eb09.TextPrompt := 'Page: p. X|pp. X-Y';
    eb10.TextPrompt := ' ';
    eb11.TextPrompt := ' ';
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgBookNoAuth.IsChecked then
  begin
    CIR.zType := 'BK:NOAUTH';
    eb01.TextPrompt := 'Title of Publication';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Edition';
    eb04.TextPrompt := 'Place of Publication';
    eb05.TextPrompt := 'Publisher Name';
    eb06.TextPrompt := 'Edited by: Init. Surname';
    eb07.TextPrompt := 'Volumes: (x Volumes)';
    eb08.TextPrompt := 'Page: p. X|pp. X-Y';
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgBookOrgAuth.IsChecked then
  begin
    CIR.zType := 'BK:ORG';
    eb01.TextPrompt := 'Organisation Name';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Publication';
    eb04.TextPrompt := 'Edition';
    eb05.TextPrompt := 'Place of Publication';
    eb06.TextPrompt := 'Publisher Name';
    eb07.TextPrompt := 'Edited by: Init. Surname';
    eb08.TextPrompt := 'Volumes: (x Volumes)';
    eb09.TextPrompt := 'Page: p. X|pp. X-Y';
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgBookReprint.IsChecked then
  begin
    CIR.zType := 'BK:REPR';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Original';
    eb03.TextPrompt := 'Title of Publication';
    eb04.TextPrompt := 'Edition Reprinted';
    eb05.TextPrompt := 'Place of Publication';
    eb06.TextPrompt := 'Publisher Name';
    eb07.TextPrompt := 'Year of reprint';
    eb08.TextPrompt := ' ';
    eb09.TextPrompt := ' ';
    eb10.TextPrompt := ' ';
    eb11.TextPrompt := ' ';
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgBookFacsimile.IsChecked then
  begin
    CIR.zType := 'BK:FACS';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Publication';
    eb04.TextPrompt := 'Edition Copied';
    eb05.TextPrompt := 'Place of Publication';
    eb06.TextPrompt := 'Publisher Name';
    eb07.TextPrompt := 'Year of Facsimile';
    eb08.TextPrompt := ' ';
    eb09.TextPrompt := ' ';
    eb10.TextPrompt := ' ';
    eb11.TextPrompt := ' ';
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgAnthology.IsChecked then
  begin
    CIR.zType := 'BK:ANTH';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Role';
    eb03.TextPrompt := 'Year of Publication';
    eb04.TextPrompt := 'Title of Publication';
    eb05.TextPrompt := 'Edition';
    eb06.TextPrompt := 'Place of Publication';
    eb07.TextPrompt := 'Publisher Name';
    eb08.TextPrompt := 'Page: p. X|pp. X-Y';
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgAnthologyLine.IsChecked then
  begin
    CIR.zType := 'BK:ANLN';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Poem/Art';
    eb04.TextPrompt := 'Surname, Init.';
    eb05.TextPrompt := 'Role';
    eb06.TextPrompt := 'Title of Publication';
    eb07.TextPrompt := 'Place of Publication';
    eb08.TextPrompt := 'Publisher Name';
    eb09.TextPrompt := 'Page: p. X|pp. X-Y';
    //    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgReference.IsChecked then
  begin
    CIR.zType := 'BK:REF';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Article Title';
    eb04.TextPrompt := 'Editors: Init. Surname';
    eb05.TextPrompt := 'Publication Title';
    eb06.TextPrompt := 'Edition';
    eb07.TextPrompt := 'Place of Publication';
    eb08.TextPrompt := 'Publisher Name';
    eb09.TextPrompt := 'Page: p. X|pp. X-Y';
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgBible.IsChecked then
  begin
    CIR.zType := 'BK:BIBL';
    eb01.TextPrompt := 'Publication Title';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Optional: Translator Edition';
    eb04.TextPrompt := 'Place of Publication';
    eb05.TextPrompt := 'Publisher Name';
    eb06.TextPrompt := 'Page: p. X|pp. X-Y|Ref';
    eb07.TextPrompt := 'Bible Short Code';
    eb08.TextPrompt := ' ';
    eb09.TextPrompt := ' ';
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgBookCollected.IsChecked then
  begin
    CIR.zType := 'BK:COLL';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Publication';
    eb04.TextPrompt := 'Edition';
    eb05.TextPrompt := 'Volumes';
    eb06.TextPrompt := 'Place of Publication';
    eb07.TextPrompt := 'Publisher Name';
    eb08.TextPrompt := 'Page: p. X|pp. X-Y';
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgBookChap.IsChecked then
  begin
    CIR.zType := 'BK:CHAP';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Chapter';
    eb04.TextPrompt := 'Editors';
    eb05.TextPrompt := 'Title of Publication';
    eb06.TextPrompt := 'Place of Publication';
    eb07.TextPrompt := 'Publisher Name';
    eb08.TextPrompt := 'Page: p. X|pp. X-Y';
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgBookPartChap.IsChecked then
  begin
    CIR.zType := 'BK:CHPT';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Chapter';
    eb04.TextPrompt := 'Editors';
    eb05.TextPrompt := 'Title of Publication';
    eb06.TextPrompt := 'Place of Publication';
    eb07.TextPrompt := 'Publisher Name';
    eb08.TextPrompt := 'Extract: Page: p. X|pp. X-Y';
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgJournalArt.IsChecked then
  begin
    CIR.zType := 'JN:ART';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Article';
    eb04.TextPrompt := 'Title of Publication';
    eb05.TextPrompt := 'Volume(Part)';
    eb06.TextPrompt := 'Page: p. X|pp. X-Y';
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgJournalWhole.IsChecked then
  begin
    CIR.zType := 'JN:FULL';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Role';
    eb03.TextPrompt := 'Year of Publication';
    eb04.TextPrompt := 'Title of Article';
    eb05.TextPrompt := 'Title of Publication';
    eb06.TextPrompt := 'Volume(Part)';
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgWebAuth.IsChecked then
  begin
    CIR.zType := 'WW:AUTH';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Page';
    eb04.Enabled := false;
    eb05.Enabled := false;
    eb06.Enabled := false;
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgWebOrg.IsChecked then
  begin
    CIR.zType := 'WW:ORG';
    eb01.TextPrompt := 'Organisation.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Page';
    eb04.Enabled := false;
    eb05.Enabled := false;
    eb06.Enabled := false;
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgWebNoAuth.IsChecked then
  begin
    CIR.zType := 'WW:NONE';
    eb01.TextPrompt := 'Title of Page';
    eb02.TextPrompt := 'Year of Publication';
    eb03.Enabled := false;
    eb04.Enabled := false;
    eb05.Enabled := false;
    eb06.Enabled := false;
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgSocialMedia.IsChecked then
  begin
    eb02.Text := FormatDateTime('yyyy', now);
    eb05.Text := FormatDateTime('dd mmmm', now);
    CIR.zType := 'SM:ALL';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Article';
    eb04.TextPrompt := 'Platform/APP';
    eb05.TextPrompt := 'Day Month';
    eb06.Enabled := false;
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgNewsByline.IsChecked then
  begin
    eb02.Text := FormatDateTime('yyyy', now);
    eb06.Text := FormatDateTime('dd mmmm', now);
    CIR.zType := 'NW:BYLN';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Article';
    eb04.TextPrompt := 'Newspaper';
    eb05.TextPrompt := 'Edition';
    eb06.TextPrompt := 'Day Month';
    eb07.TextPrompt := 'Page: p. X|pp. X-Y';
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgNewsNoByline.IsChecked then
  begin
    eb02.Text := FormatDateTime('yyyy', now);
    eb05.Text := FormatDateTime('dd mmmm', now);
    CIR.zType := 'NW:NOBY';
    eb01.TextPrompt := 'Newspaper';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Article';
    eb04.TextPrompt := 'Edition';
    eb05.TextPrompt := 'Day Month';
    eb06.TextPrompt := 'Page: p. X|pp. X-Y';
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgPainting.IsChecked then
  begin
    eb06.Text := FormatDateTime('dd mmmm yyyy', now);
    CIR.zType := 'AR:PNTG';
    eb01.TextPrompt := 'Author: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Work';
    eb04.TextPrompt := 'Media used';
    eb05.TextPrompt := 'Location';
    eb06.TextPrompt := 'Date Viewed';
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgPhotographicPrint.IsChecked then
  begin
    //  	eb06.text := formatdatetime('dd mmmm yyyy', Now);
    CIR.zType := 'AR:PHBK';
    eb01.TextPrompt := 'Photographer: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Work';
    eb04.TextPrompt := 'Media used';
    eb05.TextPrompt := 'Place of Publication';
    eb06.TextPrompt := 'Publisher Name';
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgPhotographWeb.IsChecked then
  begin
    //  	eb06.text := formatdatetime('dd mmmm yyyy', Now);
    CIR.zType := 'AR:PHWW';
    eb01.TextPrompt := 'Photographer: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Work';
    eb04.Enabled := false;
    eb05.Enabled := false;
    eb06.Enabled := false;
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
    //    cbOnline.IsChecked := True;
  end;

  if rgPodcast.IsChecked then
  begin
    //  	eb06.text := formatdatetime('dd mmmm yyyy', Now);
    CIR.zType := 'AV:PODC';
    eb02.Text := FormatDateTime('yyyy', now);
    eb05.Text := FormatDateTime('dd mmmm', now);
    eb01.TextPrompt := 'Host: Surname, Init.';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Podcast';
    eb04.TextPrompt := 'Media used';
    eb05.TextPrompt := 'Day Month';
    eb06.TextPrompt := 'Place of Publication';
    eb07.TextPrompt := 'Publisher Name';
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgRadio.IsChecked then
  begin
    eb02.Text := FormatDateTime('yyyy', now);
    eb04.Text := FormatDateTime('dd mmmm', now);
    CIR.zType := 'AV:RDIO';
    eb01.TextPrompt := 'Title of Show';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Broadcaster';
    eb04.TextPrompt := 'Day Month';
    eb05.Enabled := false;
    eb06.Enabled := false;
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgTVSingle.IsChecked then
  begin
    eb02.Text := FormatDateTime('yyyy', now);
    //    cbOnline.IsChecked := True;
    eb04.Text := FormatDateTime('dd mmmm', now);
    CIR.zType := 'AV:TV';
    eb01.TextPrompt := 'Title of Show';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Broadcaster';
    eb04.TextPrompt := 'Day Month';
    eb05.Enabled := false;
    eb06.Enabled := false;
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgTVEpisodeSeries.IsChecked then
  begin
    //    cbOnline.IsChecked := True;
    eb06.Text := FormatDateTime('dd mmmm', now);
    CIR.zType := 'AV:TVSE';
    eb01.TextPrompt := 'Title of Episode';
    eb02.TextPrompt := 'Year of Publication';
    eb03.TextPrompt := 'Title of Show';
    eb04.TextPrompt := 'Series(Episode#)';
    eb05.TextPrompt := 'Broadcaster';
    eb06.TextPrompt := 'Day Month';
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgMovies.IsChecked then
  begin
    //    cbOnline.IsChecked:=true;
    //  	eb06.text := formatdatetime('dd mmmm', Now);
    CIR.zType := 'AV:MOVI';
    eb01.TextPrompt := 'Title of Movie';
    eb02.TextPrompt := 'Year of Production';
    eb03.TextPrompt := 'Director';
    eb04.TextPrompt := 'Format [DVD/STREAM/CINEMA]';
    eb05.TextPrompt := 'Place of Publication';
    eb06.TextPrompt := 'Publisher Name';
    eb07.TextPrompt := 'Reissue Year';
    eb08.TextPrompt := 'Reprint Year';
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgVLELectureNotes.IsChecked then
  begin
    //    cbOnline.IsChecked := True;
    //  	eb06.text := formatdatetime('dd mmmm', Now);
    CIR.zType := 'VL:NTES';
    eb01.TextPrompt := 'Author/Tutor';
    eb02.TextPrompt := 'Year of Production';
    eb03.TextPrompt := 'Title of Item';
    eb04.TextPrompt := 'Module Code: Title';
    eb05.TextPrompt := 'Place of Publication';
    eb06.TextPrompt := 'Institution Name';
    eb06.Enabled := false;
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgVLETutorHandout.IsChecked then
  begin
    //    cbOnline.IsChecked := True;
    eb06.Text := 'Unpublished';
    CIR.zType := 'VL:HAND';
    eb01.TextPrompt := 'Author/Tutor';
    eb02.TextPrompt := 'Year of Production';
    eb03.TextPrompt := 'Title of Handout';
    eb04.TextPrompt := 'Module Code: Title';
    eb05.TextPrompt := 'Institution Name';
    eb06.TextPrompt := 'Published';
    eb07.Enabled := false;
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  if rgConfPaper.IsChecked then
  begin
    CIR.zType := 'CF:PAPR';
    //	//  Surname, Initial.
    //	//  Year of publication (in round brackets)
    //	//  Title of paper (in single quotation marks)
    //	//  Title of conference (in italics)
    //	//  Organisation or company (if stated)
    //	//  Location and date of conference
    //	//  Available at: DOI or URL (Accessed: date)
    eb01.TextPrompt := 'Author/Speaker';
    eb02.TextPrompt := 'Year of Presentation';
    eb03.TextPrompt := 'Title of Paper';
    eb04.TextPrompt := 'Title of Conference';
    eb05.TextPrompt := 'Org/Company';
    eb06.TextPrompt := 'Module Code: Title';
    eb07.TextPrompt := 'Locn and Date of Conference';
    eb08.Enabled := false;
    eb09.Enabled := false;
    eb10.Enabled := false;
    eb11.Enabled := false;
  end;

  //  EBOL03.Text := formatdatetime('dd mmmm yyyy', Now);
  EBOL01.TextPrompt := 'www/doi/location';
  EBOL02.TextPrompt := 'last updated';
  EBOL03.TextPrompt := 'Accessed';
  EBOL01.Enabled := true;
  EBOL02.Enabled := true;
  EBOL03.Enabled := true;
  bCRAccessed.Enabled := true;
end;

procedure TfrmMain.bCIDelClick(Sender: TObject);

var
  s: string;
begin
  s := 'delete from citeme where citeid=' + IntToStr(gCITE);
  GO.Execute(s);
  QCite.Refresh;
  lbCICount.Text := IntToStr(QCite.RecNo) + '/' + IntToStr(QCite.RecordCount);
  if QCite.RecordCount = 0 then
  begin
    eb01.Text := '';
    eb02.Text := '';
    eb03.Text := '';
    eb04.Text := '';
    eb05.Text := '';
    eb06.Text := '';
    eb07.Text := '';
    eb08.Text := '';
    eb09.Text := '';
    eb10.Text := '';
    eb11.Text := '';
    EBOL01.Text := '';
    EBOL02.Text := '';
    EBOL03.Text := '';
    //  cbOnline.IsChecked := false;
    mCRQuote.Lines.Clear;
    CIR_ILR1.Text := '';
    mCILong.Lines.Clear;

  end;
end;

procedure TfrmMain.bCIFirstClick(Sender: TObject);
begin
  QCite.First;
  lbCICount.Text := IntToStr(QCite.RecNo) + '/' + IntToStr(QCite.RecordCount);
end;

procedure TfrmMain.bCILastClick(Sender: TObject);
begin
  QCite.Last;
  lbCICount.Text := IntToStr(QCite.RecNo) + '/' + IntToStr(QCite.RecordCount);
end;

procedure TfrmMain.bCINewClick(Sender: TObject);
begin
  tcProj.ActiveTab := tsCRChooseType;
  gCITE := 0;
end;

procedure TfrmMain.bCINextClick(Sender: TObject);
begin
  QCite.Next;
  lbCICount.Text := IntToStr(QCite.RecNo) + '/' + IntToStr(QCite.RecordCount);
end;

procedure TfrmMain.bCIPrevClick(Sender: TObject);
begin
  QCite.Prior;
  lbCICount.Text := IntToStr(QCite.RecNo) + '/' + IntToStr(QCite.RecordCount);
end;

procedure TfrmMain.bCISaveClick(Sender: TObject);
var
  s, u: string;
begin
  //  t:=QCite.FieldByName('typ').AsString;
  if rgBookAuth.IsChecked = true then
    CIR.zType := 'BK:AUTH';
  if rgBookNoAuth.IsChecked = true then
    CIR.zType := 'BK:NOAUTH';
  if rgBookOrgAuth.IsChecked = true then
    CIR.zType := 'BK:ORG';
  if rgBookReprint.IsChecked = true then
    CIR.zType := 'BK:REPR';
  if rgBookFacsimile.IsChecked = true then
    CIR.zType := 'BK:FACS';
  if rgAnthology.IsChecked = true then
    CIR.zType := 'BK:ANTH';
  if rgAnthologyLine.IsChecked = true then
    CIR.zType := 'BK:ANLN';
  if rgReference.IsChecked = true then
    CIR.zType := 'BK:REF';
  if rgBible.IsChecked = true then
    CIR.zType := 'BK:BIBL';
  if rgBookCollected.IsChecked = true then
    CIR.zType := 'BK:COLL';
  if rgBookChap.IsChecked = true then
    CIR.zType := 'BK:CHAP';
  if rgBookPartChap.IsChecked = true then
    CIR.zType := 'BK:CHPT';

  if rgJournalArt.IsChecked = true then
    CIR.zType := 'JN:ART';
  if rgJournalWhole.IsChecked = true then
    CIR.zType := 'JN:FULL';

  if rgWebAuth.IsChecked = true then
    CIR.zType := 'WW:AUTH';
  if rgWebOrg.IsChecked = true then
    CIR.zType := 'WW:ORG';
  if rgWebNoAuth.IsChecked = true then
    CIR.zType := 'WW:NONE';

  if rgWebMagNoPrint.IsChecked = true then
    CIR.zType := 'WW:MAGNP';

  if rgSocialMedia.IsChecked = true then
    CIR.zType := 'SM:ALL';

  if rgNewsByline.IsChecked = true then
    CIR.zType := 'NW:BYLN';
  if rgNewsNoByline.IsChecked = true then
    CIR.zType := 'NW:NOBY';
  if rgPainting.IsChecked = true then
    CIR.zType := 'AR:PNTG';
  if rgPhotographicPrint.IsChecked = true then
    CIR.zType := 'AR:PHBK';
  if rgPhotographWeb.IsChecked = true then
    CIR.zType := 'AR:PHWW';

  if rgPodcast.IsChecked = true then
    CIR.zType := 'AV:PODC';
  if rgRadio.IsChecked = true then
    CIR.zType := 'AV:RDIO';

  if rgTVSingle.IsChecked = true then
    CIR.zType := 'AV:TV';
  if rgTVEpisodeSeries.IsChecked = true then
    CIR.zType := 'AV:TVSE';

  if rgRadio.IsChecked = true then
    CIR.zType := 'AV:RDIO';

  if rgMovies.IsChecked = true then
    CIR.zType := 'AV:MOVI';

  if rgVLELectureNotes.IsChecked = true then
    CIR.zType := 'VL:NTES';
  if rgVLETutorHandout.IsChecked = true then
    CIR.zType := 'VL:HAND';
  if rgConfPaper.IsChecked = true then
    CIR.zType := 'CF:PAPR';

  //
  //  if .IsChecked = true then
  //  cir.zType:= 'BK:';
  //  if .IsChecked = true then
  //  cir.zType:= 'BK:';
  //  if .IsChecked = true then
  //  cir.zType:= 'BK:';
  //  if .IsChecked = true then
  //  cir.zType:= 'BK:';
  //  if .IsChecked = true then
  //  cir.zType:= 'BK:';

  if gCITE = 0 then
  begin
    //    QCite.Last;
    s := 'insert into citeme([proj],[typ],[eb01],' +
      '[eb02],[eb03],[eb04],[eb05],[eb06],[eb07],' +
      '[eb08],[eb09],[eb10],[eb11],[ol1],[ol2],' +
      '[ol3],[inl1],[inl2],[ref],[biblio],[created]' + ')  values (' +
      IntToStr(gPRJ) + ',"' + CIR.zType + '","' + trim(eb01.Text) + '","' +
      trim(eb02.Text) + '","' + trim(eb03.Text) + '","' + trim(eb04.Text) +
      '","' + trim(eb05.Text) + '","' + trim(eb06.Text) + '","' +
      trim(eb07.Text) + '","' + trim(eb08.Text) + '","' + trim(eb09.Text) +
      '","' + trim(eb10.Text) + '","' + trim(eb11.Text) + '","' +
      trim(EBOL01.Text) + '","' + trim(EBOL02.Text) + '","' + trim(EBOL03.Text)
      + '","' + trim(CIR_ILR1.Text) + '","' + trim(mCRQuote.Lines.Text) + '","'
      + trim(mCILong.Lines.Text) + '",';
    if cbBibliogOnly.IsChecked = true then
      s := s + '"BIBLIOGRAPHY","'
    else
      s := s + '"CITATION","';
    s := s + FormatDateTime('yyyy/mm/dd', now) + '")';
    GO.Execute(s);
  if cbCFGciCreate.IsChecked then
    JnlAdd('[Citation] Created: ' + CIR_ILR1.Text)
  end
  else
  begin
    u := 'update citeme set ' + '[proj]=' + IntToStr(gPRJ) + ',' + '[typ]="' +
      CIR.zType + '",' + '[eb01]="' + trim(eb01.Text) + '",' + '[eb02]="' +
      trim(eb02.Text) + '",' + '[eb03]="' + trim(eb03.Text) + '",' + '[eb04]="'
      + trim(eb04.Text) + '",' + '[eb05]="' + trim(eb05.Text) + '",' +
      '[eb06]="' + trim(eb06.Text) + '",' + '[eb07]="' + trim(eb07.Text) + '",'
      + '[eb08]="' + trim(eb08.Text) + '",' + '[eb09]="' + trim(eb09.Text) +
      '",' + '[eb10]="' + trim(eb10.Text) + '",' + '[eb11]="' + trim(eb11.Text)
      + '",' + '[ol1]="' + trim(EBOL01.Text) + '",' + '[ol2]="' +
      trim(EBOL02.Text) + '",' + '[ol3]="' + trim(EBOL03.Text) + '",' +
      '[inl1]="' + trim(CIR_ILR1.Text) + '",' + '[inl2]="' +
      trim(mCRQuote.Lines.Text) + '",' + '[ref]="' +
      trim(mCILong.Lines.Text) + '",';
    if cbBibliogOnly.IsChecked = true then
      u := u + '[biblio]="BIBLIOGRAPHY",'
    else
      u := u + '[biblio]="CITATION",';
    u := u + '[created]="' + FormatDateTime('yyyy/mm/dd', now);
    u := u + '" where citeid=' + IntToStr(gCITE);
    GO.Execute(u);
  if cbCFGciUpdates.IsChecked then
    JnlAdd('[Citation] Updated: ' + CIR_ILR1.Text)
  end;
  QCite.Active := false;
  QCite.SQL.Clear;
  QCite.SQL.Add('select * from citeme where proj=' + IntToStr(gPRJ));
  QCite.Active := true;
  QCite.Last;
  lbCICount.Text := IntToStr(QCite.RecNo) + '/' + IntToStr(QCite.RecordCount);
end;

procedure TfrmMain.bPIDelClick(Sender: TObject);
var
  s: string;
begin
  s := 'delete from project where projid=' + IntToStr(gPRJ);
  GO.Execute(s);
  TPrj.Refresh;
  if TPrj.RecordCount = 0 then
  begin
    gPRJ := 0;
    //  gPRJ:=tPRJ.FieldByName('projid').AsInteger;
    ebProject.Text := '';
    ebModule.Text := '';
    ebSubject.Text := '';
  end;
  lblPICount.Text := IntToStr(TPrj.RecNo) + '/' + IntToStr(TPrj.RecordCount);
end;

procedure TfrmMain.bPIFirstClick(Sender: TObject);
begin
  if TPrj.Active = false then
    TPrj.Active := true;
  TPrj.First;
  lblPICount.Text := IntToStr(TPrj.RecNo) + '/' + IntToStr(TPrj.RecordCount);
end;

procedure TfrmMain.bPILastClick(Sender: TObject);
begin
  if TPrj.Active = false then
    TPrj.Active := true;
  TPrj.Last;
  lblPICount.Text := IntToStr(TPrj.RecNo) + '/' + IntToStr(TPrj.RecordCount);
end;

procedure TfrmMain.bPINextClick(Sender: TObject);
begin
  if TPrj.Active = false then
    TPrj.Active := true;
  TPrj.Next;
  lblPICount.Text := IntToStr(TPrj.RecNo) + '/' + IntToStr(TPrj.RecordCount);
end;

procedure TfrmMain.bPIPrevClick(Sender: TObject);
begin
  if TPrj.Active = false then
    TPrj.Active := true;
  TPrj.Prior;
  lblPICount.Text := IntToStr(TPrj.RecNo) + '/' + IntToStr(TPrj.RecordCount);
end;

procedure TfrmMain.BuildCIR(st: string);
var
  il1, il2, ref: string;
  f_com, f_stp, f_itl, f_sq: string;
begin

  // reset
  f_com := ', ';
  f_stp := '.';
  f_itl := '~~~';
  f_sq := '<qs>';
  il1 := '';
  il2 := '';
  ref := '';
  //
  // default inline start
  il1 := '(' + eb01.Text + ', ' + eb02.Text;

  if rgWebMagNoPrint.IsChecked then
  begin
    // inline
    if eb07.Text > ' ' then
      if Pos('-', eb07.Text) > 0 then
        il1 := il1 + f_com + 'pp. ' + eb07.Text
      else
        il1 := il1 + f_com + 'p. ' + eb07.Text;
    // citation
    ref := eb01.Text + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + '<qs>' + eb03.Text + '<qs>';
    if eb04.Text > ' ' then
      ref := ref + f_com + '~~~' + eb04.Text + '~~~';
    if eb05.Text > ' ' then
      ref := ref + f_com + eb05.Text;
    if eb06.Text > ' ' then
      ref := ref + f_com + '(' + eb06.Text + '),';
    if eb07.Text > ' ' then
      if Pos('-', eb07.Text) > 0 then
        ref := ref + f_com + ' pp. ' + eb07.Text + '.'
      else
        ref := ref + f_com + ' p. ' + eb07.Text + '.';
  end;

  if rgBookAuth.IsChecked then
  begin
    // inline
    if eb09.Text > ' ' then
      if Pos('-', eb09.Text) > 0 then
        il1 := il1 + f_com + 'pp. ' + eb09.Text
      else
        il1 := il1 + f_com + 'p. ' + eb09.Text;
    // citation
    ref := eb01.Text + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + '~~~' + eb03.Text + '~~~';
    if eb04.Text > ' ' then
      ref := ref + f_com + eb04.Text + ' edn. ';
    ref := ref + ' ' + eb05.Text + ': ' + eb06.Text;
    if eb07.Text > ' ' then
      ref := ref + f_com + 'Edited by ' + eb07.Text;
    if eb08.Text > ' ' then
      ref := ref + f_com + '(' + eb08.Text + ' Vols)';
  end;
  //
  if rgBookNoAuth.IsChecked then
  begin
    // inline
    il1 := '(~~~' + eb01.Text + '~~~' + f_com + eb02.Text;
    if eb08.Text > ' ' then
      if Pos('-', eb08.Text) > 0 then
        il1 := il1 + f_com + 'pp. ' + eb08.Text
      else
        il1 := il1 + f_com + 'p. ' + eb08.Text;
    // citation
    ref := '~~~' + eb01.Text + '~~~';
    if eb03.Text > ' ' then
      ref := ref + f_com + eb03.Text;
    ref := ref + f_com + '(' + eb02.Text + ')';
    ref := ref + f_com + eb04.Text + ': ' + eb05.Text;
    if eb06.Text > ' ' then
      ref := ref + f_com + 'Edited by: ' + eb06.Text;
    if eb07.Text > ' ' then
      ref := ref + f_com + '(' + eb07.Text + ' vols)';
  end;

  if rgBookReprint.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    ref := ref + f_com + '(' + eb02.Text + ')';
    ref := ref + f_com + '~~~' + eb03.Text + '~~~';
    if eb04.Text > ' ' then
      ref := ref + f_com + 'Reprint of the ' + eb04.Text + ' edn. ';
    ref := ref + f_com + eb05.Text + ': ' + eb06.Text + ', ' + eb07.Text;
  end;

  if rgBookFacsimile.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    ref := ref + ' (' + eb02.Text + ')';
    ref := ref + f_com + '~~~' + eb03.Text + '~~~';
    if eb04.Text > ' ' then
      ref := ref + f_com + 'Facsimile of the ' + eb04.Text + ' edn. ';
    ref := ref + f_com + eb05.Text + ': ' + eb06.Text + f_com + eb07.Text;
  end;

  if rgBookOrgAuth.IsChecked then
  begin
    // inline
    if eb09.Text > ' ' then
      if Pos('-', eb09.Text) > 0 then
        il1 := il1 + f_com + 'pp. ' + eb09.Text
      else
        il1 := il1 + f_com + 'p. ' + eb09.Text;
    // citation
    ref := eb01.Text + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + '~~~' + eb03.Text + '~~~ ';
    if eb04.Text > ' ' then
      ref := ref + eb04.Text + ' edn.';
    ref := ref + ' ' + eb05.Text + ': ' + eb06.Text;
    if eb07.Text > ' ' then
      ref := ref + ' Edited by ' + eb07.Text;
    if eb08.Text > ' ' then
      ref := ref + ' (' + eb08.Text + ' vols.)';
  end;

  if rgAnthology.IsChecked then
  begin
    // inline
    if eb08.Text > ' ' then
      if Pos('-', eb08.Text) > 0 then
        il1 := il1 + f_com + 'pp. ' + eb08.Text
      else
        il1 := il1 + f_com + 'p. ' + eb08.Text;
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + '(' + eb03.Text + ')';
    if eb04.Text > ' ' then
      ref := ref + f_com + eb04.Text;
    if eb05.Text > ' ' then
      ref := ref + f_com + eb05.Text;
    ref := ref + ' ' + eb06.Text + ': ' + eb07.Text;
  end;

  if rgAnthologyLine.IsChecked then
  begin
    // inline
    if eb09.Text > ' ' then
      if Pos('-', eb09.Text) > 0 then
        il1 := il1 + f_com + 'pp. ' + eb09.Text
      else
        il1 := il1 + f_com + 'p. ' + eb09.Text;
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    ref := ref + f_com + '<qs>' + eb03.Text + '</qs>';
    if eb04.Text > ' ' then
      ref := ref + f_com + 'in ' + eb04.Text;
    if eb05.Text > ' ' then
      ref := ref + f_com + '(' + eb05.Text + ')';
    if eb05.Text > ' ' then
      ref := ref + f_com + '~~~' + eb06.Text + '~~~';
    ref := ref + f_com + eb07.Text + ': ' + eb08.Text;
  end;

  if rgReference.IsChecked then
  begin
    // inline
    if eb09.Text > ' ' then
      if Pos('-', eb09.Text) > 0 then
        il1 := il1 + f_com + 'pp. ' + eb09.Text
      else
        il1 := il1 + f_com + 'p. ' + eb09.Text;
    // citation
    if eb01.Text > '' then
    begin
      ref := eb01.Text;
      if eb02.Text > ' ' then
        ref := ref + f_com + '(' + eb02.Text + ')';
      ref := ref + f_com + '<qs>' + eb03.Text + '</qs>'
    end
    else
    begin //no chapter/sect usthor
      ref := ref + f_com + '<qs>' + eb03.Text + '</qs>';
      if eb02.Text > ' ' then
        ref := ref + f_com + '(' + eb02.Text + ')';
    end;
    if eb04.Text > ' ' then
      ref := ref + f_com + 'in ' + eb04.Text + ' (eds.)';
    if eb05.Text > ' ' then
      ref := ref + f_com + '~~~' + eb05.Text + '~~~';
    if eb06.Text > ' ' then
      ref := ref + f_com + eb06.Text + ' edn.';
    ref := ref + ' ' + eb07.Text + ': ' + eb08.Text;
    if eb09.Text > ' ' then
      if Pos('-', eb09.Text) > 0 then
        ref := ref + f_com + 'pp. ' + eb09.Text + '.'
      else
        ref := ref + f_com + 'p. ' + eb09.Text + '.';
  end;

  if rgBible.IsChecked then
  begin
    // inline
    il1 := eb06.Text + ' [' + eb07.Text + '] (' + eb01.Text;
    if eb02.Text > ' ' then
      il1 := il1 + f_com + eb02.Text;
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + eb03.Text;
    ref := ref + ' ' + eb04.Text + ': ' + eb05.Text;
  end;

  if rgWebAuth.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    ref := ref + f_com + '~~~' + eb03.Text + '~~~';
  end;

  if rgWebOrg.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    ref := ref + f_com + '~~~' + eb03.Text + '~~~';
  end;

  if rgWebNoAuth.IsChecked then
  begin
    // citation
    ref := '~~~' + eb01.Text + '~~~';
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
  end;

  if rgSocialMedia.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    ref := ref + f_com + '<qs>' + eb03.Text + '<qs>';
    if eb04.Text > ' ' then
      ref := ref + f_com + '[' + eb04.Text + ']';
    if eb05.Text > ' ' then
      ref := ref + f_com + eb05.Text;
  end;

  if rgNewsByline.IsChecked then
  begin
    // inline
    if eb07.Text > ' ' then
      if Pos('-', eb07.Text) > 0 then
        il1 := il1 + f_com + 'pp. ' + eb07.Text
      else
        il1 := il1 + f_com + 'p. ' + eb07.Text;
    // citation
    ref := eb01.Text;
    ref := ref + f_com + '(' + eb02.Text + ')';
    ref := ref + f_com + '<qs>' + eb03.Text + '<qs>';
    ref := ref + f_com + '~~~' + eb04.Text + '~~~';
    if eb05.Text > ' ' then
      ref := ref + f_com + '(' + eb05.Text + ')';
    ref := ref + f_com + eb06.Text;
    if eb07.Text > ' ' then
      if Pos('-', eb07.Text) > 0 then
        il1 := il1 + ' pp. ' + eb07.Text
      else
        il1 := il1 + ' p. ' + eb07.Text;
  end;

  if rgNewsNoByline.IsChecked then
  begin
    // inline
    if eb06.Text > ' ' then
      if Pos('-', eb06.Text) > 0 then
        il1 := il1 + f_com + 'pp. ' + eb06.Text
      else
        il1 := il1 + f_com + 'p. ' + eb06.Text;
    // citation
    ref := '~~~' + eb01.Text + '~~~';
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + '<qs>' + eb03.Text + '<qs>';
    if eb04.Text > ' ' then
      ref := ref + f_com + '(' + eb04.Text + ')';
    if eb05.Text > ' ' then
      ref := ref + f_com + '' + eb05.Text;
    if eb06.Text > ' ' then
      if Pos('-', eb06.Text) > 0 then
        ref := ref + ' pp. ' + eb06.Text
      else
        ref := ref + ' p. ' + eb06.Text;
  end;

  if rgJournalArt.IsChecked then
  begin
    // inline
    if eb06.Text > ' ' then
      if Pos('-', eb06.Text) > 0 then
        il1 := il1 + f_com + 'pp. ' + eb06.Text
      else
        il1 := il1 + f_com + 'p. ' + eb06.Text;
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + '<qs>' + eb03.Text + '<qs>';
    if eb04.Text > ' ' then
      ref := ref + f_com + '~~~' + eb04.Text + '~~~';
    if eb05.Text > ' ' then
      ref := ref + f_com + eb05.Text;
    if eb06.Text > ' ' then
      if Pos('-', eb06.Text) > 0 then
        ref := ref + f_com + 'pp. ' + eb06.Text + '.'
      else
        ref := ref + f_com + 'p. ' + eb06.Text + '.';
  end;

  if rgJournalWhole.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + '.)';
    if eb03.Text > ' ' then
      ref := ref + f_com + '(' + eb03.Text + ')';
    if eb04.Text > ' ' then
      ref := ref + f_com + '<qs>' + eb04.Text + '<qs>';
    if eb05.Text > ' ' then
      ref := ref + f_com + '~~~' + eb05.Text + '~~~';
    if eb06.Text > ' ' then
    begin
      ref := ref + f_com + eb06.Text;
      ref := ref + '.';
    end;
  end;

  if rgVLELectureNotes.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + '<qs>' + eb03.Text + '<qs>.';
    if eb04.Text > ' ' then
      ref := ref + f_com + '~~~' + eb04.Text + '~~~.';
    if eb05.Text > ' ' then
      ref := ref + f_com + eb05.Text + '.';
    if eb06.Text > ' ' then
      ref := ref + f_com + eb06.Text + '.';
  end;

  if rgVLETutorHandout.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + '<qs>' + eb03.Text + '<qs>';
    if eb04.Text > ' ' then
      ref := ref + f_com + '~~~' + eb04.Text + '~~~';
    if eb05.Text > ' ' then
      ref := ref + f_com + eb05.Text;
    if eb06.Text > ' ' then
      ref := ref + f_com + eb06.Text;
  end;

  if rgPainting.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + eb03.Text;
    if eb04.Text > ' ' then
      ref := ref + f_com + '[' + eb04.Text + ']';
    if eb05.Text > ' ' then
      ref := ref + f_com + eb05.Text;
    if eb06.Text > ' ' then
      ref := ref + f_com + eb06.Text;
  end;

  if rgPhotographicPrint.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + eb03.Text;
    if eb04.Text > ' ' then
      ref := ref + f_com + '[' + eb04.Text + ']';
    if eb05.Text > ' ' then
      ref := ref + f_com + eb05.Text;
    if eb06.Text > ' ' then
      ref := ref + f_com + ': ' + eb06.Text;
  end;

  if rgPhotographWeb.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + ' ' + eb03.Text;
  end;

  if rgPodcast.IsChecked then
  begin
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + eb03.Text;
    if eb04.Text > ' ' then
      ref := ref + f_com + '[' + eb04.Text + ']';
    if eb05.Text > ' ' then
      ref := ref + f_com + eb05.Text;
    if eb06.Text > ' ' then
      ref := ref + f_com + eb06.Text;
    if eb07.Text > ' ' then
      ref := ref + ': ' + eb07.Text;
  end;

  if rgRadio.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + eb03.Text;
    if eb04.Text > ' ' then
      ref := ref + f_com + eb04.Text;
  end;

  if rgTVSingle.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + eb03.Text;
    if eb04.Text > ' ' then
      ref := ref + f_com + eb04.Text;
  end;

  if rgTVEpisodeSeries.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + eb03.Text;
    if eb04.Text > ' ' then
      ref := ref + f_com + eb04.Text;
    if eb05.Text > ' ' then
      ref := ref + f_com + eb05.Text;
    if eb06.Text > ' ' then
      ref := ref + f_com + eb06.Text;
  end;

  if rgMovies.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + 'Directed by: ' + eb03.Text;
    if eb04.Text > ' ' then
      ref := ref + f_com + '[' + eb04.Text + ']';
    if eb05.Text > ' ' then
      ref := ref + f_com + '' + eb05.Text;
    if eb06.Text > ' ' then
      ref := ref + f_com + ': ' + eb06.Text;
    if eb07.Text > ' ' then
      ref := ref + f_com + 'Reisssued: ' + eb07.Text;
    if eb08.Text > ' ' then
      ref := ref + f_com + 'Reprinted: ' + eb08.Text;
  end;

  if rgBookCollected.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + '~~~' + eb03.Text + '~~~';
    if eb04.Text > ' ' then
      ref := ref + f_com + eb04.Text + ' ';
    if eb05.Text > ' ' then
      ref := ref + f_com + '(' + eb05.Text + ' vols)';
    if eb06.Text > ' ' then
      ref := ref + f_com + eb06.Text + ' ';
    if eb07.Text > ' ' then
      ref := ref + f_com + eb07.Text + ' ';
  end;

  if rgBookChap.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + '<qs>' + eb03.Text + '<qs>';
    if eb04.Text > ' ' then
      ref := ref + f_com + 'in ' + eb04.Text + ' (eds)';
    if eb05.Text > ' ' then
      ref := ref + f_com + '~~~' + eb05.Text + '~~~';
    if eb06.Text > ' ' then
      ref := ref + f_com + eb06.Text;
    if eb07.Text > ' ' then
      ref := ref + f_com + ': ' + eb07.Text;
    if eb08.Text > ' ' then
      if Pos('-', eb08.Text) > 0 then
        ref := ref + f_com + 'pp. ' + eb08.Text + '.'
      else
        ref := ref + f_com + 'p. ' + eb08.Text + '.';
  end;

  if rgBookPartChap.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + '<qs>' + eb03.Text + '<qs>';
    if eb04.Text > ' ' then
      ref := ref + f_com + 'in ' + eb04.Text + ' (eds)';
    if eb05.Text > ' ' then
      ref := ref + f_com + '~~~' + eb05.Text + '~~~';
    if eb06.Text > ' ' then
      ref := ref + f_com + eb06.Text;
    if eb07.Text > ' ' then
      ref := ref + ': ' + eb07.Text;
    if eb08.Text > ' ' then
      if Pos('-', eb08.Text) > 0 then
        ref := ref + f_com + 'Extract pp. ' + eb08.Text + '.'
      else
        ref := ref + f_com + 'Extract p. ' + eb08.Text + '.';
  end;

  if rgConfPaper.IsChecked then
  begin
    // citation
    ref := eb01.Text;
    if eb02.Text > ' ' then
      ref := ref + f_com + '(' + eb02.Text + ')';
    if eb03.Text > ' ' then
      ref := ref + f_com + '<qs>' + eb03.Text + '<qs>';
    if eb04.Text > ' ' then
      ref := ref + f_com + '~~~' + eb04.Text + '~~~ ';
    if eb05.Text > ' ' then
      ref := ref + f_com + eb05.Text + ' ';
    if eb06.Text > ' ' then
      ref := ref + f_com + eb06.Text + ' ';
    if eb07.Text > ' ' then
      ref := ref + f_com + eb07.Text + ' ';
  end;

  // online
  if EBOL01.Text > ' ' then
    ref := ref + f_com + '[Online] Available at: ' + EBOL01.Text;
  if EBOL02.Text > ' ' then
    ref := ref + f_com + 'Last Updated: ' + EBOL02.Text;
  if EBOL03.Text > ' ' then
    ref := ref + f_com + '(Accessed: ' + EBOL03.Text + '.)';
  //
  //stop to close
  //
  ref := ref + f_stp;
  il1 := il1 + ')';
  //
  CIR_ILR1.Text := il1;
  mCILong.Lines.Clear;
  mCILong.Lines.Add(ref);
  bCRAccessed.Enabled := true;
end;


//daybook

procedure TfrmMain.CalPrepare(dat: TDateTime);
var
  offset, daysinmonth: integer;
  i: integer;
begin
  DecodeDate(dat, calwY, calwM, calwD);
  calStart := EncodeDate(calwY, calwM, 1);
  offset := DayOfWeek(calStart) - 1;
  daysinmonth := 31;
  if offset = 0 then
    offset := offset + 7;
  // set end date
  calSelected:=date;
  case calwM of
    1:
      lbnM.Text := 'JAN ' + IntToStr(calwY);
    2:
      begin
        lbnM.Text := 'FEB ' + IntToStr(calwY);
        if IsLeapYear(calwY) = false then
          daysinmonth := 28
        else
          daysinmonth := 29;
      end;
    3:
      lbnM.Text := 'MAR ' + IntToStr(calwY);
    4:
      begin
        lbnM.Text := 'APR ' + IntToStr(calwY);
        daysinmonth := 30;
      end;
    5:
      lbnM.Text := 'MAY ' + IntToStr(calwY);
    6:
      begin
        lbnM.Text := 'JUN ' + IntToStr(calwY);
        daysinmonth := 30;
      end;
    7:
      lbnM.Text := 'JULY ' + IntToStr(calwY);
    8:
      lbnM.Text := 'AUG ' + IntToStr(calwY);
    9:
      begin
        lbnM.Text := 'SEP ' + IntToStr(calwY);
        daysinmonth := 30;
      end;
    10:
      lbnM.Text := 'OCT ' + IntToStr(calwY);
    11:
      begin
        lbnM.Text := 'NOV ' + IntToStr(calwY);
        daysinmonth := 30;
      end;
    12:
      lbnM.Text := 'DEC ' + IntToStr(calwY);
  end;
  calEnd := EncodeDate(calwY, calwM, daysinmonth);
  for i := 1 to 42 Do
  begin
    mycal[i].Date := 0; // calStart;
    mycal[i].Text := 'H';
    mycal[i].Bold := false;
    mycal[i].PColor := TAlphaColorRec.Aliceblue;
  end;
  //
  for i := 1 to daysinmonth Do
  begin
    mycal[i + (offset - 1)].Date := calStart + (i - 1);
    mycal[i + (offset - 1)].Text := IntToStr(i);;
    mycal[i].PColor := TAlphaColorRec.Antiquewhite;
  end;
  if calHasDayPanel = true then
  begin
    lblCalFlagDay.Text := Uppercase(FormatDateTime('dddd', calDate));
    lblCalFlagMth.Text := Uppercase(FormatDateTime('mmmm', calDate));
    lblCalFlagNum.Text := FormatDateTime('DD', calDate);
    lblCalFlagYear.Text := FormatDateTime('YYYY', calDate);
  end;
  //prepare sortable date
  calStr := FormatDateTime('yyyymmdd', calDate);
  CalDraw(Self)
end;

function TfrmMain.CalHasdata(thissday: TDate): Boolean;
var
  rd: string;
begin
  rd := FormatDateTime('yyyymmdd', thissday);
  QJnl.Active := false;
  QJnl.SQL.Clear;
  QJnl.SQL.Add('select * from jrnl where jid="' + rd + '"');
  QJnl.Active := true;
  if QJnl.RecordCount = 0 then
    result := false
  else
    result := true;
end;

procedure TfrmMain.CalGetData(thissday: TDate);
var
  rd: string;
begin
  if calDataware = false then
    exit;
  rd := FormatDateTime('yyyymmdd', thissday);
  Memo1.Lines.Clear;
  if CalHasdata(thissday) = true then
    Memo1.Lines.Add(QJnl.FieldByName('jtxt').AsString);
end;

procedure TfrmMain.btLoadClick(Sender: TObject);
begin
  if g_noid > 100 then
    exit;
  addnode(myTV, 'A000', '0.0.Introduction');
  addnode(myTV, 'A025', '1.0 First Point ');
  addnode(myTV, 'A050', '2.0 Second Point');
  addnode(myTV, 'A075', '3.0 Third Point');
  addnode(myTV, 'A099', '9.0 Conclusion');
  //  g_noid := 100;
end;

procedure TfrmMain.btnAddNodeClick(Sender: TObject);
var
  nr: string;
begin
  node_new := true;
  if eNodeLabel.Text = '' then
    exit;
  nr := Chr(65 + g_letcyc) + IntToStr(g_noid);
  addnode(myTV, nr, eNodeLabel.Text);
  g_id := g_id + 1;
  g_noid := g_noid + 1;
  if cbCFGouNewNode.IsChecked=true then
    JnlAdd('[Outline] Create Stem: ' + eNodeLabel.Text)
end;

procedure TfrmMain.btnAddSubNodeClick(Sender: TObject);
var
  nr: string;
  item1: TTreeViewItem;
begin
  node_new := true;
  if eNodeLabel.Text = '' then
    exit;
  g_noid := g_noid + 1;
  nr := Chr(65 + g_letcyc) + IntToStr(g_noid);
  g_child := nr;
  g_node[g_id].id := g_id;
  g_node[g_id].nid := g_child;
  g_node[g_id].stm := selobj.Name;
  g_node[g_id].lbl := eNodeLabel.Text;
  g_node[g_id].txt := g_child;
  g_id := g_id + 1;
  item1 := TTreeViewItem.Create(Self);
  item1.Text := eNodeLabel.Text;
  item1.OnClick := WasSelected;
  item1.Parent := selobj;
  item1.Name := g_child;
  if cbCFGouNewSubNode.IsChecked=true then
  JnlAdd('[Outline] Create Branch: ' + eNodeLabel.Text+ ' on ' + (selobj as TTreeViewItem).Text);
//  JnlAdd('Outline Branch ' + trim(g_child)+' '+eNodeLabel.Text+ ' added to ' + selobj.Name+' '+(selobj as TTreeViewItem).Text);
  eNodeLabel.Text := '';
end;

procedure TfrmMain.btnDayTextSaveClick(Sender: TObject);

var
  rd: string;
begin
  if Memo1.Lines.Text <> g_daybook then
  begin
    rd := calStr;
    QJnl.Active := false;
    QJnl.SQL.Clear;
    QJnl.SQL.Add('select * from jrnl where jid="' + rd + '"');
    QJnl.Active := true;
    GO.CommandText.Clear;
    if QJnl.RecordCount = 0 then
      GO.CommandText.Add('insert into jrnl(jid,jtxt) values ("' + rd + '",' +
        quotedstr(Memo1.Lines.Text) + ')')
    else
      GO.CommandText.Add('update jrnl set jtxt =' + quotedstr(Memo1.Lines.Text)
        + ' where jid="' + rd + '"');
    GO.Execute;
    g_daybook := Memo1.Lines.Text;
  end;

end;

procedure TfrmMain.btnDBBackupClick(Sender: TObject);
begin
  backuprestore('>');
end;

procedure TfrmMain.btnDBRestoreClick(Sender: TObject);
begin
  backuprestore('<');
end;

procedure TfrmMain.btnDelNodeClick(Sender: TObject);
var
  i: integer;
begin
  if g_mount = '' then
    exit;
  mShow.Lines.Clear;
  for i := 0 to g_id - 1 do
    if g_node[i].nid = g_mount then
    begin
      g_node[i].id := -99;
      g_node[i].nid := '';
      g_node[i].stm := '';
      g_node[i].lbl := '';
      g_node[i].txt := '';
    end;
  FindComponent(g_mount).Free;
  //  FindComponent(g_mount).Destroy;
  myTV.Repaint;
  if cbCFGouDeletedNode.IsChecked=true then
  JnlAdd('[Outline] Branch ' + g_mount + ' deleted');
end;

procedure TfrmMain.btNewClick(Sender: TObject);
var
  i: integer;
begin
  g_id := 0;
  g_noid := 100;
  g_letcyc := 0;
  //  if g_letcyc>23 then g_letcyc:=1;

  for i := 74 downto 0 do
  begin
    g_node[i].id := i;
    g_node[i].nid := '';
    g_node[i].lbl := '';
    g_node[i].txt := '';
    myTV.RemoveObject(myTV.Items[i]);
  end;
  myTV.Clear;
  mShow.Lines.Clear;
  myTV.Repaint;
  JnlAdd('[Outline] Reset')
end;

procedure TfrmMain.btnMoveNodeClick(Sender: TObject);
begin
  if btnMoveNode.Text = 'Move Selected Node' then
  begin
    node_moving := true;
    node_old := g_mount;
    btnMoveNode.Text := 'Cancel Move';
    //    btnDelNode.Text := 'Move Node to Root';
  end
  else
  begin
    node_moving := false;
    btnMoveNode.Text := 'Move Selected Node';
    btnDelNode.Text := 'Delete Selected Node';
  end;
end;

procedure TfrmMain.btOutpClick(Sender: TObject);
var
  sl: TStringList;
  i: integer;
  lts: string;
begin
  sl := TStringList.Create;
  for i := 0 to g_id do
  begin
    if g_node[i].nid > ' ' then
    //Check whether the component is button or anything else
    begin
      lts := IntToStr(g_node[i].id) + '|' + g_node[i].nid + '|' + g_node[i].stm
        + '|' + g_node[i].lbl + '|' + g_node[i].txt;
      //      showmessage(lts);
      sl.Add(lts);
    end;
  end;
  {TODO -oMe -cGeneral : add saving for droid}
  sl.SaveToFile('story.txt');
  sl.Free;
  if cbCFGouExport.IsChecked = true then
    JnlAdd('[Outline] Exported')
end;

procedure TfrmMain.btSaveClick(Sender: TObject);
var
  s: string;
  i: integer;
begin
  if cbCFGouHousekeep.IsChecked = true then
  JnlAdd('[Outline] Config Saved');
  if QStry.RecordCount = 0 then
  begin
    s := 'insert into story([proj],[title],[cLet],[cNR],[cNode]) ' + 'values ('
      + IntToStr(gPRJ) + ',"' + eOutlineTitle.Text + '",' + IntToStr(g_letcyc) +
      ',' + IntToStr(g_id) + ',' + IntToStr(g_noid) + ')';
    GO.Execute(s);
  end
  else
  begin
    s := 'update story set ' + '[title]="' + eOutlineTitle.Text + '",' +
      '[cLet]=' + IntToStr(g_letcyc) + ',' + '[cNR]=' + IntToStr(g_id) + ',' +
      '[cNode]=' + IntToStr(g_noid) + ' where [proj]=' + IntToStr(gPRJ);
    GO.Execute(s);
  end;
  s := 'delete from outline where proj = ' + IntToStr(gPRJ);
  GO.Execute(s);
  for i := 0 to g_id do
  begin
    if g_node[i].nid > ' ' then
    //Check whether the component is button or anything else
    begin
      s := 'insert into outline (' + '[proj],[creord],[nodeid],' +
        '[stemid],[nodelbl],[nodetxt]' + ') values (' + IntToStr(gPRJ) + ',"' +
        IntToStr(g_node[i].id) + '","' + g_node[i].nid + '","' + g_node[i].stm +
        '","' + g_node[i].lbl + '","' + g_node[i].txt + '")';
      GO.Execute(s);
    end;
  end;
  if cbCFGouHousekeep.IsChecked = true then
  JnlAdd('[Outline] Saved:' + eOutlineTitle.Text);
end;

procedure TfrmMain.CalDraw(Sender: TObject);

  procedure paintit(mypan: TObject; mylab: TObject; pan: integer);
  begin
    // do panel
    if mycal[pan].Text = 'H' then
    begin
      (mypan as TPanel).StyleLookup := 'grouppanel';
      (mylab as TLabel).Text := '';
    end
    else
    begin
      // (mypan as TPanel).StyleLookup := 'flyoutpanel';
      (mypan as TPanel).StyleLookup := 'tooltippanel';
      (mylab as TLabel).Text := mycal[pan].Text;
      (mylab as TLabel).FontColor := TAlphaColorRec.Lightslategray;
    end;
    //
    if calDataware = true then
    begin
      // switch records
      if CalHasdata(mycal[pan].Date) = true then
        (mylab as TLabel).FontColor := TAlphaColorRec.Black
      else
        (mylab as TLabel).FontColor := TAlphaColorRec.Lightslategray;
    end;
    //today
    if mycal[pan].Date = calSelected then
      (mylab as TLabel).FontColor := TAlphaColorRec.Green;
    if mycal[pan].Date = Date then
    if CalHasdata(mycal[pan].Date) = false then
      (mylab as TLabel).FontColor := TAlphaColorRec.Maroon
      else
      (mylab as TLabel).FontColor := TAlphaColorRec.Red;
  end;
//

begin
  paintit(cpv0x0, lbv0x0, 1);
  paintit(cpv0x1, lbv0x1, 2);
  paintit(cpv0x2, lbv0x2, 3);
  paintit(cpv0x3, lbv0x3, 4);
  paintit(cpv0x4, lbv0x4, 5);
  paintit(cpv0x5, lbv0x5, 6);
  paintit(cpv0x6, lbv0x6, 7);
  //
  paintit(cpv1x0, lbv1x0, 8);
  paintit(cpv1x1, lbv1x1, 9);
  paintit(cpv1x2, lbv1x2, 10);
  paintit(cpv1x3, lbv1x3, 11);
  paintit(cpv1x4, lbv1x4, 12);
  paintit(cpv1x5, lbv1x5, 13);
  paintit(cpv1x6, lbv1x6, 14);
  //
  paintit(cpv2x0, lbv2x0, 15);
  paintit(cpv2x1, lbv2x1, 16);
  paintit(cpv2x2, lbv2x2, 17);
  paintit(cpv2x3, lbv2x3, 18);
  paintit(cpv2x4, lbv2x4, 19);
  paintit(cpv2x5, lbv2x5, 20);
  paintit(cpv2x6, lbv2x6, 21);
  //
  paintit(cpv3x0, lbv3x0, 22);
  paintit(cpv3x1, lbv3x1, 23);
  paintit(cpv3x2, lbv3x2, 24);
  paintit(cpv3x3, lbv3x3, 25);
  paintit(cpv3x4, lbv3x4, 26);
  paintit(cpv3x5, lbv3x5, 27);
  paintit(cpv3x6, lbv3x6, 28);
  //
  paintit(cpv4x0, lbv4x0, 29);
  paintit(cpv4x1, lbv4x1, 30);
  paintit(cpv4x2, lbv4x2, 31);
  paintit(cpv4x3, lbv4x3, 32);
  paintit(cpv4x4, lbv4x4, 33);
  paintit(cpv4x5, lbv4x5, 34);
  paintit(cpv4x6, lbv4x6, 35);
  //
  paintit(cpv5x0, lbv5x0, 36);
  paintit(cpv5x1, lbv5x1, 37);
  paintit(cpv5x2, lbv5x2, 38);
  paintit(cpv5x3, lbv5x3, 39);
  paintit(cpv5x4, lbv5x4, 40);
  paintit(cpv5x5, lbv5x5, 41);
  paintit(cpv5x6, lbv5x6, 42);
end;

procedure TfrmMain.lbnMClick(Sender: TObject);
begin
  calHasDayPanel := true;
  calDate := Date;
  CalPrepare(calDate);
  //CalDraw(self);
end;

procedure TfrmMain.lbv0x0Click(Sender: TObject);
var
  pnlnam: string;
begin
  //  if calTileNo <> 0 then
  //    mycal[calTileNo].FColor := oldcol;
  pnlnam := (Sender as TLabel).Name;
  Memo1.Lines.Clear;
  //  showmessage(pnlnam);
  if pnlnam = 'lbv0x0' then
    calTileNo := 1;
  if pnlnam = 'lbv0x1' then
    calTileNo := 2;
  if pnlnam = 'lbv0x2' then
    calTileNo := 3;
  if pnlnam = 'lbv0x3' then
    calTileNo := 4;
  if pnlnam = 'lbv0x4' then
    calTileNo := 5;
  if pnlnam = 'lbv0x5' then
    calTileNo := 6;
  if pnlnam = 'lbv0x6' then
    calTileNo := 7;

  if pnlnam = 'lbv1x0' then
    calTileNo := 8;
  if pnlnam = 'lbv1x1' then
    calTileNo := 9;
  if pnlnam = 'lbv1x2' then
    calTileNo := 10;
  if pnlnam = 'lbv1x3' then
    calTileNo := 11;
  if pnlnam = 'lbv1x4' then
    calTileNo := 12;
  if pnlnam = 'lbv1x5' then
    calTileNo := 13;
  if pnlnam = 'lbv1x6' then
    calTileNo := 14;

  if pnlnam = 'lbv2x0' then
    calTileNo := 15;
  if pnlnam = 'lbv2x1' then
    calTileNo := 16;
  if pnlnam = 'lbv2x2' then
    calTileNo := 17;
  if pnlnam = 'lbv2x3' then
    calTileNo := 18;
  if pnlnam = 'lbv2x4' then
    calTileNo := 19;
  if pnlnam = 'lbv2x5' then
    calTileNo := 20;
  if pnlnam = 'lbv2x6' then
    calTileNo := 21;

  if pnlnam = 'lbv3x0' then
    calTileNo := 22;
  if pnlnam = 'lbv3x1' then
    calTileNo := 23;
  if pnlnam = 'lbv3x2' then
    calTileNo := 24;
  if pnlnam = 'lbv3x3' then
    calTileNo := 25;
  if pnlnam = 'lbv3x4' then
    calTileNo := 26;
  if pnlnam = 'lbv3x5' then
    calTileNo := 27;
  if pnlnam = 'lbv3x6' then
    calTileNo := 28;

  if pnlnam = 'lbv4x0' then
    calTileNo := 29;
  if pnlnam = 'lbv4x1' then
    calTileNo := 30;
  if pnlnam = 'lbv4x2' then
    calTileNo := 31;
  if pnlnam = 'lbv4x3' then
    calTileNo := 32;
  if pnlnam = 'lbv4x4' then
    calTileNo := 33;
  if pnlnam = 'lbv4x5' then
    calTileNo := 34;
  if pnlnam = 'lbv4x6' then
    calTileNo := 35;

  if pnlnam = 'lbv5x0' then
    calTileNo := 36;
  if pnlnam = 'lbv5x1' then
    calTileNo := 37;
  if pnlnam = 'lbv5x2' then
    calTileNo := 38;
  if pnlnam = 'lbv5x3' then
    calTileNo := 39;
  if pnlnam = 'lbv5x4' then
    calTileNo := 40;
  if pnlnam = 'lbv5x5' then
    calTileNo := 41;
  if pnlnam = 'lbv5x6' then
    calTileNo := 42;
  calSelected := mycal[calTileNo].Date;
  if mycal[calTileNo].Text = 'H' then
    exit;
  calDate := calSelected; //mycal[calTileNo].Date;
  calStr := FormatDateTime('yyyymmdd', mycal[calTileNo].Date);
  if calDataware = true then
    CalGetData(calDate);
  CalDraw(Self);
  if calHasDayPanel = true then
  begin
    lblCalFlagDay.Text := Uppercase(FormatDateTime('dddd', calDate));
    lblCalFlagMth.Text := Uppercase(FormatDateTime('mmmm', calDate));
    lblCalFlagNum.Text := FormatDateTime('DD', calDate);
    lblCalFlagYear.Text := FormatDateTime('YYYY', calDate);
  end;

end;

procedure TfrmMain.backuprestore(dire: string);
var
  pfrom, pto: string;
begin
  if dire = '>' then
  begin
    pfrom := glob_mdb;
    pto := glob_bdb;
  end
  else
  begin
    pfrom := glob_bdb;
    pto := glob_mdb;
  end;

  if FileExists(pfrom) then
  begin
    TDialogService.MessageDialog(('Are you sure...?'),
      System.UITypes.TMsgDlgType.mtConfirmation,
      [System.UITypes.TMsgDlgBtn.mbYes, System.UITypes.TMsgDlgBtn.mbNo],
      System.UITypes.TMsgDlgBtn.mbYes, 0,
      procedure(const AResult: System.UITypes.TModalResult)
      begin
        case AResult of
          mrYES:
            begin
              DTA.Connected := false;
              if FileExists(pfrom) then
              begin
                if FileExists(pto) then
                  DeleteFile(pto);
                with BACKUP do
                begin
                  DestDatabase := pto;
                  Database := pfrom;
                  DestPassword := '';
                  Password := '';
                  BACKUP;
                  DroidAlert('Completed..');
                end;
              end;
            end;
        end;
      end);
  end;

end;

procedure TfrmMain.DroidAlert(msg: string);
var
  gflag: string;
begin
  TDialogService.MessageDialog((msg), System.UITypes.TMsgDlgType.mtConfirmation,
    [System.UITypes.TMsgDlgBtn.mbOK], System.UITypes.TMsgDlgBtn.mbOK, 0,
    procedure(const AResult: System.UITypes.TModalResult)
    begin
      gflag := 'N';
      case AResult of
        mrOk:
          gflag := 'Y';
      end;
    end);
end;

procedure TfrmMain.WasSelected(Sender: TObject);
var
  ml, ll: string;
  obj: TFmxObject;
  i: integer;
begin
  if not(Sender is TTreeViewItem) then
    exit;
  // save any updates
  if node_new = false then
  begin
    ml := mShow.Lines.Text;
    ll := eNodeLabel.Text;
    if ((ml <> g_text) or (ll <> g_node[i].lbl)) then
    begin
      for i := 0 to g_id - 1 do
        if g_node[i].nid = g_mount then
        begin
          (FindComponent(g_mount) as TTreeViewItem).Text := ll;
          g_node[i].txt := ml;
          g_node[i].lbl := eNodeLabel.Text;
        end;
      myTV.Repaint;
    end;
  end;
  //are re relocating?
  if node_moving = true then
  begin
    obj := TTreeViewItem(Sender);
    selobj.Parent := obj;
    node_moving := false;
    btnMoveNode.Text := 'Move Selected Node';
    myTV.Repaint;
    for i := 0 to g_id - 1 do
      if g_node[i].nid = g_mount then
      begin
        g_node[i].stm := obj.Name;
        eNodeLabel.Text := g_node[i].lbl;
      end;
  if cbCFGouMovedNode.IsChecked = true then
    JnlAdd('[Outline] Moved Branch: ' + g_mount + ' to ' + g_node[i].stm);
  end;

  // get new values
  selobj := TTreeViewItem(Sender);
  g_mount := TTreeViewItem(Sender).Name;
  // grab text contents of dynamically created TMemo held in: m_child
  t_orig := '';
  for i := 0 to g_id - 1 do
  begin
    if g_node[i].nid = g_mount then
    begin
      t_orig := g_node[i].txt;
      g_label := g_node[i].lbl;
      eNodeLabel.Text := g_node[i].lbl;
    end;
  end;
  mShow.Lines.Clear;
  mShow.Lines.Add(t_orig);
  node_new := false;
end;

procedure TfrmMain.addnode(BRoot: TTreeView; BNId: string; BText: String);
var
  item1: TTreeViewItem;
begin
  //  if Edit1.Text='' then exit;
  g_child := BNId;
  //Chr(65 + g_letcyc) + IntToStr(g_noid);
  g_node[g_id].id := g_id;
  g_node[g_id].nid := g_child;
  g_node[g_id].stm := BRoot.Name;
  g_node[g_id].lbl := BText;
  g_node[g_id].txt := g_child;
  g_id := g_id + 1;
  item1 := TTreeViewItem.Create(Self);
  item1.OnClick := WasSelected;
  item1.Parent := BRoot;
  item1.Text := BText;
  item1.Name := g_child;
  eNodeLabel.Text := '';
  g_noid := g_noid + 1;
end;

procedure TfrmMain.btnMoveNodetoRootClick(Sender: TObject);
begin
  if selobj.Parent <> myTV then
  begin
    selobj.Parent := myTV;
    node_moving := false;
    btnMoveNode.Text := 'Move Selected Node';
    myTV.Repaint;
  if cbCFGouMovedNode.IsChecked = true then
    JnlAdd('[Outline] Moved Branch: ' + g_mount + ' to Stem');
  end;
end;

procedure TfrmMain.btnStorySaveFrontClick(Sender: TObject);
var
  s: string;
  i: integer;
begin
  s := 'update story set ' + '[Title]="' + eOutlineTitle.Text + '",' + '[cLet]='
    + IntToStr(g_letcyc) + ',' + '[cNR]=' + IntToStr(g_id) + ',' + '[cNode]=' +
    IntToStr(g_noid) + ' where [proj]=' + IntToStr(gPRJ);
  GO.Execute(s);
  //remove old entries (simplest purge and redo)
  s := 'delete from outline where proj = ' + IntToStr(gPRJ);
  GO.Execute(s);
  // scroll through nodes and save to outline table
  for i := 0 to g_id do
  begin
    //Only save active TreeViewItems
    if g_node[i].nid > ' ' then
    begin
      s := 'insert into outline ([proj],[creord],[nodeid],' +
        '[stemid],[nodelbl],[nodetxt]) values (' + IntToStr(gPRJ) + ',"' +
        IntToStr(g_node[i].id) + '","' + g_node[i].nid + '","' + g_node[i].stm +
        '","' + g_node[i].lbl + '","' + g_node[i].txt + '")';
      GO.Execute(s);
    end;
  end;
  if cbCFGouHousekeep.IsChecked = true then
  JnlAdd('[Outline] Saved: ' + eOutlineTitle.Text);
end;

procedure TfrmMain.JnlAdd(jtxt: string);
var
  rd: string;
begin
  if calSelected<>date then
  begin
    CalPrepare(date);
    calSelected:=date;
    if CalHasdata(date) = true then;
    CalGetData(date)
  end;
  rd := FormatDateTime('HH:MM', now) + ' ' + jtxt;
  Memo1.Lines.Add(rd);
end;

procedure TfrmMain.Label12Click(Sender: TObject);
begin
  Memo1.Font.Size:=12;
  Label13.Text := IntToStr(12);
  TrackBar2.Value:=12;
end;

end.

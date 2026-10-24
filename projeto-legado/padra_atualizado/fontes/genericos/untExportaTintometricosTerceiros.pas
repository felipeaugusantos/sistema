unit untExportaTintometricosTerceiros;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Winapi.Windows, Winapi.Messages, Vcl.Graphics, cxFilter, cxData,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, UniClientDataSet,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, cxContainer,
  cxProgressBar, cxDataControllerConditionalFormattingRulesManagerDialog, untPrincipal,
  untConexaoThread,
{$ENDIF}
  System.SysUtils, System.Variants, System.Classes, Datasnap.DBClient,
  untThreadExportacaoTerceiros, Uni, Math;

type
  TTipoTinta = (SemTipo, Cim, Suv, Fut, Say, She, Rei, Euc, Dac, Bau, Ppg, Bza,
     Sky, Dup, Fal, Wan, Laz, Shw, Adv, Ale, Ajt, Anj, Aja, Bzc, Gen, Ann, Bel,
     Bzi, Cal, Cia, Dux, Frb, Glo, Gra, Hyd, Int, Iqu, Jot, Kil, Lik, Lks, Lkc,
     Mza, Mzi, Mzd, Meg, Mon, Nex, Ppx, Qua, Rec, Ren, Spa, Dox, Sta, Unv, Vel,
     Weg, Ink, Rsi, Stw, Kre, Kin, Adt, Max, Alp, Bsn, Csn, Gbc, Clb, Blt, Alk,
     Coa, C11, Tex, Chr, Ads, Du2, Lei, Mae, Sin, Dca, Luz, Lec, Rep, Mif, Rob);

{$IFNDEF LINUX}
type
  TfrmExportaTintometricosTerceiros = class(TfrmPaiSimples)
    pnlDados: TPanel;
    btnExportar: TBitBtnLocked;
    dbgTintasDBTableView1: TcxGridDBTableView;
    dbgTintasLevel1: TcxGridLevel;
    dbgTintas: TcxGrid;
    cdsTintas: TUniClientDataSet;
    cdsTintasNOME: TStringField;
    cdsTintasEXPORTAR: TStringField;
    dtsTintas: TDataSource;
    dbgTintasDBTableView1NOME: TcxGridDBColumn;
    dbgTintasDBTableView1EXPORTAR: TcxGridDBColumn;
    cdsTintasIDEPRO: TStringField;
    dbgTintasDBTableView1IDEPRO: TcxGridDBColumn;
    pnlProgTintas: TPanel;
    Timer: TTimer;
    btnMarDes: TBitBtnLocked;
    ScrProgTintas: TScrollBox;
    procedure FormShow(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerTimer(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnMarDesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }

    Labels: TList;
    Progresso: TList;
    Threads: TList;

    lblGen: TLabel;
    prgGen: TcxProgressBar;

    ThreadTin: TThreadExportacaoTerceiros;

    procedure pAdicionaCds;
    function fSeleciou: Boolean;
    function fTabelaTintaConfigurada: Boolean;
    function fValidou: Boolean;

    procedure pExecutaThreads(strIdePro: String; intTopL, intTopP: Integer);

    function fGeracaoFinalizada: Boolean;

    procedure pLimparTela;
    procedure pLimparGrid;

    function fUtilizaTinta(strIdePro: String): Boolean;

    procedure pLiberarAsThreads;
    procedure pHabilitaBotoes(blnFlag: Boolean);
    procedure pMarcarDesmarcar;

    function fTodasAsThreadsLiberadas: Boolean;
    function fTodasAsThreadsFinalizadas(intCont: Integer): Boolean;

    // Criando as Threads
    procedure pThreadExecutando(Tipo: TTipoTinta; strIdePro: String;
      intTopL, intTopP: Integer);
    function fRetornaTipoTinta(strIdePro: String): TTipoTinta;

    // Criando progresso tintas
    procedure pCriaThread(Tipo: TTipoTinta);
    procedure pCriaLabelGeneric(strIdePro: String; intTop: Integer);
    procedure pCriaProgressoGeneric(strIdePro: String; intTop: Integer);
    function fRetNomeTinta(strIdePro: String): String;
    procedure SetEnabledButtonClose(Form: TForm; Habilitar: Boolean);

  public
    { Public declarations }

  end;
{$ENDIF}

Type
  TExportarAutomaticoTintometricosTerceiros = Class
  private
    ThreadSuv: TThreadExportacaoTerceiros;
    ThreadCim: TThreadExportacaoTerceiros;
    ThreadFut: TThreadExportacaoTerceiros;
    ThreadSay: TThreadExportacaoTerceiros;
    ThreadShe: TThreadExportacaoTerceiros;
    ThreadRei: TThreadExportacaoTerceiros;
    ThreadEuc: TThreadExportacaoTerceiros;
    ThreadDac: TThreadExportacaoTerceiros;
    ThreadBau: TThreadExportacaoTerceiros;
    ThreadPpg: TThreadExportacaoTerceiros;
    ThreadBza: TThreadExportacaoTerceiros;
    ThreadSky: TThreadExportacaoTerceiros;
    ThreadDup: TThreadExportacaoTerceiros;
    ThreadFal: TThreadExportacaoTerceiros;
    ThreadWan: TThreadExportacaoTerceiros;
    ThreadLaz: TThreadExportacaoTerceiros;
    ThreadShw: TThreadExportacaoTerceiros;
    ThreadAdv: TThreadExportacaoTerceiros;
    ThreadAle: TThreadExportacaoTerceiros;
    ThreadAjt: TThreadExportacaoTerceiros;
    ThreadAnj: TThreadExportacaoTerceiros;
    ThreadAja: TThreadExportacaoTerceiros;
    ThreadBzc: TThreadExportacaoTerceiros;
    ThreadGen: TThreadExportacaoTerceiros;
    ThreadAnn: TThreadExportacaoTerceiros;
    ThreadBel: TThreadExportacaoTerceiros;
    ThreadBzi: TThreadExportacaoTerceiros;
    ThreadCal: TThreadExportacaoTerceiros;
    ThreadCia: TThreadExportacaoTerceiros;
    ThreadDux: TThreadExportacaoTerceiros;
    ThreadFar: TThreadExportacaoTerceiros;
    ThreadGlo: TThreadExportacaoTerceiros;
    ThreadGra: TThreadExportacaoTerceiros;
    ThreadHyd: TThreadExportacaoTerceiros;
    ThreadInt: TThreadExportacaoTerceiros;
    ThreadIqu: TThreadExportacaoTerceiros;
    ThreadJot: TThreadExportacaoTerceiros;
    ThreadKil: TThreadExportacaoTerceiros;
    ThreadLik: TThreadExportacaoTerceiros;
    ThreadLks: TThreadExportacaoTerceiros;
    ThreadLkc: TThreadExportacaoTerceiros;
    ThreadMza: TThreadExportacaoTerceiros;
    ThreadMzi: TThreadExportacaoTerceiros;
    ThreadMzd: TThreadExportacaoTerceiros;
    ThreadMeg: TThreadExportacaoTerceiros;
    ThreadAlp: TThreadExportacaoTerceiros;
    ThreadMon: TThreadExportacaoTerceiros;
    ThreadNex: TThreadExportacaoTerceiros;
    ThreadPpx: TThreadExportacaoTerceiros;
    ThreadQua: TThreadExportacaoTerceiros;
    ThreadRec: TThreadExportacaoTerceiros;
    ThreadRen: TThreadExportacaoTerceiros;
    ThreadSpa: TThreadExportacaoTerceiros;
    ThreadDox: TThreadExportacaoTerceiros;
    ThreadSta: TThreadExportacaoTerceiros;
    ThreadUnv: TThreadExportacaoTerceiros;
    ThreadVel: TThreadExportacaoTerceiros;
    ThreadWeg: TThreadExportacaoTerceiros;
    ThreadInk: TThreadExportacaoTerceiros;
    ThreadRsi: TThreadExportacaoTerceiros;
    ThreadStw: TThreadExportacaoTerceiros;
    ThreadKre: TThreadExportacaoTerceiros;
    ThreadKin: TThreadExportacaoTerceiros;
    ThreadAdt: TThreadExportacaoTerceiros;
    ThreadMax: TThreadExportacaoTerceiros;
    ThreadBsn: TThreadExportacaoTerceiros;
    ThreadCsn: TThreadExportacaoTerceiros;
    ThreadGbc: TThreadExportacaoTerceiros;
    ThreadClb: TThreadExportacaoTerceiros;
    ThreadBlt: TThreadExportacaoTerceiros;
    ThreadAlk: TThreadExportacaoTerceiros;
    ThreadCoa: TThreadExportacaoTerceiros;
    ThreadC11: TThreadExportacaoTerceiros;
    ThreadTex: TThreadExportacaoTerceiros;
    ThreadChr: TThreadExportacaoTerceiros;
    ThreadAds: TThreadExportacaoTerceiros;
    ThreadDu2: TThreadExportacaoTerceiros;
    ThreadLei: TThreadExportacaoTerceiros;
    ThreadMae: TThreadExportacaoTerceiros;
    ThreadSin: TThreadExportacaoTerceiros;
    ThreadDca: TThreadExportacaoTerceiros;
    ThreadLuz: TThreadExportacaoTerceiros;
    ThreadLec: TThreadExportacaoTerceiros;
    ThreadRep: TThreadExportacaoTerceiros;
    ThreadMif: TThreadExportacaoTerceiros;
    ThreadRob: TThreadExportacaoTerceiros;
  public
    procedure pExportarAutomaticoTintometricosTerceiros(strIdePro: String;
      blnGeracaoAut: Boolean);
    function fExportacaoAtiva: Boolean;
  End;

CONST
  ArrTintas: array [1 .. 86] of array [1 .. 3] of string =(
    ('Advance'                  , 'N', 'ADV'),
    ('Advance Str'              , 'N', 'ADS'),
    ('Advance TintoSystem'      , 'N', 'ADT'),
    ('Alessi Imobiliária'       , 'N', 'ALE'),
    ('Alter Plus'               , 'N', 'ALP'),
    ('Anjo Automotiva'          , 'N', 'AJT'),
    ('Anjo Imobiliária'         , 'N', 'ANJ'),
    ('Anjo Sintetica'           , 'N', 'AJA'),
    ('Annetta'                  , 'N', 'ANN'),
    ('Autoluks'                 , 'N', 'ALK'),
    ('Bautech'                  , 'N', 'BAU'),
    ('BellaCor'                 , 'N', 'BEL'),
    ('BellaCor Tintavel'        , 'N', 'BLT'),
    ('Brazilian Color'          , 'N', 'BZC'),
    ('Brasimix Automotiva'      , 'N', 'BZA'),
    ('Brasimix Imobiliária'     , 'N', 'BZI'),
    ('Calamar'                  , 'N', 'CAL'),
    ('Chreon'                   , 'N', 'CHR'),
    ('CiaCollor'                , 'N', 'CIA'),
    ('Colorbraz'                , 'N', 'CLB'),
    ('Color Pro'                , 'N', 'WCP'),
    ('Coral Imobiliária'        , 'N', 'CIM'),
    ('Dacar'                    , 'N', 'DAC'),
    ('Dacasa'                   , 'N', 'DCA'),
    ('Axalta'                   , 'N', 'DUP'),
    ('Duxone'                   , 'N', 'DUX'),
    ('Duxone 2'                 , 'N', 'DU2'),
    ('Eucatex'                  , 'N', 'EUC'),
    ('Falcao'                   , 'N', 'FAL'),
    ('Farben Automotiva'        , 'N', 'FAR'),
    ('Futura'                   , 'N', 'FUT'),
    ('General'                  , 'N', 'GEN'),
    ('Global Bc'                , 'N', 'GBC'),
    ('Global Bsn'               , 'N', 'BSN'),
    ('Global Cc11'              , 'N', 'C11'),
    ('Global Collor'            , 'N', 'GLO'),
    ('Global Csn'               , 'N', 'CSN'),
    ('Grafftex'                 , 'N', 'GRA'),
    ('Hydronorth Imobiliária'   , 'N', 'HYD'),
    ('Inkor'                    , 'N', 'INK'),
    ('International'            , 'N', 'INT'),
    ('Iquine'                   , 'N', 'IQU'),
    ('Jotun'                    , 'N', 'JOT'),
    ('Killing'                  , 'N', 'KIL'),
    ('Killing Industrial'       , 'N', 'KIN'),
    ('Kresil'                   , 'N', 'KRE'),
    ('Lazzumix'                 , 'N', 'LAZ'),
    ('Lechler'                  , 'N', 'LEC'),
    ('Leinertex'                , 'N', 'LEI'),
    ('Liko'                     , 'N', 'LIK'),
    ('Lukscolor'                , 'N', 'LKS'),
    ('Lukscolor 2'              , 'N', 'LKC'),
    ('Luztol'                   , 'N', 'LUZ'),
    ('Maestria'                 , 'N', 'MAE'),
    ('MaxVinil'                 , 'N', 'MAX'),
    ('Maza Automotiva'          , 'N', 'MZA'),
    ('Maza Imobiliária'         , 'N', 'MZI'),
    ('Maza Industrial'          , 'N', 'MZD'),
    ('Mega Tintas'              , 'N', 'MEG'),
    ('Mini Fábrica'             , 'N', 'MIF'),
    ('Montana'                  , 'N', 'MON'),
    ('Nexa Autocolor'           , 'N', 'NEX'),
    ('Ppg'                      , 'N', 'PPG'),
    ('Ppg/Nexa'                 , 'N', 'PPX'),
    ('QualyVinil'               , 'N', 'QUA'),
    ('Recoa'                    , 'N', 'REC'),
    ('Renner Imobiliária'       , 'N', 'REI'),
    ('Renner Industrial'        , 'N', 'REN'),
    ('Renner Performance'       , 'N', 'REP'),
    ('Resicolor'                , 'N', 'RSI'),
    ('Roberlo'                  , 'N', 'ROB'),
    ('Sayerlack'                , 'N', 'SAY'),
    ('Sinteplast'               , 'N', 'SIN'),
    ('Sherwin Williams'         , 'N', 'SHE'),
    ('Sherwin Williams 2'       , 'N', 'SHW'),
    ('Skymix Automotiva'        , 'N', 'SKY'),
    ('Sparlack'                 , 'N', 'SPA'),
    ('Standox'                  , 'N', 'DOX'),
    ('Starmix'                  , 'N', 'STA'),
    ('Starmix Web'              , 'N', 'STW'),
    ('Suvinil'                  , 'N', 'SUV'),
    ('Textura e Cia'            , 'N', 'TEX'),
    ('Top Coat'                 , 'N', 'COA'),
    ('Universo'                 , 'N', 'UNI'),
    ('Velutex'                  , 'N', 'VEL'),
    ('Weg'                      , 'N', 'WEG'));

{$IFNDEF LINUX}
var
  frmExportaTintometricosTerceiros: TfrmExportaTintometricosTerceiros;
{$ENDIF}

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  untExportaTintometricosTerceirosSuvinil,
  untExportaTintometricosTerceirosCoralImobiliaria,
  untExportaTintometricosTerceirosFutura,
  untExportaTintometricosTerceirosSayerlack,
  untExportaTintometricosTerceirosSherwinWilliams,
  untExportaTintometricosTerceirosRennerImobiliaria,
  untExportaTintometricosTerceirosEucatex,
  untExportaTintometricosTerceirosDacar,
  untExportaTintometricosTerceirosBautech,
  untExportaTintometricosTerceirosPPG,
  untExportaTintometricosTerceirosBrasimixAutomotiva,
  untExportaTintometricosTerceirosSkymixAutomotiva,
  untExportaTintometricosTerceirosDupont,
  untExportaTintometricosTerceirosFalcao,
  untExportaTintometricosTerceirosColorPro,
  untExportaTintometricosTerceirosLazzumix,
  untExportaTintometricosTerceirosSherwinWilliams2,
  untExportaTintometricosTerceirosAdvance,
  untExportaTintometricosTerceirosAlessiImobiliaria,
  untExportaTintometricosTerceirosAnjoAutomotiva,
  untExportaTintometricosTerceirosAnjoImobiliaria,
  untExportaTintometricosTerceirosAnjoSintetica,
  untExportaTintometricosTerceirosBrazilianColor,
  untExportaTintometricosTerceirosGeneral,
  untExportaTintometricosTerceirosAnnetta,
  untExportaTintometricosTerceirosBellaCor,
  untExportaTintometricosTerceirosBrasimixImobiliaria,
  untExportaTintometricosTerceirosCalamar,
  untExportaTintometricosTerceirosCiaCollor,
  untExportaTintometricosTerceirosDuxone,
  untExportaTintometricosTerceirosFarbenAutomotiva,
  untExportaTintometricosTerceirosGlobalColor,
  untExportaTintometricosTerceirosGrafftex,
  untExportaTintometricosTerceirosHydronorthImobiliaria,
  untExportaTintometricosTerceirosInternational,
  untExportaTintometricosTerceirosIquine,
  untExportaTintometricosTerceirosJotun,
  untExportaTintometricosTerceirosKilling,
  untExportaTintometricosTerceirosKresil,
  untExportaTintometricosTerceirosLiko,
  untExportaTintometricosTerceirosLukscolor,
  untExportaTintometricosTerceirosLukscolor2,
  untExportaTintometricosTerceirosMazaAutomotiva,
  untExportaTintometricosTerceirosMazaImobiliaria,
  untExportaTintometricosTerceirosMazaIndustrial,
  untExportaTintometricosTerceirosMegaTintas,
  untExportaTintometricosTerceirosMontana,
  untExportaTintometricosTerceirosNexa,
  untExportaTintometricosTerceirosPpgNexa,
  untExportaTintometricosTerceirosQualyVinil,
  untExportaTintometricosTerceirosRecoa,
  untExportaTintometricosTerceirosRennerIndustrial,
  untExportaTintometricosTerceirosSparlack,
  untExportaTintometricosTerceirosStandox,
  untExportaTintometricosTerceirosStarmix,
  untExportaTintometricosTerceirosUniverso,
  untExportaTintometricosTerceirosVelutex,
  untExportaTintometricosTerceirosWeg,
  untExportaTintometricosTerceirosInkor,
  untExportaTintometricosTerceirosResicolor,
  untExportaTintometricosTerceirosStarmixWeb,
  untExportaTintometricosTerceirosKillingIndustrial,
  untExportaTintometricosTerceirosAdvanceTintoSystem,
  untExportaTintometricosTerceirosMaxVinil,
  untExportaTintometricosTerceirosAlterPlus,
  untExportaTintometricosTerceirosGlobalBsn,
  untExportaTintometricosTerceirosGlobalCsn,
  untExportaTintometricosTerceirosGlobalBc,
  untExportaTintometricosTerceirosColorbraz,
  untExportaTintometricosTerceirosBellaCorTintavel,
  untExportaTintometricosTerceirosAutoluks,
  untExportaTintometricosTerceirosTopCoat,
  untExportaTintometricosTerceirosGlobalCc11,
  untExportaTintometricosTerceirosTexturaCia,
  untExportaTintometricosTerceirosChreon,
  untExportaTintometricosTerceirosAdvanceStr,
  untExportaTintometricosTerceirosDuxone2,
  untExportaTintometricosTerceirosLeinertex,
  untExportaTintometricosTerceirosMaestria,
  untExportaTintometricosTerceirosSinteplast,
  untExportaTintometricosTerceirosDacasa,
  untExportaTintometricosTerceirosLuztol,
  untExportaTintometricosTerceirosLechler,
  untExportaTintometricosTerceirosRennerPerformance,
  untExportaTintometricosTerceirosMiniFabrica,
  untExportaTintometricosTerceirosRoberlo;

{$IFNDEF LINUX}
  {$R *.dfm}
{$ENDIF}

{$IFNDEF LINUX}
procedure TfrmExportaTintometricosTerceiros.btnExportarClick(Sender: TObject);
var
  intTopL, intTopP: Integer;
  intQtdTin: Integer;
begin
  inherited;
  If fValidou Then
  Begin
    Try

      intTopL := 5;
      intTopP := 20;
      intQtdTin := 1;

      pHabilitaBotoes(False);
      dbgTintas.Enabled := False;
      Timer.Enabled := True;
      SetEnabledButtonClose(Self, False);

      TNewTimer.SuspendedTimers.Add('TfrmPrincipal');

      cdsTintas.First;
      While Not cdsTintas.Eof Do
      Begin
        If (intQtdTin >= 2) And (cdsTintasEXPORTAR.AsString = 'S') Then
        Begin
          intTopL := intTopL + 40;
          intTopP := intTopP + 40;
        End;

        If cdsTintasEXPORTAR.AsString = 'S' Then
        Begin
          pExecutaThreads(cdsTintasIDEPRO.AsString, intTopL, intTopP);
          Inc(intQtdTin);
        End;

        cdsTintas.Next;
      End;

    Finally
      TNewTimer.SuspendedTimers.Remove('TfrmPrincipal');
    End;
  End;
end;

procedure TfrmExportaTintometricosTerceiros.btnMarDesClick(Sender: TObject);
begin
  inherited;
  pMarcarDesmarcar;
end;

procedure TfrmExportaTintometricosTerceiros.btnSairClick(Sender: TObject);
begin
  If fTodasAsThreadsLiberadas Then
    inherited;
end;

function TfrmExportaTintometricosTerceiros.fGeracaoFinalizada: Boolean;
var
  intCont: Integer;
begin
  Result := True;

  For intCont := 0 To Threads.Count - 1 Do
  Begin
    Result := fTodasAsThreadsFinalizadas(intCont);

    If Not Result Then
      Break;
  End;

  Result := Result And (Not btnExportar.Enabled);
end;

procedure TfrmExportaTintometricosTerceiros.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  pLiberarAsThreads();
  cdsTintas.Close;
  inherited;
end;

procedure TfrmExportaTintometricosTerceiros.FormCreate(Sender: TObject);
begin
  inherited;
  Labels := TList.Create;
  Progresso := TList.Create;
  Threads := TList.Create;
end;

procedure TfrmExportaTintometricosTerceiros.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(Labels);
  FreeAndNil(Progresso);
  FreeAndNil(Threads);
end;

procedure TfrmExportaTintometricosTerceiros.FormShow(Sender: TObject);
begin
  inherited;
  With cdsTintas Do
  Begin
    CreateDataSet;
    pAdicionaCds;
  End;
  pSetFocus(btnExportar);
end;

function TfrmExportaTintometricosTerceiros.fRetNomeTinta
  (strIdePro: String): String;
begin
  Result := '';

  If strIdePro = 'SUV' Then
    Result := 'Suvinil'
  Else If strIdePro = 'CIM' Then
    Result := 'Coral Imobilíaria'
  Else If strIdePro = 'FUT' Then
    Result := 'Futura'
  Else If strIdePro = 'SAY' Then
    Result := 'Sayerlack'
  Else If strIdePro = 'SHE' Then
    Result := 'Sherwin Willians'
  Else If strIdePro = 'REI' Then
    Result := 'Renner Imobilíaria'
  Else If strIdePro = 'EUC' Then
    Result := 'Eucatex'
  Else If strIdePro = 'DAC' Then
    Result := 'Dacar'
  Else If strIdePro = 'DCA' Then
    Result := 'Dacasa'
  Else If strIdePro = 'BAU' Then
    Result := 'Bautech'
  Else If strIdePro = 'PPG' Then
    Result := 'Ppg'
  Else If strIdePro = 'BZA' Then
    Result := 'Brasimix Automotiva'
  Else If strIdePro = 'SKY' Then
    Result := 'Skymix Automotiva'
  Else If strIdePro = 'DUP' Then
    Result := 'Axalta'
  Else If strIdePro = 'FAL' Then
    Result := 'Falcao'
  Else If strIdePro = 'WCP' Then
    Result := 'Color Pro'
  Else If strIdePro = 'LAZ' Then
    Result := 'Lazzumix'
  Else If strIdePro = 'LEI' Then
    Result := 'Leinertex'
  Else If strIdePro = 'SHW' Then
    Result := 'Sherwin Willians 2'
  Else If strIdePro = 'ADV' Then
    Result := 'Advance'
  Else If strIdePro = 'ADS' Then
    Result := 'Advance Str'
  Else If strIdePro = 'ADT' Then
    Result := 'Advance TintoSystem'
  Else If strIdePro = 'ALE' Then
    Result := 'Alessi Imobilíaria'
  Else If strIdePro = 'ALP' Then
    Result := 'Alter Plus'
  Else If strIdePro = 'AJT' Then
    Result := 'Anjo Automotiva'
  Else If strIdePro = 'ANJ' Then
    Result := 'Anjo Imobiliária'
  Else If strIdePro = 'AJA' Then
    Result := 'Anjo Sintetica'
  Else If strIdePro = 'ALK' Then
    Result := 'Autoluks'
  Else If strIdePro = 'BZC' Then
    Result := 'Brazilian Color'
  Else If strIdePro = 'GEN' Then
    Result := 'General'
  Else If strIdePro = 'ANN' Then
    Result := 'Annetta'
  Else If strIdePro = 'BEL' Then
    Result := 'BellaCor'
  Else If strIdePro = 'BLT' Then
    Result := 'BellaCor Tintavel'
  Else If strIdePro = 'BZI' Then
    Result := 'Brasimix Imobilíaria'
  Else If strIdePro = 'CAL' Then
    Result := 'Calamar'
  Else If strIdePro = 'CHR' Then
    Result := 'Chreon'
  Else If strIdePro = 'CIA' Then
    Result := 'CiaCollor'
  Else If strIdePro = 'CLB' Then
    Result := 'Colorbraz'
  Else If strIdePro = 'DUX' Then
    Result := 'Duxone'
  Else if strIdePro = 'DU2' Then
    Result := 'Duxone 2'
  Else If strIdePro = 'FAR' Then
    Result := 'Farben Automotiva'
  Else If strIdePro = 'GLO' Then
    Result := 'Global Color'
  Else If strIdePro = 'GBC' Then
    Result := 'Global BC'
  Else If strIdePro = 'BSN' Then
    Result := 'Global Bsn'
  Else If strIdePro = 'C11' Then
    Result := 'Global Cc11'
  Else If strIdePro = 'CSN' Then
    Result := 'Global Csn'
  Else If strIdePro = 'GRA' Then
    Result := 'Grafftex'
  Else If strIdePro = 'HYD' Then
    Result := 'Hydronorth Imobilíaria'
  Else If strIdePro = 'INK' Then
    Result := 'Inkor'
  Else If strIdePro = 'INT' Then
    Result := 'International'
  Else If strIdePro = 'IQU' Then
    Result := 'Iquine'
  Else If strIdePro = 'JOT' Then
    Result := 'Jotun'
  Else If strIdePro = 'KIL' Then
    Result := 'Killing'
  Else If strIdePro = 'KIN' Then
    Result := 'Killing Industrial'
  Else If strIdePro = 'KRE' Then
    Result := 'Kresil'
  Else If strIdePro = 'LEC' Then
    Result := 'Lechler'
  Else If strIdePro = 'LIK' Then
    Result := 'Liko'
  Else If strIdePro = 'LKS' Then
    Result := 'Lukscolor'
  Else If strIdePro = 'LKC' Then
    Result := 'Lukscolor2'
  Else If strIdePro = 'LUZ' Then
    Result := 'Luztol'
  Else If strIdePro = 'MAE' Then
    Result := 'Maestria'
  Else If strIdePro = 'MAX' Then
    Result := 'MaxVinil'
  Else If strIdePro = 'MZA' Then
    Result := 'Maza Automotiva'
  Else If strIdePro = 'MZI' Then
    Result := 'Maza Imobiliária'
  Else If strIdePro = 'MZD' Then
    Result := 'Maza Industrial'
  Else If strIdePro = 'MEG' Then
    Result := 'Mega Tintas'
  Else If strIdePro = 'MIF' Then
    Result := 'Mini Fábrica'
  Else If strIdePro = 'MON' Then
    Result := 'Montana'
  Else If strIdePro = 'NEX' Then
    Result := 'Nexa Autocolor'
  Else If strIdePro = 'PPX' Then
    Result := 'Ppg/Nexa'
  Else If strIdePro = 'QUA' Then
    Result := 'QualyVinil'
  Else If strIdePro = 'REC' Then
    Result := 'Recoa'
  Else If strIdePro = 'REN' Then
    Result := 'Renner Industrial'
  Else If strIdePro = 'REP' Then
    Result := 'Renner Performance'
  Else If strIdePro = 'RSI' Then
    Result := 'Resicolor'
  Else If strIdePro = 'ROB' Then
    Result := 'Roberlo'
  Else If strIdePro = 'SIN' Then
    Result := 'Sinteplast'
  Else If strIdePro = 'SPA' Then
    Result := 'Sparlack'
  Else If strIdePro = 'DOX' Then
    Result := 'Standox'
  Else If strIdePro = 'STA' Then
    Result := 'Starmix'
  Else If strIdePro = 'STW' Then
    Result := 'Starmix Web'
  Else If strIdePro = 'TEX' Then
    Result := 'Textura e Cia'
  Else If strIdePro = 'COA' Then
    Result := 'Top Coat'
  Else If strIdePro = 'UNI' Then
    Result := 'Universo'
  Else If strIdePro = 'VEL' Then
    Result := 'Velutex'
  Else If strIdePro = 'WEG' Then
    Result := 'Weg';
end;

function TfrmExportaTintometricosTerceiros.fRetornaTipoTinta(strIdePro: String)
  : TTipoTinta;
begin
  Result := SemTipo;

  If strIdePro = 'SUV' Then
    Result := Suv
  Else If strIdePro = 'CIM' Then
    Result := Cim
  Else If strIdePro = 'FUT' Then
    Result := Fut
  Else If strIdePro = 'SAY' Then
    Result := Say
  Else If strIdePro = 'SHE' Then
    Result := She
  Else If strIdePro = 'REI' Then
    Result := Rei
  Else If strIdePro = 'EUC' Then
    Result := Euc
  Else If strIdePro = 'DAC' Then
    Result := Dac
  Else If strIdePro = 'DCA' Then
    Result := Dca
  Else If strIdePro = 'BAU' Then
    Result := Bau
  Else If strIdePro = 'PPG' Then
    Result := Ppg
  Else If strIdePro = 'BZA' Then
    Result := Bza
  Else If strIdePro = 'SKY' Then
    Result := Sky
  Else If strIdePro = 'DUP' Then
    Result := Dup
  Else If strIdePro = 'FAL' Then
    Result := Fal
  Else If strIdePro = 'WCP' Then
    Result := Wan
  Else If strIdePro = 'LAZ' Then
    Result := Laz
  Else If strIdePro = 'SHW' Then
    Result := Shw
  Else If strIdePro = 'ADV' Then
    Result := Adv
  Else If strIdePro = 'ADS' Then
    Result := Ads
  Else If strIdePro = 'ADT' Then
    Result := Adt
  Else If strIdePro = 'ALE' Then
    Result := Ale
  Else If strIdePro = 'ALP' Then
    Result := Alp
  Else If strIdePro = 'AJT' Then
    Result := Ajt
  Else If strIdePro = 'ANJ' Then
    Result := Anj
  Else If strIdePro = 'AJA' Then
    Result := Aja
  Else If strIdePro = 'ALK' Then
    Result := Alk
  Else If strIdePro = 'BZC' Then
    Result := Bzc
  Else If strIdePro = 'GEN' Then
    Result := Gen
  Else If strIdePro = 'ANN' Then
    Result := Ann
  Else If strIdePro = 'BEL' Then
    Result := Bel
  Else If strIdePro = 'BLT' Then
    Result := Blt
  Else If strIdePro = 'BZI' Then
    Result := Bzi
  Else If strIdePro = 'CAL' Then
    Result := Cal
  Else If strIdePro = 'CHR' Then
    Result := Chr
  Else If strIdePro = 'CIA' Then
    Result := Cia
  Else If strIdePro = 'CLB' Then
    Result := Clb
  Else If strIdePro = 'DUX' Then
    Result := Dux
  Else If strIdePro = 'DU2' Then
    Result := Du2
  Else If strIdePro = 'FAR' Then
    Result := Frb
  Else If strIdePro = 'GBC' Then
    Result := Gbc
  Else If strIdePro = 'BSN' Then
    Result := Bsn
  Else If strIdePro = 'C11' Then
    Result := C11
  Else If strIdePro = 'GLO' Then
    Result := Glo
  Else If strIdePro = 'CSN' Then
    Result := Csn
  Else If strIdePro = 'GRA' Then
    Result := Gra
  Else If strIdePro = 'HYD' Then
    Result := Hyd
  Else If strIdePro = 'INK' Then
    Result := Ink
  Else If strIdePro = 'INT' Then
    Result := Int
  Else If strIdePro = 'IQU' Then
    Result := Iqu
  Else If strIdePro = 'JOT' Then
    Result := Jot
  Else If strIdePro = 'KIL' Then
    Result := Kil
  Else If strIdePro = 'KIN' Then
    Result := Kin
  Else If strIdePro = 'KRE' Then
    Result := Kre
  Else If strIdePro = 'LEC' Then
    Result := Lec
  Else If strIdePro = 'LEI' Then
    Result := Lei
  Else If strIdePro = 'LIK' Then
    Result := Lik
  Else If strIdePro = 'LKS' Then
    Result := Lks
  Else If strIdePro = 'LKC' Then
    Result := Lkc
  Else If strIdePro = 'LUZ' Then
    Result := Luz
  Else If strIdePro = 'MAE' Then
    Result := Mae
  Else If strIdePro = 'MAX' Then
    Result := Max
  Else If strIdePro = 'MZA' Then
    Result := Mza
  Else If strIdePro = 'MZI' Then
    Result := Mzi
  Else If strIdePro = 'MZD' Then
    Result := Mzd
  Else If strIdePro = 'MEG' Then
    Result := Meg
  Else If strIdePro = 'MIF' Then
    Result := Mif
  Else If strIdePro = 'MON' Then
    Result := Mon
  Else If strIdePro = 'NEX' Then
    Result := Nex
  Else If strIdePro = 'PPX' Then
    Result := Ppx
  Else If strIdePro = 'QUA' Then
    Result := Qua
  Else If strIdePro = 'REC' Then
    Result := Rec
  Else If strIdePro = 'REN' Then
    Result := Ren
  Else If strIdePro = 'REP' Then
    Result := Rep
  Else If strIdePro = 'RSI' Then
    Result := Rsi
  Else If strIdePro = 'ROB' Then
    Result := Rob
  Else If strIdePro = 'SIN' Then
    Result := Sin
  Else If strIdePro = 'SPA' Then
    Result := Spa
  Else If strIdePro = 'DOX' Then
    Result := Dox
  Else If strIdePro = 'STA' Then
    Result := Sta
  Else If strIdePro = 'STW' Then
    Result := Stw
  Else If strIdePro = 'TEX' Then
    Result := Tex
  Else If strIdePro = 'COA' Then
    Result := Coa
  Else If strIdePro = 'UNI' Then
    Result := Unv
  Else If strIdePro = 'VEL' Then
    Result := Vel
  Else If strIdePro = 'WEG' Then
    Result := Weg;
end;

function TfrmExportaTintometricosTerceiros.fSeleciou: Boolean;
begin
  Result := False;
  With cdsTintas Do
  Begin
    Try
      DisableControls;
      While Not Eof Do
      Begin
        If FieldByName('EXPORTAR').AsString = 'S' Then
        Begin
          Result := True;
          Break;
        End;
        Next;
      End;
    Finally
      First;
      EnableControls;
    End;
  End;

  If Not Result Then
    fMensagem('ATENÇÃO',
      'Nenhuma tinta foi selecionada para exportação!', ['&Ok']);
end;

function TfrmExportaTintometricosTerceiros.fTabelaTintaConfigurada: Boolean;
var
  strTabTin: String;
begin
  Result := False;
  If (fCfgSis('PREGER') = '1') Then
  Begin
    strTabTin := fCfgSis('TABPRE');

    If Not fEmptyStr(strTabTin) Then
      Result := True;
  End
  // Quando configurado por tabela de preço do cliente.
  // Sistema irá pegar uma tabela especifica somente para a geracao.
  Else If (fCfgSis('PREGER') = '2') Then
  Begin
    strTabTin := fCfgSis('TABTER');
    If Not fEmptyStr(strTabTin) Then
      Result := True;
  End;

  If (Not Result) Then
    fMensagem('ATENÇÃO',
      'Tabela de preço da tinta de máquina não configurada!', ['&Ok']);
end;

function TfrmExportaTintometricosTerceiros.fTodasAsThreadsFinalizadas(intCont: Integer): Boolean;
begin
  Result := (TThreadExportacaoTerceiros(Threads[intCont]).FStatus = 'F');
end;

function TfrmExportaTintometricosTerceiros.fTodasAsThreadsLiberadas: Boolean;
Var
  intCont: Integer;
begin
  Result := True;

  For intCont := 0 To Threads.Count - 1 Do
  Begin
    Result := (TThreadExportacaoTerceiros(Threads[intCont]) = Nil);

    If Not Result Then
      Break;
  End;
end;

function TfrmExportaTintometricosTerceiros.fUtilizaTinta
  (strIdePro: String): Boolean;
var
  qryCfgTin: TUniQuery;
begin
  Try
    qryCfgTin := fCriaQuery;
    With qryCfgTin Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT CFG_VALCFG ');
      SQL.Add('   FROM CFGTIN     ');
      SQL.Add('  WHERE CFG_IDEPRO = :IDEPRO  ');
      SQL.Add('    AND CFG_CODEMP = :CODEMP  ');
      SQL.Add('    AND CFG_CODCFG = "USATIN" ');
      ParamByName('IDEPRO').AsString := strIdePro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      Result := FieldByName('CFG_VALCFG').AsString = 'S';
    End;
  Finally
    FreeAndNil(qryCfgTin);
  End;
end;

function TfrmExportaTintometricosTerceiros.fValidou: Boolean;
begin
  Result := fSeleciou;

  If Result Then
    Result := fTabelaTintaConfigurada;
end;

procedure TfrmExportaTintometricosTerceiros.pAdicionaCds;
var
  intContador: Integer;
begin
  With cdsTintas Do
  Begin
    Try
      DisableControls;

      For intContador := 1 To Length(ArrTintas) Do
      Begin
        If fUtilizaTinta(ArrTintas[intContador][3]) Then
        Begin
          Append;
          FieldByName('NOME').AsString := ArrTintas[intContador][1];
          FieldByName('EXPORTAR').AsString := ArrTintas[intContador][2];
          FieldByName('IDEPRO').AsString := ArrTintas[intContador][3];
          Post;
        End;
      End;
    Finally
      First;
      EnableControls;
    End;
  End;
end;


procedure TfrmExportaTintometricosTerceiros.pCriaLabelGeneric(strIdePro: String;
  intTop: Integer);
begin
  lblGen := TLabel.Create(Nil);
  lblGen.Parent := ScrProgTintas;
  lblGen.Name := 'lbl' + strIdePro;
  lblGen.Top := intTop;
  lblGen.Left := 5;
  lblGen.Caption := fRetNomeTinta(strIdePro);
  Labels.Add(lblGen);
end;

procedure TfrmExportaTintometricosTerceiros.pCriaProgressoGeneric
  (strIdePro: String; intTop: Integer);
begin
  prgGen := TcxProgressBar.Create(Nil);
  prgGen.Parent := ScrProgTintas;
  prgGen.Name := 'Prg' + strIdePro;
  prgGen.Top := intTop;
  prgGen.Left := 5;
  prgGen.Width := 350;
  Progresso.Add(prgGen);
end;

procedure TfrmExportaTintometricosTerceiros.pCriaThread(Tipo: TTipoTinta);
begin
  case Tipo of
    Adv: ThreadTin := TExportaTintometricosTerceirosAdvance.Create(prgGen, 'ADV', False);
    Ads: ThreadTin := TExportaTintometricosTerceirosAdvanceStr.Create(prgGen, 'ADS', False);
    Adt: ThreadTin := TExportaTintometricosTerceirosAdvanceTintoSystem.Create(prgGen, 'ADT', False);
    Ale: ThreadTin := TExportaTintometricosTerceirosAlessiImobiliaria.Create(prgGen, 'ALE', False);
    Alp: ThreadTin := TExportaTintometricosTerceirosAlterPlus.Create(prgGen, 'ALP', False);
    Ajt: ThreadTin := TExportaTintometricosTerceirosAnjoAutomotiva.Create(prgGen, 'AJT', False);
    Anj: ThreadTin := TExportaTintometricosTerceirosAnjoImobiliaria.Create(prgGen, 'ANJ', False);
    Aja: ThreadTin := TExportaTintometricosTerceirosAnjoSintetica.Create(prgGen, 'AJA', False);
    Ann: ThreadTin := TExportaTintometricosTerceirosAnnetta.Create(prgGen, 'ANN', False);
    Alk: ThreadTin := TExportaTintometricosTerceirosAutoluks.Create(prgGen, 'ALK', False);
    Bau: ThreadTin := TExportaTintometricosTerceirosBautech.Create(prgGen, 'BAU', False);
    Bel: ThreadTin := TExportaTintometricosTerceirosBellaCor.Create(prgGen, 'BEL', False);
    Blt: ThreadTin := TExportaTintometricosTerceirosBellaCorTintavel.Create(prgGen, 'BLT', False);
    Bza: ThreadTin := TExportaTintometricosTerceirosBrasimixAutomotiva.Create(prgGen, 'BZA', False);
    Bzi: ThreadTin := TExportaTintometricosTerceirosBrasimixImobiliaria.Create(prgGen, 'BZI', False);
    Bzc: ThreadTin := TExportaTintometricosTerceirosBrazilianColor.Create(prgGen, 'BZC', False);
    Cal: ThreadTin := TExportaTintometricosTerceirosCalamar.Create(prgGen, 'CAL', False);
    Chr: ThreadTin := TExportaTintometricosTerceirosChreon.Create(prgGen, 'CHR', False);
    Cia: ThreadTin := TExportaTintometricosTerceirosCiaCollor.Create(prgGen, 'CIA', False);
    Clb: ThreadTin := TExportaTintometricosTerceirosColorbraz.Create(prgGen, 'CLB', False);
    Wan: ThreadTin := TExportaTintometricosTerceirosColorPro.Create(prgGen, 'WCP', False);
    Cim: ThreadTin := TExportaTintometricosTerceirosCoralImobiliaria.Create(prgGen, 'CIM', False);
    Dac: ThreadTin := TExportaTintometricosTerceirosDacar.Create(prgGen, 'DAC', False);
    Dca: ThreadTin := TExportaTintometricosTerceirosDacasa.Create(prgGen, 'DCA', False);
    Dup: ThreadTin := TExportaTintometricosTerceirosDupont.Create(prgGen, 'DUP', False);
    Dux: ThreadTin := TExportaTintometricosTerceirosDuxone.Create(prgGen, 'DUX', False);
    Du2: ThreadTin := TExportaTintometricosTerceirosDuxone2.Create(prgGen, 'DU2', False);
    Euc: ThreadTin := TExportaTintometricosTerceirosEucatex.Create(prgGen, 'EUC', False);
    Fal: ThreadTin := TExportaTintometricosTerceirosFalcao.Create(prgGen, 'FAL', False);
    Frb: ThreadTin := TExportaTintometricosTerceirosFarbenAutomotiva.Create(prgGen, 'FAR', False);
    Fut: ThreadTin := TExportaTintometricosTerceirosFutura.Create(prgGen, 'FUT', False);
    Gen: ThreadTin := TExportaTintometricosTerceirosGeneral.Create(prgGen, 'GEN', False);
    Gbc: ThreadTin := TExportaTintometricosTerceirosGlobalBc.Create(prgGen, 'GBC', False);
    Bsn: ThreadTin := TExportaTintometricosTerceirosGlobalBsn.Create(prgGen, 'BSN', False);
    C11: ThreadTin := TExportaTintometricosTerceirosGlobalCc11.Create(prgGen, 'C11', False);
    Glo: ThreadTin := TExportaTintometricosTerceirosGlobalColor.Create(prgGen, 'GLO', False);
    Csn: ThreadTin := TExportaTintometricosTerceirosGlobalCsn.Create(prgGen, 'CSN', False);
    Gra: ThreadTin := TExportaTintometricosTerceirosGrafftex.Create(prgGen, 'GRA', False);
    Hyd: ThreadTin := TExportaTintometricosTerceirosHydronorthImobiliaria.Create(prgGen, 'HYD', False);
    Ink: ThreadTin := TExportaTintometricosTerceirosInkor.Create(prgGen, 'INK', False);
    Int: ThreadTin := TExportaTintometricosTerceirosInternational.Create(prgGen, 'INT', False);
    Iqu: ThreadTin := TExportaTintometricosTerceirosIquine.Create(prgGen, 'IQU', False);
    Jot: ThreadTin := TExportaTintometricosTerceirosJotun.Create(prgGen, 'JOT', False);
    Kil: ThreadTin := TExportaTintometricosTerceirosKilling.Create(prgGen, 'KIL', False);
    Kin: ThreadTin := TExportaTintometricosTerceirosKillingIndustrial.Create(prgGen, 'KIN', False);
    Kre: ThreadTin := TExportaTintometricosTerceirosKresil.Create(prgGen, 'KRE', False);
    Laz: ThreadTin := TExportaTintometricosTerceirosLazzumix.Create(prgGen, 'LAZ', False);
    Lec: ThreadTin := TExportaTintometricosTerceirosLechler.Create(prgGen, 'LEC', False);
    Lei: ThreadTin := TExportaTintometricosTerceirosLeinertex.Create(prgGen, 'LEI', False);
    Lik: ThreadTin := TExportaTintometricosTerceirosLiko.Create(prgGen, 'LIK', False);
    Lks: ThreadTin := TExportaTintometricosTerceirosLukscolor.Create(prgGen, 'LKS', False);
    Lkc: ThreadTin := TExportaTintometricosTerceirosLukscolor2.Create(prgGen, 'LKC', False);
    Luz: ThreadTin := TExportaTintometricosTerceirosLuztol.Create(prgGen, 'LUZ', False);
    Mae: ThreadTin := TExportaTintometricosTerceirosMaestria.Create(prgGen, 'MAE', False);
    Max: ThreadTin := TExportaTintometricosTerceirosMaxVinil.Create(prgGen, 'MAX', False);
    Mza: ThreadTin := TExportaTintometricosTerceirosMazaAutomotiva.Create(prgGen, 'MZA', False);
    Mzi: ThreadTin := TExportaTintometricosTerceirosMazaImobiliaria.Create(prgGen, 'MZI', False);
    Mzd: ThreadTin := TExportaTintometricosTerceirosMazaIndustrial.Create(prgGen, 'MZD', False);
    Meg: ThreadTin := TExportaTintometricosTerceirosMegaTintas.Create(prgGen, 'MEG', False);
    Mif: ThreadTin := TExportaTintometricosTerceirosMiniFabrica.Create(prgGen, 'MIF', False);
    Mon: ThreadTin := TExportaTintometricosTerceirosMontana.Create(prgGen, 'MON', False);
    Nex: ThreadTin := TExportaTintometricosTerceirosNexa.Create(prgGen, 'NEX', False);
    Ppg: ThreadTin := TExportaTintometricosTerceirosPpg.Create(prgGen, 'PPG', False);
    Ppx: ThreadTin := TExportaTintometricosTerceirosPpgNexa.Create(prgGen, 'PPX', False);
    Qua: ThreadTin := TExportaTintometricosTerceirosQualyVinil.Create(prgGen, 'QUA', False);
    Rec: ThreadTin := TExportaTintometricosTerceirosRecoa.Create(prgGen, 'REC', False);
    Rei: ThreadTin := TExportaTintometricosTerceirosRennerImobiliaria.Create(prgGen, 'REI', False);
    Ren: ThreadTin := TExportaTintometricosTerceirosRennerIndustrial.Create(prgGen, 'REN', False);
    Rep: ThreadTin := TExportaTintometricosTerceirosRennerPerformance.Create(prgGen, 'REP', False);
    Rsi: ThreadTin := TExportaTintometricosTerceirosResicolor.Create(prgGen, 'RSI', False);
    Rob: ThreadTin := TExportaTintometricosTerceirosRoberlo.Create(prgGen, 'ROB', False);
    Say: ThreadTin := TExportaTintometricosTerceirosSayerlack.Create(prgGen, 'SAY', False);
    Sin: ThreadTin := TExportaTintometricosTerceirosSinteplast.Create(prgGen, 'SIN', False);
    She: ThreadTin := TExportaTintometricosTerceirosSherwinWilliams.Create(prgGen, 'SHE', False);
    Shw: ThreadTin := TExportaTintometricosTerceirosSherwinWilliams2.Create(prgGen, 'SHW', False);
    Sky: ThreadTin := TExportaTintometricosTerceirosSkymixAutomotiva.Create(prgGen, 'SKY', False);
    Spa: ThreadTin := TExportaTintometricosTerceirosSparlack.Create(prgGen, 'SPA', False);
    Dox: ThreadTin := TExportaTintometricosTerceirosStandox.Create(prgGen, 'DOX', False);
    Sta: ThreadTin := TExportaTintometricosTerceirosStarmix.Create(prgGen, 'STA', False);
    Stw: ThreadTin := TExportaTintometricosTerceirosStarmixWeb.Create(prgGen, 'STW', False);
    Suv: ThreadTin := TExportaTintometricosTerceirosSuvinil.Create(prgGen, 'SUV', False);
    Tex: ThreadTin := TExportaTintometricosTerceirosTexturaCia.Create(prgGen, 'TEX', False);
    Coa: ThreadTin := TExportaTintometricosTerceirosTopCoat.Create(prgGen, 'COA', False);
    Unv: ThreadTin := TExportaTintometricosTerceirosUniverso.Create(prgGen, 'UNI', False);
    Vel: ThreadTin := TExportaTintometricosTerceirosVelutex.Create(prgGen, 'VEL', False);
    Weg: ThreadTin := TExportaTintometricosTerceirosWeg.Create(prgGen, 'WEG', False);
  end;
  ThreadTin.Start;
  Threads.Add(ThreadTin);
end;


procedure TfrmExportaTintometricosTerceiros.pExecutaThreads(strIdePro: String;
  intTopL, intTopP: Integer);
begin
  pThreadExecutando(fRetornaTipoTinta(strIdePro), strIdePro, intTopL, intTopP);
end;

procedure TfrmExportaTintometricosTerceiros.pHabilitaBotoes(blnFlag: Boolean);
begin
  btnExportar.Enabled := blnFlag;
  btnMarDes.Enabled := blnFlag;
end;

procedure TfrmExportaTintometricosTerceiros.pLiberarAsThreads;
Var
  intCont: Integer;
begin
  For intCont := 0 To Threads.Count -1 Do
  Begin
    If Assigned(TThreadExportacaoTerceiros(Threads[intCont])) Then
      TThreadExportacaoTerceiros(Threads[intCont]).Free;
  End;
  Threads.Clear;
end;

procedure TfrmExportaTintometricosTerceiros.pLimparGrid;
begin
  Try
    cdsTintas.DisableControls;
    cdsTintas.First;
    While Not cdsTintas.Eof Do
    Begin
      If cdsTintasEXPORTAR.AsString = 'S' Then
      Begin
        cdsTintas.Edit;
        cdsTintasEXPORTAR.AsString := 'N';
        cdsTintas.Post;
      End;

      cdsTintas.Next;
    End;
  Finally
    cdsTintas.First;
    cdsTintas.EnableControls;
  End;
end;

procedure TfrmExportaTintometricosTerceiros.pLimparTela;
var
  intCont: Integer;
begin
  For intCont := 0 To Labels.Count - 1 Do
  Begin
    TLabel(Labels[intCont]).Free;
  End;
  Labels.Clear;

  For intCont := 0 To Progresso.Count - 1 Do
  Begin
    TcxProgressBar(Progresso[intCont]).Free;
  End;
  Progresso.Clear;
end;

procedure TfrmExportaTintometricosTerceiros.pMarcarDesmarcar;
begin
  Try
    cdsTintas.DisableControls;
    cdsTintas.First;
    While Not cdsTintas.Eof Do
    Begin
      cdsTintas.Edit;
      cdsTintasEXPORTAR.AsString := IIF(cdsTintasEXPORTAR.AsString = 'S',
        'N', 'S');
      cdsTintas.Post;

      cdsTintas.Next;
    End;
  Finally
    cdsTintas.EnableControls;
    cdsTintas.First;
  End;
end;

procedure TfrmExportaTintometricosTerceiros.pThreadExecutando(Tipo: TTipoTinta;
  strIdePro: String; intTopL, intTopP: Integer);
begin
  If Tipo = SemTipo Then
  Begin
    fMensagem('ATENÇÃO',
      'A Tinta selecionada não está configurada corretamente!', ['OK']);
    pHabilitaBotoes(True);
    Exit;
  End;

  pCriaLabelGeneric(strIdePro, intTopL);
  pCriaProgressoGeneric(strIdePro, intTopP);
  pCriaThread(Tipo);
end;

procedure TfrmExportaTintometricosTerceiros.SetEnabledButtonClose(Form: TForm;
  Habilitar: Boolean);
Var
  Flag: UINT;
  AppSysMenu: THandle;
begin
  AppSysMenu := GetSystemMenu(Form.Handle, False);
  Flag := IfThen(Habilitar, MF_ENABLED, MF_DISABLED);
  EnableMenuItem(AppSysMenu, SC_CLOSE, MF_BYCOMMAND OR FLAG);
end;

procedure TfrmExportaTintometricosTerceiros.TimerTimer(Sender: TObject);
begin
  inherited;
  If fGeracaoFinalizada Then
  Begin
    pLiberarAsThreads;
    pLimparTela;
    pLimparGrid;
    pHabilitaBotoes(True);
    dbgTintas.Enabled := True;
    Timer.Enabled := False;
    SetEnabledButtonClose(Self, True);
    fMensagem('ATENÇÃO', 'Registros exportados com sucesso!', ['&Ok']);
  End;
end;
{$ENDIF}

procedure TExportarAutomaticoTintometricosTerceiros.
  pExportarAutomaticoTintometricosTerceiros(strIdePro: String;
  blnGeracaoAut: Boolean);
var
  ArrIdePro: Array Of String;
  intCont: Integer;

  function fValidaTabelaTinta: Boolean;
  var
    strTabTin: String;
  begin
    Result := False;
    If (fCfgSis('PREGER') = '1') Then
    Begin
      strTabTin := fCfgSis('TABPRE');
      If Not fEmptyStr(strTabTin) Then
        Result := True;
    End
    // Quando configurado por tabela de preço do cliente.
    // Sistema irá pegar uma tabela especifica somente para a geracao.
    Else If (fCfgSis('PREGER') = '2') Then
    Begin
      strTabTin := fCfgSis('TABTER');
      If Not fEmptyStr(strTabTin) Then
        Result := True;
    End;
  End;

  procedure pThreadAdvance;
  Begin
    ThreadAdv := TExportaTintometricosTerceirosAdvance.Create(Nil, 'ADV', blnGeracaoAut);
    ThreadAdv.Start;
  End;

  procedure pThreadAdvanceStr;
  Begin
    ThreadAds := TExportaTintometricosTerceirosAdvanceStr.Create(Nil, 'ADS', blnGeracaoAut);
    ThreadAds.Start;
  End;

  procedure pThreadAdvanceTintoSystem;
  Begin
    ThreadAdt := TExportaTintometricosTerceirosAdvanceTintoSystem.Create(Nil, 'ADT', blnGeracaoAut);
    ThreadAdt.Start;
  End;

  procedure pThreadAlessiImobiliaria;
  Begin
    ThreadAle := TExportaTintometricosTerceirosAlessiImobiliaria.Create(Nil, 'ALE', blnGeracaoAut);
    ThreadAle.Start;
  End;

  procedure pThreadAlterPlus;
  Begin
    ThreadAlp := TExportaTintometricosTerceirosAlterPlus.Create(Nil, 'ALP', blnGeracaoAut);
    ThreadAlp.Start;
  End;

  procedure pThreadAnjoAutomotiva;
  Begin
    ThreadAjt := TExportaTintometricosTerceirosAnjoAutomotiva.Create(Nil, 'AJT', blnGeracaoAut);
    ThreadAjt.Start;
  End;

  procedure pThreadAnjoImobiliaria;
  Begin
    ThreadAnj := TExportaTintometricosTerceirosAnjoImobiliaria.Create(Nil, 'ANJ', blnGeracaoAut);
    ThreadAnj.Start;
  End;

  procedure pThreadAnjoSintetica;
  Begin
    ThreadAja := TExportaTintometricosTerceirosAnjoSintetica.Create(Nil, 'AJA', blnGeracaoAut);
    ThreadAja.Start;
  End;

  procedure pThreadAnnetta;
  Begin
    ThreadAnn := TExportaTintometricosTerceirosAnnetta.Create(Nil, 'ANN', blnGeracaoAut);
    ThreadAnn.Start;
  End;

  procedure pThreadAutoluks;
  Begin
    ThreadAlk := TExportaTintometricosTerceirosAutoluks.Create(Nil, 'ALK', blnGeracaoAut);
    ThreadAlk.Start;
  End;

  procedure pThreadBautech;
  begin
    ThreadBau := TExportaTintometricosTerceirosBautech.Create(Nil, 'BAU', blnGeracaoAut);
    ThreadBau.Start;
  end;

  procedure pThreadBellaCor;
  Begin
    ThreadBel := TExportaTintometricosTerceirosBellaCor.Create(Nil, 'BEL', blnGeracaoAut);
    ThreadBel.Start;
  End;

  procedure pThreadBellaCorTintavel;
  Begin
    ThreadBlt := TExportaTintometricosTerceirosBellaCorTintavel.Create(Nil, 'BLT', blnGeracaoAut);
    ThreadBlt.Start;
  End;

  procedure pThreadBrasimixAutomotiva;
  Begin
    ThreadBza := TExportaTintometricosTerceirosBrasimixAutomotiva.Create(Nil, 'BZA', blnGeracaoAut);
    ThreadBza.Start;
  End;

  procedure pThreadBrasimixImobiliaria;
  Begin
    ThreadBzi := TExportaTintometricosTerceirosBrasimixImobiliaria.Create(Nil, 'BZI', blnGeracaoAut);
    ThreadBzi.Start;
  End;

  procedure pThreadBrazilianColor;
  Begin
    ThreadBzc := TExportaTintometricosTerceirosBrazilianColor.Create(Nil, 'BZC', blnGeracaoAut);
    ThreadBzc.Start;
  End;

  procedure pThreadCalamar;
  Begin
    ThreadCal := TExportaTintometricosTerceirosCalamar.Create(Nil, 'CAL', blnGeracaoAut);
    ThreadCal.Start;
  End;

  procedure pThreadChreon;
  Begin
    ThreadChr := TExportaTintometricosTerceirosChreon.Create(Nil, 'CHR', blnGeracaoAut);
    ThreadChr.Start;
  End;

  procedure pThreadCiaCollor;
  Begin
    ThreadCia := TExportaTintometricosTerceirosCiaCollor.Create(Nil, 'CIA', blnGeracaoAut);
    ThreadCia.Start;
  End;

  procedure pThreadColorbraz;
  Begin
    ThreadClb := TExportaTintometricosTerceirosColorbraz.Create(Nil, 'CLB', blnGeracaoAut);
    ThreadClb.Start;
  End;

  procedure pThreadWanColorPro;
  Begin
    ThreadWan := TExportaTintometricosTerceirosColorPro.Create(Nil, 'WCP', blnGeracaoAut);
    ThreadWan.Start;
  End;

  procedure pThreadCoralImobiliaria;
  begin
    ThreadCim := TExportaTintometricosTerceirosCoralImobiliaria.Create(Nil, 'CIM', blnGeracaoAut);
    ThreadCim.Start;
  end;

  procedure pThreadDacar;
  begin
    ThreadDac := TExportaTintometricosTerceirosDacar.Create(Nil, 'DAC', blnGeracaoAut);
    ThreadDac.Start;
  end;

  procedure pThreadDacasa;
  begin
    ThreadDca := TExportaTintometricosTerceirosDacasa.Create(Nil, 'DCA', blnGeracaoAut);
    ThreadDca.Start;
  end;

  procedure pThreadAxalta;
  Begin
    ThreadDup := TExportaTintometricosTerceirosDupont.Create(Nil, 'DUP', blnGeracaoAut);
    ThreadDup.Start;
  End;

  procedure pThreadDuxone;
  Begin
    ThreadDux := TExportaTintometricosTerceirosDuxone.Create(Nil, 'DUX', blnGeracaoAut);
    ThreadDux.Start;
  End;

  procedure pThreadDuxone2;
  Begin
    ThreadDu2 := TExportaTintometricosTerceirosDuxone2.Create(Nil, 'DU2', blnGeracaoAut);
    ThreadDu2.Start;
  End;

  procedure pThreadEucatex;
  begin
    ThreadEuc := TExportaTintometricosTerceirosEucatex.Create(Nil, 'EUC', blnGeracaoAut);
    ThreadEuc.Start;
  end;

  procedure pThreadFalcao;
  Begin
    ThreadFal := TExportaTintometricosTerceirosFalcao.Create(Nil, 'FAL', blnGeracaoAut);
    ThreadFal.Start;
  End;

  procedure pThreadFarbenAutomotiva;
  Begin
    ThreadFar := TExportaTintometricosTerceirosFarbenAutomotiva.Create(Nil, 'FAR', blnGeracaoAut);
    ThreadFar.Start;
  End;

  procedure pThreadFutura;
  begin
    ThreadFut := TExportaTintometricosTerceirosFutura.Create(Nil, 'FUT', blnGeracaoAut);
    ThreadFut.Start;
  end;

  procedure pThreadGeneral;
  Begin
    ThreadGen := TExportaTintometricosTerceirosGeneral.Create(Nil, 'GEN', blnGeracaoAut);
    ThreadGen.Start;
  End;

  procedure pThreadGlobalBc;
  Begin
    ThreadGbc := TExportaTintometricosTerceirosGlobalBc.Create(Nil, 'GBC', blnGeracaoAut);
    ThreadGbc.Start;
  End;

  procedure pThreadGlobalBsn;
  Begin
    ThreadBsn := TExportaTintometricosTerceirosGlobalBsn.Create(Nil, 'BSN', blnGeracaoAut);
    ThreadBsn.Start;
  End;

  procedure pThreadGlobalCc11;
  Begin
    ThreadC11 := TExportaTintometricosTerceirosGlobalCc11.Create(Nil, 'C11', blnGeracaoAut);
    ThreadC11.Start;
  End;

  procedure pThreadGlobalColor;
  Begin
    ThreadGlo := TExportaTintometricosTerceirosGlobalColor.Create(Nil, 'GLO', blnGeracaoAut);
    ThreadGlo.Start;
  End;

  procedure pThreadGlobalCsn;
  Begin
    ThreadCsn := TExportaTintometricosTerceirosGlobalCsn.Create(Nil, 'CSN', blnGeracaoAut);
    ThreadCsn.Start;
  End;

  procedure pThreadGrafftex;
  Begin
    ThreadGra := TExportaTintometricosTerceirosGrafftex.Create(Nil, 'GRA', blnGeracaoAut);
    ThreadGra.Start;
  End;

  procedure pThreadHydronorthImobiliaria;
  Begin
    ThreadHyd := TExportaTintometricosTerceirosHydronorthImobiliaria.Create(Nil, 'HYD', blnGeracaoAut);
    ThreadHyd.Start;
  End;

  procedure pThreadInkor;
  Begin
    ThreadInk := TExportaTintometricosTerceirosInkor.Create(Nil, 'INK', blnGeracaoAut);
    ThreadInk.Start;
  End;

  procedure pThreadInternational;
  Begin
    ThreadInt := TExportaTintometricosTerceirosInternational.Create(Nil, 'INT', blnGeracaoAut);
    ThreadInt.Start;
  End;

  procedure pThreadIquine;
  Begin
    ThreadIqu := TExportaTintometricosTerceirosIquine.Create(Nil, 'IQU', blnGeracaoAut);
    ThreadIqu.Start;
  End;

  procedure pThreadJotun;
  Begin
    ThreadJot := TExportaTintometricosTerceirosJotun.Create(Nil, 'JOT',
      blnGeracaoAut);
    ThreadJot.Start;
  End;

  procedure pThreadKilling;
  Begin
    ThreadKil := TExportaTintometricosTerceirosKilling.Create(Nil, 'KIL', blnGeracaoAut);
    ThreadKil.Start;
  End;

  procedure pThreadKillingIndustrial;
  Begin
    ThreadKin := TExportaTintometricosTerceirosKillingIndustrial.Create(Nil, 'KIN', blnGeracaoAut);
    ThreadKin.Start;
  End;

  procedure pThreadKresil;
  Begin
    ThreadKre := TExportaTintometricosTerceirosKresil.Create(Nil, 'KRE', blnGeracaoAut);
    ThreadKre.Start;
  End;

  procedure pThreadLazzumix;
  Begin
    ThreadLaz := TExportaTintometricosTerceirosLazzumix.Create(Nil, 'LAZ', blnGeracaoAut);
    ThreadLaz.Start;
  End;

  procedure pThreadLechler;
  Begin
    ThreadLec := TExportaTintometricosTerceirosLechler.Create(Nil, 'LEC', blnGeracaoAut);
    ThreadLec.Start;
  End;

  procedure pThreadLeinertex;
  Begin
    ThreadLei := TExportaTintometricosTerceirosLeinertex.Create(Nil, 'LEI', blnGeracaoAut);
    ThreadLei.Start;
  End;

  procedure pThreadLiko;
  Begin
    ThreadLik := TExportaTintometricosTerceirosLiko.Create(Nil, 'LIK', blnGeracaoAut);
    ThreadLik.Start;
  End;

  procedure pThreadLukscolor;
  Begin
    ThreadLks := TExportaTintometricosTerceirosLukscolor.Create(Nil, 'LKS', blnGeracaoAut);
    ThreadLks.Start;
  End;

  procedure pThreadLukscolor2;
  Begin
    ThreadLkc := TExportaTintometricosTerceirosLukscolor2.Create(Nil, 'LKC', blnGeracaoAut);
    ThreadLkc.Start;
  End;

  procedure pThreadLuztol;
  Begin
    ThreadLuz := TExportaTintometricosTerceirosLuztol.Create(Nil, 'LUZ', blnGeracaoAut);
    ThreadLuz.Start;
  End;

  procedure pThreadMaestria;
  Begin
    ThreadMae := TExportaTintometricosTerceirosMaestria.Create(Nil, 'MAE', blnGeracaoAut);
    ThreadMae.Start;
  End;

  procedure pThreadMaxVinil;
  Begin
    ThreadMax := TExportaTintometricosTerceirosMaxVinil.Create(Nil, 'MAX', blnGeracaoAut);
    ThreadMax.Start;
  End;

  procedure pThreadMazaAutomotiva;
  Begin
    ThreadMza := TExportaTintometricosTerceirosMazaAutomotiva.Create(Nil, 'MZA', blnGeracaoAut);
    ThreadMza.Start;
  End;

  procedure pThreadMazaImobiliaria;
  Begin
    ThreadMzi := TExportaTintometricosTerceirosMazaImobiliaria.Create(Nil, 'MZI', blnGeracaoAut);
    ThreadMzi.Start;
  End;

  procedure pThreadMazaIndustrial;
  Begin
    ThreadMzd := TExportaTintometricosTerceirosMazaIndustrial.Create(Nil, 'MZD', blnGeracaoAut);
    ThreadMzd.Start;
  End;

  procedure pThreadMegaTintas;
  Begin
    ThreadMeg := TExportaTintometricosTerceirosMegaTintas.Create(Nil, 'MEG', blnGeracaoAut);
    ThreadMeg.Start;
  End;

  procedure pThreadMiniFabrica;
  Begin
    ThreadMif := TExportaTintometricosTerceirosMiniFabrica.Create(Nil, 'MIF', blnGeracaoAut);
    ThreadMif.Start;
  End;

  procedure pThreadMontana;
  Begin
    ThreadMon := TExportaTintometricosTerceirosMontana.Create(Nil, 'MON', blnGeracaoAut);
    ThreadMon.Start;
  End;

  procedure pThreadNexa;
  Begin
    ThreadNex := TExportaTintometricosTerceirosNexa.Create(Nil, 'NEX', blnGeracaoAut);
    ThreadNex.Start;
  End;

  procedure pThreadPpg;
  begin
    ThreadPpg := TExportaTintometricosTerceirosPpg.Create(Nil, 'PPG', blnGeracaoAut);
    ThreadPpg.Start;
  end;

  procedure pThreadPpgNexa;
  Begin
    ThreadPpx := TExportaTintometricosTerceirosPpgNexa.Create(Nil, 'PPX', blnGeracaoAut);
    ThreadPpx.Start;
  End;

  procedure pThreadQualyVinil;
  Begin
    ThreadQua := TExportaTintometricosTerceirosQualyVinil.Create(Nil, 'QUA', blnGeracaoAut);
    ThreadQua.Start;
  End;

  procedure pThreadRecoa;
  Begin
    ThreadRec := TExportaTintometricosTerceirosRecoa.Create(Nil, 'REC', blnGeracaoAut);
    ThreadRec.Start;
  End;

  procedure pThreadRennerImobiliaria;
  begin
    ThreadRei := TExportaTintometricosTerceirosRennerImobiliaria.Create(Nil, 'REI', blnGeracaoAut);
    ThreadRei.Start;
  end;

  procedure pThreadRennerIndustrial;
  Begin
    ThreadRen := TExportaTintometricosTerceirosRennerIndustrial.Create(Nil, 'REN', blnGeracaoAut);
    ThreadRen.Start;
  End;

  procedure pThreadRennerPerformance;
  Begin
    ThreadRep := TExportaTintometricosTerceirosRennerPerformance.Create(Nil, 'REP', blnGeracaoAut);
    ThreadRep.Start;
  End;

  procedure pThreadResicolor;
  Begin
    ThreadRsi := TExportaTintometricosTerceirosResicolor.Create(Nil, 'RSI', blnGeracaoAut);
    ThreadRsi.Start;
  End;

  procedure pThreadRoberlo;
  Begin
    ThreadRob := TExportaTintometricosTerceirosRoberlo.Create(Nil, 'ROB', blnGeracaoAut);
    ThreadRob.Start;
  End;

  procedure pThreadSayerlack;
  begin
    ThreadSay := TExportaTintometricosTerceirosSayerlack.Create(Nil, 'SAY', blnGeracaoAut);
    ThreadSay.Start;
  end;

  procedure pThreadSinteplast;
  begin
    ThreadSin := TExportaTintometricosTerceirosSinteplast.Create(Nil, 'SIN', blnGeracaoAut);
    ThreadSin.Start;
  end;

  procedure pThreadSherwinWilliams;
  begin
    ThreadShe := TExportaTintometricosTerceirosSherwinWilliams.Create(Nil, 'SHE', blnGeracaoAut);
    ThreadShe.Start;
  end;

  procedure pThreadSherwinWilliams2;
  begin
    ThreadShw := TExportaTintometricosTerceirosSherwinWilliams2.Create(Nil, 'SHW', blnGeracaoAut);
    ThreadShw.Start;
  end;

  procedure pThreadSkymixAutomotiva;
  Begin
    ThreadSky := TExportaTintometricosTerceirosSkymixAutomotiva.Create(Nil, 'SKY', blnGeracaoAut);
    ThreadSky.Start;
  End;

  procedure pThreadSparlack;
  Begin
    ThreadSpa := TExportaTintometricosTerceirosSparlack.Create(Nil, 'SPA', blnGeracaoAut);
    ThreadSpa.Start;
  End;

  procedure pThreadStandox;
  Begin
    ThreadDox := TExportaTintometricosTerceirosStandox.Create(Nil, 'DOX', blnGeracaoAut);
    ThreadDox.Start;
  End;

  procedure pThreadStarmix;
  Begin
    ThreadSta := TExportaTintometricosTerceirosStarmix.Create(Nil, 'STA', blnGeracaoAut);
    ThreadSta.Start;
  End;

  procedure pThreadStarmixWeb;
  Begin
    ThreadStw := TExportaTintometricosTerceirosStarmixWeb.Create(Nil, 'STW', blnGeracaoAut);
    ThreadStw.Start;
  End;

  procedure pThreadSuvinil;
  begin
    ThreadSuv := TExportaTintometricosTerceirosSuvinil.Create(Nil, 'SUV', blnGeracaoAut);
    ThreadSuv.Start;
  end;

  procedure pThreadTexturaCia;
  Begin
    ThreadTex := TExportaTintometricosTerceirosTexturaCia.Create(Nil, 'TEX', blnGeracaoAut);
    ThreadTex.Start;
  End;

  procedure pThreadTopCoat;
  Begin
    ThreadCoa := TExportaTintometricosTerceirosTopCoat.Create(Nil, 'COA', blnGeracaoAut);
    ThreadCoa.Start;
  End;

  procedure pThreadUniverso;
  Begin
    ThreadUnv := TExportaTintometricosTerceirosUniverso.Create(Nil, 'UNI', blnGeracaoAut);
    ThreadUnv.Start;
  End;

  procedure pThreadVelutex;
  Begin
    ThreadVel := TExportaTintometricosTerceirosVelutex.Create(Nil, 'VEL', blnGeracaoAut);
    ThreadVel.Start;
  End;

  procedure pThreadWeg;
  Begin
    ThreadWeg := TExportaTintometricosTerceirosWeg.Create(Nil, 'WEG', blnGeracaoAut);
    ThreadWeg.Start;
  End;


  procedure pExecutaThreads(strTinta: String);
  begin
    If strTinta = 'ADV' Then
      pThreadAdvance
    Else If  strTinta = 'ADS' Then
      pThreadAdvanceStr
    Else If strTinta = 'ADT' Then
      pThreadAdvanceTintoSystem
    Else If strTinta = 'ALE' Then
      pThreadAlessiImobiliaria
    Else If strTinta = 'ALP' Then
      pThreadAlterPlus
    Else If strTinta = 'AJT' Then
      pThreadAnjoAutomotiva
    Else If strTinta = 'ANJ' Then
      pThreadAnjoImobiliaria
    Else If strTinta = 'AJA' Then
      pThreadAnjoSintetica
    Else If strTinta = 'ALK' Then
      pThreadAutoluks
    Else If strTinta = 'ANN' Then
      pThreadAnnetta
    Else If strTinta = 'BAU' Then
      pThreadBautech
    Else If strTinta = 'BEL' Then
      pThreadBellaCor
    Else If strTinta = 'BLT' Then
      pThreadBellaCorTintavel
    Else If strTinta = 'BZA' Then
      pThreadBrasimixAutomotiva
    Else If strTinta = 'BZI' Then
      pThreadBrasimixImobiliaria
    Else If strTinta = 'BZC' Then
      pThreadBrazilianColor
    Else If strTinta = 'CAL' Then
      pThreadCalamar
    Else If strTinta = 'CHR' Then
      pThreadChreon
    Else If strTinta = 'CIA' Then
      pThreadCiaCollor
    Else If strTinta = 'CLB' Then
      pThreadColorbraz
    Else If strTinta = 'WCP' Then
      pThreadWanColorPro
    Else If strTinta = 'CIM' Then
      pThreadCoralImobiliaria
    Else If strTinta = 'DAC' Then
      pThreadDacar
    Else if strTinta = 'DCA' Then
      pThreadDacasa
    Else If strTinta = 'DUP' Then
      pThreadAxalta
    Else If strTinta = 'DUX' Then
      pThreadDuxone
    Else If strTinta = 'DU2' Then
      pThreadDuxone2
    Else If strTinta = 'EUC' Then
      pThreadEucatex
    Else If strTinta = 'FAL' Then
      pThreadFalcao
    Else If strTinta = 'FAR' Then
      pThreadFarbenAutomotiva
    Else If strTinta = 'FUT' Then
      pThreadFutura
    Else If strTinta = 'GEN' Then
      pThreadGeneral
    Else If strTinta = 'GBC' Then
      pThreadGlobalBc
    Else if strTinta = 'BSN' Then
      pThreadGlobalBsn
    Else If strTinta = 'C11' Then
      pThreadGlobalCc11
    Else If strTinta = 'GLO' Then
      pThreadGlobalColor
    Else if strTinta = 'CSN' Then
      pThreadGlobalCsn
    Else If strTinta = 'GRA' Then
      pThreadGrafftex
    Else If strTinta = 'HYD' Then
      pThreadHydronorthImobiliaria
    Else If strTinta = 'INK' Then
      pThreadInkor
    Else If strTinta = 'INT' Then
      pThreadInternational
    Else If strTinta = 'IQU' Then
      pThreadIquine
    Else If strTinta = 'JOT' Then
      pThreadJotun
    Else If strTinta = 'KIL' Then
      pThreadKilling
    Else If strTinta = 'KIN' Then
      pThreadKillingIndustrial
    Else If strTinta = 'KRE' Then
      pThreadKresil
    Else If strTinta = 'LAZ' Then
      pThreadLazzumix
    Else If strTinta = 'LEC' Then
      pThreadLechler
    Else If strTinta = 'LEI' Then
      pThreadLeinertex
    Else If strTinta = 'LIK' Then
      pThreadLiko
    Else If strTinta = 'LKS' Then
      pThreadLukscolor
    Else If strTinta = 'LKC' Then
      pThreadLukscolor2
    Else If strTinta = 'LUZ' Then
      pThreadLuztol
    Else If strTinta = 'MAE' Then
      pThreadMaestria
    Else If strTinta = 'MAX' Then
      pThreadMaxVinil
    Else If strTinta = 'MZA' Then
      pThreadMazaAutomotiva
    Else If strTinta = 'MZI' Then
      pThreadMazaImobiliaria
    Else If strTinta = 'MZD' Then
      pThreadMazaIndustrial
    Else If strTinta = 'MEG' Then
      pThreadMegaTintas
    Else If strTinta = 'MIF' Then
      pThreadMiniFabrica
    Else If strTinta = 'MON' Then
      pThreadMontana
    Else If strTinta = 'NEX' Then
      pThreadNexa
    Else If strTinta = 'PPG' Then
      pThreadPpg
    Else If strTinta = 'PPX' Then
      pThreadPpgNexa
    Else If strTinta = 'QUA' Then
      pThreadQualyVinil
    Else If strTinta = 'REC' Then
      pThreadRecoa
    Else If strTinta = 'REI' Then
      pThreadRennerImobiliaria
    Else If strTinta = 'REN' Then
      pThreadRennerIndustrial
    Else If strTinta = 'REP' Then
      pThreadRennerPerformance
    Else If strTinta = 'RSI' Then
      pThreadResicolor
    Else If strTinta = 'ROB' Then
      pThreadRoberlo
    Else If strTinta = 'SAY' Then
      pThreadSayerlack
    Else If strTinta = 'SIN' Then
      pThreadSinteplast
    Else If strTinta = 'SHE' Then
      pThreadSherwinWilliams
    Else If strTinta = 'SHW' Then
      pThreadSherwinWilliams2
    Else If strTinta = 'SKY' Then
      pThreadSkymixAutomotiva
    Else If strTinta = 'SPA' Then
      pThreadSparlack
    Else If strTinta = 'DOX' Then
      pThreadStandox
    Else If strTinta = 'STA' Then
      pThreadStarmix
    Else If strTinta = 'STW' Then
      pThreadStarmixWeb
    Else If strTinta = 'SUV' Then
      pThreadSuvinil
    Else If strTinta = 'TEX' Then
      pThreadTexturaCia
    Else If strTinta = 'COA' Then
      pThreadTopCoat
    Else If strTinta = 'UNI' Then
      pThreadUniverso
    Else If strTinta = 'VEL' Then
      pThreadVelutex
    Else If strTinta = 'WEG' Then
      pThreadWeg;
  end;

  procedure pVerificaIdePro;
  var
    strValores: String;
  begin
    SetLength(ArrIdePro, 0);

    strValores := strIdePro;

    Repeat
      If Length(strValores) > 0 Then
      Begin
        SetLength(ArrIdePro, Length(ArrIdePro) + 1);
        ArrIdePro[Length(ArrIdePro) - 1] := Copy(strValores, 1, 3);

        strValores := Copy(strValores, 4, Length(strValores) - 3);
      End;
    Until strValores = '';
  end;

begin
  {$IFDEF LINUX}
  if fEmptyStr(strIdePro) or strIdePro.StartsWith('-') then
    raise Exception.Create(
      sLineBreak + 'Necessário informar a sigla da tinta para exportação. Exemplo:' +
      sLineBreak + ' $ ./ExportacaoTintometricosTerceirosService CIM -e001 > coral.log &' +
      sLineBreak + ' $ ./ExportacaoTintometricosTerceirosService SUV -e001 > suvinil.log &');
  {$ENDIF}

  {$IFDEF LINUX}
  if strIdePro.Length > 3 then
    raise Exception.Create(
      sLineBreak + 'Somente é permitido exportar uma tinta por processo no Linux.' +
      sLineBreak + 'Para realizar mais de uma exportação criar processos distintos. Exemplo:' +
      sLineBreak + ' $ ./ExportacaoTintometricosTerceirosService CIM -e001 > coral.log &' +
      sLineBreak + ' $ ./ExportacaoTintometricosTerceirosService SUV -e001 > suvinil.log &');
  {$ENDIF}

  If (Not fEmptyStr(strIdePro)) And fValidaTabelaTinta Then
  Begin
   {$IFNDEF LINUX}
    VS_objConexaoThread := TConexaoThread.Create;
   {$ENDIF}

    pVerificaIdePro;

    For intCont := 0 To Length(ArrIdePro) - 1 Do
      pExecutaThreads(ArrIdePro[intCont]);
  End;
end;

function TExportarAutomaticoTintometricosTerceiros.fExportacaoAtiva: Boolean;
begin
  Result := False;
  If ThreadSuv <> Nil Then
    Result := ThreadSuv.FStatus = 'I';

  If (Not Result) And (ThreadCim <> Nil) Then
    Result := ThreadCim.FStatus = 'I';

  If (Not Result) And (ThreadFut <> Nil) Then
    Result := ThreadFut.FStatus = 'I';

  If (Not Result) And (ThreadSay <> Nil) Then
    Result := ThreadSay.FStatus = 'I';

  If (Not Result) And (ThreadShe <> Nil) Then
    Result := ThreadShe.FStatus = 'I';

  If (Not Result) And (ThreadRei <> Nil) Then
    Result := ThreadRei.FStatus = 'I';

  If (Not Result) And (ThreadEuc <> Nil) Then
    Result := ThreadEuc.FStatus = 'I';

  If (Not Result) And (ThreadDac <> Nil) Then
    Result := ThreadDac.FStatus = 'I';

  If (Not Result) And (ThreadBau <> Nil) Then
    Result := ThreadBau.FStatus = 'I';

  If (Not Result) And (ThreadPpg <> Nil) Then
    Result := ThreadPpg.FStatus = 'I';

  If (Not Result) And (ThreadBza <> Nil) Then
    Result := ThreadBza.FStatus = 'I';

  If (Not Result) And (ThreadSky <> Nil) Then
    Result := ThreadSky.FStatus = 'I';

  If (Not Result) And (ThreadDup <> Nil) Then
    Result := ThreadDup.FStatus = 'I';

  If (Not Result) And (ThreadFal <> Nil) Then
    Result := ThreadFal.FStatus = 'I';

  If (Not Result) And (ThreadWan <> Nil) Then
    Result := ThreadWan.FStatus = 'I';

  If (Not Result) And (ThreadLaz <> Nil) Then
    Result := ThreadLaz.FStatus = 'I';

  If (Not Result) And (ThreadShw <> Nil) Then
    Result := ThreadShw.FStatus = 'I';

  If (Not Result) And (ThreadAdv <> Nil) Then
    Result := ThreadAdv.FStatus = 'I';

  If (Not Result) And (ThreadAle <> Nil) Then
    Result := ThreadAle.FStatus = 'I';

  If (Not Result) And (ThreadAjt <> Nil) Then
    Result := ThreadAjt.FStatus = 'I';

  If (Not Result) And (ThreadAnj <> Nil) Then
    Result := ThreadAnj.FStatus = 'I';

  If (Not Result) And (ThreadAja <> Nil) Then
    Result := ThreadAja.FStatus = 'I';

  If (Not Result) And (ThreadAnn <> Nil) Then
    Result := ThreadAnn.FStatus = 'I';

  If (Not Result) And (ThreadBel <> Nil) Then
    Result := ThreadBel.FStatus = 'I';

  If (Not Result) And (ThreadBzi <> Nil) Then
    Result := ThreadBzi.FStatus = 'I';

  If (Not Result) And (ThreadBzc <> Nil) Then
    Result := ThreadBzc.FStatus = 'I';

  If (Not Result) And (ThreadCal <> Nil) Then
    Result := ThreadCal.FStatus = 'I';

  If (Not Result) And (ThreadCia <> Nil) Then
    Result := ThreadCia.FStatus = 'I';

  If (Not Result) And (ThreadDux <> Nil) Then
    Result := ThreadDux.FStatus = 'I';

  If (Not Result) And (ThreadFar <> Nil) Then
    Result := ThreadFar.FStatus = 'I';

  If (Not Result) And (ThreadGen <> Nil) Then
    Result := ThreadGen.FStatus = 'I';

  If (Not Result) And (ThreadGlo <> Nil) Then
    Result := ThreadGlo.FStatus = 'I';

  If (Not Result) And (ThreadGra <> Nil) Then
    Result := ThreadGra.FStatus = 'I';

  If (Not Result) And (ThreadHyd <> Nil) Then
    Result := ThreadHyd.FStatus = 'I';

  If (Not Result) And (ThreadInt <> Nil) Then
    Result := ThreadInt.FStatus = 'I';

  If (Not Result) And (ThreadIqu <> Nil) Then
    Result := ThreadIqu.FStatus = 'I';

  If (Not Result) And (ThreadJot <> Nil) Then
    Result := ThreadJot.FStatus = 'I';

  If (Not Result) And (ThreadKil <> Nil) Then
    Result := ThreadKil.FStatus = 'I';

  If (Not Result) And (ThreadKre <> Nil) Then
    Result := ThreadKre.FStatus = 'I';

  If (Not Result) And (ThreadLik <> Nil) Then
    Result := ThreadLik.FStatus = 'I';

  If (Not Result) And (ThreadLks <> Nil) Then
    Result := ThreadLks.FStatus = 'I';

  If (Not Result) And (ThreadLkc <> Nil) Then
    Result := ThreadLkc.FStatus = 'I';

  If (Not Result) And (ThreadMza <> Nil) Then
    Result := ThreadMza.FStatus = 'I';

  If (Not Result) And (ThreadMzi <> Nil) Then
    Result := ThreadMzi.FStatus = 'I';

  If (Not Result) And (ThreadMzd <> Nil) Then
    Result := ThreadMzd.FStatus = 'I';

  If (Not Result) And (ThreadMeg <> Nil) Then
    Result := ThreadMeg.FStatus = 'I';

  If (Not Result) And (ThreadMon <> Nil) Then
    Result := ThreadMon.FStatus = 'I';

  If (Not Result) And (ThreadNex <> Nil) Then
    Result := ThreadNex.FStatus = 'I';

  If (Not Result) And (ThreadPpx <> Nil) Then
    Result := ThreadPpx.FStatus = 'I';

  If (Not Result) And (ThreadQua <> Nil) Then
    Result := ThreadQua.FStatus = 'I';

  If (Not Result) And (ThreadRec <> Nil) Then
    Result := ThreadRec.FStatus = 'I';

  If (Not Result) And (ThreadRen <> Nil) Then
    Result := ThreadRen.FStatus = 'I';

  If (Not Result) And (ThreadDox <> Nil) Then
    Result := ThreadDox.FStatus = 'I';

  If (Not Result) And (ThreadSta <> Nil) Then
    Result := ThreadSta.FStatus = 'I';

  If (Not Result) And (ThreadStw <> Nil) Then
    Result := ThreadStw.FStatus = 'I';

  If (Not Result) And (ThreadUnv <> Nil) Then
    Result := ThreadUnv.FStatus = 'I';

  If (Not Result) And (ThreadVel <> Nil) Then
    Result := ThreadVel.FStatus = 'I';

  If (Not Result) And (ThreadWeg <> Nil) Then
    Result := ThreadWeg.FStatus = 'I';

  If (Not Result) And (ThreadInk <> Nil) Then
    Result := ThreadInk.FStatus = 'I';

  If (Not Result) And (ThreadRsi <> Nil) Then
    Result := ThreadRsi.FStatus = 'I';

  If (Not Result) And (ThreadKin <> Nil) Then
    Result := ThreadKin.FStatus = 'I';

  If (Not Result) And (ThreadAdt <> Nil) Then
    Result := ThreadAdt.FStatus = 'I';

  If (Not Result) And (ThreadMax <> Nil) Then
    Result := ThreadMax.FStatus = 'I';

  If (Not Result) And (ThreadAlp <> Nil) Then
    Result := ThreadAlp.FStatus = 'I';

  If (Not Result) And (ThreadBsn <> Nil) Then
    Result := ThreadBsn.FStatus = 'I';

  If (Not Result) And (ThreadC11 <> Nil) Then
    Result := ThreadC11.FStatus = 'I';

  If (Not Result) And (ThreadCsn <> Nil) Then
    Result := ThreadCsn.FStatus = 'I';

  If (Not Result) And (ThreadGbc <> Nil) Then
    Result := ThreadGbc.FStatus = 'I';

  If (Not Result) And (ThreadClb <> Nil) Then
    Result := ThreadClb.FStatus = 'I';

  If (Not Result) And (ThreadBlt <> Nil) Then
    Result := ThreadBlt.FStatus = 'I';

  If (Not Result) And (ThreadAlk <> Nil) Then
    Result := ThreadAlk.FStatus = 'I';

  If (Not Result) And (ThreadCoa <> Nil) Then
    Result := ThreadCoa.FStatus = 'I';

  If (Not Result) And (ThreadTex <> Nil) Then
    Result := ThreadTex.FStatus = 'I';

  If (Not Result) And (ThreadChr <> Nil) Then
    Result := ThreadChr.FStatus = 'I';

  If (Not Result) And (ThreadAds <> Nil) Then
    Result := ThreadAds.FStatus = 'I';

  If (Not Result) And (ThreadDu2 <> Nil) Then
    Result := ThreadDu2.FStatus = 'I';

  If (Not Result) And (ThreadLei <> Nil) Then
    Result := ThreadLei.FStatus = 'I';

  If (Not Result) And (ThreadMae <> Nil) Then
    Result := ThreadMae.FStatus = 'I';

  If (Not Result) And (ThreadSin <> Nil) Then
    Result := ThreadSin.FStatus = 'I';

  If (Not Result) And (ThreadDca <> Nil) Then
    Result := ThreadDca.FStatus = 'I';

  If (Not Result) And (ThreadLuz <> Nil) Then
    Result := ThreadLuz.FStatus = 'I';

  If (Not Result) And (ThreadLec <> Nil) Then
    Result := ThreadLec.FStatus = 'I';

  If (Not Result) And (ThreadRep <> Nil) Then
    Result := ThreadRep.FStatus = 'I';

  If (Not Result) And (ThreadMif <> Nil) Then
    Result := ThreadMif.FStatus = 'I';

  If (Not Result) And (ThreadSpa <> Nil) Then
    Result := ThreadSpa.FStatus = 'I';

  If (Not Result) And (ThreadRob <> Nil) Then
    Result := ThreadRob.FStatus = 'I';
end;

end.

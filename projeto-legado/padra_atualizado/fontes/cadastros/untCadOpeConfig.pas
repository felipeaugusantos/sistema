unit untCadOpeConfig;

interface

uses
  Windows, Classes, Controls, untPai, StdCtrls, DBCtrls, Mask, AppEvnts, Menus,
  Buttons, ExtCtrls, Uni, DB, DBEditFocus, DirectoryEditFocus, ComCtrls,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, frxClass,
  frxExportCSVTestabilidade, 
  untFrameDirectoryEditFocus;

type
  TfrmCadOpeConfig = class(TfrmPai)
    pnlTopo: TPanel;
    Label1: TLabel;
    dbReplicarPedido: TDBCheckBox;
    dbReplicarHistPedido: TDBCheckBox;
    dbAlterarPlanoVisita: TDBCheckBox;
    dbPoliticaVenda: TDBRadioGroup;
    dbDiasPrazoFaturamento: TDBEditFocus;
    pnlDados: TPanel;
    Label3: TLabel;
    dbTelCon: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    Label2: TLabel;
    dbExcedMargem: TDBCheckBox;
    pnlConex: TPanel;
    pgcConexoes: TPageControl;
    tbsPopSmtp: TTabSheet;
    tbsDialUp: TTabSheet;
    tbsFtp: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    dbUsuarioDial: TDBEditFocus;
    dbSenhaDial: TDBEditFocus;
    dbeServPop: TDBEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    dbeServSmtp: TDBEditFocus;
    Label9: TLabel;
    Label8: TLabel;
    dbeSenPop: TDBEditFocus;
    dbeUsuPop: TDBEditFocus;
    Label10: TLabel;
    Label11: TLabel;
    dbeSenFtp: TDBEditFocus;
    dbeUsuFtp: TDBEditFocus;
    Label12: TLabel;
    dbeEmailDes: TDBEditFocus;
    Label13: TLabel;
    dbeHostFtp: TDBEditFocus;
    fraDirRec: TfraDirectoryEditFocus;
    fraDirEnv: TfraDirectoryEditFocus;
    Label14: TLabel;
    Label15: TLabel;
    dbeCndPag: TDBCheckBox;
    btnConfirma: TBitBtnLocked;
    procedure dbPoliticaVendaChange(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryCadOpeMob: TUniQuery;
    dtsCadOpeMob: TDataSource;
    FstrCodOpe: String;

    procedure pAfterScroll(Dataset: TDataset);
  protected
    procedure pCriarDataSets;
    procedure pLigarDataSet;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    constructor Create(AOwner:TComponent; strCodOpe: String); reintroduce;
    property strCodOpe: String read FstrCodOpe;
  end;


implementation

uses SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}

constructor TfrmCadOpeConfig.Create(AOwner:TComponent; strCodOpe: String); 
begin
  Inherited Create(AOwner);
  FstrCodOpe := strCodOpe;
  pCriarDataSets;
  pLigarDataSet;

  qryCadOpeMob.AfterScroll := pAfterScroll;

  qryCadOpeMob.Open;
  If qryCadOpeMob.IsEmpty Then
  Begin
    qryCadOpeMob.Insert;
    qryCadOpeMob.FieldByName('MOB_MAXFAT').AsInteger := 0;
    qryCadOpeMob.FieldByName('MOB_REPPED').AsInteger := 0;
    qryCadOpeMob.FieldByName('MOB_REPHIS').AsInteger := 0;
    qryCadOpeMob.FieldByName('MOB_ALTPLA').AsInteger := 0;
    qryCadOpeMob.FieldByName('MOB_EXCELI').AsInteger := 0;
    qryCadOpeMob.FieldByName('MOB_POLITI').AsInteger := 3;

    qryCadOpeMob.FieldByName('MOB_DESCRI').AsString := '';
    qryCadOpeMob.FieldByName('MOB_SERPOP').AsString := '';
    qryCadOpeMob.FieldByName('MOB_SERSMT').AsString := '';
    qryCadOpeMob.FieldByName('MOB_USUPOP').AsString := '';
    qryCadOpeMob.FieldByName('MOB_SENPOP').AsString := '';
    qryCadOpeMob.FieldByName('MOB_USUFTP').AsString := '';
    qryCadOpeMob.FieldByName('MOB_SENFTP').AsString := '';
    qryCadOpeMob.FieldByName('MOB_E_MAIL').AsString := '';
    qryCadOpeMob.FieldByName('MOB_HOSFTP').AsString := '';
    qryCadOpeMob.FieldByName('MOB_DIRREC').AsString := '';
    qryCadOpeMob.FieldByName('MOB_DIRENV').AsString := '';
  End
  Else
    qryCadOpeMob.Edit;

end;

procedure TfrmCadOpeConfig.dbPoliticaVendaChange(Sender: TObject);
begin
  inherited;
  dbExcedMargem.Enabled := dbPoliticaVenda.ItemIndex <> 0;
end;

procedure TfrmCadOpeConfig.pCriarDataSets;
begin
  qryCadOpeMob := fCriarQuery('SELECT * FROM CADOPE_MOB WHERE MOB_CODOPE = "' + FstrCodOpe + '"');
  dtsCadOpeMob := fCriaDataSource(qryCadOpeMob);
end;

procedure TfrmCadOpeConfig.pLigarDataSet;
  Var
    intCont: Integer;
begin
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
      TDBEdit(Components[intCont]).DataSource := dtsCadOpeMob;

    If (Components[intCont] is TDBCheckBox) Then
      TDBCheckBox(Components[intCont]).DataSource := dtsCadOpeMob;

    If (Components[intCont] is TDBRadioGroup) Then
      TDBRadioGroup(Components[intCont]).DataSource := dtsCadOpeMob;
  End;

  dbDiasPrazoFaturamento.DataField := 'MOB_MAXFAT';
  dbReplicarPedido.DataField := 'MOB_REPPED';
  dbReplicarHistPedido.DataField := 'MOB_REPHIS';
  dbAlterarPlanoVisita.DataField := 'MOB_ALTPLA';
  dbeCndPag.DataField := 'MOB_LIBCND';
  dbPoliticaVenda.DataField := 'MOB_POLITI';
  dbExcedMargem.DataField := 'MOB_EXCELI';
  dbTelCon.DataField := 'MOB_TELCON';
  dbUsuarioDial.DataField := 'MOB_USUDIL';
  dbSenhaDial.DataField := 'MOB_SENDIL';

  dbeDescricao.DataField := 'MOB_DESCRI';
  dbeServPop.DataField   := 'MOB_SERPOP';
  dbeServSmtp.DataField  := 'MOB_SERSMT';
  dbeUsuPop.DataField    := 'MOB_USUPOP';
  dbeSenPop.DataField    := 'MOB_SENPOP';
  dbeUsuFtp.DataField    := 'MOB_USUFTP';
  dbeSenFtp.DataField    := 'MOB_SENFTP';
  dbeEmailDes.DataField  := 'MOB_E_MAIL';
  dbeHostFtp.DataField   := 'MOB_HOSFTP';
end;

procedure TfrmCadOpeConfig.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  qryCadOpeMob.FieldByName('MOB_DIRREC').AsString := fraDirRec.edtDirectory.text;
  qryCadOpeMob.FieldByName('MOB_DIRENV').AsString := fraDirEnv.edtDirectory.text;
  qryCadOpeMob.FieldByName('MOB_CODOPE').AsString := FstrCodOpe;
  qryCadOpeMob.Post;
  Close;
end;

procedure TfrmCadOpeConfig.btnSairClick(Sender: TObject);
begin
  qryCadOpeMob.Cancel;
  inherited;
end;

procedure TfrmCadOpeConfig.FormDestroy(Sender: TObject);
begin
  FreeAndNil(dtsCadOpeMob);
  FreeAndNil(qryCadOpeMob);
  inherited;
end;

function TfrmCadOpeConfig.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := false;
  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = dbDiasPrazoFaturamento Then
    Begin
      If fEmptyStr(dbDiasPrazoFaturamento.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'A Quantidade de dias prazo faturamento deve ser preenchida!', ['OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmCadOpeConfig.FormShow(Sender: TObject);
begin
  inherited;
  pgcConexoes.ActivePage := tbsPopSmtp;
end;

procedure TfrmCadOpeConfig.pAfterScroll(Dataset: TDataset);
begin
  fraDirRec.edtDirectory.text := Dataset.FieldByName('MOB_DIRREC').AsString;
  fraDirEnv.edtDirectory.text := Dataset.FieldByName('MOB_DIRENV').AsString;
end;

end.

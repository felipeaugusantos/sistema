unit untFatConsultaDocumentoEntrega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Vcl.Mask,
  MaskEditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, MemDS, DBAccess, Uni;

type
  TfrmFatConsultaDocumentoEntrega = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    lblMotorista: TLabel;
    edtCodMot: TEditFocus;
    edtNomMot: TEditFocus;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    lblNumDoc: TLabel;
    edtNumDoc: TEditFocus;
    lblEspDoc: TLabel;
    edtEspDoc: TEditFocus;
    lblDtaDoc: TLabel;
    lblDtaSai: TLabel;
    lblDtaChe: TLabel;
    mskDtaDocIni: TMaskEditFocus;
    Label6: TLabel;
    mskDtaDocFin: TMaskEditFocus;
    mskDtaSaiIni: TMaskEditFocus;
    Label1: TLabel;
    mskDtaSaiFin: TMaskEditFocus;
    mskDtaCheIni: TMaskEditFocus;
    Label2: TLabel;
    mskDtaCheFin: TMaskEditFocus;
    cxgDocumentosDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgDocumentosLevel1: TcxGridLevel;
    cxgDocumentos: TcxGridCitel;
    dtsDocumentos: TDataSource;
    cxgDocumentosDOCUMENTO: TcxGridDBColumn;
    cxgDocumentosCLIENTE: TcxGridDBColumn;
    cxgDocumentosENTREGADOR: TcxGridDBColumn;
    cxgDocumentosDATAHORADOC: TcxGridDBColumn;
    cxgDocumentosSAIDA: TcxGridDBColumn;
    cxgDocumentosCHEGADA: TcxGridDBColumn;
    btnFiltrar: TBitBtnLocked;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure btnFiltrarClick(Sender: TObject);
  private
    { Private declarations }
    FQryDocumentos: TUniQuery;

    procedure pConsulta;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, StrUtils, untTypesSistema, untConsultas;

{$R *.dfm}

procedure TfrmFatConsultaDocumentoEntrega.btnFiltrarClick(Sender: TObject);
begin
  inherited;

  if fVerificaCampos then
    pConsulta;
end;

procedure TfrmFatConsultaDocumentoEntrega.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
var
  arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    fValidaCampos(edtCodCli, True);
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatConsultaDocumentoEntrega.edtCodMotKeyPress(Sender: TObject;
  var Key: Char);
var
  arrMotoristas: TConsultasArray;
begin
  inherited;
  If fPesqMotorista(Self, edtCodMot, edtNomMot, Nil, Key, arrMotoristas) Then
  Begin
    fValidaCampos(edtCodMot, True);
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatConsultaDocumentoEntrega.FormCreate(Sender: TObject);
begin
  inherited;
  FQryDocumentos := fCriaQuery;
  dtsDocumentos.DataSet := FQryDocumentos;
end;

procedure TfrmFatConsultaDocumentoEntrega.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FQryDocumentos);
end;

procedure TfrmFatConsultaDocumentoEntrega.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodMot);
end;

function TfrmFatConsultaDocumentoEntrega.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtCodMot) Then
  Begin
    If (Not fEmptyStr(edtCodMot.Text)) Then
    Begin
      edtCodMot.Text := fStrZero(edtCodMot.Text, edtCodMot.TamCampo);
      edtNomMot.Text := fRetNomeMotorista(edtCodMot.Text);

      If fEmptyStr(edtNomMot.Text) Then
      Begin
        pMensagemOk('Motorista não cadastrado!');
        Result := False;
      End;
    End
    Else
    Begin
      edtNomMot.Clear;
    End;
  End

  Else If (Sender = edtCodCli) Then
  Begin
    If (Not fEmptyStr(edtCodCli.Text)) Then
    Begin
      edtCodCli.Text := fStrZero(edtCodCli.Text, edtCodCli.TamCampo);
      edtNomCli.Text := fRetNomCliente(edtCodCli.Text);

      If fEmptyStr(edtNomCli.Text) Then
      Begin
        pMensagemOk('Cliente não cadastrado!');
        Result := False;
      end;
    End
    Else
    Begin
      edtNomCli.Clear;
    End;
  End

  Else If (Sender = edtNumDoc) Then
  Begin
    If (Not fEmptyStr(edtNumDoc.Text)) Then
    Begin
      edtNumDoc.Text := fStrZero(edtNumDoc.Text, edtNumDoc.TamCampo);
    End;
  End

  Else If (Sender = mskDtaDocIni) Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaDocIni.Text))) Then
      mskDtaDocFin.Enabled := False
    Else
      mskDtaDocFin.Enabled := True;
  End

  Else If (Sender = mskDtaDocFin) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaDocIni.Text))) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaDocFin.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskDtaDocIni.Text, 0) > StrToDateDef(mskDtaDocFin.Text, 0)) Then
      Begin
        fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = mskDtaSaiIni) Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaSaiIni.Text))) Then
      mskDtaSaiFin.Enabled := False
    Else
      mskDtaSaiFin.Enabled := True;
  End

  Else If (Sender = mskDtaSaiFin) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaSaiIni.Text))) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaSaiFin.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskDtaSaiIni.Text, 0) > StrToDateDef(mskDtaSaiFin.Text, 0)) Then
      Begin
        fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = mskDtaCheIni) Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaCheIni.Text))) Then
      mskDtaCheFin.Enabled := False
    Else
      mskDtaCheFin.Enabled := True;
  End

  Else If (Sender = mskDtaCheFin) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaCheIni.Text))) Then
    Begin
      If (fEmptyStr(fTiraCaracEspeciais(mskDtaCheFin.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (StrToDateDef(mskDtaCheIni.Text, 0) > StrToDateDef(mskDtaCheFin.Text, 0)) Then
      Begin
        fMensagem('','A Data Inicial deve ser menor que a Data Final!',['&O K']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatConsultaDocumentoEntrega.pConsulta;
begin
  FQryDocumentos.Close;
  FQryDocumentos.SQL.Clear;
  FQryDocumentos.SQL.Add('SELECT CONCAT(MOVGER.GER_NUMDOC,"-",MOVGER.GER_ESPDOC,"-",MOVGER.GER_CODEMP) AS DOCUMENTO,');
  FQryDocumentos.SQL.Add('       CONCAT(CADCLI.CLI_CODCLI,"-",CADCLI.CLI_NOMCLI) AS CLIENTE,');
  FQryDocumentos.SQL.Add('       CONCAT(CADMOT.MOT_CODMOT,"-",CADMOT.MOT_NOMMOT) AS ENTREGADOR,');
  FQryDocumentos.SQL.Add('       CAST(CONCAT(DATE_FORMAT(MOVGER.GER_DTAENT, "%d/%m/%Y")," - ",DATE_FORMAT(MOVGER.GER_HORENT, "%H:%i:%s")) AS CHAR(21)) AS DATAHORADOC,');
  FQryDocumentos.SQL.Add('       CAST(CONCAT(DATE_FORMAT(COMENG.ENG_DTACAD, "%d/%m/%Y")," - ",DATE_FORMAT(COMENG.ENG_HRACAD, "%H:%i:%s")) AS CHAR(21)) AS SAIDA,');
  FQryDocumentos.SQL.Add('       CAST(CONCAT(DATE_FORMAT(COMEND.END_DTABAI, "%d/%m/%Y")," - ",DATE_FORMAT(COMEND.END_HRABAI, "%H:%i:%s")) AS CHAR(21)) AS CHEGADA');
  FQryDocumentos.SQL.Add('FROM MOVGER ');
  FQryDocumentos.SQL.Add('LEFT JOIN COMEND');
  FQryDocumentos.SQL.Add('ON(MOVGER.GER_NUMDOC = COMEND.END_NUMDOC AND MOVGER.GER_ESPDOC = COMEND.END_ESPDOC AND MOVGER.GER_CODEMP = COMEND.END_EMPDOC AND MOVGER.GER_CODCLI = COMEND.END_CODCLI)');
  FQryDocumentos.SQL.Add('LEFT JOIN COMENG');
  FQryDocumentos.SQL.Add('ON(COMEND.END_SEQENG = COMENG.AUTOINCREM)');
  FQryDocumentos.SQL.Add('LEFT JOIN CADCLI');
  FQryDocumentos.SQL.Add('ON(MOVGER.GER_CODCLI = CADCLI.CLI_CODCLI)');
  FQryDocumentos.SQL.Add('LEFT JOIN CADMOT');
  FQryDocumentos.SQL.Add('ON(COMENG.ENG_CODENT = CADMOT.MOT_CODMOT)');
  FQryDocumentos.SQL.Add('WHERE MOVGER.GER_TIP_FC = "C"');
  FQryDocumentos.SQL.Add('AND MOVGER.GER_ORIDOC = "V"');
  FQryDocumentos.SQL.Add('AND MOVGER.GER_CLAFIS > "5000"');
  FQryDocumentos.SQL.Add('AND MOVGER.GER_ENTFAT = "S"');
  FQryDocumentos.SQL.Add('AND MOVGER.GER_NUMROM IS NULL');
  FQryDocumentos.SQL.Add('AND MOVGER.GER_CODEMP = :CODEMP');

  if (not fEmptyStr(edtCodMot.Text)) then
  begin
    FQryDocumentos.SQL.Add('AND CADMOT.MOT_CODMOT = :CODMOT');
    FQryDocumentos.ParamByName('CODMOT').AsString := edtCodMot.Text;
  end;

  if (not fEmptyStr(edtCodCli.Text)) then
  begin
    FQryDocumentos.SQL.Add('AND CADCLI.CLI_CODCLI = :CODCLI');
    FQryDocumentos.ParamByName('CODCLI').AsString := edtCodCli.Text;
  end;

  if (not fEmptyStr(edtNumDoc.Text)) then
  begin
    FQryDocumentos.SQL.Add('AND MOVGER.GER_NUMDOC = :NUMDOC');
    FQryDocumentos.ParamByName('NUMDOC').AsString := edtNumDoc.Text;
  end;

  if (not fEmptyStr(edtEspDoc.Text)) then
  begin
    FQryDocumentos.SQL.Add('AND MOVGER.GER_ESPDOC =:ESPDOC');
    FQryDocumentos.ParamByName('ESPDOC').AsString := edtEspDoc.Text;
  end;

  if (not fEmptyStr(fTiraCaracEspeciais(mskDtaDocIni.Text))) and (not fEmptyStr(fTiraCaracEspeciaisPonto(mskDtaDocFin.Text))) Then
  Begin
    FQryDocumentos.SQL.Add('AND MOVGER.GER_DTAENT BETWEEN :DTADOCINI AND :DTADOCFIN');
    FQryDocumentos.ParamByName('DTADOCINI').AsDate := StrToDateDef(mskDtaDocIni.Text, 0);
    FQryDocumentos.ParamByName('DTADOCFIN').AsDate := StrToDateDef(mskDtaDocFin.Text, 0);
  End;

  if (not fEmptyStr(fTiraCaracEspeciais(mskDtaSaiIni.Text))) and (not fEmptyStr(fTiraCaracEspeciaisPonto(mskDtaSaiFin.Text))) Then
  Begin
    FQryDocumentos.SQL.Add('AND COMENG.ENG_DTACAD BETWEEN :DTASAIINI AND :DTASAIFIN');
    FQryDocumentos.ParamByName('DTASAIINI').AsDate := StrToDateDef(mskDtaSaiIni.Text, 0);
    FQryDocumentos.ParamByName('DTASAIFIN').AsDate := StrToDateDef(mskDtaSaiFin.Text, 0);
  End;

  if (not fEmptyStr(fTiraCaracEspeciais(mskDtaCheIni.Text))) and (not fEmptyStr(fTiraCaracEspeciaisPonto(mskDtaCheFin.Text))) Then
  Begin
    FQryDocumentos.SQL.Add('AND COMEND.END_DTABAI BETWEEN :DTACHEINI AND :DTACHEFIN');
    FQryDocumentos.ParamByName('DTACHEINI').AsDate := StrToDateDef(mskDtaCheIni.Text, 0);
    FQryDocumentos.ParamByName('DTACHEFIN').AsDate := StrToDateDef(mskDtaCheFin.Text, 0);
  End;

  FQryDocumentos.ParamByName('CODEMP').AsString := VS_strCodEmp;

  FQryDocumentos.Open;
end;

end.

unit untConsultaFatCliente;

interface

uses
  Windows, Messages, SysUtils, Types, Classes, Variants, Graphics, Controls,
  Forms, Dialogs, StdCtrls, untConsultaComp, DB, Uni, ExtCtrls, ComCtrls,
  Buttons, Grids, DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, untFuncoesGenerica,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaFatCliente = class(TfrmConsultaComp)
    pnlDadosCliente: TPanel;
    Label7: TLabel;
    dbeFone01: TDBEditFocus;
    Label8: TLabel;
    dbeFone02: TDBEditFocus;
    dbeCgcCpf: TDBEditFocus;
    Label9: TLabel;
    Label10: TLabel;
    dbeStatus: TDBEditFocus;
    dbeUltCom: TDBEditFocus;
    Label11: TLabel;
    GroupBox1: TGroupBox;
    dbeEndere: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbeBairro: TDBEditFocus;
    Label6: TLabel;
    dbeNumCep: TDBEditFocus;
    Label5: TLabel;
    dbeCidade: TDBEditFocus;
    Label12: TLabel;
    DBEditFocus1: TDBEditFocus;
    GroupBox2: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    dbeBaiCob: TDBEditFocus;
    dbeCepCob: TDBEditFocus;
    dbeCidCob: TDBEditFocus;
    dbeEstCob: TDBEditFocus;
    GroupBox3: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    dbeEndEnt: TDBEditFocus;
    dbeBaiEnt: TDBEditFocus;
    dbeCepEnt: TDBEditFocus;
    dbeCidEnt: TDBEditFocus;
    dbeEstEnt: TDBEditFocus;
    Label23: TLabel;
    dbeContat: TDBEditFocus;
    btnResFin: TBitBtnLocked;
    Label24: TLabel;
    dbeNumCel: TDBEditFocus;
    Label25: TLabel;
    dbeFax: TDBEditFocus;
    Label26: TLabel;
    dbeIES: TDBEditFocus;
    Label27: TLabel;
    Label28: TLabel;
    dbeEmail2: TDBEditFocus;
    dbeEmail1: TDBEditFocus;
    dbeEndCob: TDBEditFocus;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnResFinClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure qryConsultaAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }

    FPais: TPais;

    procedure pDesabilitaColunas;
    procedure pAplicaMascara;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaFatCliente: TfrmConsultaFatCliente;

implementation

uses untConsulta, untResFinanceiro, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaFatCliente.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
  FPais := fSetaPais;
  pAplicaMascara;
end;

procedure TfrmConsultaFatCliente.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaFatCliente.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
  pAplicaMascara;

end;

procedure TfrmConsultaFatCliente.pDesabilitaColunas;
begin
  If qryConsulta.Active Then
  Begin
    pAplicaMascara;

    qryConsulta.FieldByName('CLI_ENDERE').Visible := False;
    qryConsulta.FieldByName('CLI_C_E_P_').Visible := False;
    qryConsulta.FieldByName('CID_NOMCID').Visible := False;
    qryConsulta.FieldByName('CID_ESTADO').Visible := False;
    qryConsulta.FieldByName('CLI_BAIRRO').Visible := False;

    qryConsulta.FieldByName('CLI_ENDCOB').Visible := False;
    qryConsulta.FieldByName('CLI_BAICOB').Visible := False;
    qryConsulta.FieldByName('CID_CIDCOB').Visible := False;
    qryConsulta.FieldByName('CLI_CEPCOB').Visible := False;
    qryConsulta.FieldByName('CID_ESTCOB').Visible := False;

    qryConsulta.FieldByName('CLI_ENDENT').Visible := False;
    qryConsulta.FieldByName('CLI_BAIENT').Visible := False;
    qryConsulta.FieldByName('CID_CIDENT').Visible := False;
    qryConsulta.FieldByName('CLI_CEPENT').Visible := False;
    qryConsulta.FieldByName('CID_ESTENT').Visible := False;

    qryConsulta.FieldByName('CLI_CONTAT').Visible := False;
    qryConsulta.FieldByName('CLI_FONE01').Visible := False;
    qryConsulta.FieldByName('CLI_FONE02').Visible := False;
    qryConsulta.FieldByName('CLI_C_G_C_').Visible := False;
    qryConsulta.FieldByName('CLI_CGCCPF').Visible := False;
    qryConsulta.FieldByName('CLI_I_E_S_').Visible := False;
    qryConsulta.FieldByName('CLI_STATUS').Visible := False;
    qryConsulta.FieldByName('CLI_ULTCOM').Visible := False;
    qryConsulta.FieldByName('CLI_DTMCOM').Visible := False;
    qryConsulta.FieldByName('CLI_EMAIL_').Visible := False;
    qryConsulta.FieldByName('CLI_EMAIL2').Visible := False;

    If qryConsulta.FindField('CLI_CELULA') <> Nil Then
       qryConsulta.FieldByName('CLI_CELULA').Visible := False;

    If qryConsulta.FindField('CLI_F_A_X_') <> Nil Then
       qryConsulta.FieldByName('CLI_F_A_X_').Visible := False;

    If qryConsulta.FindField('CLI_ENDNUM') <> Nil Then
       qryConsulta.FieldByName('CLI_ENDNUM').Visible := False;

  End;
end;

procedure TfrmConsultaFatCliente.qryConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  If qryConsulta.FieldByName('CLI_CGCCPF').AsString = '1' Then
    qryConsulta.FieldByName('CLI_C_G_C_').EditMask := fRetMascaraC_G_C_(FPais, C_G_C_)
  Else
    qryConsulta.FieldByName('CLI_C_G_C_').EditMask := fRetMascaraC_G_C_(FPais, C_P_F_);
end;

procedure TfrmConsultaFatCliente.pAplicaMascara;
begin
  If qryConsulta.Active Then
  Begin
    qryConsulta.FieldByName('CLI_FONE01').EditMask := fRetMascaraFonePais;
    qryConsulta.FieldByName('CLI_FONE02').EditMask := fRetMascaraFonePais;
    qryConsulta.FieldByName('CLI_CELULA').EditMask := fRetMascaraFonePais;
    qryConsulta.FieldByName('CLI_F_A_X_').EditMask := fRetMascaraFonePais;
    qryConsulta.FieldByName('CLI_C_E_P_').EditMask := '99999-999;0;_';
    qryConsulta.FieldByName('CLI_CEPCOB').EditMask := '99999-999;0;_';
    qryConsulta.FieldByName('CLI_CEPENT').EditMask := '99999-999;0;_';
  End;
end;

procedure TfrmConsultaFatCliente.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaFatCliente.btnConfirmaClick(Sender: TObject);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  CADCLI.*, CND_CODCND, CND_CNDPAG ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + strNomTabela;
  strSQL := strSQL + '  LEFT JOIN CLICND ON CLI_CODCLI = CND_CODCLI AND CND_SUGEST = "S" AND ';

  If fCfgSis('USACND', varBoolean) Then
    strSQL := strSQL + '  CLICND.CND_CODCND IS NOT NULL '
  Else
    strSQL := strSQL + '  IFNULL(CLICND.CND_CNDPAG, "") <> "" ';

  strSQL := strSQL + ' WHERE ';
  If(qryConsulta.IsEmpty) Then
  Begin
    strSQL := strSQL + ' FALSE ';
  End
  Else
  Begin
    strSQL := strSQL + ' CADCLI.' + strCampoChave + ' = ' + QuotedStr(qryConsulta.FieldByName('AUTOINCREM').AsString);
  End;

  bkmUltAcesso := qryConsulta.GetBookMark;

  With qryTabConsulta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  pSalvaOrdemGrid;

  blnConfirma := True;
  Close;

end;

procedure TfrmConsultaFatCliente.btnResFinClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaAcessoSistema('RESFIN') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao Resumo Financeiro!', ['&O k']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmResFinanceiro,frmResFinanceiro);

    If Not fEmptyStr(qryConsulta.fieldbyname('Código').asstring) Then
      frmResFinanceiro.strCodCli := qryConsulta.fieldbyname('Código').asstring;

    frmResFinanceiro.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmConsultaFatCliente.btnResFinClick]');
    End;
  End;

  pFreeAndNil(frmResFinanceiro);

end;

procedure TfrmConsultaFatCliente.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F7) Then
  Begin
    btnResFin.Click
  End;

end;

end.

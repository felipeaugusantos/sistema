unit untSelClienteFiltro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Menus, ComCtrls, StdCtrls, Buttons, ExtCtrls,
  QColorLabel, EditFocus, Uni, AppEvnts, Mask, MaskEditFocus, untTypesSistema,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, untFuncoesConsulta;

type
  TfrmSelClienteFiltro = class(TfrmPaiSimples)
    pnlBotoesMostra: TPanel;
    pnlGeral: TPanel;
    Label12: TLabel;
    edtCodCliente: TEditFocus;
    edtDesCliente: TEditFocus;
    gpbCheques: TGroupBox;
    edtFiltro: TEditFocus;
    ColorLabel1: TColorLabel;
    Label1: TLabel;
    Label11: TLabel;
    lblDesDtaFin: TLabel;
    lblDesDtaIni: TLabel;
    chkAjuDta: TCheckBox;
    btnFechar: TBitBtnLocked;
    btnConfirmaAlt: TBitBtnLocked;
    lbl1: TLabel;
    edtCodPor: TEditFocus;
    edtNomPor: TEditFocus;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    chkRedLoj: TCheckBox;
    pnlFiltraEmpresa: TPanel;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharClick(Sender: TObject);

    procedure pCarregaCliente(Var qryCadCli: TUniQuery);
    procedure btnConfirmaAltClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    function fValRedLoj (Const strCodCli: String): Boolean;
    procedure edtCodClienteEnter(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
  private
    { Private declarations }
    protected
      function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  public
    { Public declarations }
    blnSoVencidos: Boolean;
    blnConfirma : Boolean;
    strRedLoj: String;
    blnFiltraEmp: Boolean;
    arrEmp: TConsultasArray;
    arrPortador: TConsultasArray;
  end;


implementation

uses  untFuncoesSimples, untPesqAux, untPai,
      untConsultas;

{$R *.dfm}

procedure TfrmSelClienteFiltro.edtCodClienteEnter(Sender: TObject);
begin
  inherited;
  strRedLoj := '';
end;

procedure TfrmSelClienteFiltro.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}

  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtDesCliente, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
End;

procedure TfrmSelClienteFiltro.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  // seleção multi empresa com controle dos digitos 000 quando mais de uma empresa
  If Not edtCodEmp.ReadOnly Then
    pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfrmSelClienteFiltro.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp,True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmSelClienteFiltro.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtNomPor, arrPortador, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmSelClienteFiltro.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
//  Var
//    arrSel: TConsultasArray;
begin
  inherited;
{  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtNomPor, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPor, True) Then
        SelectNext(edtCodPor, True, True);
    End;
  End;}

  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtNomPor,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) then
  Begin
    If (fValidaCampos(edtCodPor, True)) Then
       Self.SelectNext(edtCodPor, True, True);
  End;

end;

function TfrmSelClienteFiltro.fValRedLoj(Const strCodCli: String): Boolean;
var
  qryRed: TUniQuery;
  strSQL: String;
begin
  Result := False;
  qryRed := fCriaQuery(nil);

  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT ';
    strSQL := strSQL + '    CLI_CODRED ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    CADCLI ';
    strSQL := strSQL + '  WHERE ';
    strSql := strSQL + '    CLI_CODCLI = :CODCLI ';
    strSQL := strSQL + ' AND COALESCE(CLI_CODRED <> "", "") ';

    With qryRed Do
    Begin

      Close;
      Sql.Clear;
      Sql.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
    End;

    If qryRed.RecordCount > 0 Then
    begin
      strRedLoj := qryRed.FieldByName('CLI_CODRED').AsString;
      Result := True;
    end;

  Finally
    FreeAndNil(qryRed);
  End;
end;

procedure TfrmSelClienteFiltro.btnFecharClick(Sender: TObject);
begin
  inherited;

  edtCodCliente.Clear;
  Close;

end;

procedure TfrmSelClienteFiltro.pCarregaCliente(Var qryCadCli: TUniQuery);
Begin

  pPesquisaCadCli(qryCadCli, qryCadCli, edtCodCliente.Text);
  If Not (fEmptyStr(edtCodCliente.Text)) Then
    edtDesCliente.Text := qryCadCli.FieldByName('CLI_NOMCLI').AsString
  Else
    edtDesCliente.Text := '';
End;

function TfrmSelClienteFiltro.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If ((Sender = mskDtaIni) Or (Sender = mskDtaFin)) And (Not blnSoVencidos) Then
    Begin

      If (Sender = mskDtaFin) Then
      Begin
        {*************************************************}
        {* RETIRADA TRAVA POR SOLICITAÇÃO DA CASA JARDIM *}
        {**18/03/2013**********************************JU*}

        {If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
        Begin
          fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
          blnMudarFoco := False;
          pSetFocus(mskDtaIni);
          Result := False;
        End
        Else}
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fValidaDataStr(mskDtaIni.Text)) Then
        Begin
          fMensagem('', 'Data Inicial não é válida!', ['&O k']);
          pSetFocus(mskDtaIni);
          Result := False;
        end
        Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fValidaDataStr(mskDtaFin.Text)) Then
        Begin
          fMensagem('', 'Data Final não é válida!', ['&O k']);
          pSetFocus(mskDtaFin);
          Result := False;
        end        
        Else If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then 
        Begin
          If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
          Begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
            Result := False;
          End;
        End;
      End
      Else If (Sender = mskDtaIni) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text, True, True)) Then
        Begin
          mskDtaFin.Clear;
          mskDtaFin.Enabled := False;
        End
        Else
          mskDtaFin.Enabled := True;
      End;

    End

    Else If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) And (edtCodPor.Text <> '00000') Then
      Begin
        edtNomPor.Text := fRetNomPortador(edtCodPor.Text);
        If fEmptyStr(edtNomPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        if (edtCodPor.Text = '00000') Then
            edtNomPor.Text := '+1'
        else
            edtNomPor.Text := 'TODOS';
      End;
    End

    Else If (Sender = edtCodCliente) Then
    Begin

      edtDesCliente.Clear;

      If fEmptyStr(edtCodCliente.Text) Then
      Begin
        fMensagem('AVISO','É necessário informar o código do cliente.', ['&O K']);
        edtCodCliente.Clear;
        Result := False;
      End
      Else
        edtDesCliente.Text := fRetNomCliente(edtCodCliente.Text);

      If fEmptyStr(edtDesCliente.Text) And (Not fEmptyStr(edtCodCliente.Text))  Then
      Begin
        fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
        edtCodCliente.Clear;
        Result := False;
      End
      Else
      If fValRedLoj(edtCodCliente.Text) Then
        If Not fEmptyStr(strRedLoj) Then
          chkRedLoj.Enabled := True;

    End


    Else If (Sender = edtFiltro) Then
    Begin

      If fEmptyStr(edtFiltro.Text) Then
      Begin
        fMensagem('AVISO','É necessário informar o filtro a ser utilizado.', ['&O K']);
        Result := False;
      End
      Else
      Begin

        If Pos(Trim(edtFiltro.Text), 'ABT') = 0 Then
        Begin
          fMensagem('AVISO','É filtro informado não é válido.', ['&O K']);
          Result := False;
        End
        Else
        Begin
          If edtFiltro.Text = 'A' Then
          Begin
            lblDesDtaIni.Caption := '(VENCIMENTO)';
            lblDesDtaFin.Caption := '(VENCIMENTO)';
          End;
          If edtFiltro.Text = 'B' Then
          Begin
            lblDesDtaIni.Caption := '(RECEBIMENTO)';
            lblDesDtaFin.Caption := '(RECEBIMENTO)';
          End;
          If edtFiltro.Text = 'T' Then
          Begin
            lblDesDtaIni.Caption := '(VENCIMENTO)';
            lblDesDtaFin.Caption := '(VENCIMENTO)';
          End;
        End;

      End;
    End;
  End;

  If fEmptyStr(strRedLoj) Then
    chkRedLoj.Enabled := False;

  If Not Result And (blnMudarFoco) Then
    pSetFocus(Sender)

end;

procedure TfrmSelClienteFiltro.btnConfirmaAltClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    strTipFil := Trim(edtFiltro.Text);
    Close;

  End;

end;

procedure TfrmSelClienteFiltro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;

  If Key = VK_Escape Then
    btnFechar.Click;
end;

procedure TfrmSelClienteFiltro.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodCliente);
end;

procedure TfrmSelClienteFiltro.FormCreate(Sender: TObject);
begin
  inherited;
  blnSoVencidos := False;
  blnConfirma   := False;
  strRedLoj     := '';
end;

procedure TfrmSelClienteFiltro.FormShow(Sender: TObject);
begin
  inherited;
  pnlFiltraEmpresa.Visible := blnFiltraEmp;

  If blnSoVencidos Then
  Begin
    gpbCheques.Enabled := False;
    mskDtaIni.Enabled  := False;
    mskDtaFin.Enabled  := False;
    chkAjuDta.Enabled  := False;
    ClientHeight       := 100;
  End;

  If fValRedLoj(edtCodCliente.Text) Then
    If Not fEmptyStr(strRedLoj) Then
      chkRedLoj.Enabled := True;

  chkRedLoj.Visible := (fCfgSis('TRFTCR', varString) <> '2');
end;

end.


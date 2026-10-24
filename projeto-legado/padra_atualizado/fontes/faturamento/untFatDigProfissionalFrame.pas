unit untFatDigProfissionalFrame;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Windows,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, strUtils,
  ExtCtrls, EditFocus, QColorLabel, untFuncFat, Uni, AppEvnts, Mask,
  MaskEditFocus, BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus,
  cxHint, TypInfo, DBEditFocus, ComboBoxFocus, dxScreenTip, cxClasses,
  dxCustomHint, frxClass, frxExportCSVTestabilidade, untFuncFatTypes, untLiberacao,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  DB, cxEdit, cxGroupBox;

type
  TfraFatDigProfissionalFrame = class(TFrame)
    pnlFundo: TPanel;
    lblNomPro: TLabel;
    edtCodPro: TEditFocus;
    edtDesPro: TEditFocus;
    lblCliDiv: TLabel;
    lblComissao: TLabel;
    edtComissao: TEditFocus;
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProChange(Sender: TObject);
    procedure edtComissaoExit(Sender: TObject);
  private
    { Private declarations }
    qryConDiv: TUniQuery;
    blnEmpDiv: Boolean;
    blnVerStatus: Boolean;
    blnConfirmou: Boolean;
    procedure pCarregaCadDiv;
    function fSenhaLibProf: Boolean;
  public
    { Public declarations }
    objVenda: TFatVenda;
    intLblNomProWidth: Integer;
    intFrameWidth: Integer;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

    procedure OnFormShow;
    procedure OnFormCreate;
    procedure OnFormDestroy;
    procedure OnFormClose(Sender: TObject; var Action: TCloseAction);

    function fConfirmaDados: Boolean;
  end;


implementation

uses Math, untfuncoesSimples, untConsultas, untTypesSistema, untFuncoesGenerica;

{$R *.dfm}

function TfraFatDigProfissionalFrame.fSenhaLibProf: Boolean;
Var
  objLiberacao: TLiberacao;
Begin
  Result := True;
  If fCfgSis('SENPRF', varBoolean) Then
  Begin
    objLiberacao := TLiberacao.Create;
    Try
      objLiberacao.objMsgLibera.pAddTexto('Senha para Liberação da Informação do Profissional no Faturamento');
      objLiberacao.objMsgLibera.pAddSeparador(65);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'  , objVenda.strCodCli + '-' + Copy(objVenda.strCliNom,1,65), 13);
      objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ' , fFormataCpfCgc(objVenda.strCliCgc, fSetaPais), 13);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor' , objVenda.strCodVen + '-' + Copy(objVenda.strNomVen,1,70), 13);
      objLiberacao.objMsgLibera.pAddTextoCaption('Tot.Documento', FormatFloat('#,##0.00', objVenda.fltTotGer) , 13);
      objLiberacao.objMsgLibera.pAddSeparador(65);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cond. Pagto'  , objVenda.strCodCnd + '-' + objVenda.strDesCnd + #13#10 + StringOfChar(' ', 15) +
                                                                  fFormataCondPag(objVenda.strConPag), 13);
      objLiberacao.objMsgLibera.pAddTextoCaption('Forma Pagto', (objVenda.strCodFpg+'-'+objVenda.strDesFpg), 13);
      objLiberacao.objMsgLibera.pAddSeparador(65);
      objLiberacao.objMsgLibera.pAddTextoCaption('Profissional', edtCodPro.Text + '-' + edtDesPro.Text, 13);
      objLiberacao.objMsgLibera.pAddSeparador(65);

      objLiberacao.strDirAce := 'INFPRO';
      objLiberacao.strSenLib := fCfgSis('SNHPRF');
      objLiberacao.strMsgSen := 'Informação do Profissional';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := objVenda.strCodVen;
      objLiberacao.strCodDig := objVenda.strCodDig;

      If (Not objVenda.fFatMensagemLiberacao(objLiberacao)) Then
        Result := False;
    Finally
      FreeAndNil(objLiberacao);
    End;
  End;
End;


procedure TfraFatDigProfissionalFrame.edtCodProChange(Sender: TObject);
begin
  If fEmptyStr(edtCodPro.Text) Then
    edtDesPro.Clear;
end;

procedure TfraFatDigProfissionalFrame.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrDiversos : TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE DIVERSOS *}
  {**************************DP*}
  If (Not edtCodPro.ReadOnly) Then
  Begin
    If fPesqDiversos(GetParentForm(self) as TForm, edtCodPro,
      edtDesPro, Nil, Key, arrDiversos, True, blnVerStatus, blnEmpDiv, objVenda.strCodCli) Then
    Begin
      If fValidaCampos(edtCodPro, True) Then
        SelectNext(edtCodPro, True, True);
    End;
  End;
end;

procedure TfraFatDigProfissionalFrame.edtComissaoExit(Sender: TObject);
begin
  edtComissao.Text := IIF(fEmptyStr(edtComissao.Text), FormatFloat(fMskDigitos(objVenda.VS_intDecUni), 0), FormatFloat(fMskDigitos(objVenda.VS_intDecUni), fStrToFloat(edtComissao.Text)));
end;

function TfraFatDigProfissionalFrame.fConfirmaDados: Boolean;
begin
  Result := False;
  If Not fValidaCampos(edtCodPro) Then
    Exit(False);

  If (Not fEmptyStr(edtCodPro.Text)) Then
  Begin
    If Not fSenhaLibProf Then
      Exit(False);

    objVenda.strCodDiv := edtCodPro.Text;
    Result := True;
  End
  Else If fEmptyStr(edtCodPro.Text) Then
  Begin
    If fDigitacaoProfissionalObrigatoria(objVenda.strOpcDoc, objVenda.strEspDoc) Then
      Exit(False);

    If (fEmptyStr(edtCodPro.Text)) Then
      objVenda.strCodDiv := '';

    Result := True;
  End;

  Result := Result and objVenda.fInsereEnderecoProfissionalComoEndEnt(objVenda.strCodDiv);

  blnConfirmou := Result;
end;

procedure TfraFatDigProfissionalFrame.OnFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Not blnConfirmou Then
    If fDigitacaoProfissionalObrigatoria(objVenda.strOpcDoc, objVenda.strEspDoc) Then
      If fMensagem('AVISO', 'É obrigatório informar '+ fCfgSis('PROFIS') +
        ', deseja cancelar operação?', ['&Não', '&Sim']) = 1 then
      Action := caNone;
end;

procedure TfraFatDigProfissionalFrame.OnFormCreate;
begin
  inherited;
  blnConfirmou      := False;
  blnVerStatus      := True;

  intLblNomProWidth := lblNomPro.Width;
  intFrameWidth     := 557;

  lblNomPro.Caption := fCfgSis('PROFIS') + ':';
  qryConDiv         := fCriarQuery('SELECT * FROM CADDIV WHERE FALSE', Self);
  blnEmpDiv         := fCfgSis('EMPDIV', varBoolean);
end;

procedure TfraFatDigProfissionalFrame.OnFormDestroy;
begin
  inherited;
end;

procedure TfraFatDigProfissionalFrame.pCarregaCadDiv;
begin
  edtDesPro.Text := fRetNomProfissional(edtCodPro.Text,blnVerStatus) + '-' + fRetNomAtividadeProfissional(edtCodPro.Text,blnVerStatus);
  If Trim(edtDesPro.Text) = '-' Then
    edtDesPro.Clear;
end;

function TfraFatDigProfissionalFrame.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  fltBasComissao,
  fltVlrComissao: Double;
  strClienteProfissional: String;
begin
  Result := True;

  If (Sender = edtCodPro) Then
  Begin

    If Not fEmptyStr(edtCodPro.Text) Then
    Begin
      edtCodPro.Text := fStrZero(edtCodPro.Text, edtCodPro.TamCampo);
      pCarregaCadDiv;
      strClienteProfissional := fCampoTabela('DIV_CODCLI', 'CADDIV', ['DIV_CODDIV'], [edtCodPro.Text]);

      If (fCfgSis('TCOPRO') = '2') And (fEmptyStr(strClienteProfissional)) And
         (objVenda.strOpcDoc <> 'BR') Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse ' + fCfgSis('PROFIS') + ' não possui Cód. de Cliente cadastrado!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If fEmptyStr(edtDesPro.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse ' + fCfgSis('PROFIS') + ' não está cadastrado ou está inativo!', ['&O k']);
          Result := False;
        End
        Else If (blnEmpDiv) Then
        Begin
          If (Pos(VS_strCodEmp, fGetEmpAceCadDiv(edtCodPro.Text)) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', Format('O ' + fCfgSis('PROFIS') + ' [%s] não possui vinculos de empresa identificadora com a empresa [%s]!', [edtCodPro.Text, VS_strCodEmp]), ['&OK']);
            Result := False;
          End;
        End
        Else If (Not fCfgSis('PRFCLI', varBoolean)) Then
        Begin
          If (strClienteProfissional.Equals(objVenda.strCodCli)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Não é permitido vincular o profissional do próprio cliente!', ['&O k']);
            Result := False;
          End;
        End;
      End;

      If Result Then
      Begin
        If Pos(fCfgSis('OBDVCL', varString), 'S_O_') > 0 Then
        Begin
          If fClienteTemProfissionaisVinculados(objVenda.strCodCli) Then
          Begin
            If (Not fTemVinculoComCliente(objVenda.strCodCli, edtCodPro.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Esse ' + fCfgSis('PROFIS') + ' não está vinculado ao cliente ' + fRetNomCliente(objVenda.strCodCli) + '!', ['&Ok']);
              Result := False;
            End;
          End;
        End;
      End;

    End
    Else
    Begin
      if fDigitacaoProfissionalObrigatoria(objVenda.strOpcDoc, objVenda.strEspDoc) then
       Begin
         fMensagem('ATENÇÃO!', fCfgSis('PROFIS') + ' deve ser informado!', ['&O k']);
         Result := False;
       End;
    End;

  End
  Else If (Sender = edtComissao) And (edtComissao.Visible) Then
  Begin
    if fEmptyStr(edtCodPro.Text) then
      edtComissao.Text := FormatFloat(fMskDigitos(objVenda.VS_intDecUni), 0);

    if (fEmptyStr(edtComissao.Text)) Or (fStrToFloat(edtComissao.Text, 0) < 0) then
    begin
      fMensagem('ATENÇÃO!', 'Valor da comissão não pode ser vazio ou menor que zero.', ['&Ok']);
      Result := False;
    end;

    objVenda.strCodDiv := edtCodPro.Text;

    if (Result) and (objVenda.fGComPro(fltBasComissao, fltVlrComissao, False, False)) then
    begin
      if (fStrToFloat(edtComissao.Text, 0) > fltVlrComissao) then
      begin
        fMensagem('ATENÇÃO!', 'Não é permitido informar um valor maior que '+FormatFloat(fMskDigitos(objVenda.VS_intDecUni), fltVlrComissao)+', conforme valor configurado para o profissional informado.' +sLineBreak+
                              'Se for o caso, peça para o responsável revisar as configurações de comissão de profissionais e os cadastros envolvidos.', ['&Ok']);
        edtComissao.Text := FormatFloat(fMskDigitos(objVenda.VS_intDecUni), 0);
        Result := False;
      end;
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfraFatDigProfissionalFrame.OnFormShow;
Var
  strSQL: String;
  qryGenDiv: TUniQuery;
begin
  inherited;

  If (fEmptyStr(objVenda.strCodDiv)) and
     (fEmptyStr(objVenda.strNumOrc) or ((not fEmptyStr(objVenda.strCliAnt)) and (not SameText(objVenda.strCodCli, objVenda.strCliAnt)))) Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   DIV_CODDIV ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CLIDIV ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DIV_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   DIV_SUGEST = "S" ';

    qryGenDiv := fCriaQuery;

    Try
      qryGenDiv.Close;
      qryGenDiv.SQL.Clear;
      qryGenDiv.SQL.Add(strSQL);
      qryGenDiv.ParamByName('CODCLI').AsString := objVenda.strCodCli;
      qryGenDiv.Open;

      if Not qryGenDiv.IsEmpty then
        edtCodPro.Text := qryGenDiv.FieldByName('DIV_CODDIV').AsString
      Else
        edtCodPro.Text := EmptyStr;
    Finally
      qryGenDiv.Free;
    End;
  End
  Else
    edtCodPro.Text := objVenda.strCodDiv;

  If SameText(objVenda.strOpcDoc, 'BR') And (Not SameText(objVenda.strCodCli, objVenda.strCliAntPro)) then
    edtCodPro.Text := '';

  If SameText(objVenda.strOpcDoc, 'BR') And fClienteProfissional(objVenda.strCodCli) Then
  Begin
    edtCodPro.Text     := fRetClienteProfissional(objVenda.strCodCli);
    edtCodPro.ReadOnly := True;
  End;

  objVenda.strCliAntPro := objVenda.strCodCli;

  pCarregaCadDiv;
  lblCliDiv.Visible := False;
  edtComissao.Text := FormatFloat(fMskDigitos(objVenda.VS_intDecUni), 0);
  edtComissao.Visible := ((fCfgSis('ALTCOM', varBoolean)) and (Pos(objVenda.strOpcDoc, 'VN_CP_') > 0));
  lblComissao.Visible := edtComissao.Visible;

  If Not fEmptyStr(objVenda.strCodCli) Then
  begin
    If (fCfgSis('OBDVCL') = 'S') Then
    Begin
      If (fDigitacaoProfissionalObrigatoria(objVenda.strOpcDoc, objVenda.strEspDoc)) then
          If (not fClienteTemProfissionaisVinculados(objVenda.strCodCli)) then
            lblCliDiv.Visible := True;
    End;
  end;
end;

end.


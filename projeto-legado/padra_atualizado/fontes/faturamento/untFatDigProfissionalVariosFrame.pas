unit untFatDigProfissionalVariosFrame;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Windows,
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons, strUtils,
  ExtCtrls, EditFocus, QColorLabel, untFuncFat, Uni, AppEvnts, Mask,
  MaskEditFocus, BitBtnLockedIncrem, DBCtrls, DBLookupComboBoxFocus,
  cxHint, TypInfo, DBEditFocus, ComboBoxFocus, dxScreenTip, cxClasses,
  dxCustomHint, frxClass, frxExportCSVTestabilidade, untFuncFatTypes,
  untLiberacao, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, DB, cxEdit, cxGroupBox, Vcl.Grids, Vcl.DBGrids, DBGridCitel,
  Datasnap.DBClient, UniClientDataSet, untCadDiversos;

type
  TfraFatDigProfissionalVariosFrame = class(TFrame)
    pnlFundo: TPanel;
    lblNomPro: TLabel;
    edtCodPro: TEditFocus;
    edtDesPro: TEditFocus;
    btnAdicionaItem: TBitBtnLocked;
    dbgItens: TDBGridCitel;
    lblCliDiv: TLabel;
    dsGrid: TDataSource;
    cdsGrid: TUniClientDataSet;
    cdsGridDIV_CODDIV: TStringField;
    cdsGridDIV_NOMDIV: TStringField;
    cdsGridATI_CODATI: TStringField;
    cdsGridATI_DESATI: TStringField;
    lblComissao: TLabel;
    edtComissao: TEditFocus;
    cdsGridCOM_VRCOMI: TFloatField;
    cdsGridCOM_PRCOMI: TFloatField;
    procedure edtCodProKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionaItemClick(Sender: TObject);
    procedure edtCodProExit(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodProKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtComissaoExit(Sender: TObject);
  private
    qryGenDiv: TUniQuery;
    qryConDiv: TUniQuery;
    qryGen   : TUniQuery;
    blnEmpDiv: Boolean;
    strAutInc: String;
    procedure pCarregaCadDiv;
    function fSenhaLibProfVarios: Boolean;
    function fAlteraCadDiv(const strCodDivLocal: String): String;
    { Private declarations }
  public
    { Public declarations }
    objVenda: TFatVenda;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

    procedure OnFormShow;
    procedure OnFormCreate;
    procedure OnFormDestroy;
    procedure OnFormClose(Sender: TObject; var Action: TCloseAction);

    function fConfirmaDados: Boolean;
  end;


implementation

uses Math, untfuncoesSimples, untConsultas, untTypesSistema, untFuncoesGenerica, untFuncIns, untFuncIns2;

{$R *.dfm}

function TfraFatDigProfissionalVariosFrame.fSenhaLibProfVarios: Boolean;
Var
  objLiberacao : TLiberacao;
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

      Self.cdsGrid.first;
      while not Self.cdsGrid.eof do
      begin
         objLiberacao.objMsgLibera.pAddTextoCaption('Profissional', Self.cdsGridDIV_CODDIV.Text + '-' + Self.cdsGridDIV_NOMDIV.Text, 13);
         Self.cdsGrid.next;
      end;
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

procedure TfraFatDigProfissionalVariosFrame.btnAdicionaItemClick(
  Sender: TObject);
  Var
    strSQL : String;
    fltPrComi: Double;
begin
  inherited;

  If (fEmptyStr(edtCodPro.Text)) Then
  Begin
    pSetFocus(edtCodPro);
    Exit;
  End;

  If Not fValidaCampos(edtCodPro, True) Then
    Exit;

  If Not fValidaCampos(edtComissao, True) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   ATI_CODATI, ';
  strSQL := strSQL + '   ATI_DESATI, ';
  strSQL := strSQL + '   DIV_CODDIV, ';
  strSQL := strSQL + '   DIV_NOMDIV ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADATI, ';
  strSQL := strSQL + '   CADDIV ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   ATI_CODATI = DIV_CODATI AND ';
  strSQL := strSQL + '   DIV_CODDIV = :CODDIV ';

  qryGen.Close;
  qryGen.SQL.Clear;
  qryGen.SQL.Add(strSQL);
  qryGen.ParamByName('CODDIV').AsString := edtCodPro.Text;
  qryGen.Open;

  If (Not qryGen.IsEmpty) Then
  Begin

    if not (fCfgSis('ATIPRO', varBoolean)) then
    begin
      cdsGrid.First;
      While Not cdsGrid.Eof Do
      Begin
        If cdsGrid.FieldByName('ATI_CODATI').AsString = qryGen.FieldByName('ATI_CODATI').AsString Then
        Begin
          fMensagem('ATENÇÃO!', 'Já existe um profissional com atividade igual incluso!', ['&O k']);
          pSetFocus(edtCodPro);
          Exit;
        End;

        cdsGrid.Next;
      End;
    end
    else
    begin
      cdsGrid.First;
      While Not cdsGrid.Eof Do
      Begin
        if cdsGrid.FieldByName('DIV_CODDIV').AsString = qryGen.FieldByName('DIV_CODDIV').AsString then
        begin
          fMensagem('ATENÇÃO!', 'Este profissional já foi incluso!', ['&O k']);
          pSetFocus(edtCodPro);
          Exit;
        end;

        cdsGrid.Next;
      End;
    end;

    fltPrComi := -1;

    If (edtComissao.Visible) And (fStrToFloat(edtComissao.Text, 0) > 0) Then
      fltPrComi := fFormataFloat((fStrToFloat(edtComissao.Text, -1) / objVenda.fltTotGer) * 100, 4);

    cdsGrid.Insert;
    cdsGrid.FieldByName('DIV_CODDIV').AsString := qryGen.fieldbyname('DIV_CODDIV').AsString;
    cdsGrid.FieldByName('DIV_NOMDIV').AsString := qryGen.fieldbyname('DIV_NOMDIV').AsString;
    cdsGrid.FieldByName('ATI_CODATI').AsString := qryGen.fieldbyname('ATI_CODATI').AsString;
    cdsGrid.FieldByName('ATI_DESATI').AsString := qryGen.fieldbyname('ATI_DESATI').AsString;
    cdsGrid.FieldByName('COM_VRCOMI').AsFloat  := IIF(edtComissao.Visible, fStrToFloat(edtComissao.Text, -1), -1);
    cdsGrid.FieldByName('COM_PRCOMI').AsFloat  := fltPrComi;
    cdsGrid.Post;
  End
  Else
  Begin
    fMensagem('', 'Profissional não cadastrado!', ['&Ok']);
  End;

  edtCodPro.Text := EmptyStr;
  edtDesPro.Text := EmptyStr;
  edtComissao.Text := FormatFloat(fMskDigitos(objVenda.VS_intDecUni), 0);
  pSetFocus(edtCodPro);
end;

procedure TfraFatDigProfissionalVariosFrame.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_DELETE) And (dbgItens.Enabled) Then
    If (dbgItens.DataSource.DataSet.Active) And (Not dbgItens.DataSource.DataSet.IsEmpty) Then
      dbgItens.DataSource.DataSet.Delete;
end;

procedure TfraFatDigProfissionalVariosFrame.edtCodProExit(Sender: TObject);
begin
  if fEmptyStr(edtCodPro.Text) Then
  Begin
    edtDesPro.Text := EmptyStr;
  End;
end;

procedure TfraFatDigProfissionalVariosFrame.edtCodProKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  strCodTmp: String;
begin
  if fIsInsert(Key) Then
  Begin
    if fVerificaAcessoSistema('frmCadDiversos') then
    begin
      if fEmptyStr(edtCodPro.Text) or
         fEmptyStr(fCampoTabela('DIV_CODDIV', 'CADDIV', ['DIV_CODDIV'], [fStrZero(edtCodPro.Text, 8)])) then
        strCodTmp := fChamaCadDiv(Key)
      else
      begin
        objVenda.strCodDiv := '';
        strCodTmp := fAlteraCadDiv(fStrZero(edtCodPro.Text, 8));
      end;

      if (not fEmptyStr(strCodTmp)) then
      begin
        edtCodPro.Text := strCodTmp;
        edtDesPro.Text := fRetNomDiversos(edtCodPro.Text);
      end;
    end;
  end;
end;

procedure TfraFatDigProfissionalVariosFrame.edtCodProKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrDiversos : TConsultasArray;
begin
  inherited;
  If fPesqDiversos(GetParentForm(Self) as TForm, edtCodPro, edtDesPro, Nil, Key, arrDiversos, True,
    True, blnEmpDiv, objVenda.strCodCli) Then
  Begin
    If fValidaCampos(edtCodPro, True) Then
      SelectNext(edtCodPro, True, True);
  End;
end;

procedure TfraFatDigProfissionalVariosFrame.edtComissaoExit(Sender: TObject);
begin
  edtComissao.Text := IIF(fEmptyStr(edtComissao.Text), FormatFloat(fMskDigitos(objVenda.VS_intDecUni), 0), FormatFloat(fMskDigitos(objVenda.VS_intDecUni), fStrToFloat(edtComissao.Text)));
end;

function TfraFatDigProfissionalVariosFrame.fAlteraCadDiv(
  const strCodDivLocal: String): String;
var
  frmCadDiversos: TfrmCadDiversos;
begin
  if not fVerificaAcessoSistema('frmCadDiversos') then
    Exit;

  pCriarFormularios(TfrmCadDiversos, frmCadDiversos);
  try
    try
      frmCadDiversos.strCodDiversosIniciarCadastro := strCodDivLocal;
      frmCadDiversos.ShowModal;
      Result := frmCadDiversos.strUltimoCodigo;
    except
      on E: Exception do
        pMensagensErro(E.Message, '');
    end;
  finally
    pFreeAndNil(frmCadDiversos);
  end;
end;

function TfraFatDigProfissionalVariosFrame.fConfirmaDados: Boolean;
begin
  Result := False;
  If Not fValidaCampos(edtCodPro) Then
    Exit(False);

  If (Self.cdsGrid.RecordCount > 0) Then
    If Not fSenhaLibProfVarios Then
      Exit;

  If Assigned(objVenda.cdsProfiss) Then
    FreeAndNil(objVenda.cdsProfiss);

  objVenda.cdsProfiss := TUniClientDataSet.Create(objVenda);

  {***********************************************************}
  {* PASSA OS DADOS (CLONA) DE UM CLIENTDATASET PARA O OUTRO *}
  {********************************************************LU*}
  pCloneDataSet(objVenda.cdsProfiss, Self.cdsGrid);

  If Assigned(objVenda.cdsProfiss) And (objVenda.cdsProfiss.Active) Then
    If (objVenda.cdsProfiss.IsEmpty) Then
      objVenda.strCodDiv := '';

  Result := objVenda.fInsereEnderecoProfissionalComoEndEnt('', objVenda.cdsProfiss);
end;

procedure TfraFatDigProfissionalVariosFrame.OnFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(qryGen);
  FreeAndNil(qryGenDiv);
  FreeAndNil(qryConDiv);
end;

procedure TfraFatDigProfissionalVariosFrame.OnFormCreate;
begin
  inherited;
  qryConDiv := fCriarQuery('SELECT * FROM CADDIV WHERE FALSE', Self);
  blnEmpDiv := (fCfgSis('EMPDIV', varBoolean));
end;

procedure TfraFatDigProfissionalVariosFrame.OnFormDestroy;
begin
  inherited;
end;

procedure TfraFatDigProfissionalVariosFrame.pCarregaCadDiv;
begin
  edtDesPro.Text := fRetNomProfissional(edtCodPro.Text,True) + '-' + fRetNomAtividadeProfissional(edtCodPro.Text,True);
  If Trim(edtDesPro.Text) = '-' Then
    edtDesPro.Clear;
end;

function TfraFatDigProfissionalVariosFrame.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
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

      If (fCfgSis('TCOPRO') = '2') And (fEmptyStr(strClienteProfissional)) And (objVenda.strOpcDoc <> 'BR') Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse profissional não possui Cód. de Cliente cadastrado!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If fEmptyStr(edtDesPro.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse profissional não está cadastrado ou está inativo!', ['&O k']);
          Result := False;
        End
        Else If (blnEmpDiv) Then
        Begin
          If (Pos(VS_strCodEmp, fGetEmpAceCadDiv(edtCodPro.Text)) <= 0) Then
          Begin
            fMensagem('ATENÇÃO!', Format('O profissional [%s] não possui vinculos de empresa identificadora com a empresa [%s]!', [edtCodPro.Text, VS_strCodEmp]), ['&OK']);
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
        If (Pos(fCfgSis('OBDVCL', varString), 'S_O_') > 0) Then
        Begin
          If fClienteTemProfissionaisVinculados(objVenda.strCodCli) Then
          Begin
            If (Not fTemVinculoComCliente(objVenda.strCodCli, edtCodPro.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Esse profissional não está vinculado ao cliente ' + fRetNomCliente(objVenda.strCodCli) + '!', ['&Ok']);
              Result := False;
            End;
          End;
        End;
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

    if (Result) and (objVenda.fGComPro(fltBasComissao, fltVlrComissao, False, False, 0, True)) then
    begin
      if (fStrToFloat(edtComissao.Text, 0) > fltVlrComissao) then
      begin
        fMensagem('ATENÇÃO!', 'Não é permitido informar um valor maior que '+FormatFloat(fMskDigitos(objVenda.VS_intDecUni), fltVlrComissao)+', conforme valor configurado para o profissional informado.' +sLineBreak+
                              'Se for o caso, peça para o responsável revisar as configurações de comissão de profissionais e os cadastros envolvidos.', ['&Ok']);
        edtComissao.Text := FormatFloat(fMskDigitos(objVenda.VS_intDecUni), 0);
        Result := False;
      end;
    end;
  End
  Else If (Sender = dbgItens) Then
  Begin
    If (cdsGrid.IsEmpty) and fDigitacaoProfissionalObrigatoria(objVenda.strOpcDoc, objVenda.strEspDoc) Then
    Begin
      fMensagem('ATENÇÃO!', 'Ao menos um profissional deve ser informado!', ['&O k']);
      Sender := edtCodPro;
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfraFatDigProfissionalVariosFrame.OnFormShow;
Var
  strSQL : String;
  blnProfDig : Boolean;
begin
  inherited;
  blnProfDig := True;

  if Assigned(objVenda) then
  Begin
    If ((fCfgSis('OBDVCL') = 'S') or (fCfgSis('LMPRVE') = 'S')) And
       (Not fEmptyStr(objVenda.strCliAnt)) And
       (objVenda.strCliAnt <> objVenda.strCodCli) Then
    Begin
      blnProfDig := False;
    End;
  End;

  qryGen    := fCriaQuery(Self);
  qryGenDiv := fCriaQuery(Self);
  {********************************************************************************}
  {* LOCALIZADO O AUTOINCREM DO PEDIDO/ORCAMENTO                                  *}
  {* VAI SER UTILIZADO QD FOR CARREGAR OS PROFISSIONAIS GRAVADOS, COMO NO SALVAR  *}
  {*****************************************************************************LU*}
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   FDO_SEQGER ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   FATDOR ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   FDO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   FDO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   FDO_CODEMP = :CODEMP ';

  qryGenDiv.Close;
  qryGenDiv.SQL.Clear;
  qryGenDiv.SQL.Add(strSQL);
  qryGenDiv.ParamByName('NUMDOC').AsString := objVenda.strNumOrc;
  qryGenDiv.ParamByName('ESPDOC').AsString := objVenda.strEspOrc;
  qryGenDiv.ParamByName('CODEMP').AsString := objVenda.strEmpOri;
  qryGenDiv.Open;

  If fEmptyStr(objVenda.strAutIncDiv) Then
  Begin
    Self.strAutInc := qryGenDiv.fieldbyname('FDO_SEQGER').AsString;
    objVenda.strSeqAntFgo := qryGenDiv.fieldbyname('FDO_SEQGER').AsString;
  End
  Else
    Self.strAutInc := objVenda.strAutIncDiv;

  If (fEmptyStr(objVenda.strNumOrc)) or (not blnProfDig)Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   DIV_CODDIV ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CLIDIV ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   DIV_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   DIV_SUGEST = "S" ';
    qryGenDiv.Close;
    qryGenDiv.SQL.Clear;
    qryGenDiv.SQL.Add(strSQL);
    qryGenDiv.ParamByName('CODCLI').AsString := objVenda.strCodCli;
    qryGenDiv.Open;

    if Not qryGenDiv.IsEmpty then
      Self.edtCodPro.Text := qryGenDiv.FieldByName('DIV_CODDIV').AsString
    Else
      Self.edtCodPro.Text := EmptyStr;
  End;

  If SameText(objVenda.strOpcDoc, 'BR') And (Not SameText(objVenda.strCodCli, objVenda.strCliAntPro)) then
    Self.edtCodPro.Text := '';

  If SameText(objVenda.strOpcDoc, 'BR') And fClienteProfissional(objVenda.strCodCli) Then
    Self.edtCodPro.Text := fRetClienteProfissional(objVenda.strCodCli);

  objVenda.strCliAntPro := objVenda.strCodCli;

  qryGen := fCriaQuery(Self);
  cdsGrid.Close;
  cdsGrid.CreateDataSet;
  cdsGrid.Open;

  If Not fEmptyStr(strAutInc) And blnProfDig Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   F.DIV_CODDIV, ';
    strSQL := strSQL + '   D.DIV_NOMDIV, ';
    strSQL := strSQL + '   D.DIV_CODATI, ';
    strSQL := strSQL + '   A.ATI_DESATI ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   DIVFAT F, ';
    strSQL := strSQL + '   CADDIV D, ';
    strSQL := strSQL + '   CADATI A  ';
    strSQL := strSQL + ' WHERE  ';
    strSQL := strSQL + '   F.DIV_CODDIV = D.DIV_CODDIV AND ';
    strSQL := strSQL + '   D.DIV_CODATI = A.ATI_CODATI AND  ';
    strSQL := strSQL + '   F.DIV_SEQGER = :AUTINC ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('AUTINC').AsString := strAutInc;
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin
      cdsGrid.Insert;
      cdsGrid.FieldByName('DIV_CODDIV').AsString := qryGen.fieldbyname('DIV_CODDIV').AsString;
      cdsGrid.FieldByName('DIV_NOMDIV').AsString := qryGen.fieldbyname('DIV_NOMDIV').AsString;
      cdsGrid.FieldByName('ATI_CODATI').AsString := qryGen.fieldbyname('DIV_CODATI').AsString;
      cdsGrid.FieldByName('ATI_DESATI').AsString := qryGen.fieldbyname('ATI_DESATI').AsString;
      cdsGrid.Post;
      qryGen.Next;
    End;

  End;

  edtComissao.Text := FormatFloat(fMskDigitos(objVenda.VS_intDecUni), 0);
  edtComissao.Visible := ((fCfgSis('ALTCOM', varBoolean)) and (Pos(objVenda.strOpcDoc, 'VN_CP_') > 0));
  lblComissao.Visible := edtComissao.Visible;
  fFindColumnByName(dbgItens, 'COM_VRCOMI').Visible := edtComissao.Visible;
  cdsGridCOM_VRCOMI.DisplayFormat := fMskDigitos(objVenda.VS_intDecUni);

  lblCliDiv.Visible := False;
  if not fEmptyStr(objVenda.strCodCli) then
  begin
    if (fCfgSis('OBDVCL') = 'S') then
    begin
      if fDigitacaoProfissionalObrigatoria(objVenda.strOpcDoc, objVenda.strEspDoc) then
        if (not fClienteTemProfissionaisVinculados(objVenda.strCodCli)) then
          lblCliDiv.Visible := True;
    end;
  end;

  If Not fEmptyStr(edtCodPro.Text) Then
  Begin
    pCarregaCadDiv;

    If SameText(objVenda.strOpcDoc, 'BR') Then
    Begin
      btnAdicionaItem.Click;
      edtCodPro.ReadOnly := True;
      dbgItens.Enabled   := False;
    End;
  End;
end;

end.


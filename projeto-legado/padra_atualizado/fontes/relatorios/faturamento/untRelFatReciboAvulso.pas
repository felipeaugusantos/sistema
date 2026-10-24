unit untRelFatReciboAvulso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, DBAccess,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus,
  QColorLabel, ExtCtrls, Buttons, Mask, MaskEditFocus, Uni, DB, untMskTelefone,
  StrUtils, BitBtnLockedIncrem, MemoFocus, frxExportCSVTestabilidade, MemDS,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, UniClientDataSet, frxDMPClass,
  untRecAvulso,untFastPrintEditor, MaskUtils, untMskC_G_C_,untPesqAux,
  untFuncoesConsulta,untConsultas,untTypesSistema;

type
  TfrmRelFatReciboAvulso = class(TfrmPaiRelatorio)
    Label9: TLabel;
    edtValRec: TEditFocus;
    edtNomRec: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtAssRec: TEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    edtQtdVia: TEditFocus;
	frxReportJ: TfrxReport;					   
    frxUser: TfrxUserDataSet;
    frxReportM: TfrxReport;
    mmfHisRec: TMemoFocus;
    lblLinhas: TLabel;
    mskDtaRec: TcxDateEdit; 
    lblCNPJ_CPF: TLabel;
    edtOpcCnpjCpf: TEditFocus;
    edtCnpjCpf: TMaskEditFocus;
    edtEndereco: TEditFocus;
    Label6: TLabel;
    edtNroEndereco: TEditFocus;
    Label7: TLabel;
    edtCidade: TEditFocus;
    Label8: TLabel;
    pnlCliente: TPanel;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    procedure frxUserGetValue(const VarName: String; var Value: Variant);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure frxUserFirst(Sender: TObject);
    procedure frxUserCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure frxUserPrior(Sender: TObject);
    procedure frxUserNext(Sender: TObject);
    procedure mmfHisRecExit(Sender: TObject);
    procedure mmfHisRecKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure edtOpcCnpjCpfExit(Sender: TObject);
    procedure edtCnpjCpfExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCliChange(Sender: TObject);
    procedure edtNomRecChange(Sender: TObject);
  private
    { Private declarations }
    qryConCli: TUniQuery;
    intQtdVia: Integer;
    blnCpfCnpjObrig : Boolean;
    arrClientes: TConsultasArray;
    procedure pGetDadosEmp(var qryEmp: TUniQuery);
    function fImprimeRelatorioLayout: Boolean;
    function fLimpaMaskCgcCpf(edtCnpjCpf: TMaskEditFocus) : String;
    procedure pCarregaCliente;
    procedure pPreparaForm;
    procedure HabilitaCampos;
    procedure pCarregaDadosCli(strCodCli : String);
    procedure pLimpaDadosCli;
    function VerificaHabCampos: Boolean;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    function fLoadReport(strTpImp: String): Boolean;
  end;

Const
  MAXLIN = 7;
  MAXCHR = (MAXLIN * 80);

var
  frmRelFatReciboAvulso: TfrmRelFatReciboAvulso;
  intMaxLin : Integer;
  intMaxChr : Integer;
  strCodEmp : String;
  frxRel     : TfrxReport;

implementation

uses untFuncoesSimples, untFuncoes, untFuncoesRelatorios,untValorPorExtenso, untIFuncoes,
     untQckRelFatReciboAvulso, untFuncoesGenerica;

{$R *.dfm}

{**************************************}
{* Carrega os dados da empresa logada *}
{*** Preenche o Cabeçalho do Recibo ***}
{* RQ 26114 ************************BB*}
procedure TfrmRelFatReciboAvulso.pCarregaCliente;
begin
  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
    pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text);
  End
  Else
    edtNomCli.Clear;
end;

procedure TfrmRelFatReciboAvulso.pGetDadosEmp(var qryEmp:TUniQuery);
  var
    strSQL : String;
begin
  Try
    strSQL:= ' SELECT SQL_NO_CACHE ' +
      ' EMP_NOMEMP AS NOME, ' +
      ' COALESCE( ' +
      '   CONCAT('+ QuotedStr('(') + ', SUBSTR(EMP_FONE01,1,2),' + QuotedStr(')') + ',' +
      '   SUBSTR(EMP_FONE01, 3, IF((CHAR_LENGTH(EMP_FONE01) = 10), 4, 5)), ' + QuotedStr('-') + ',' +
			'   SUBSTR(EMP_FONE01,IF((CHAR_LENGTH(EMP_FONE01) = 10), 6, 8),4) ' +
      '   ), ' + QuotedStr('0000000000')+ ') AS TELEFONE, ' +
      ' CONCAT(EMP_ENDERE, ' + QuotedStr(',') + ', EMP_ENDNUM) AS ENDERECO,' +
      ' EMP_BAIRRO AS BAIRRO, ' +
      ' EMP_C_E_P_ AS CEP, ' +
      ' EMP_C_G_C_ AS NUMCNPJ, ' +
      ' CID_NOMCID AS CIDADE ' +
      ' FROM ' +
      ' CADEMP ' +
      ' JOIN CADCID ' +
      ' ON CID_CODCID = EMP_CODCID ' +
      ' WHERE EMP_CODEMP = ' + QuotedStr(VS_strCodEmp) ;

    qryEmp := fCriarQuery(strSQL);
    qryEmp.Close;
    qryEmp.Open;

  Except
   On E: Exception do
   Begin
    pMensagensErro(E.Message, '[frmRelFatReciboAvulso.pGetDadosEmp]');
    End;
  End;
end;

procedure TfrmRelFatReciboAvulso.pPreparaForm;
  Var
    blnUsaLayoutPersonalizado : Boolean;
begin
  blnUsaLayoutPersonalizado := Not fEmptyStr( VarToStrDef(fCampoTabela('LAY_RELFR3', 'LAYIMP',
                                                                      ['LAY_CODEMP', 'LAY_CODLAY'],
                                                                      [VS_strCodEmp, 'RECAVU']), ''));

  If Not blnUsaLayoutPersonalizado Then
  Begin
    pnlcliente.Visible := False;
    Self.Height := Self.Height - (pnlcliente.Height + 2);

    //edtCodCli.Visible  := False;
    //edtNomCli.Visible  := False;
    //lblCliente.Visible := False;
    //Self.Height := 390;
  End;
end;


function TfrmRelFatReciboAvulso.fLimpaMaskCgcCpf(edtCnpjCpf: TMaskEditFocus) : String;
var
  strMask,strCnpjCpf : String;
begin
  strMask             := edtCnpjCpf.EditMask;
  edtCnpjCpf.EditMask := '';
  strCnpjCpf          := edtCnpjCpf.Text;
  edtCnpjCpf.EditMask := strMask;

  result              := strCnpjCpf;
end;

procedure TfrmRelFatReciboAvulso.frxUserGetValue(const VarName: String;
  var Value: Variant);
var
  qryGetEmp: TUniQuery;
begin
  inherited;

  pGetDadosEmp(qryGetEmp); //Carrega Dados da Empresa Logada No Sistema

  If SameText('DTAREC', VarName) Then
  begin
    if strTipImp = 'M' then
      Value := fTiraCaracEspeciais(fRetDataExtenso(StrToDate(mskDtaRec.Text), True))
    Else
      Value := fRetDataExtenso(StrToDate(mskDtaRec.Text), True);
  end
  Else
  If SameText('VALREC', VarName) Then
  begin
    Value := fStrToFloat(edtValRec.Text);
  end
  Else
  If SameText('CLIEND', VarName) Then
  begin
    Value := IIF( fEmptyStr(edtEndereco.Text), '', edtEndereco.Text + ', ');
  end
  Else
  If SameText('CLICID', VarName) Then
  begin
    Value := IIF( fEmptyStr(edtCIDADE.Text), '', edtCIDADE.Text + ', ');
  end
  Else
  If SameText('CLINRO', VarName) Then
  begin
    Value := IIF( fEmptyStr(edtNroEndereco.Text), '', edtNroEndereco.Text + ', ');
  end
  Else
  If SameText('NOMREC', VarName) Then
  begin
    if strTipImp = 'M' Then
      Value := fTiraCaracEspeciais(edtNomRec.Text)
    Else
      Value := edtNomRec.Text;
  end
  Else
  If SameText('NOMASS', VarName) Then
  begin
    if strTipImp = 'M' Then
      Value := fTiraCaracEspeciais(edtAssRec.Text)
    Else
      Value := edtAssRec.Text;
  end
  Else
  If SameText('HISREC', VarName) Then
  begin
    if strTipImp = 'M' Then
      Value := fTiraCaracEspeciais(mmfHisRec.Lines.Text)
    Else
      Value := mmfHisRec.Lines.Text;
  end
  Else
  If SameText('NROVIA', VarName) Then
  begin
    Value := intQtdVia;
  end
  Else
  If SameText('VLREXT', VarName) Then
  begin
    Value := UpperCase(fRetExtensoNumero(edtValRec.Text));
  end
  Else
  If SameText('CGCCPF', VarName) Then
  begin
    if edtOpcCnpjCpf.Text = '1' then
      Value := ' portador(a) do CNPJ nº.: '+edtCnpjCpf.Text
    else
    if edtOpcCnpjCpf.Text = '2' then
      Value := ' portador(a) do CPF nº.: '+edtCnpjCpf.Text
    else
      Value := '';
  end
  Else
  If SameText('NOMEMP', VarName) Then
  begin
    if strTipImp = 'M' Then
      Value := fTiraCaracEspeciais(qryGetEmp.FieldByName('NOME').AsString)
    Else
      Value := UpperCase(qryGetEmp.FieldByName('NOME').AsString);
  end
  Else
  If SameText('NUMTEL', VarName) Then
  begin
    Value := UpperCase(qryGetEmp.FieldByName('TELEFONE').AsString);
  end
  Else
  If SameText('NOMCID', VarName) Then
  begin
    if strTipImp = 'M' Then
      Value := fTiraCaracEspeciais(UpperCase(qryGetEmp.FieldByName('CIDADE').AsString))
    Else
      Value := UpperCase(qryGetEmp.FieldByName('CIDADE').AsString);
  end
  Else
  If SameText('NOMEND', VarName) Then
  begin
    if strTipImp = 'M' Then
      Value := fTiraCaracEspeciais(UpperCase(qryGetEmp.FieldByName('ENDERECO').AsString))
    Else
      Value := UpperCase(qryGetEmp.FieldByName('ENDERECO').AsString);
  end
  Else
  If SameText('NOMBAI', VarName) Then
  begin
    if strTipImp = 'M' Then
      Value := fTiraCaracEspeciais(UpperCase(qryGetEmp.FieldByName('BAIRRO').AsString))
    Else
      Value := UpperCase(qryGetEmp.FieldByName('BAIRRO').AsString);
  end
  Else
  If SameText('NUMCEP', VarName) Then
  begin
    Value := UpperCase(qryGetEmp.FieldByName('CEP').AsString);
  end;
  If SameText('NUMCNPJ', VarName) Then
  begin
    Value := UpperCase(fFormataCpfCgc(qryGetEmp.FieldByName('NUMCNPJ').AsString,fSetaPais));
  end;

  If Assigned(qryGetEmp) Then
    qryGetEmp.Free;

end;

function TfrmRelFatReciboAvulso.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtNomRec) Then
  Begin

    If fEmptyStr(edtNomRec.Text) Then
    Begin
      fMensagem('', 'O campo Nome deve ser preenchido!', ['&OK']);
      Result := False;
    End;

  End

  Else If (Sender = edtValRec) Then
  Begin

    If fStrToFloat(edtValRec.Text) <= 0 Then
    Begin
      fMensagem('', 'O Valor do Recibo deve ser maior que zero!', ['&OK']);
      Result := False;
    End
    Else If fStrToFloat(AnsiReplaceStr(edtValRec.Text, '.', '')) > 999999999.99 Then
    Begin
      fMensagem('', 'Valor acima do permitido (999.999.999,99)!', ['&OK']);
      Result := False;
    End;

  End

  Else If (Sender = mmfHisRec) Then
  Begin

    If fEmptyStr(mmfHisRec.Lines.Text) Then
    Begin
      fMensagem('', 'O campo Histórico deve ser preenchido!', ['&OK']);
      Result := False;
    End;

  End

  Else If (Sender = edtAssRec) Then
  Begin

    If fEmptyStr(edtAssRec.Text) Then
    Begin
      fMensagem('', 'O Nome na Assinatura deve ser preenchido!', ['&OK']);
      Result := False;
    End;

  End

  Else If (Sender = mskDtaRec) Then
  Begin

    If fEmptyStr(fTiraCaracEspeciais(mskDtaRec.Text)) Then
    Begin
      fMensagem('', 'O campo Data do Recibo deve ser preenchido!', ['&OK']);
      Result := False;
    End

  End

  Else If (Sender = edtQtdVia) Then
  Begin

    If StrToIntDef(edtQtdVia.Text, 0) <= 0 Then
    Begin
      fMensagem('', 'A quantidade de vias deve ser maior que zero!', ['&OK']);
      Result := False;
    End

  End

  Else If (Sender = edtOpcCnpjCpf) Then
  Begin
    If fEmptyStr(edtOpcCnpjCpf.Text) and (Pos(edtOpcCnpjCpf.Text, '1_2_') > 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe 1-CNPJ / 2-CPF!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtCnpjCpf) Then
  Begin
    If fEmptyStr(fLimpaMaskCgcCpf(edtCnpjCpf)) and (Pos(edtOpcCnpjCpf.Text, '1_2_') > 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Informe o CNPJ / CPF!', ['&Ok']);
      Result := False;
    End
    else
    If (Not fEmptyStr(edtCnpjCpf.Text)) Then
      Result := fValidaCnpjCpf(edtOpcCnpjCpf.Text, edtCnpjCpf.Text, True, True);

  End

  Else If (Sender = edtCodCli) Then
  Begin
    If (Not fEmptyStr(edtCodCli.Text)) Then
    Begin
      If Not SameText(edtCodCli.Text, '00000000') Then
      Begin
        SetLength(arrClientes, 0);

        pCarregaCliente;
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else
    Begin
      edtNomCli.Clear;
    End;
  End;


  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelFatReciboAvulso.mmfHisRecExit(Sender: TObject);
begin
  inherited;
  If intMaxLin > MAXLIN Then
  Begin
    fMensagem('', 'Linhas a mais do que o permitido!', ['&OK']);
    pSetFocus(mmfHisRec);
    Exit;
  End;

  If intMaxChr > MAXCHR Then
  Begin
    fMensagem('', 'Caracteres a mais do que o permitido!', ['&OK']);
    pSetFocus(mmfHisRec);
    Exit;
  End;
end;

procedure TfrmRelFatReciboAvulso.mmfHisRecKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  intMaxLin := mmfHisRec.Lines.Count; 

  intMaxChr := (mmfHisRec.Lines.Count-1) * 80;
  intMaxChr := intMaxChr + Length(mmfHisRec.Lines.Strings[intMaxLin-1]);

  If intMaxChr < 0 Then intMaxChr := 0;

  lblLinhas.Caption := 'Linhas: '     + IntToStr(intMaxLin) + '/' + IntToStr(MAXLIN) + ' ' +
                       'Caracteres: ' + IntToStr(intMaxChr) + '/' + IntToStr(MAXCHR);
end;

procedure TfrmRelFatReciboAvulso.btnImprimirClick(Sender: TObject);
Var
  frxReport : TfrxReport;
  I         : Integer;
begin
  inherited;
  if not blnImprime then
    Exit;


  If Not fImprimeRelatorioLayout Then
  begin
    pnlInfo.Caption := 'Gerando Relatório...';
    pnlInfo.Repaint;

    Try

      {Impressão logo da empresa - Somente para jato de tinta}
      If (strTipImp <> 'M') Then
      Begin

        {Logo}
        If FileExists(fCfgSis('PATLOG')) Then
        begin

          {Não oculta textos do cabeçalho}
          for i := 1 to 12 do
            TfrxMemoView(frxReportJ.FindObject('Memo' + IntToStr(i))).Visible := True;

          TfrxPictureView(frxReportJ.FindObject('imgImagem')).Picture.LoadFromFile(fCfgSis('PATLOG'));
          TfrxPictureView(frxReportJ.FindObject('imgImagem')).Width := 143.6;
        end
        else
        {Logo Cabeçalho Completo}
        If FileExists(fCfgSis('PATCAB')) Then
        begin

          {Oculta textos do cabeçalho, para exibir imagem completa do cabeçalho}
          for i := 1 to 12 do
            TfrxMemoView(frxReportJ.FindObject('Memo' + IntToStr(i))).Visible := False;

          TfrxPictureView(frxReportJ.FindObject('imgImagem')).Picture.LoadFromFile(fCfgSis('PATCAB'));
          TfrxPictureView(frxReportJ.FindObject('imgImagem')).Width := 744.56;
        end
        else
        begin

          {Procedimento quando nenhum logo configurado!}

          {Não oculta textos do cabeçalho}
          for i := 1 to 12 do
            TfrxMemoView(frxReportJ.FindObject('Memo' + IntToStr(i))).Visible := True;

          TfrxPictureView(frxReportJ.FindObject('imgImagem')).Visible := False;

          {Retorna textos do cabeçalho para a esquerda}
          for i := 1 to 4 do
            TfrxMemoView(frxReportJ.FindObject('Memo' + IntToStr(i))).Left := 4.91;

          for i := 5 to 7 do
            TfrxMemoView(frxReportJ.FindObject('Memo' + IntToStr(i))).Left := 69.16;

        end;

      End;

      If strTipImp = 'M' Then
        frxReport := frxReportM
      Else
        frxReport := frxReportJ;

      If Not fEmptyStr(strNomImp) Then
      Begin
        frxReport.PrintOptions.Printer      := strNomImp;
        frxReport.PrintOptions.ShowDialog   := False;
      End;

      If frxReport.PrepareReport Then
      Begin
        If edtDestino.Text = 'V' Then
          pPreviewReport(Self.Name, Self.Caption, frxReport)
        Else
          pPrintReport(Self.Name, Self.Caption, strNomImp, frxReport);
      End;


    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmRelFatReciboAvulso.btnImprimirClick]');
      End;

    End;

    btnImprimir.Enabled := True;
    pnlInfo.Caption     := '';
  end;

end;

procedure TfrmRelFatReciboAvulso.edtCnpjCpfExit(Sender: TObject);
begin
  inherited;
  if Pos(edtOpcCnpjCpf.Text, '1_2_') > 0 then
    if (fLimpaMaskCgcCpf(edtCnpjCpf) = '') then
      fMensagem('ATENÇÃO!', 'Informe CNPJ / CPF!', ['&Ok']);
end;

procedure TfrmRelFatReciboAvulso.edtCodCliChange(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtCodCli.Text) Then
     pLimpaDadosCli;
  HabilitaCampos();
end;

procedure TfrmRelFatReciboAvulso.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, Nil, fRetNomCliente, 'do Cliente');
  if Not fEmptyStr(edtCodCli.Text) then
     pCarregaDadosCli(edtCodCli.Text)
  Else
     pLimpaDadosCli;
end;

procedure TfrmRelFatReciboAvulso.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelFatReciboAvulso.edtNomRecChange(Sender: TObject);
begin
  inherited;
  HabilitaCampos();
end;

Function TfrmRelFatReciboAvulso.VerificaHabCampos : Boolean;
Begin
  Result := False;

  If ( fEmptyStr(edtcodCli.Text) ) Then
  Begin

    If Not fEmptyStr(edtNomRec.Text) Then
      Result := True
    Else
    if Not fEmptyStr(edtCnpjCpf.Text) Then
       Result := true
    Else
    if Not fEmptyStr(edtEndereco.Text) Then
      Result := true
    Else
    if Not fEmptyStr(edtCidade.Text) Then
      Result := true;

  End;

End;

Procedure TfrmRelFatReciboAvulso.HabilitaCampos();
Begin

   if pnlCliente.Visible  then
   Begin

      If VerificaHabCampos then
      Begin
         edtcodCli.enabled      := False;
         edtNomRec.enabled      := True;
         edtOpcCnpjCpf.enabled  := True;
         edtCnpjCpf.enabled     := True;
         edtEndereco.enabled    := True;
         edtNroEndereco.enabled := True;
         edtcidade.enabled      := True;
      End
      Else
      If Not fEmptyStr(edtcodCli.Text) Then
      Begin
         edtNomRec.enabled      := False;
         edtOpcCnpjCpf.enabled  := False;
         edtCnpjCpf.enabled     := False;
         edtEndereco.enabled    := False;
         edtNroEndereco.enabled := False;
         edtcidade.enabled      := False;
      End
      Else
      Begin
         edtcodCli.enabled      := True;
         edtNomRec.enabled      := True;
         edtOpcCnpjCpf.enabled  := True;
         edtCnpjCpf.enabled     := True;
         edtEndereco.enabled    := True;
         edtNroEndereco.enabled := True;
         edtcidade.enabled      := True;
      End;

   End;

End;


procedure TfrmRelFatReciboAvulso.edtOpcCnpjCpfExit(Sender: TObject);
var
  intOpcCgc : Integer;
begin
  inherited;
  blnCpfCnpjObrig := False;
  if Trim(edtOpcCnpjCpf.Text) <> '' then
    begin
      intOpcCgc := StrToInt(edtOpcCnpjCpf.Text);
      case intOpcCgc of
        1 : blnCpfCnpjObrig := True;
        2 : blnCpfCnpjObrig := True;
      end;
    end;

  edtCnpjCpf.Enabled := True;

  pSetFocus(edtCnpjCpf);

  if edtOpcCnpjCpf.Text = '1' then
    edtCnpjCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_, True)
  else
  if edtOpcCnpjCpf.Text = '2' then
    edtCnpjCpf.EditMask := '999.999.999-99;1;'
  else
    begin
      edtCnpjCpf.EditMask := '';
      edtCnpjCpf.Enabled := False;
      edtCnpjCpf.Clear;

      pSetFocus(edtEndereco);
    end;
end;

function TfrmRelFatReciboAvulso.fImprimeRelatorioLayout: Boolean;
Var
  blnImpPersonalizado : Boolean;
  qryCfgRel : TUniQuery;
  qryDadosEmp : TUniQuery;
  strVlrExt : String;
  strNomRec : String;
  strCgcCpf : String;
  i : Integer;
  strEndCli,
  strEndNro,
  strEndCid,
  strCodCid : String;
begin
  blnImpPersonalizado := False;
  strEndCli := '';
  strEndNro := '';
  strEndCid := '';
  strCodCid := '';

  Try
    qryCfgRel := fCriaQuery;
    qryDadosEmp   := fCriaQuery;

    pCriarFormularios(TfrmQckRelFatReciboAvulso,frmQckRelFatReciboAvulso);

    If edtDestino.Text <> 'V' Then
      begin
        frmQckRelFatReciboAvulso.frxDotMatrixExport.PageBreaks := True;
        blnImpPersonalizado := fLoadReport(strTipImp);
      end
    else
      begin
        strTipImp := 'L';
        blnImpPersonalizado := fLoadReport(strTipImp);
      end;

    if blnImpPersonalizado then
    begin
      frmQckRelFatReciboAvulso.strCodEmp := VS_strCodEmp;
      frmQckRelFatReciboAvulso.intQtdVia := StrToInt(edtQtdVia.Text);
      frmQckRelFatReciboAvulso.strQtdVia := edtQtdVia.Text;
      frmQckRelFatReciboAvulso.strCodCli := edtCodCli.Text;
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        strEndCli := VarToStrDef(fCampoTabela('CLI_ENDERE', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]), '');
        strEndNro := VarToStrDef(fCampoTabela('CLI_ENDNUM', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]), '');
        strEndCid := VarToStrDef(fCampoTabela('CLI_ENDERE', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]), '');
        strCodCid := VarToStrDef(fCampoTabela('CLI_CODCID', 'CADCLI', ['CLI_CODCLI'], [edtCodCli.Text]), '');
        strEndCid := VarToStrDef(fCampoTabela('CID_NOMCID', 'CADCID', ['CID_CODCID'], [strCodCid])  , '');
      End
      Else
      Begin
        strEndCli := EdtEndereco.Text;
        strEndNro := EdtNroEndereco.Text;
        strEndCid := EdtCidade.Text;
      End;

      frmQckRelFatReciboAvulso.strEndNro := IIF( fEmptyStr(strEndNro),'', strEndNro + ', ');
      frmQckRelFatReciboAvulso.strEndCid := IIF( fEmptyStr(strEndCid),'', strEndCid + ', ');

      qryDadosEmp.SQL.Add('SELECT ');
      qryDadosEmp.SQL.Add('  EMP_NOMEMP NOMEMP, ');
      qryDadosEmp.SQL.Add('  CID_NOMCID NOMCID, ');
      qryDadosEmp.SQL.Add('  EMP_FONE01 NUMTEL,  ');
      qryDadosEmp.SQL.Add('  EMP_ENDERE NOMEND,  ');
      qryDadosEmp.SQL.Add('  EMP_BAIRRO NOMBAI,  ');
      qryDadosEmp.SQL.Add('  EMP_C_E_P_ NUMCEP,  ');
      qryDadosEmp.SQL.Add('  EMP_C_G_C_ NUMCNPJ, ');
      qryDadosEmp.SQL.Add('  EMP_ENDNUM NUMEND   ');
      qryDadosEmp.SQL.Add('FROM ');
      qryDadosEmp.SQL.Add('  CADEMP ');
      qryDadosEmp.SQL.Add('  LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ');
      qryDadosEmp.SQL.Add('WHERE ');
      qryDadosEmp.SQL.Add('  LOCATE(EMP_CODEMP, :CODEMP) ');
      qryDadosEmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryDadosEmp.Open;

      if strTipImp = 'M' then
        begin
          frmQckRelFatReciboAvulso.strNomEmp := fTiraCaracEspeciais(qryDadosEmp.FieldByName('NOMEMP').AsString);
          frmQckRelFatReciboAvulso.strNomCid := fTiraCaracEspeciais(UpperCase(qryDadosEmp.FieldByName('NOMCID').AsString));
          frmQckRelFatReciboAvulso.strNomEnd := fTiraCaracEspeciais(UpperCase(qryDadosEmp.FieldByName('NOMEND').AsString + IIF(qryDadosEmp.FieldByName('NUMEND').AsString <> '',(', '+qryDadosEmp.FieldByName('NUMEND').AsString),'') ));
          frmQckRelFatReciboAvulso.strNomBai := fTiraCaracEspeciais(UpperCase(qryDadosEmp.FieldByName('NOMBAI').AsString));
          frmQckRelFatReciboAvulso.strDtaRec := fTiraCaracEspeciais(fRetDataExtenso(StrToDate(mskDtaRec.Text), True));
          strNomRec                          := fTiraCaracEspeciais(edtNomRec.Text);
          frmQckRelFatReciboAvulso.strNomAss := fTiraCaracEspeciais(edtAssRec.Text);
        end
      else
        begin
          frmQckRelFatReciboAvulso.strNomEmp := UpperCase(qryDadosEmp.FieldByName('NOMEMP').AsString);
          frmQckRelFatReciboAvulso.strNomCid := UpperCase(qryDadosEmp.FieldByName('NOMCID').AsString);
          frmQckRelFatReciboAvulso.strNomEnd := UpperCase(qryDadosEmp.FieldByName('NOMEND').AsString + IIF(qryDadosEmp.FieldByName('NUMEND').AsString <> '',(', '+qryDadosEmp.FieldByName('NUMEND').AsString),'') );
          frmQckRelFatReciboAvulso.strNomBai := UpperCase(qryDadosEmp.FieldByName('NOMBAI').AsString);
          frmQckRelFatReciboAvulso.strDtaRec := fRetDataExtenso(StrToDate(mskDtaRec.Text), True);
          strNomRec                          := edtNomRec.Text;
          frmQckRelFatReciboAvulso.strNomAss := edtAssRec.Text;
        end;

      frmQckRelFatReciboAvulso.strNumTel   := UpperCase(qryDadosEmp.FieldByName('NUMTEL').AsString);
      frmQckRelFatReciboAvulso.strNumCep   := UpperCase(qryDadosEmp.FieldByName('NUMCEP').AsString);
      frmQckRelFatReciboAvulso.strNumCnpj  := UpperCase(fFormataCpfCgc(qryDadosEmp.FieldByName('NUMCNPJ').AsString,fSetaPais));

      frmQckRelFatReciboAvulso.strValRec := edtValRec.Text;

      frmQckRelFatReciboAvulso.strNomRec := strNomRec;

      strVlrExt := UpperCase(fRetExtensoNumero(edtValRec.Text));

      frmQckRelFatReciboAvulso.strVlrExt := strVlrExt;

      If fEmptyStr(edtCnpjCpf.Text) Then
      Begin
        If (Not fEmptyStr(edtCodCli.Text)) Then
        Begin
          edtCnpjCpf.Text := fRetCgcCpf(edtCodCli.Text);
          edtOpcCnpjCpf.Text := IIF ((Length(fRetCgcCpf(edtCodCli.Text)) > 11),'1','2');

          if edtOpcCnpjCpf.Text = '1' then
            edtCnpjCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_, True)
          else if edtOpcCnpjCpf.Text = '2' then
            edtCnpjCpf.EditMask := '999.999.999-99;1;'
        end;
      End;

      if edtOpcCnpjCpf.Text = '1' then
        strCgcCpf := ' portador(a) do CNPJ nº.: '+edtCnpjCpf.Text
      else
      if edtOpcCnpjCpf.Text = '2' then
        strCgcCpf := ' portador(a) do CPF nº.: '+edtCnpjCpf.Text
      else
        strCgcCpf := '';

      If fEmptyStr(fLimpaMaskCgcCpf(edtCnpjCpf)) then
        if (Pos(edtOpcCnpjCpf.Text, '1_2_') > 0) Then
          strCgcCpf := '';

      frmQckRelFatReciboAvulso.strCgcCpf := strCgcCpf;

      If SameText(strTipImp, 'M') Then
        frxRel := frmQckRelFatReciboAvulso.frxReportM
      Else
      Begin
        frxRel := frmQckRelFatReciboAvulso.frxReportJ;
      End;

      If (strTipImp <> 'M') Then
      Begin
        if Assigned(frxRel.FindObject('imgImagem')) then
        begin
          {Logo}
          If FileExists(fCfgSis('PATLOG')) Then
          begin

            {Não oculta textos do cabeçalho}
            for i := 1 to 12 do
            begin
              if Assigned(frxRel.FindObject('Memo'+ IntToStr(i))) then
                TfrxMemoView(frxRel.FindObject('Memo' + IntToStr(i))).Visible := True;
            end;

            TfrxPictureView(frxRel.FindObject('imgImagem')).Picture.LoadFromFile(fCfgSis('PATLOG'));
            TfrxPictureView(frxRel.FindObject('imgImagem')).Width := 143.6;
          end
          else
          {Logo Cabeçalho Completo}
          If FileExists(fCfgSis('PATCAB')) Then
          begin

            {Oculta textos do cabeçalho, para exibir imagem completa do cabeçalho}
            for i := 1 to 12 do
            begin
              if Assigned(frxRel.FindObject('Memo'+ IntToStr(i))) then
                TfrxMemoView(frxRel.FindObject('Memo' + IntToStr(i))).Visible := False;
            end;

            TfrxPictureView(frxRel.FindObject('imgImagem')).Picture.LoadFromFile(fCfgSis('PATCAB'));
            TfrxPictureView(frxRel.FindObject('imgImagem')).Width := 744.56;
          end
          else
          begin

            {Procedimento quando nenhum logo configurado!}

            {Não oculta textos do cabeçalho}
            for i := 1 to 12 do
            begin
              if Assigned(frxRel.FindObject('Memo'+ IntToStr(i))) then
                TfrxMemoView(frxRel.FindObject('Memo' + IntToStr(i))).Visible := True;
            end;

            TfrxPictureView(frxRel.FindObject('imgImagem')).Visible := False;

            {Retorna textos do cabeçalho para a esquerda}
            for i := 1 to 4 do
            begin
              if Assigned(frxRel.FindObject('Memo'+ IntToStr(i))) then
                TfrxMemoView(frxRel.FindObject('Memo' + IntToStr(i))).Left := 4.91;
            end;

            for i := 5 to 7 do
            begin
              if Assigned(frxRel.FindObject('Memo'+ IntToStr(i))) then
                TfrxMemoView(frxRel.FindObject('Memo' + IntToStr(i))).Left := 69.16;
            end;

          end;
        end
        else
        begin
          {Retorna textos do cabeçalho para a esquerda}
          for i := 1 to 4 do
          begin
            if Assigned(frxRel.FindObject('Memo'+ IntToStr(i))) then
              TfrxMemoView(frxRel.FindObject('Memo' + IntToStr(i))).Left := 4.91;
          end;

          for i := 5 to 7 do
          begin
            if Assigned(frxRel.FindObject('Memo'+ IntToStr(i))) then
              TfrxMemoView(frxRel.FindObject('Memo' + IntToStr(i))).Left := 69.16;
          end;
        end;
      End;

      If Not (fEmptyStr(strEndCli))Then
         strEndCli := strEndCli; //strEndCli := 'Endereço: '+ strEndCli;

      frxRel.Script.Variables['strNOMREC']    := strNomRec;
      frxRel.Script.Variables['strVALREC']    := edtValRec.Text;
      frxRel.Script.Variables['strVLREXT']    := strVlrExt;
      frxRel.Script.Variables['strHISREC']    := mmfHisRec.Lines.Text;
      frxRel.Script.Variables['strCGCCPF']    := strCgcCpf;
      frxRel.Script.Variables['strENDCLI']    := IIF( fEmptyStr(strEndCli),'',strEndCli + ', ' );
      frxRel.Script.Variables['strENDNRO']    := IIF( fEmptyStr(strEndNro),'',strEndNro + ', ' );
      frxRel.Script.Variables['strENDCID']    := IIF( fEmptyStr(strEndCid),'',strEndCid + ', ' );

      if edtDestino.Text = 'I' then
      begin
        frxRel.PrintOptions.Printer   := strNomImp;
        frxRel.PreviewOptions.Buttons := [pbPrint,pbExport,pbZoom,pbFind,pbOutline,pbPageSetup,pbTools,pbNavigator];
        frxRel.PrintOptions.ShowDialog := False;
      end;

      If Not fEmptyStr(strNomImp) Then
      Begin
        frxRel.PrintOptions.Printer      := strNomImp;
        frxRel.PrintOptions.ShowDialog   := False;
      End
      Else
        frxRel.PrintOptions.ShowDialog   := True;

      if edtDestino.Text = 'I' then
      begin
        If frxRel.PrepareReport Then
        Begin
          pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
        End;
      end
      else If frxRel.PrepareReport Then
      Begin
        pPreviewReport(Self.Name, Self.Caption, frxRel);
      End;
    end;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fImprimeRelatorioLayout]');
    End;
  End;

  Result := blnImpPersonalizado;

  pFreeAndNil(frmQckRelFatReciboAvulso);
  FreeAndNil(qryCfgRel);
end;

procedure TfrmRelFatReciboAvulso.FormActivate(Sender: TObject);
begin
  inherited;
  if pnlcliente.visible then
     pSetFocus(edtCodCli)
  else
     pSetFocus(edtNomRec);
end;

procedure TfrmRelFatReciboAvulso.FormShow(Sender: TObject);
begin
  inherited;
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  mskDtaRec.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
  pPreparaForm;
  intMaxLin := 0;
  intMaxChr := 0;

  mmfHisRec.Width := 489;

  lblLinhas.Caption := 'Linhas: '     + '0/' + IntToStr(MAXLIN) + ' ' +
                       'Caracteres: ' + '0/' + IntToStr(MAXCHR);
end;

procedure TfrmRelFatReciboAvulso.frxUserFirst(Sender: TObject);
begin
  inherited;
  intQtdVia := 1;

end;

procedure TfrmRelFatReciboAvulso.frxUserCheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  inherited;
  Eof := intQtdVia > StrToIntDef(edtQtdVia.Text, 0);

end;

procedure TfrmRelFatReciboAvulso.frxUserPrior(Sender: TObject);
begin
  inherited;
  Dec(intQtdVia);
end;

procedure TfrmRelFatReciboAvulso.frxUserNext(Sender: TObject);
begin
  inherited;
  Inc(intQtdVia);
end;

function TfrmRelFatReciboAvulso.fLoadReport(strTpImp: String): Boolean;
 Var
   mmsLoad: TStream;
   FLayImp: TUniQuery;
Begin
  Result := False;
  FLayImp:= fCriaQuery(nil);
  Try
    FLayImp.Close;
    FLayImp.SQL.Clear;
    FLayImp.SQL.Add('SELECT * FROM ');
    FLayImp.SQL.Add('  LAYIMP');
    FLayImp.SQL.Add('WHERE');
    FLayImp.SQL.Add('  LAY_TIPLAY = :TIPLAY AND  ');
    FLayImp.SQL.Add('  LAY_CODEMP = :CODEMP AND  ');
    FLayImp.SQL.Add('  LAY_CODLAY = :CODLAY      ');

    FLayImp.ParamByName('CODEMP').AsString := VS_strCodEmp;

    If fCfgSis('COLRAV') = '1' Then //40 COLUNAS
       FLayImp.ParamByName('CODLAY').AsString := 'RECAV1'
    Else //80 COLUNAS
       FLayImp.ParamByName('CODLAY').AsString := 'RECAVU';

    If(strTpImp = 'M') Then
      FLayImp.ParamByName('TIPLAY').AsString := 'M'
    Else
      FLayImp.ParamByName('TIPLAY').AsString := 'L';

    FLayImp.SQL.Add('ORDER BY');
    FLayImp.SQL.Add('  LAY_DTAALT DESC,');
    FLayImp.SQL.Add('  LAY_HORALT DESC ');
    FLayImp.SQL.Add('LIMIT 1');
    FLayImp.Open;

    If Not FLayImp.IsEmpty Then
    Begin
      Result := True;
      mmsLoad := FLayImp.CreateBlobStream(FLayImp.FieldByName('LAY_RELFR3'), bmRead);
      If (strTpImp = 'M') Then
      Begin
        frmQckRelFatReciboAvulso.frxReportM.LoadFromStream(mmsLoad);
        frmQckRelFatReciboAvulso.frxReportM.Variables.Clear;
      End
      Else
      Begin
        frmQckRelFatReciboAvulso.frxReportJ.LoadFromStream(mmsLoad);
        frmQckRelFatReciboAvulso.frxReportJ.Variables.Clear;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fLoadReport]');
    End;
  End;

  If Not FLayImp.IsEmpty Then
    FreeAndNil(mmsLoad);
  FreeAndNil(FLayImp);
End;

Procedure TFrmRelFatReciboAvulso.pCarregaDadosCli(strCodCli : String);
 var strCodCid : String;
Begin
   edtnomRec.text      := edtNomcli.text;
   edtCnpjCpf.EditMask := '';
   edtCnpjCpf.Text     := fRetCgcCpf(edtCodcli.Text);
   edtOpcCnpjCpf.Text  := IIF ((Length(fRetCgcCpf(edtCodcli.Text)) > 11),'1','2');
   if edtOpcCnpjCpf.Text = '1' then
      edtCnpjCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_, True)
   else if edtOpcCnpjCpf.Text = '2' then
      edtCnpjCpf.EditMask := '999.999.999-99;1;';

   edtEndereco.Text    := VarToStrDef(fCampoTabela('CLI_ENDERE', 'CADCLI', ['CLI_CODCLI'], [strCodCli]), '');
   edtNroEndereco.Text := VarToStrDef(fCampoTabela('CLI_ENDNUM', 'CADCLI', ['CLI_CODCLI'], [strCodCli]), '');
   edtCidade.text      := VarToStrDef(fCampoTabela('CLI_ENDERE', 'CADCLI', ['CLI_CODCLI'], [strCodCli]), '');
   strCodCid           := VarToStrDef(fCampoTabela('CLI_CODCID', 'CADCLI', ['CLI_CODCLI'], [strCodCli]), '');
   EdtCidade.text      := VarToStrDef(fCampoTabela('CID_NOMCID', 'CADCID', ['CID_CODCID'], [strCodCid])  , '');
End;

Procedure TFrmRelFatReciboAvulso.pLimpaDadosCli();
Begin
   edtnomRec.text      := '';
   edtCnpjCpf.Text     := '';
   edtCnpjCpf.editmask := '';
   edtOpcCnpjCpf.Text  := '';
   edtEndereco.Text    := '';
   edtNroEndereco.Text := '';
   edtCidade.text      := '';
End;


end.

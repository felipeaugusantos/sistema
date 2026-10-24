unit untRelCtpTitContasAno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus, Uni,
  QColorLabel, ExtCtrls, Buttons, Mask, MaskEditFocus, untTypesSistema,
  untFuncoesFactory, DB, StrUtils, DateUtils, BitBtnLockedIncrem, ComCtrls,
  untGeraExcel, untExcel, frxExportCSVTestabilidade, untIFuncoes;

type
  TfrmRelCtpTitContasAno = class(TfrmPaiRelatorio)
    Label1: TLabel;
    mskMesBas: TMaskEditFocus;
    Label27: TLabel;
    lblEmpresa: TLabel;
    Label2: TLabel;
    mskContaIni: TMaskEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesContaIni: TEditFocus;
    edtDesEmpresa: TEditFocus;
    edtCodEve: TEditFocus;
    edtDesEve: TEditFocus;
    edtQtdMes: TEditFocus;
    Label6: TLabel;
    rdgTipRel: TRadioGroup;
    rdgTipQue: TRadioGroup;
    chkQuePag: TCheckBox;
    chkMosEve: TCheckBox;
    lbl1: TLabel;
    mskContaFin: TMaskEditFocus;
    edtDesContaFin: TEditFocus;
    pgbProgresso: TProgressBar;
    Label9: TLabel;
    mskCompet: TMaskEditFocus;
    rdgTipoData: TRadioGroup;
    gpbContas: TGroupBox;
    ColorLabel3: TColorLabel;
    edtContas: TEditFocus;
    procedure mskContaIniExit(Sender: TObject);
    procedure mskContaIniKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEveExit(Sender: TObject);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure rdgTipQueClick(Sender: TObject);
    procedure rdgTipRelClick(Sender: TObject);
    procedure mskContaFinKeyPress(Sender: TObject; var Key: Char);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mskContaFinExit(Sender: TObject);
  private
    { Private declarations }
    qryRelatorio: TUniQuery;
    arrContaIni : TConsultasArray;
    arrContaFin : TConsultasArray;
    arrEmpresa  : TConsultasArray;
    arrEvento   : TConsultasArray;
    strEmpresa  : String;
    strEvento   : String;

    function fRetSql: String;
    procedure pFiltroCentroCusto(Var strSql: String);
    procedure pGeraExcel(qryDados: TUniQuery);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotais(Var Totais: TTotais; Dados: TDataSet);
    procedure pCriaQryRelatorio;
    function fRetMedia(DataSet: TDataSet): Double;
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

var
  frmRelCtpTitContasAno: TfrmRelCtpTitContasAno;

implementation

uses untQckCtpTitContasAno, untMemo;

{$R *.dfm}

procedure TfrmRelCtpTitContasAno.mskContaFinExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskContaFin, edtDesContaFin,
                    arrContaFin, fRetNomeConta, nil, 'do Custo Final');
end;

procedure TfrmRelCtpTitContasAno.mskContaFinKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, mskContaFin, edtDesContaFin, Nil, Key, arrContaFin) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmRelCtpTitContasAno.mskContaIniExit(Sender: TObject);
begin
  pEdtCodSelectExit(mskContaIni, edtDesContaIni,
                    arrContaIni, fRetNomeConta, nil, 'do Custo Inicial');
end;

procedure TfrmRelCtpTitContasAno.mskContaIniKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, mskContaIni, edtDesContaIni, Nil, Key, arrContaIni, False) Then
  Begin
    fvalidaCampos(mskContaIni,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpTitContasAno.pCriaQryRelatorio;
begin
  qryRelatorio:= fCriaQuery(Self);
  frxRelatorio.DataSet := qryRelatorio;
end;

procedure TfrmRelCtpTitContasAno.pFiltroCentroCusto(var strSql: String);
  Var
    intCont: Integer;
    strLeft: String;

    {******************************************************************************}
    {* VERIFICA SE VAI COMPARAR AS CONTAS DENTRO DA LINHA E GRUPO.                *}
    {* EX: A CONTA 01.01.012 ESTA CONTIDA NA LINHA 01.00.000 E NO GRUPO 01.01.000 *}
    {***************************************************************************JC*}
    procedure pSetaLeft(strCodCta: String);
    begin
      strLeft := '7'; //COMPARA TODA A CONTA
      If RightStr(strCodCta, 3) = '000'   Then strLeft := '4'; //COMPARA SOMENTE O GRUPO
      If RightStr(strCodCta, 5) = '00000' Then strLeft := '2'; //COMPARA SOMENTE A LINHA
    end;

    {*****************************************************************************}
    {* MONTA A STRING DO FILTRO USANDO AS COMPARACOES IGUAL, MAIOR, MENOR ETC... *}
    {**************************************************************************JC*}
    function fstrLeft(strCodCta, strComp: String): String;
    begin
      Result := '(LEFT(IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA),' + strLeft +
                ') ' + strComp + ' "' + LeftStr(strCodCta, StrToInt(strLeft)) + '")';
    end;

begin

  {*******************************************}
  {* CASO TENHA SELECIONADO VARIAS CONTAS EN-*}
  {* TAO MONTA FILTRO USANDO A CONDICAO "OR" *}
  {* EX: CONTA IGUAL XX OU CONTA IGUAL A YY  *}
  {****************************************JC*}
  If Length(arrContaIni) > 1 Then
  Begin
    strSql := strSql + ' AND ( ';

    For intCont := 0 To Length(arrContaIni) -1 Do
    Begin
      pSetaLeft(arrContaIni[intCont].strCodigo);
      strSql := strSql + fstrLeft(arrContaIni[intCont].strCodigo, '=') + ifthen(intCont < (Length(arrContaIni) -1), ' OR ', '');
    End;

    strSql := strSql + ' )';
  End

  Else If (Not fEmptyStr(fTiraCaracEspeciais(mskContaIni.Text))) Then
  Begin
    {*************************************************************}
    {* CONTA(LEFT) DEVE SER MAIOR OU IGUAL A CONTA INICIAL(LEFT) *}
    {**********************************************************JC*}
    pSetaLeft(fTiraCaracEspeciais(mskContaIni.Text));
    strSql := strSql + ' AND ' + fstrLeft(fTiraCaracEspeciais(mskContaIni.Text), '>=');

    If (Not fEmptyStr(fTiraCaracEspeciais(mskContaFin.Text))) Then
    Begin
      {*************************************************************}
      {* CONTA(LEFT) DEVE SER MENOR OU IGUAL A CONTA FINAL(LEFT)   *}
      {**********************************************************JC*}
      pSetaLeft(fTiraCaracEspeciais(mskContaFin.Text));
      strSql := strSql + ' AND ' + fstrLeft(fTiraCaracEspeciais(mskContaFin.Text), '<=');
    End;
  End;
end;

procedure TfrmRelCtpTitContasAno.pGeraExcel(qryDados: TUniQuery);
  Var
    objGeraExcel: TGeraExcel;
    intCont     : Integer;
    strTitCon   : String;
begin
  objGeraExcel := TGeraExcel.Create(qryDados, pgbProgresso);
  With objGeraExcel Do
  Begin
    strNomRel := 'RELATORIO DE TITULOS POR PLANO DE CONTAS ANUAL';

    strTitCon := '';
    If Length(arrContaIni) > 1 Then
    Begin
      strTitCon := 'CONTA INICIAL: ';
      For intCont := 0 To Length(arrContaIni) -1 Do
        strTitCon := strTitCon + arrContaIni[intCont].strCodigo + ifthen(intCont < (Length(arrContaIni) -1), ',','');
    End
    Else If (Not fEmptyStr(mskContaIni.Text)) Then
      strTitCon := 'CONTA INICIAL: ' + mskContaIni.Text + ' - ' + edtDesContaIni.Text
    Else
      strTitCon := 'CONTA INICIAL: TODAS';

    If (Not fEmptyStr(mskContaFin.Text)) Then
      strTitCon := strTitCon +  '    CONTA FINAL: ' + mskContaFin.Text + ' - ' + edtDesContaFin.Text
    Else
      strTitCon := strTitCon +  '    CONTA FINAL: TODAS';

    AddFiltro(strTitCon);
    AddFiltro(fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA'));
    AddFiltro(fStrTitulo(edtCodEve.Text, edtDesEve, arrEvento, strEvento, 'CENTRO DE CUSTOS'));

    If edtContas.Text = 'T' Then
      AddFiltro('TITULOS: TODOS')
    Else
      AddFiltro('TITULOS: ' + IfThen(edtContas.Text = 'A', 'ABERTOS', 'QUITADOS'));

    If (rdgTipQue.ItemIndex = 1) Then
      AddQuebra('EVENT_EXCEL', 'CENTRO DE CUSTOS:');

    AddQuebra('LINHA_EXCEL', ' ');

    If (rdgTipRel.ItemIndex = 0) Then
      AddQuebra('GRUPO_EXCEL', ' ');

    If chkMosEve.Checked Then
      AddQuebra('CONTA_EXCEL', ' ');

    AddCampo('ESPACO', '');
    If chkMosEve.Checked Then
      AddCampo('NOMEVE', 'DESCRIÇÃO')
    Else
      AddCampo('CONTA_EXCEL', 'DESCRIÇÃO');
      
    For intCont := 1 To 12 Do
    Begin
      If (intCont) <= StrToInt(Copy(edtQtdMes.Text,01,02)) Then
      Begin
        AddCampo('VALPA' + fStrZero(intCont, 1), '''' + FormatDateTime('MM/yyyy', IncMonth(StrToDate('01/' + mskMesBas.Text), intCont-1)));
        AddTotais('VALPA' + fStrZero(intCont, 1));
      End;
    End;



    AddCampo(fRetMedia, 'MEDIA', 'MÉDIA',2,False);
    AddTotais('MEDIA');
    AddCampo('VALPAG', 'TOTAL');
    AddTotais('VALPAG');

    OnMontaResumo := pMontaResumo;
    OnSomaResumo  := pSomaTotais;

    If fGerarRelatorio Then
      fMensagem('','Arquivo gerado com sucesso!', ['&OK']);

  End;
  FreeAndNil(objGeraExcel);
end;

function TfrmRelCtpTitContasAno.fRetMedia(DataSet : TDataSet):Double;
var
  strValue: String;
begin
  strValue:= FormatCurr('#.###0,00', DataSet.FieldByName('VALPAG').AsFloat / StrToIntDef(edtQtdMes.Text, 1));

  Result := fStrToFloat(strValue);

End;

procedure TfrmRelCtpTitContasAno.pMontaResumo(Excel: TExcel; Campos: TCampos;
  Quebra: TRecQuebras);
  Var
    strTotal : String;
    strTotCol: String;
    intCont  : Integer;
    fltMedia : Double;
    fltTotal : Double;
    fltQtdMes: Double;
begin
  With Excel Do
  Begin
    If (Quebra.NomeCampo = 'LINHA_EXCEL') Then
      strTotal := 'TOTAL DA LINHA: '
    Else If (Quebra.NomeCampo = 'GRUPO_EXCEL') Then
      strTotal := '    TOTAL DO GRUPO: '
    Else If (Quebra.NomeCampo = 'CONTA_EXCEL') Then
      strTotal := '    TOTAL DO PLANO DE CONTAS: '
    Else If (Quebra.NomeCampo = 'EVENT_EXCEL') Then
      strTotal := '    TOTAL DO CENTRO DE CUSTOS: '
    Else
      strTotal := '   TOTAIS: ';

    If (strTotal <> '') Then
    Begin
      ProximaLinha;

      For intCont := 1 To 12 Do
      Begin
        If (intCont) <= StrToInt(edtQtdMes.Text) Then
        Begin
          strTotCol := fPadL(FormatFloat('##,#0.00', Quebra.Totais['VALPA' + fStrZero(intCont, 1)]), 14);
          Escrever(LinhaAtual, Campos.ColunaPorNome['VALPA' + fStrZero(intCont, 1)].Coluna, strTotCol);
        End;
      End;
      Escrever(LinhaAtual, 02, strTotal);
      strTotal := fPadL(FormatFloat('##,#0.00', Quebra.Totais['VALPAG']), 14);
      fltTotal := fStrToFloat(Trim(strTotal));
      fltQtdMes:= fStrToFloat(edtQtdMes.Text);

      fltMedia := fltTotal / fltQtdMes;
      Escrever(LinhaAtual, Campos.ColunaPorNome['MEDIA'].Coluna, fPadL(FormatFloat('##,#0.00', fltMedia), 14));

      Escrever(LinhaAtual, Campos.ColunaPorNome['VALPAG'].Coluna, strTotal);
      //Mesclar('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));

      Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
      CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
      CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
      Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
      Alinhamento('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Direita);
    End;
  End;
end;

procedure TfrmRelCtpTitContasAno.pSomaTotais(var Totais: TTotais;
  Dados: TDataSet);
  Var
    intCont: Integer;
begin
  For intCont := 1 To 12 Do
  Begin
    If (intCont) <= StrToInt(edtQtdMes.Text) Then
      Totais['VALPA' + fStrZero(intCont, 1)] := Totais['VALPA' + fStrZero(intCont, 1)] + Dados.FieldByName('VALPA' + fStrZero(intCont, 1)).AsFloat;
  End;
  Totais['VALPAG'] := Totais['VALPAG'] + Dados.FieldByName('VALPAG').AsFloat;
end;

procedure TfrmRelCtpTitContasAno.edtCodEveExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEve, edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');
end;

procedure TfrmRelCtpTitContasAno.edtCodEveKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EVENTOS    *}
  {****************************RV*}
  If fPesqEventos(Self, edtCodEve, edtDesEve, Nil, Key, arrEvento, False) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpTitContasAno.edtDestinoExit(Sender: TObject);
begin
  If (edtDestino.Text <> 'E') Then
    inherited;
end;

procedure TfrmRelCtpTitContasAno.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, fRetNomeEmpresa, Nil, 'da empresa');
end;

procedure TfrmRelCtpTitContasAno.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    fValidaCampos(edtCodEmpresa,False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelCtpTitContasAno.btnImprimirClick(Sender: TObject);
  Var
    strSQL    : String;
    intCont   : Integer;
    frxRel    : TfrxReport;
    dtaDtaIni : TDateTime;
    intQtdMes : Integer;
    strTitCon : String;
    strTitConF: String;
    qryAux    : TUniQuery;
    lstLista  : TStringList;
    strCodCta : String;
begin
  qryAux := fCriaQuery(Nil);

  If fRetornaCtaResDuplicado(qryAux) Then
  Begin
    lstLista := TStringList.Create;

    lstLista.Add('---------------------------------------------------------------------');
    lstLista.Add('     PLANOS DE CONTAS DUPLICADOS NO CADASTRO DE CONTAS RESULTADO     ');
    lstLista.Add('---------------------------------------------------------------------');
    lstLista.Add('CONTAS RESULTADO   PLANO DE CONTAS   DESCRICAO                       ');
    lstLista.Add('---------------------------------------------------------------------');

    With qryAux Do
    Begin
      First;

      strCodCta := FieldByName('CRE_CODCTA').AsString;

      While Not Eof Do
      Begin
        If FieldByName('CRE_CODCTA').AsString = strCodCta Then
          lstLista.Add(fPadC(FieldByName('CRE_CODCRE').AsString, 16) +
                       fPadC(Copy(FieldByName('CRE_CODCTA').AsString, 01, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 03, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 05, 03), 20) + ' ' +
                       fPadR(FieldByName('CTA_DESCTA').AsString, 40) )
        Else
        Begin
          lstLista.Add(' ');
          lstLista.Add(fPadC(FieldByName('CRE_CODCRE').AsString, 16) +
                       fPadC(Copy(FieldByName('CRE_CODCTA').AsString, 01, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 03, 02) + '.' +
                             Copy(FieldByName('CRE_CODCTA').AsString, 05, 03), 20) + ' ' +
                       fPadR(FieldByName('CTA_DESCTA').AsString, 40) );
          strCodCta := FieldByName('CRE_CODCTA').AsString;
        End;

        Next;
      End;

      lstLista.Add(' ');
      lstLista.Add('---------------------------------------------------------------------');
      lstLista.Add('SERA NECESSARIO ACESSAR O MENU DE CADASTROS, AUXILIARES, CONTAS DE   ');
      lstLista.Add('RESULTADO, E EXCLUIR OS REGISTROS DUPLICADOS, DEIXANDO APENAS O      ');
      lstLista.Add('PLANO DE CONTAS DENTRO DE UMA UNICA CONTA DE RESULTADO.              ');
      lstLista.Add('---------------------------------------------------------------------');

    End;

    Try
      pCriarFormularios(TfrmMemo, frmMemo);
      frmMemo.cxMemo.Lines := lstLista;
      frmMemo.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmRelCtpTitContas.btnImprimirClick]');
      End;
    End;

    pFreeAndNil(frmMemo);

    FreeAndNil(qryAux);
    FreeAndNil(lstLista);

    Exit;

  End
  Else
    FreeAndNil(qryAux);

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin

    Try

      pCriarFormularios(TfrmQckCtpTitContasAno,frmQckCtpTitContasAno);

      frmQckCtpTitContasAno.frxRel.DataSet := qryRelatorio;

      strSQL := fRetSql;

      With qryRelatorio Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('DTAINI').AsDate := StrToDate('01/' + mskMesBas.Text);
        ParamByName('DTAFIN').AsDate := IncMonth(StrToDate('01/' + mskMesBas.Text), StrToIntDef(edtQtdMes.Text,1)) - 1;

        If Not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
        ParamByName('COMPET').AsString := mskCompet.Text;

        pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryRelatorio);

        pSetaParam(edtCodEve.Text, arrEvento, strEvento, 'CODEVE', qryRelatorio);

        dtaDtaIni := StrToDate('01/' + mskMesBas.Text);

        For intQtdMes := 1 To 12 Do
        Begin
          ParamByName('DTAIN' + IntToStr(intQtdMes)).AsDate := dtaDtaIni;
          ParamByName('DTAFI' + IntToStr(intQtdMes)).AsDate := IncMonth(dtaDtaIni, 1) - 1;
          dtaDtaIni := IncMonth(dtaDtaIni, 1);
        End;

        Open;
      End;

      If Not qryRelatorio.IsEmpty Then
      Begin
        Try
          If SameText(strTipImp,'M') Then
            frxRel := frmQckCtpTitContasAno.frxQckCtpTitContasAnoM
          Else
          Begin
            frxRel := frmQckCtpTitContasAno.frxQckCtpTitContasAnoJ;

            frxRel.DotMatrixReport           := False;
            frxRel.PrintOptions.PrintMode    := pmScale;
            frxRel.PrintOptions.PrintOnSheet := 9; //A4

            TfrxMemoView(frxRel.FindObject('rllZebra')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clWhite);

          End;

          frxRel.Script.Variables['CODEMP']  := VS_strCodEmp;

          frxRel.Script.Variables['NOMREL']  := 'RELATORIO DE TITULOS POR PLANO DE CONTAS ANUAL';
          frxRel.Script.Variables['PERIODO'] := 'PERIODO: ' + '01/' + mskMesBas.Text + ' A ' + FormatDateTime('dd/mm/yyyy', IncMonth(StrToDate('01/' + mskMesBas.Text), StrToIntDef(edtQtdMes.Text,1)) - 1);

          strTitCon := '';
          If Length(arrContaIni) > 1 Then
          Begin
            strTitCon := 'CONTA INICIAL: ';
            For intCont := 0 To Length(arrContaIni) -1 Do
              strTitCon := strTitCon + arrContaIni[intCont].strCodigo + ifthen(intCont < (Length(arrContaIni) -1), ',','');
          End
          Else If (Not fEmptyStr(mskContaIni.Text)) Then
            strTitCon := 'CONTA INICIAL: ' + mskContaIni.Text + ' - ' + edtDesContaIni.Text
          Else
            strTitCon := 'CONTA INICIAL: TODAS';

          If (Not fEmptyStr(mskContaFin.Text)) Then
            strTitConF := 'CONTA FINAL: ' + mskContaFin.Text + ' - ' + edtDesContaFin.Text
          Else
            strTitConF := 'CONTA FINAL: TODAS';

          frxRel.Script.Variables['CONTA']   := strTitCon;
          frxRel.Script.Variables['CONTAF']  := strTitConF;
          frxRel.Script.Variables['EMPRESA'] := fStrTitulo(edtCodEmpresa.Text, edtDesEmpresa, arrEmpresa, strEmpresa, 'EMPRESA');
          frxRel.Script.Variables['EVENTOS'] := fStrTitulo(edtCodEve.Text, edtDesEve, arrEvento, strEvento, 'CENTRO DE CUSTOS');
          frxRel.Script.Variables['QTDMES']  := StrToIntDef(edtQtdMes.Text, 1);

          If edtContas.Text = 'T' Then
            frxRel.Script.Variables['CONTAS']  := 'TITULOS: TODOS'
          Else
            frxRel.Script.Variables['CONTAS']  := 'TITULOS: ' + IfThen(edtContas.Text = 'A', 'ABERTOS', 'QUITADOS');

          frxRel.FindObject('rlbCabGrupo').Visible := rdgTipRel.ItemIndex = 0;
          frxRel.FindObject('rlbRodGrupo').Visible := rdgTipRel.ItemIndex = 0;

          frxRel.FindObject('rlbCabEvento').Visible := rdgTipQue.ItemIndex = 1;
          frxRel.FindObject('rlbRodEvento').Visible := rdgTipQue.ItemIndex = 1;

          frxRel.FindObject('rlbCabConta').Visible := chkMosEve.Checked;
          frxRel.FindObject('rlbRodConta').Visible := chkMosEve.Checked;

          If chkMosEve.Checked Then
            TfrxMemoView(frxRel.FindObject('rdbDescri')).Text := '[frxRel."NOMEVE"]'
          Else
            TfrxMemoView(frxRel.FindObject('rdbDescri')).Text := '[frxRel."CONTA"]-[frxRel."DESCTA"]';

          TfrxGroupHeader(frxRel.FindObject('rlbCabEvento')).StartNewPage := chkQuePag.Checked;

          For intCont := 0 To 11 Do
          Begin

            If (intCont + 1) <= StrToInt(edtQtdMes.Text) Then
              TfrxMemoView(frxRel.FindObject('rllMes' + fStrZero(intCont + 1,2))).Text := FormatDateTime('mm/yyyy', IncMonth(StrToDate('01/' + mskMesBas.Text), intCont))
            Else
            Begin
              TfrxMemoView(frxRel.FindObject('rllMes' + fStrZero(intCont + 1,2))).Visible := False;
              TfrxMemoView(frxRel.FindObject('rdbMes' + fStrZero(intCont + 1,2))).Visible := False;
              TfrxMemoView(frxRel.FindObject('rdbGru' + fStrZero(intCont + 1,2))).Visible := False;
              TfrxMemoView(frxRel.FindObject('rdbLin' + fStrZero(intCont + 1,2))).Visible := False;
              TfrxMemoView(frxRel.FindObject('rdbTot' + fStrZero(intCont + 1,2))).Visible := False;
            End;

          End;

          If edtDestino.Text = 'V' Then
            frxRel.ShowReport

          Else If (edtDestino.Text = 'E') Then
            pGeraExcel(qryRelatorio)

          Else If frxRel.PrepareReport Then
            frxRel.Print;

        Except
          On E: Exception Do
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
        End;

        FreeAndNil(frmQckCtpTitContasAno);

      End

      Else
        pTabelaVazia;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[btnImprimir]');
    End;

  End;

  pnlInfo.Caption := '';
  btnImprimir.Enabled := True;
end;

function TfrmRelCtpTitContasAno.fRetSql: String;
  Var
    strSQL  : String;
    strUnion: String;
    intQtdMes: Integer;
Begin

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

  For intQtdMes := 1 To 12 Do
  Begin
    Case rdgTipoData.ItemIndex Of
      0 : strSQL := strSQL + ' SUM(IF(P.CTP_DTACAD BETWEEN :DTAIN' + IntToStr(intQtdMes) + ' AND :DTAFI' + IntToStr(intQtdMes) + ', VAPG, 0)) AS VALPA' + IntToStr(intQtdMes) + ', ';
      1 : strSQL := strSQL + ' SUM(IF(P.CTP_DTAVEN BETWEEN :DTAIN' + IntToStr(intQtdMes) + ' AND :DTAFI' + IntToStr(intQtdMes) + ', VAPG, 0)) AS VALPA' + IntToStr(intQtdMes) + ', ';
      2 : strSQL := strSQL + ' SUM(IF(P.CTP_DTAPAG BETWEEN :DTAIN' + IntToStr(intQtdMes) + ' AND :DTAFI' + IntToStr(intQtdMes) + ', VAPG, 0)) AS VALPA' + IntToStr(intQtdMes) + ', ';
    End;
  End;

  strSQL := strSQL + '  IF(D.CTP_CODCTA IS NULL, P.CTP_CODCTA, D.CTP_CODCTA) AS CTP_CODCTA, ';

  If (rdgTipQue.ItemIndex = 1) Or chkMosEve.Checked Then
    strSQL := strSQL + '  P.CTP_CODEVE  '
  Else
    strSQL := strSQL + ' "" AS CTP_CODEVE ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPAG P ';
  strSQL := strSQL + '  INNER JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ';
  strSQL := strSQL + '  INNER JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
  strSQL := strSQL + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
  strSQL := strSQL + '                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
  strSQL := strSQL + '                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
  strSQL := strSQL + '  LEFT JOIN CTARES R ON R.CRE_CODCTA = ABRV ';
  strSQL := strSQL + '  LEFT JOIN CTAGER G ON R.CRE_CODCRE = G.CRE_CODCRE ';

  strSQL := strSQL + '  LEFT JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA ';
  strSQL := strSQL + 'WHERE ';

  Case rdgTipoData.ItemIndex Of
    0 : strSQL := strSQL + '  P.CTP_DTACAD BETWEEN :DTAINI AND :DTAFIN ';
    1 : strSQL := strSQL + '  P.CTP_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';
    2 : strSQL := strSQL + '  P.CTP_DTAPAG BETWEEN :DTAINI AND :DTAFIN ';
  End;

  {**************************}
  {* FILTRO POR COMPETÊNCIA *}
  {************************BB}
  if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
    strSQL := strSQL + '  AND CTP_COMPET = :COMPET ';

  pFiltroCentroCusto(strSQL);

  strSQL := strSQL + fStrLocate(edtCodEmpresa,  arrEmpresa,  'IF(D.CTP_CODCTA IS NULL, P.CTP_CODEMP, D.CTP_CODEMP)', 'CODEMP');

  strSql := strSQL + fStrLocate(edtCodEve,  arrEvento,  'IF(D.CTP_CODCTA IS NULL, P.CTP_CODEVE, D.CTP_CODEVE)', 'CODEVE');

  If edtContas.Text = 'A' Then
    strSQL := strSQL + ' AND P.CTP_DTAPAG IS NULL '
  Else If edtContas.Text = 'Q' Then
    strSQL := strSQL + ' AND P.CTP_DTAPAG IS NOT NULL ';

    If edtContas.Text = 'T' Then
    Begin

      strSQL := AnsiReplaceStr(AnsiReplaceStr(strSQL,'VAPG','ROUND(' +
              ' IF(P.CTP_DTAPAG IS NULL, P.CTP_VALDUP, P.CTP_VALPAG) ' +
              ' * D.CTP_FATCAL,2)'), 'ABRV', 'D.CTP_CODCTA') +
              ' GROUP BY ' + IfThen((rdgTipQue.ItemIndex = 1) Or chkMosEve.Checked,
               'P.CTP_CODEVE, ', '') + ' CTP_CODCTA UNION ALL '
              + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL,
              'INNER','LEFT'),'VAPG',
              ' IF(P.CTP_DTAPAG IS NULL, P.CTP_VALDUP, P.CTP_VALPAG) ' ),
              'ABRV', 'P.CTP_CODCTA') + ' AND D.CTP_CODCTA IS NULL GROUP BY ' +
               ifthen((rdgTipQue.ItemIndex = 1) Or chkMosEve.Checked ,
              ' P.CTP_CODEVE, ', '') + ' CTP_CODCTA ';
    End
    Else
    Begin

      strSQL := AnsiReplaceStr(AnsiReplaceStr(strSQL,'VAPG','ROUND(' +
               IfThen(edtContas.Text = 'A', 'P.CTP_VALDUP',' P.CTP_VALPAG') +
              ' * D.CTP_FATCAL,2)'), 'ABRV', 'D.CTP_CODCTA') +
              ' GROUP BY ' + IfThen((rdgTipQue.ItemIndex = 1) Or chkMosEve.Checked,
               'P.CTP_CODEVE, ', '') + ' CTP_CODCTA UNION ALL '
              + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL,
              'INNER','LEFT'),'VAPG',IfThen(edtContas.Text = 'A', 'P.CTP_VALDUP',
              ' P.CTP_VALPAG')), 'ABRV', 'P.CTP_CODCTA') +
              ' AND D.CTP_CODCTA IS NULL GROUP BY ' +
               ifthen((rdgTipQue.ItemIndex = 1) Or chkMosEve.Checked ,
              ' P.CTP_CODEVE, ', '') + ' CTP_CODCTA ';
    End;

  strUnion := strSQL;

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';

  strSQL := strSQL + '  CONCAT(LEFT(CTP_CODCTA,2),".00.000") AS LINHA, ';
  strSQL := strSQL + '  CONCAT(LEFT(CTP_CODCTA,2),".",RIGHT(LEFT(CTP_CODCTA,4),2),".000") AS GRUPO, ';

  strSQL := strSQL + '  "" AS ESPACO, ';
  strSQL := strSQL + '  CONCAT(LEFT(CTP_CODCTA,2),".00.000", "-", L.CTA_DESCTA)                              AS LINHA_EXCEL, ';
  strSQL := strSQL + '  CONCAT(LEFT(CTP_CODCTA,2),".",RIGHT(LEFT(CTP_CODCTA,4),2),".000", "-", U.CTA_DESCTA) AS GRUPO_EXCEL, ';

  strSQL := strSQL + '  L.CTA_DESCTA AS DESLIN,   ';
  strSQL := strSQL + '  U.CTA_DESCTA AS DESGRU,   ';

  If rdgTipQue.ItemIndex = 1 Then
  Begin
    strSQL := strSQL + '  CTP_CODEVE AS CODEVE,   ';
    strSQL := strSQL + '  CONCAT(CTP_CODEVE, "-", EVE_DESEVE) AS DESEVE, ';
    strSQL := strSQL + '  CONCAT(CTP_CODEVE, "-", EVE_DESEVE)                                                AS EVENT_EXCEL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  "" AS CODEVE,   ';
    strSQL := strSQL + '  "" AS DESEVE, ';
    strSQL := strSQL + '  ""                                                                                 AS EVENT_EXCEL, ';
  End;

  If rdgTipRel.ItemIndex = 0 Then
  Begin
    strSQL := strSQL + '  CTP_CODCTA AS CONTA,      ';
    strSQL := strSQL + '  T.CTA_DESCTA AS DESCTA,   ';
    strSQL := strSQL + '  CONCAT(CTP_CODCTA, "-", T.CTA_DESCTA)                                              AS CONTA_EXCEL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  CONCAT(LEFT(CTP_CODCTA,2),".",RIGHT(LEFT(CTP_CODCTA,4),2),".000") AS CONTA, ';
    strSQL := strSQL + '  U.CTA_DESCTA AS DESCTA,   ';
    strSQL := strSQL + '  CONCAT(LEFT(CTP_CODCTA,2),".",RIGHT(LEFT(CTP_CODCTA,4),2),".000","-",U.CTA_DESCTA) AS CONTA_EXCEL, ';
  End;

  If chkMosEve.Checked Then
  Begin
    strSQL := strSQL + '  CTP_CODCTA                            AS CODCTA, ';
    strSQL := strSQL + '  CONCAT(CTP_CODCTA, "-", T.CTA_DESCTA) AS DESCON, ';

    strSQL := strSQL + '  CONCAT(CTP_CODEVE, "-", EVE_DESEVE) AS NOMEVE, ';
    strSQL := strSQL + '  CTP_CODEVE                          AS DETEVE, ';
    strSQL := strSQL + '  CONCAT(CTP_CODEVE, "-", EVE_DESEVE)                                                AS EVENT_EXCEL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  ""   AS CODCTA,    ';
    strSQL := strSQL + '  ""   AS DESCON,    ';

    strSQL := strSQL + '  "" AS NOMEVE, ';
    strSQL := strSQL + '  "" AS DETEVE, ';
    strSQL := strSQL + '  ""                                                                                 AS EVENT_EXCEL, ';
  End;

  For intQtdMes := 1 To 12 Do
    strSQL := strSQL + ' SUM(VALPA' + IntToStr(intQtdMes) + ') AS VALPA' + IntToStr(intQtdMes) + ', ';

  strSQL := strSQL + ' SUM( ';
  For intQtdMes := 1 To StrToIntDef(edtQtdMes.Text, 0) Do
  Begin
    If intQtdMes <> StrToIntDef(edtQtdMes.Text, 0) Then
      strSQL := strSQL + ' VALPA' + IntToStr(intQtdMes) + ' + '
    Else
      strSQL := strSQL + ' VALPA' + IntToStr(intQtdMes)
  End;

  strSQL := strSQL + ' ) AS VALPAG ';

  strSQL := strSQL + ' FROM (';

  strSQL := strSQL + strUnion;

  strSQL := strSQL + ' ) AS TAB ';

  strSQL := strSQL + '  LEFT JOIN CADCTA L ON L.CTA_CODCTA = CONCAT(LEFT(CTP_CODCTA,2),"00000") ';
  strSQL := strSQL + '  LEFT JOIN CADCTA U ON U.CTA_CODCTA = CONCAT(LEFT(CTP_CODCTA,4),  "000") ';
  strSQL := strSQL + '  LEFT JOIN CADCTA T ON T.CTA_CODCTA = CTP_CODCTA ';

  If (rdgTipQue.ItemIndex = 1) Or chkMosEve.Checked  Then
    strSQL := strSQL + '  LEFT JOIN CADEVE ON EVE_CODEVE = CTP_CODEVE ';

  If rdgTipRel.ItemIndex = 0 Then
  Begin

    If chkMosEve.Checked Then
    Begin
      strSQL := strSQL + ' GROUP BY CTP_CODCTA, DETEVE ';
      strSQL := strSQL + ' ORDER BY CTP_CODCTA, DETEVE ';
    End Else
    Begin
      strSQL := strSQL + ' GROUP BY ' + ifthen((rdgTipQue.ItemIndex = 1) Or chkMosEve.Checked, 'CTP_CODEVE, ', '') + ' CTP_CODCTA ';
      strSQL := strSQL + ' ORDER BY ' + ifthen((rdgTipQue.ItemIndex = 1) Or chkMosEve.Checked, 'CTP_CODEVE, ', '') + ' CTP_CODCTA ';
    End

  End Else
  Begin
    strSQL := strSQL + ' GROUP BY ' + ifthen((rdgTipQue.ItemIndex = 1) Or chkMosEve.Checked, 'CTP_CODEVE, ', '') + ' LEFT(CTP_CODCTA, 4) ';
    strSQL := strSQL + ' ORDER BY ' + ifthen((rdgTipQue.ItemIndex = 1) Or chkMosEve.Checked, 'CTP_CODEVE, ', '') + ' LEFT(CTP_CODCTA, 4) ';
  End;

  Result := strSQL;

End;

procedure TfrmRelCtpTitContasAno.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskMesBas);
end;

procedure TfrmRelCtpTitContasAno.FormCreate(Sender: TObject);
begin
  inherited;
  mskMesBas.Text := FormatDateTime('mm/yyyy',VS_Date);
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;
end;

procedure TfrmRelCtpTitContasAno.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryRelatorio);
end;

function TfrmRelCtpTitContasAno.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If Sender = mskMesBas Then
  Begin

    If fEmptyStr(mskMesBas.Text) Then
    Begin
      fMensagem('','O mês base deve ser preenchido!',['&OK']);
      Result := False;
    End
    Else
    Begin

      Try
        StrToDate('01/' + mskMesBas.Text);
      Except
        fMensagem('','O mês base não é válido!',['&OK']);
        Result := False;
      End;

    End;

  End

  Else If Sender = edtQtdMes Then
  Begin

    If fEmptyStr(edtQtdMes.Text) Then
    Begin
      fMensagem('','A quantidade de meses não pode ser vazia!',['&OK']);
      Result := False;
    End
    Else If (StrToInt(edtQtdMes.Text) > 12) Or (StrToInt(edtQtdMes.Text) < 1) Then
    Begin
      fMensagem('','A quantidade de meses deve estar entre 1 e 12!',['&OK']);
      Result := False;
    End;

  End

  Else If (Sender = edtDestino) Then
  Begin
    If fEmptyStr(edtDestino.Text) Or (Pos(edtDestino.Text, 'V_I_E_') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Destino do Relatório deve ser "V", "I" ou "E"!', ['&O k']);
      Result := False;
    End;
  End

  Else if (Sender = mskCompet) then
  Begin

    if not fEmptyStr(fTiraCaracEspeciais(mskCompet.Text)) then
    begin

      If not fValidaDataStr('01/'+ mskCompet.Text) Then
      Begin
        pMensagemOk('Data informada na Competência não é válida!');
        Result := False;
      End;

    end;

  End

  Else If (Sender = mskContaIni) Then
  Begin
    If (fEmptyStr(mskContaIni.Text)) Or
       (Length(arrContaIni) > 1)     Then
    Begin
      mskContaFin.Clear;
      mskContaFin.Enabled := False;
      edtDesContaFin.Text := 'TODOS'
    End
    Else
    Begin
      mskContaFin.Enabled := True;
      edtDesContaIni.Text := fRetNomeConta(mskContaIni.Text);
    End;

    If fEmptyStr(edtDesContaIni.Text) And (Not fEmptyStr(mskContaIni.Text))  Then
    Begin
      Result := False;
      fMensagem('AVISO','Código da Conta não encontrado.', ['&O K']);
      mskContaIni.Clear;
    End;
  End

  Else If (Sender = mskContaFin) Then
  Begin

    If fEmptyStr(mskContaFin.Text) Then
      edtDesContaFin.Text := 'TODOS'
    Else
      edtDesContaFin.Text := fRetNomeConta(mskContaFin.Text);

    If mskContaFin.Enabled Then
    Begin
      If fEmptyStr(edtDesContaFin.Text) And (Not fEmptyStr(mskContaFin.Text))  Then
      Begin
        Result:= False;
        fMensagem('AVISO','Código da Conta não encontrado.', ['&O K']);
        mskContaFin.Clear;
      End
      Else If mskContaFin.Text < mskContaIni.Text Then
      Begin
        Result := False;
        fMensagem('AVISO','Código da Conta final não pode ser menor que o código da conta inicial.', ['&O K']);
      End;
    End;
  End

  Else If (Sender = edtContas) Then
  Begin
    If (edtContas.Text <> 'T') And (edtContas.Text <> 'A') And (edtContas.Text <> 'Q') Then
    Begin
      fMensagem('ATENÇÃO!','O campo Contas deve ser T,A ou Q.',['&O K']);
      Result := False;
    End;
  End

  Else If (Sender = edtCodEmpresa) Then
  Begin
    pDesmarcaLista(edtCodEmpresa, arrEmpresa);

    If Not fEmptyStr(edtCodEmpresa.Text) And (edtCodEmpresa.Text <> '000') Then
    Begin
      If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtCodEve) Then
  Begin
    pDesmarcaLista(edtCodEve, arrEvento);
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelCtpTitContasAno.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If ActiveControl Is TRadioButton Then
                 Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelCtpTitContasAno.FormShow(Sender: TObject);
begin
  inherited;
  pCriaQryRelatorio;
end;

procedure TfrmRelCtpTitContasAno.rdgTipQueClick(Sender: TObject);
begin
  inherited;

  chkQuePag.Enabled := rdgTipQue.ItemIndex = 1;
  If Not chkQuePag.Enabled Then
    chkQuePag.Checked := False;

  chkMosEve.Enabled := (rdgTipQue.ItemIndex = 0) And (rdgTipRel.ItemIndex = 0);
  If Not chkMosEve.Enabled Then
    chkMosEve.Checked := False;

end;

procedure TfrmRelCtpTitContasAno.rdgTipRelClick(Sender: TObject);
begin
  inherited;

  chkMosEve.Enabled := (rdgTipQue.ItemIndex = 0) And (rdgTipRel.ItemIndex = 0);
  If Not chkMosEve.Enabled Then
    chkMosEve.Checked := False;

end;

end.

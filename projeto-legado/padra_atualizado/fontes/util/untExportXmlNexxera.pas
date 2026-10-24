unit untExportXmlNexxera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, ComCtrls, StdCtrls, Mask, DirectoryEditFocus, untTypesSistema,
  AppEvnts, Menus, Buttons, ExtCtrls, Uni, ComboBoxFocus, StrUtils, MaskEditFocus,
  EditFocus, XMLDoc, XMLIntf, untFuncoesSimples, BitBtnLockedIncrem, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit,
  frxClass, frxExportCSVTestabilidade, 
  untFrameDirectoryEditFocus;

type
  TfrmExportXmlNexxera = class(TfrmPai)
    pnlGeral: TPanel;
    pgbProgresso: TProgressBar;
    pnlTopo: TPanel;
    pnlMeio: TPanel;
    pnlBase: TPanel;
    lblDtaIni: TLabel;
    lblCodEmp: TLabel;
    lbl1: TLabel;
    mskDtaIni: TMaskEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtNomArq: TEditFocus;
    lbl2: TLabel;
    lblPatExp: TLabel;
    edtNomCli: TEditFocus;
    edtCodCli: TEditFocus;
    lbl3: TLabel;
    rdgCodIte: TRadioGroup;
    lblAlerta: TLabel;
    lblAlerta2: TLabel;
    lbl4: TLabel;
    edtDocExc: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    fraPatExp: TfraDirectoryEditFocus;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtDocExcKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    xmlDoc   : TXMLDocument;
    xmlAtual : IXMLNode;
    strPatXml: String;
    strDocExc: String;

    arrFornec: TConsultasArray;
    strFornec: String;

    qryItens : TUniQuery;
    qryClaFis: TUniQuery;
    qryCadEmp: TUniQuery;

    procedure pLeEmpresa;

    function fProcurarElemento(ElementoPai: IXMLNode; strNome: String): IXMLNode;
    function fRetornaClaFisNota(strAutInc: String): String;
    function fGetCnpjEmpMatriz(strEmpresa, strCnpj: String): String;    
  protected
    function fXmlGeraArq(Var xmlNo: IXMLNode): Boolean;
    function fXmlGeraDadosArq(Var xmlNo: IXMLNode; intOpcao: Integer; qryDados: TUniQuery): Boolean;
    function fXmlGeraIdentificaArq(Var xmlNo: IXMLNode; qryDados: TUniQuery): Boolean;
    function fXmlGeraIdentificaEmpreArq(Var xmlNo: IXMLNode; qryDados: TUniQuery): Boolean;
    function fXmlGeraIdentificaDestinatarArq(Var xmlNo: IXMLNode; qryDados: TUniQuery): Boolean;
    function fXmlGeraDadosDocumentosArq(Var xmlNo: IXMLNode; qryDados: TUniQuery): Boolean;
    function fXmlGeraDetalheDocArq(Var xmlNo: IXMLNode; qryDados: TUniQuery): Boolean;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    arrCliente: TConsultasArray;

    destructor Destroy; override;
  end;

implementation

uses untFuncoesConsulta, MaskUtils, DateUtils, untConsultas,
  untListDocsNaoExpNexxera, Data.DB;

{$R *.dfm}

destructor TfrmExportXmlNexxera.Destroy;
begin
  If Assigned(xmlDoc) Then FreeAndNil(xmlDoc);
  inherited;
end;

function TfrmExportXmlNexxera.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  //#Asimov# inherited fValidaCampos
  If not (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Exit(False);
  //
  Result := True;

  If (Sender = mskDtaIni) Then
  Begin

    If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
    Begin
      Try
        StrToDate('01/' + mskDtaIni.Text);
      Except
        On E: Exception Do
        Begin
          fMensagem('ATENÇÃO!', 'Período de referência é inválido!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'O período de referência deve ser preenchido!', ['&Ok']);
      Result := False;
    End;

  End
  Else If (Sender = edtCodFor) Then
  Begin

    If fEmptyStr(edtCodFor.Text) Then
    Begin
      edtNomFor.Text := 'TODOS';
    End;

  End
  Else If (Sender = edtCodEmp) Then
  Begin

    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      pMensagemOk('Informe o código da Empresa!');
      Result := False;
    End Else
    Begin
      edtNomEmp.Text := fRetNomeEmpresa(edtCodEmp.Text);

      If fEmptyStr(edtNomEmp.Text) Then
      Begin
        pMensagemOk('Empresa não encontrada!');
        Result := False;
      End;
    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmExportXmlNexxera.pLeEmpresa;
Begin
  With qryCadEmp, SQL Do
  Begin
    Clear;
    Add('SELECT ');
    Add('  EMP_C_G_C_   ');
    Add('FROM CADEMP   ');
    Add('WHERE          ');
    Add('  EMP_CODEMP = :CODEMP ');

    ParamByName('CODEMP').AsString := edtCodEmp.Text;

    Open;
  End;
End;

procedure TfrmExportXmlNexxera.btnConfirmaDadosClick(Sender: TObject);
  Var
    strArqXml: String;
    blnGerou : Boolean;
    intCont  : Integer;
    strLinCli: String;
begin
  If fEmptyStr(fraPatExp.edtDirectory.text) Then
    Exit;

  inherited;

  If Not DirectoryExists(fraPatExp.edtDirectory.text) Then
  Begin
    If fMensagem('ATENÇÃO!', 'O Path informado não existe, deseja criá-lo?', ['&Sim', '&Não']) = 1 Then
      CreateDir(fraPatExp.edtDirectory.text)
    Else
      Exit;
  End;

  btnConfirmaDados.Enabled := False;
  btnSair.Enabled := False;

  (*************************************************)
  (* PARA SAIR O CGC DA EMPRESA NO NOME DO ARQUIVO *)
  (* QUANDO NAO HOUVER MOVIMENTO                   *)
  (*************************************************)
  pLeEmpresa;

  qryItens.SQL.Clear;

  qryItens.SQL.Add('SELECT  SQL_NO_CACHE           ');
  qryItens.SQL.Add('   EMP_C_G_C_,                 ');
  qryItens.SQL.Add('   YEAR(D.DET_DTAENT) AS ANO,  ');
  qryItens.SQL.Add('   MONTH(D.DET_DTAENT) AS MES, ');
  qryItens.SQL.Add('   D.DET_DTAENT,      ');
  qryItens.SQL.Add('   D.DET_CODEMP,      ');
  qryItens.SQL.Add('   G.GER_CODCLI,      ');
  qryItens.SQL.Add('   G.GER_CGCCON,      ');
  qryItens.SQL.Add('   G.GER_CODVEN,      ');
  qryItens.SQL.Add('   O.OPE_NOMOPE,      ');
  qryItens.SQL.Add('   " " AS DET_CNAERV, ');
  qryItens.SQL.Add('   G.AUTOINCREM,      ');
  qryItens.SQL.Add('   G.GER_NUMDOC,      ');
  qryItens.SQL.Add('   G.GER_ESPDOC,      ');
  qryItens.SQL.Add('   G.GER_VLRCON,      ');
  qryItens.SQL.Add('   G.GER_CONPAG,      ');
  qryItens.SQL.Add('   I.ITE_CODFAB,      ');
  qryItens.SQL.Add('   D.DET_CODITE,      ');
  qryItens.SQL.Add('   D.DET_QTDITE,      ');
  qryItens.SQL.Add('   U.UNI_SIGUNI,      ');
  qryItens.SQL.Add('   D.DET_UNITAR       ');
  qryItens.SQL.Add('FROM        ');
  qryItens.SQL.Add('   MOVDET D ');
  qryItens.SQL.Add('   INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER ');
  qryItens.SQL.Add('   INNER JOIN CADEMP E ON E.EMP_CODEMP = D.DET_CODEMP ');
  qryItens.SQL.Add('   INNER JOIN CADCLI C ON C.CLI_CODCLI = G.GER_CODCLI ');
  qryItens.SQL.Add('   INNER JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE ');
  qryItens.SQL.Add('    LEFT JOIN CADOPE O ON O.OPE_CODOPE = G.GER_CODVEN ');
  qryItens.SQL.Add('    LEFT JOIN CADUNI U ON U.UNI_CODUNI = D.DET_UNIDAD ');
  qryItens.SQL.Add('WHERE       ');
  qryItens.SQL.Add('   D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ');

  If Not fEmptyStr(edtCodEmp.Text) Then
    qryItens.SQL.Add('   AND D.DET_CODEMP = :CODEMP ')
  Else qryItens.SQL.Add('   AND LOCATE(D.DET_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ');

  If Not fEmptyStr(edtCodFor.Text) Then
    qryItens.SQL.Add( fStrLocate(edtCodFor, arrFornec, 'I.ITE_CODFOR', 'CODFOR') );

  If pnlMeio.Visible Then
    qryItens.SQL.Add( fStrLocate(edtCodCli, arrCliente, 'G.GER_CODCLI', 'CODCLI', False, True) );

  qryItens.SQL.Add('   AND D.DET_PROEMB <> "S"    ');
  qryItens.SQL.Add('   AND D.DET_TIP_FC = "C"     ');
  qryItens.SQL.Add('   AND C.CLI_CGCCPF = "1"     ');
  qryItens.SQL.Add('   AND G.GER_CODCLI NOT IN (' + VS_strCliFil + ') ');
  qryItens.SQL.Add('   AND D.DET_ESPDOC NOT IN ("FF", "TR", "DV")     ');
  qryItens.SQL.Add('   AND ( ( LOCATE(D.DET_CLAFIS, :CLAVEN) > 0 ) OR ( LOCATE(D.DET_CLAFIS, :CLADEV) > 0 ) ) ');
  qryItens.SQL.Add('ORDER BY         ');
  qryItens.SQL.Add('   ANO,          ');
  qryItens.SQL.Add('   MES,          ');
  qryItens.SQL.Add('   D.DET_CODEMP, ');
  qryItens.SQL.Add('   G.GER_CODCLI, ');
  qryItens.SQL.Add('   G.GER_CODVEN, ');
  qryItens.SQL.Add('   D.DET_DTAENT, ');
  qryItens.SQL.Add('   D.DET_ESPDOC, ');
  qryItens.SQL.Add('   D.DET_NUMDOC, ');
  qryItens.SQL.Add('   D.DET_CODITE  ');

  qryItens.ParamByName('DTAINI').AsDate   := StrToDate('01/' + mskDtaIni.Text);
  qryItens.ParamByName('DTAFIN').AsDate   := StrToDate(fStrZero(DaysInMonth(StrToDate('01/'+mskDtaIni.Text)),2)+'/'+mskDtaIni.Text);
  qryItens.ParamByName('CLAVEN').AsString := VS_strClaVen;
  qryItens.ParamByName('CLADEV').AsString := VS_strClaDev;

  If Not fEmptyStr(edtCodEmp.Text) Then
    qryItens.ParamByName('CODEMP').AsString := edtCodEmp.Text;

  If Not fEmptyStr(edtCodFor.Text) Then
    pSetaParam(edtCodFor.Text, arrFornec, strFornec, 'CODFOR', qryItens);

  If pnlMeio.Visible Then
    pSetaParam(edtCodCli.Text, arrCliente, strLinCli, 'CODCLI', qryItens);

  qryItens.Open;

  pgbProgresso.Max := qryItens.RecordCount;
  pgbProgresso.Position := 0;

  xmlDoc := TXMLDocument.Create(Self);
  xmlDoc.Options := [doNodeAutoCreate, doNodeAutoIndent, doAutoPrefix, doNamespaceDecl];

  strPatXml := fraPatExp.edtDirectory.text + '\';

  If Not fEmptyStr(edtNomArq.Text) then
    strPatXml := strPatXml + fTiraCaracEspeciais(edtNomArq.Text) + '.';

  If fCfgSis('EMPGER',varBoolean, edtCodEmp.Text) Then
    strPatXml := strPatXml + 'mat_'
  Else
    strPatXml := strPatXml + 'fil_';

  strArqXml := strPatXml + Trim(RightStr(FormatDateTime('YYYY', StrToDate('01/'+mskDtaIni.Text)),4)
                               + fStrZero(LeftStr(mskDtaIni.Text,2), 2))
                               + '.cnpj.' + fTiraCaracEspeciais(qryCadEmp.FieldByName('EMP_C_G_C_').AsString)
                               + '.XML';

  xmlDoc.Active := True;
  xmlDoc.Version := '1.0';
  xmlDoc.Encoding := 'UTF-8';

  blnGerou := fXmlGeraArq(xmlAtual);
  While (Not qryItens.Eof) Do
  Begin
    For intCont := 1 to 3 Do
      blnGerou := blnGerou And fXmlGeraDadosArq(xmlAtual, intCont, qryItens);
  End;

  If blnGerou Then
    xmlDoc.SaveToFile(strArqXml);

  fMensagem('ATENÇÃO!', 'Arquivo gerado com sucesso! Anote o caminho: ' + #13#10 + strArqXml, ['&Ok']);

  btnConfirmaDados.Enabled := True;
  btnSair.Enabled := True;
  pgbProgresso.Position := 0;
end;

function TfrmExportXmlNexxera.fXmlGeraArq(Var xmlNo: IXMLNode): Boolean;
begin
  xmlDoc.AddChild('distribuidor_movimento_faturamento');
  xmlNo := fProcurarElemento(xmlDoc.Node, 'distribuidor_movimento_faturamento');
  Result := True;
end;

function TfrmExportXmlNexxera.fXmlGeraDadosArq(Var xmlNo: IXMLNode; intOpcao: Integer; qryDados: TUniQuery): Boolean;
begin

  If intOpcao = 1 Then
    Result := fXmlGeraIdentificaArq(xmlNo, qryDados)
  Else If intOpcao = 2 Then
    Result := fXmlGeraIdentificaEmpreArq(xmlNo, qryDados)
  Else
    Result := fXmlGeraIdentificaDestinatarArq(xmlNo, qryDados);

end;

function TfrmExportXmlNexxera.fXmlGeraIdentificaArq(Var xmlNo: IXMLNode; qryDados: TUniQuery): Boolean;
begin
  // "movimento_dados"
  xmlNo := xmlNo.AddChild('movimento_dados');
  xmlNo.AddChild('ano_arquivo').NodeValue := qryDados.FieldByName('ANO').AsString;
  xmlNo.AddChild('mes_arquivo').NodeValue := fStrZero(qryDados.FieldByName('MES').AsString,2);
  xmlNo := xmlNo.ParentNode;

  Result := True;
end;

function TfrmExportXmlNexxera.fXmlGeraIdentificaEmpreArq(Var xmlNo: IXMLNode; qryDados: TUniQuery): Boolean;
begin
  // "distribuidor_dados"
  xmlNo := xmlNo.AddChild('distribuidor_dados');

  xmlNo.AddChild('cnpj_distribuidor').NodeValue := fGetCnpjEmpMatriz(qryDados.FieldByName('DET_CODEMP').AsString, qryDados.FieldByName('EMP_C_G_C_').AsString);
  xmlNo.AddChild('centro_distribuicao').NodeValue := qryDados.FieldByName('EMP_C_G_C_').AsString;

  xmlNo := xmlNo.ParentNode;

  Result := True;
end;

function TfrmExportXmlNexxera.fXmlGeraIdentificaDestinatarArq(Var xmlNo: IXMLNode; qryDados: TUniQuery): Boolean;
Var strCodEmp: String;
    strMesRef: String;
    strAnoRef: String;
    blnOk: Boolean;
begin
  blnOk := False;

  // "revenda"
  xmlNo := xmlNo.AddChild('revendas');

  strCodEmp := qryDados.FieldByName('DET_CODEMP').AsString;
  strMesRef := qryDados.FieldByName('MES').AsString;
  strAnoRef := qryDados.FieldByName('ANO').AsString;
  While (qryDados.FieldByName('DET_CODEMP').AsString = strCodEmp) And
        (qryDados.FieldByName('MES').AsString = strMesRef) And
        (qryDados.FieldByName('ANO').AsString = strAnoRef) And (Not qryDados.Eof) Do
  Begin
    xmlNo := xmlNo.AddChild('revenda_dados');
    xmlNo.AddChild('cnpj_revenda').NodeValue     := IIF( qryDados.FieldByName('EMP_C_G_C_').IsNull, ' ',
                                                         fTiraCaracEspeciais(qryDados.FieldByName('EMP_C_G_C_').AsString) );
    xmlNo.AddChild('vendedor_revenda').NodeValue := IIF( qryDados.FieldByName('OPE_NOMOPE').IsNull, ' ',
                                                         fPadR(qryDados.FieldByName('OPE_NOMOPE').AsString,30) );
    xmlNo.AddChild('cnae_revenda').NodeValue     := '  ';
    blnOk := fXmlGeraDadosDocumentosArq(xmlNo, qryDados);
    xmlNo := xmlNo.ParentNode; // nível "revenda_dados"
  End;

  xmlNo := xmlNo.ParentNode; // nível "revenda"
  Result := blnOk;
end;

function TfrmExportXmlNexxera.fXmlGeraDadosDocumentosArq(Var xmlNo: IXMLNode; qryDados: TUniQuery): Boolean;
Var strCodCli: String;
    strCodVen: String;
    strClaFis: String;
    blnOk: Boolean;
begin
  blnOk := False;

  // "notas"
  xmlNo := xmlNo.AddChild('notas');

  strCodCli := qryDados.FieldByName('GER_CODCLI').AsString;
  strCodVen := IIF( qryDados.FieldByName('GER_CODVEN').IsNull, ' ', qryDados.FieldByName('GER_CODVEN').AsString );
  While (qryDados.FieldByName('GER_CODCLI').AsString = strCodCli) And
        (IIF( qryDados.FieldByName('GER_CODVEN').IsNull, ' ', qryDados.FieldByName('GER_CODVEN').AsString ) = strCodVen) And
        (Not qryDados.Eof) Do
  Begin
    strClaFis := fRetornaClaFisNota(qryDados.FieldByName('AUTOINCREM').AsString);

    xmlNo := xmlNo.AddChild('nota_fiscal');
    xmlNo.AddChild('nota_numero').NodeValue             := RightStr(qryDados.FieldByName('GER_NUMDOC').AsString,9);
    xmlNo.AddChild('nota_tipo_nota').NodeValue          := strClaFis; //qryDados.FieldByName('GER_ESPDOC').AsString;
    xmlNo.AddChild('nota_valor_total').NodeValue        := AnsiReplaceStr(FloatToStr(qryDados.FieldByName('GER_VLRCON').AsFloat),',','.');
    xmlNo.AddChild('nota_condicao_pagamento').NodeValue := qryDados.FieldByName('GER_CONPAG').AsString;
    blnOk := fXmlGeraDetalheDocArq(xmlNo, qryDados);
    xmlNo := xmlNo.ParentNode; // nível "nota_fiscal"
  End;

  xmlNo := xmlNo.ParentNode; // nível "notas"

  Result := blnOk;
end;

function TfrmExportXmlNexxera.fXmlGeraDetalheDocArq(Var xmlNo: IXMLNode; qryDados: TUniQuery): Boolean;
Var strNumDoc: String;
begin

  // "itens"
  xmlNo := xmlNo.AddChild('itens');

  strNumDoc := qryDados.FieldByName('GER_NUMDOC').AsString;
  While (qryDados.FieldByName('GER_NUMDOC').AsString = strNumDoc) And (Not qryDados.Eof) Do
  Begin
    xmlNo := xmlNo.AddChild('nota_item');
    If (rdgCodIte.ItemIndex = 0) Then
      xmlNo.AddChild('codigo_produto').NodeValue := IIF( qryDados.FieldByName('DET_CODITE').IsNull, ' ',
                                                         qryDados.FieldByName('DET_CODITE').AsString )
    Else
      xmlNo.AddChild('codigo_produto').NodeValue := IIF( qryDados.FieldByName('ITE_CODFAB').IsNull, ' ',
                                                         qryDados.FieldByName('ITE_CODFAB').AsString );
    xmlNo.AddChild('quantidade').NodeValue     := AnsiReplaceStr(FloatToStr(qryDados.FieldByName('DET_QTDITE').AsFloat),',','.');
    xmlNo.AddChild('unidade').NodeValue        := IIF( qryDados.FieldByName('UNI_SIGUNI').IsNull, ' ',
                                                       qryDados.FieldByName('UNI_SIGUNI').AsString );
    xmlNo.AddChild('valor_unitario').NodeValue := AnsiReplaceStr(FloatToStr(qryDados.FieldByName('DET_UNITAR').AsFloat),',','.');
    xmlNo := xmlNo.ParentNode; // nível "nota_item"
    qryDados.Next;
    pgbProgresso.StepBy(1);
  End;

  xmlNo := xmlNo.ParentNode; // nível "itens"
  Result := True;

end;

function TfrmExportXmlNexxera.fProcurarElemento(ElementoPai: IXMLNode;
  strNome: String): IXMLNode;
begin
  If ElementoPai = nil Then
  Begin
    Result := nil;
    Exit;
  End;

  If ElementoPai.LocalName = strNome Then
  Begin
    Result := ElementoPai;
    Exit;
  End;

  Result := fProcurarElemento(ElementoPai.ChildNodes.First, strNome);
  If Result <> nil Then
  Begin
    Exit;
  End;

  Result := fProcurarElemento(ElementoPai.NextSibling, strNome);
  If Result <> nil Then
  Begin
    Exit;
  End;

  Result := nil;
end;

function TfrmExportXmlNexxera.fRetornaClaFisNota(strAutInc: String): String;
Var strClaFis: String;
    strAux   : String;
begin
  strClaFis := '';

  qryClaFis.SQL.Clear;
  qryClaFis.SQL.Add('SELECT       ');
  qryClaFis.SQL.Add('  DISTINCT   ');
  qryClaFis.SQL.Add('  DET_CLAFIS ');
  qryClaFis.SQL.Add('FROM         ');
  qryClaFis.SQL.Add('  MOVDET     ');
  qryClaFis.SQL.Add('WHERE        ');
  qryClaFis.SQL.Add('  DET_SEQGER = :AUTINC ');

  qryClaFis.ParamByName('AUTINC').AsString := strAutInc;
  qryClaFis.Open;

  If Not qryClaFis.IsEmpty Then
  Begin
    qryClaFis.First;
    strAux := qryClaFis.FieldByName('DET_CLAFIS').AsString;
    While Not qryClaFis.Eof Do
    Begin
      If (strAux <> qryClaFis.FieldByName('DET_CLAFIS').AsString) Then
        strClaFis := strClaFis + '_';

      strClaFis := strClaFis + qryClaFis.FieldByName('DET_CLAFIS').AsString;
      qryClaFis.Next;
    End;
  End;

  qryClaFis.Close;

  If Length(strClaFis) > 10 Then
    Result := LeftStr(strClaFis, 10)
  Else Result := strClaFis;
end;

procedure TfrmExportXmlNexxera.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    fValidaCampos(edtCodEmp, True);
  End;
end;

procedure TfrmExportXmlNexxera.FormCreate(Sender: TObject);
begin
  inherited;
  qryItens  := fCriaQuery(Self);
  qryClaFis := fCriaQuery(Self);
  qryCadEmp := fCriaQuery(Self);
end;

procedure TfrmExportXmlNexxera.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) And (ActiveControl Is TRadioButton) Then
    SelectNext(ActiveControl, True, True)
  Else If (Shift=[ssCtrl]) And (Key = 83){Tecla: 'S'} Then
  Begin
    pnlMeio.Visible    := Not pnlMeio.Visible;
    lblAlerta.Visible  := Not lblAlerta.Visible;
    lblAlerta2.Visible := Not lblAlerta2.Visible;
  End;
end;

procedure TfrmExportXmlNexxera.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryItens);
  FreeAndNil(qryClaFis);
  FreeAndNil(qryCadEmp);
end;

procedure TfrmExportXmlNexxera.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
    fValidaCampos(edtCodFor, True);
end;

procedure TfrmExportXmlNexxera.edtDocExcKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    Key := #0;
    Try
      pCriarFormularios(TfrmListDocsNaoExpNexxera, frmListDocsNaoExpNexxera);
      frmListDocsNaoExpNexxera.mskDtaIni.Text := '01/' + mskDtaIni.Text;
      frmListDocsNaoExpNexxera.mskDtaFin.Text := fStrZero(DaysInMonth(StrToDate('01/' + mskDtaIni.Text)), 2) + '/' + mskDtaIni.Text;
      frmListDocsNaoExpNexxera.edtCodEmp.Text := edtCodEmp.Text;
      frmListDocsNaoExpNexxera.edtNomEmp.Text := edtNomEmp.Text;
      frmListDocsNaoExpNexxera.edtCodFor.Text := edtCodFor.Text;
      frmListDocsNaoExpNexxera.edtNomFor.Text := edtNomFor.Text;
      frmListDocsNaoExpNexxera.ShowModal;
      If (frmListDocsNaoExpNexxera.ModalResult = mrOk) Then
      Begin
        edtDocExc.Text := frmListDocsNaoExpNexxera.strDocSel;
        strDocExc      := frmListDocsNaoExpNexxera.strAutoIn;
        pSetFocus(btnConfirmaDados);
      End;
    Finally
      pFreeAndNil(frmListDocsNaoExpNexxera);
    End;
  End;
end;

procedure TfrmExportXmlNexxera.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrCliente, Nil, fRetNomCliente , 'do cliente');
end;

procedure TfrmExportXmlNexxera.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE CLIENTES *}
  {**************************IV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCliente, False) Then
    fValidaCampos(edtCodCli, True);
end;

procedure TfrmExportXmlNexxera.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtCodEmp, True);
end;

procedure TfrmExportXmlNexxera.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, Nil, 'do fornecedor');
end;

function TfrmExportXmlNexxera.fGetCnpjEmpMatriz(strEmpresa, strCnpj: String): String;
begin
  If fCfgSis('EMPGER',varBoolean,strEmpresa) Then
    Result := strCnpj
  Else
    Result := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [fCfgSis('EMPMAT',varString,strEmpresa)]);
end;

end.

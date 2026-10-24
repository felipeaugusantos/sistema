unit untFuncoesAuxiliares;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untIDocumento,
  untPreAlt_Trigger,
  untFuncoesSimples,
{$ENDIF}
  SysUtils,
  Uni,
  Classes,
  StrUtils,
  DB,
  untTypesSistema;

{$IFNDEF LINUX}
{procedure pMostraContaCorrente(strCodCli: String = '';strTipFil: String = '';
                               blnSelDocumentos: Boolean = FALSE; blnVencidos: Boolean = FALSE;
                               blnAjuDta: Boolean = False;strFiltro: String = '';
                               objDocumento: IDocumento = nil;blnFiltraEmp : Boolean = False;
                               arrPort: TConsultasArray = nil; dtInicial : Tdate = 0; dtfinal :Tdate = 0; blnInfCob : Boolean = False); }
{$ENDIF}

function fRetornaTotalPromocaoPorDocumento(strNumDoc, strEspDoc, strCodEmp,
  strCodCli: String): Double;
  function fGetCfgCalculoBaseICMSNotaImportacao: TConjCalculoBaseICMSNotaImp;

{**************************************}
{* MOSTRA AS DUPLICATAS AGRUPADAS     *}
{* PARAMETROS:                        *}
{* Arquivo DUPAGR e  Nr Agrupamento   *}
{***********************************MV*}
function fRetornaSQLDupAgrupadas: String;
function fRetornaSQLDupAgrupadasTotal: String;

{$IFNDEF LINUX}
procedure pMostraDuplicatasAgrupadas(strNumAgr, strCodEmp,
  strCodCli: String; blnSelDocumentosAgr: Boolean;
  blnMostraPromocao: Boolean = False);
{$ENDIF}

{*******************************************}
{* PROCEDURE USADA PARA ATUALIZAR PRECOS DE*}
{* ITENS QUE ESTEJAM NO GRUPO DE PRECOS DO *}
{* ITEM PASSADO COMO PARAMETRO...          *}
{****************************************JC*}
procedure pAtualizaItensGrupoPrecos(strCodItem, strNomFrm: String; strAgrupadorPreAlt: string; pdtaAltPre: TDateTime = 0);

implementation

uses
  untPreAlt,
{$IFDEF LINUX}
{$ELSE}
  untSelClienteFiltro, untCtrMostraAgrupadas; //, untMostraDebCtrChq2;
{$ENDIF}

{$IFNDEF LINUX}
{procedure pMostraContaCorrente(strCodCli: String = '';strTipFil: String = '';
                               blnSelDocumentos: Boolean = FALSE; blnVencidos: Boolean = FALSE;
                               blnAjuDta: Boolean = False;strFiltro: String = '';
                               objDocumento: IDocumento = nil;blnFiltraEmp : Boolean = False;
                               arrPort: TConsultasArray = nil; dtInicial : Tdate = 0; dtfinal :Tdate = 0; blnInfCob : Boolean = False);
Var
  strDtaIni: String;
  strDtaFin: String;
  strCodPor: String;
  blnConf : Boolean;
  strRedLoj: String;
  frmSelClienteFiltro : TfrmSelClienteFiltro;
  strCodEmpSel : String;
  arrEmpSel: TConsultasArray;
  arrPortador: TConsultasArray;
Begin
  blnConf := True;
  strRedLoj := '';
  //********************************************************//
  // SE O CODIGO DO CLIENTE QUE EH INFORMADO POR PARAMENTRO //
  // ESTIVER EM BRANCO ENTAO ABRE A TELA DE SELECAO DE CLI- //
  // -NTE COM CAMPO CODIGO DO CLIENTE HABILITADO            //
  //*****************************************************ED*//
  If (fEmptyStr(strTipFil)) And ((Not blnVencidos) Or fEmptyStr(strCodCli)) Then
  Begin
    Try
      pCriarFormularios(TfrmSelClienteFiltro, frmSelClienteFiltro);
      frmSelClienteFiltro.blnFiltraEmp := blnFiltraEmp;
      If fEmptyStr(strCodCli) Then
      Begin

        With frmSelClienteFiltro Do
        Begin

          If Not fEmptyStr(strFiltro) Then
            edtFiltro.Text := strFiltro;
          edtCodCliente.Clear;
          edtDesCliente.Clear;
          blnSoVencidos := blnVencidos;
          edtCodCliente.ReadOnly := False;

          if Not (arrPort = nil) then
          begin
             arrPortador := arrPort;
             if length(arrPortador) > 1 then
             Begin
                edtCodPor.Text := '00000';
                edtNomPor.Text := '+1';
             end
             else
             if length(arrPortador) = 1 then
             Begin
                edtCodPor.Text := arrPortador[0].strCodigo;
                edtNomPor.Text := arrPortador[0].strDescri;
             End;
          end;

          If (Not (dtInicial = 0)) And (Not (dtfinal = 0)) Then
          Begin
             mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',dtInicial);
             mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',dtfinal);
          End
          Else
          Begin
             mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
             mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',VS_Date);
          End;

          ShowModal;
        End;

      End
      Else
      Begin

        With frmSelClienteFiltro Do
        Begin
          If Not fEmptyStr(strFiltro) Then
            edtFiltro.Text := strFiltro;
          edtCodCliente.Text     := strCodCli;
          edtDesCliente.Text     := fRetNomCliente(strCodCli);
          edtCodCliente.ReadOnly := True;

          if Not (arrPort = nil) then
          begin
             arrPortador := arrPort;
             if length(arrPortador) > 1 then
             Begin
                edtCodPor.Text := '00000';
                edtNomPor.Text := '+1';
             end
             else
             if length(arrPortador) = 1 then
             Begin
                edtCodPor.Text := arrPortador[0].strCodigo;
                edtNomPor.Text := arrPortador[0].strDescri;
             End;
          end;

          If (Not (dtInicial = 0)) And (Not (dtfinal = 0)) Then
          Begin
             mskDtaIni.Text := FormatDateTime('dd/mm/yyyy',dtInicial);
             mskDtaFin.Text := FormatDateTime('dd/mm/yyyy',dtfinal);
          End;

          ShowModal;
        End;

      End;

      blnConf := frmSelClientefiltro.blnConfirma;
      strCodCli := frmSelClienteFiltro.edtCodCliente.Text;
      If frmSelClienteFiltro.chkRedLoj.Checked = True  Then
        strRedLoj := frmSelClienteFiltro.strRedLoj;
      strCodPor   := frmSelClienteFiltro.edtCodPor.Text;
      arrPortador := frmSelClienteFiltro.arrPortador;

      If Not fEmptyStr(fTiraCaracEspeciais(frmSelClienteFiltro.mskDtaIni.Text)) Then
      Begin
        strDtaIni := frmSelClienteFiltro.mskDtaIni.Text;
        strDtaFin := frmSelClienteFiltro.mskDtaFin.Text;
      End
      Else
      Begin
        strDtaIni := '';
        strDtaFin := '';
      End;

      blnAjuDta := frmSelClienteFiltro.chkAjuDta.Checked;

      If blnFiltraEmp Then
      Begin
        With frmSelClienteFiltro Do
        Begin
          strCodEmpSel := edtCodEmp.Text;
          arrEmpSel    := arrEmp;
        End;
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[pMostraContaCorrente]');
    End;

    pFreeAndNil(frmSelClienteFiltro);

  End;

  If Not blnConf Then
    Exit;

  If fEmptyStr(strCodCli) Then
    Exit;

  Try
    If blnVencidos Then
      strTipFil :=  'A';  // Abertos;

    pCriarFormularios(TfrmMostraDebCtrChq2, frmMostraDebCtrChq2);

    frmMostraDebCtrChq2.strRedLoj := strRedLoj;
    frmMostraDebCtrChq2.strCodCli := strCodCli;

    If blnFiltraEmp Then
    Begin
      With frmMostraDebCtrChq2 Do
      Begin
        strCodEmp := strCodEmpSel;
        arrEmp    := arrEmpSel;
      End;
    End;

    frmMostraDebCtrChq2.strCodPor := strCodPor;
    frmMostraDebCtrChq2.arrPort   := arrPortador;

    If Not fEmptyStr(strDtaIni) Then
    Begin
      frmMostraDebCtrChq2.strDtaIni := strDtaIni;
      frmMostraDebCtrChq2.strDtaFin := strDtaFin;
    End
    Else
    Begin
      frmMostraDebCtrChq2.strDtaIni := '';
      frmMostraDebCtrChq2.strDtaFin := '';
    End;

    frmMostraDebCtrChq2.blnVencidos := blnVencidos;
    frmMostraDebCtrChq2.blnAjuDta   := blnAjuDta;

    frmMostraDebCtrChq2.blnSelDocumentosDeb := blnSelDocumentos;
    frmMostraDebCtrChq2.objDocumento        := objDocumento;

    If (Not fEmptyStr(strTipFil)) Then
      untFuncoesSimples.strTipFil := strTipFil;

    // Antes de abrir a tela verifica se terá informações para mostrar
    if frmMostraDebCtrChq2.fInicializa Then
      frmMostraDebCtrChq2.ShowModal
    Else
      fMensagem('','Não ha registros para essa consulta !',['&O K']);

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraContaCorrente]');
  End;

  pFreeAndNil(frmMostraDebCtrChq2);

End;}
{$ENDIF}

{**************************************}
{* MOSTRA AS DUPLICATAS AGRUPADAS     *}
{* PARAMETROS:                        *}
{* Arquivo DUPAGR e  Nr Agrupamento   *}
{***********************************MV*}
{$IFNDEF LINUX}
procedure pMostraDuplicatasAgrupadas(strNumAgr, strCodEmp,
  strCodCli: String; blnSelDocumentosAgr: Boolean;
  blnMostraPromocao: Boolean = False);
var
  fltTotPro: Double;
  frmCtrMostraAgrupadas : TfrmCtrMostraAgrupadas;
  LQryGen: TUniQuery;
begin

  Try
    pCriarFormularios(TfrmCtrMostraAgrupadas, frmCtrMostraAgrupadas);

    frmCtrMostraAgrupadas.qryDados.Close;
    frmCtrMostraAgrupadas.qryDados.SQL.Clear;
    frmCtrMostraAgrupadas.qryDados.SQL.Add(fRetornaSQLDupAgrupadas);
    frmCtrMostraAgrupadas.qryDados.ParamByName('NUMAGR').AsString := strNumAgr;
    frmCtrMostraAgrupadas.qryDados.ParamByName('CODCLI').AsString := strCodCli;
    frmCtrMostraAgrupadas.qryDados.ParamByName('EMPAGR').AsString := strCodEmp;
    frmCtrMostraAgrupadas.qryDados.Open;

    LQryGen := fCriaQuery;
    LQryGen.Close;
    LQryGen.SQL.Clear;
    LQryGen.SQL.Add(fRetornaSQLDupAgrupadasTotal);
    LQryGen.ParamByName('NUMAGR').AsString := strNumAgr;
    LQryGen.ParamByName('CODCLI').AsString := strCodCli;
    LQryGen.ParamByName('EMPAGR').AsString := strCodEmp;
    LQryGen.Open;

    frmCtrMostraAgrupadas.edtValorTotal.Text := FormatFloat('#,##0.00', LQryGen.FieldByName('TOTFOR').AsFloat);

    if blnMostraPromocao then
    Begin
      frmCtrMostraAgrupadas.blnMosPro := True;
      frmCtrMostraAgrupadas.qryDados.DisableControls;
      frmCtrMostraAgrupadas.qryDados.FieldByName('PROMOC').ReadOnly := False;
      While Not frmCtrMostraAgrupadas.qryDados.Eof Do
      Begin
        fltTotPro := fRetornaTotalPromocaoPorDocumento(LeftStr(frmCtrMostraAgrupadas.qryDados.FieldByName('CTR_DUPPAR').AsString, fTamDocCadRec),
                                                       frmCtrMostraAgrupadas.qryDados.FieldByName('CTR_ESPDOC').AsString,
                                                       LeftStr(frmCtrMostraAgrupadas.qryDados.FieldByName('CTR_CODEMP').AsString, 3),
                                                       frmCtrMostraAgrupadas.qryDados.FieldByName('CTR_CODCLI').AsString);
        if fltTotPro > 0  then
        begin
          frmCtrMostraAgrupadas.qryDados.Edit;
          frmCtrMostraAgrupadas.qryDados.FieldByName('PROMOC').AsString := 'S';
          frmCtrMostraAgrupadas.qryDados.post;
        end;
        frmCtrMostraAgrupadas.qryDados.Next;
      End;

      frmCtrMostraAgrupadas.qryDados.First;
      frmCtrMostraAgrupadas.qryDados.EnableControls;
    End;
    frmCtrMostraAgrupadas.Caption := frmCtrMostraAgrupadas.Caption + ' - ' + strNumAgr + '-AG-' + strCodEmp;
    frmCtrMostraAgrupadas.blnSelDocumentosDupAgr := blnSelDocumentosAgr;
    frmCtrMostraAgrupadas.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmModuloCadRec.pMostraDuplicatasAgrupadas]');
    End;
  End;

  pFreeAndNil(frmCtrMostraAgrupadas);

  If Assigned(LQryGen) Then
    FreeAndNil(LQryGen);

end;
{$ENDIF}

{*******************************************}
{* PROCEDURE USADA PARA ATUALIZAR PRECOS DE*}
{* ITENS QUE ESTEJAM NO GRUPO DE PRECOS DO *}
{* ITEM PASSADO COMO PARAMETRO...          *}
{****************************************JC*}
procedure pAtualizaItensGrupoPrecos(strCodItem, strNomFrm: String; strAgrupadorPreAlt: string; pdtaAltPre: TDateTime = 0);
  Var
    StrSql     : String;
    strCampos  : String;
    strEmpresa : String;
    qryIteger  : TUniQuery;
    qryGenIte  : TUniQuery;
    qryUpdate  : TUniQuery;
    intContad  : Integer;
    stlItens   : TStringList;

    {***************************************}
    {* FORMATA O NUMERO PARA USO NO UPDATE *}
    {************************************JC*}
    function fFloatStr(Value: Double): String;
    begin
      Result := AnsiReplaceStr(FormatFloat('#0.0000',Value), ',', '.');
    end;

    {******************************************}
    {* RETORNA OS PRODUTOS DO GRUPO DE PRECOS *}
    {***************************************JC*}
    function fRetProdutosGrupo(strGrupo: String): Boolean;
      Var
        qryBusca: TUniQuery;
    begin

      stlItens.Clear;
      Result   := False;

      If fEmptyStr(strGrupo) Then
        Exit;

      qryBusca := fCriaQuery(Nil);

      With qryBusca Do
      Begin
        SQL.Add(' SELECT ITE_CODITE FROM CADITE WHERE ITE_CODGPR = :CODGPR AND ITE_CODITE <> :CODITE ');
        ParamByName('CODITE').AsString := strCodItem;
        ParamByName('CODGPR').AsString := strGrupo;
        Open;

        If Not IsEmpty Then
        Begin
          Result := True;
          First;
          While Not Eof Do
          Begin
            stlItens.Add(Fields[0].AsString);
            Next;
          End;
        End;

      End;

      FreeAndNil(qryBusca);

    end;

    {***************************************}
    {* RETORNA OS VALORES ATUAIS DO ITEM   *}
    {* PARA GRAVACAO NA TABELA PREALT      *}    
    {************************************JC*}
    procedure pDadosItem(strCodigo: String);
    begin
      With qryGenIte Do
      Begin
        Close;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODITE').AsString := strCodigo;
        Open;
      End;
    end;

    {*******************************}
    {* RETORNA CAMPO DO ITEM ATUAL *}
    {****************************JC*}
    function fGenIte(strField: String): TField;
    begin
      Result := qryGenIte.FieldByName(strField);
    end;

    {********************************}
    {* RETORNA CAMPO DO ITEM ORIGEM *}
    {*****************************JC*}
    function fIteger(strField: String): TField;
    begin
      Result := qryIteger.FieldByName(strField);
    end;

    {*********************************}
    {* ATUALIZA PRECOS DO ITEM ATUAL *}
    {******************************JC*}
    function fUpdate(strCodigo: String):Boolean;
      Var
        strUpdate: String;
        intIndex : Integer;
    begin
      strUpdate := '';
      strUpdate := strUpdate + ' UPDATE    ';
      strUpdate := strUpdate + '   ITEGER  ';
      strUpdate := strUpdate + ' SET       ';

      strUpdate := strUpdate + '  ITE_PREALT = "' + strAgrupadorPreAlt +'",';
      {*******************************************}
      {* MONTA STRING COM OS CAMPOS E OS VALORES *}
      {****************************************JC*}
      For intIndex := Low(arrCamposPrecos) To High(arrCamposPrecos) Do
      Begin
         strUpdate := strUpdate + String(arrCamposPrecos[intIndex]) + ' = '+
                                  fFloatStr(fIteger(String(arrCamposPrecos[intIndex])).AsFloat) +
                                  IIF(intIndex < High(arrCamposPrecos), ', ', ' ');
      End;

      strUpdate := strUpdate +' WHERE                                 ';
      strUpdate := strUpdate +'   LOCATE(ITE_CODEMP, :CODEMP) > 0 AND ';
      strUpdate := strUpdate +'   ITE_CODITE = :CODITE                ';

      {*******************************************}
      {* EXECUTA O UPDATE NOS PRECOS DOS ITENS   *}
      {* NA EMPRESA ATUAL E NAS QUE UTILIZAM O   *}
      {* PRECO DA MATRIZ, CASO A MESMA SEJA...   *}
      {****************************************JC*}
      With qryUpdate, SQL Do
      Begin
        Close;
        Clear;
        SQL.Add(strUpdate);
        ParamByName('CODEMP').AsString := strEmpresa;
        ParamByName('CODITE').AsString := strCodigo;
        ExecSQL;
        Result := RowsAffected > 0;
      End;

      If Result then
      begin
        strUpdate := ' UPDATE CADITE I SET I.ITE_DTAALT = :DTAALT WHERE I.ITE_CODGPR = :CODGPR AND I.ITE_CODITE = :CODITE ';
        qryUpdate.close;
        qryUpdate.Sql.clear;
        qryUpdate.Sql.Add(strUpdate);
        if pdtaAltPre =  0 then
          qryUpdate.ParamByName('DTAALT').AsDateTime := fIteger('ITE_DTAALT').AsDateTime
        else
          qryUpdate.ParamByName('DTAALT').AsDateTime := pdtaAltPre;
        qryUpdate.ParamByName('CODITE').AsString := strCodigo;
        qryUpdate.ParamByName('CODGPR').AsString := fIteger('ITE_CODGPR').AsString;
        qryUpdate.ExecSql;
        Result := qryUpdate.RowsAffected > 0;
      end;
    end;

begin

  strCampos := '';

  {****************************************}
  {* MONTA STRING COM OS CAMPOS DE PRECOS *}
  {*************************************JC*}
  For intContad := Low(arrCamposPrecos) To High(arrCamposPrecos) Do
  Begin
    strCampos := strCampos + String(arrCamposPrecos[intContad]) + IIF(intContad < High(arrCamposPrecos), ', ', ' ');
  End;

  StrSql := '';
  StrSql := StrSql + ' SELECT SQL_NO_CACHE ';
  StrSql := StrSql + ' ' + strCampos + ',  ';
  StrSql := StrSql + '   I.ITE_CODGPR, ';
  StrSql := StrSql + '   I.ITE_CODGRU, ';
  StrSql := StrSql + '   I.ITE_CODITE, ';
  StrSql := StrSql + '   I.ITE_DTAALT  ';
  StrSql := StrSql + '  FROM           ';
  StrSql := StrSql + '    CADITE I     ';
  StrSql := StrSql + '    INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ';
  StrSql := StrSql + '  WHERE          ';
  StrSql := StrSql + '    G.ITE_CODEMP = :CODEMP AND ';
  StrSql := StrSql + '    G.ITE_CODITE = :CODITE     ';

  qryIteger := fCriaQuery(Nil);
  qryUpdate := fCriaQuery(Nil);
  qryGenIte := fCriaQuery(Nil);
  stlItens  := TStringList.Create;

  {***********************************************}
  {* ATRIBUI SELECT COM DADOS DO ITEM PARA USO   *}
  {* NO MOMENTO DE RETORNAR OS PRECOS ANTERIORES *}
  {********************************************JC*}
  With qryGenIte, SQL Do
  Begin
    Add(StrSql);
  End;

  {*******************************************}
  {* RETORNA PRECOS DO ITEM ALTERADO (ORIGEM)*}
  {* VERIFICA SE O MESMO POSSUI GRUPO DE PRE-*}
  {* COS E SEUS RESPECTIVOS ITENS            *}
  {****************************************JC*}
  With qryIteger, SQL Do
  Begin
    Add(StrSql);
    ParamByName('CODITE').AsString := strCodItem;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    If (Not IsEmpty) And fRetProdutosGrupo(fIteger('ITE_CODGPR').AsString) Then
    Begin

      {*********************************************}
      {* RETORNA EMPRESA QUE USAM PRECOS DA MATRIZ *}
      {******************************************JC*}
      strEmpresa := fRetEmpresasUsamPrecoMatriz;

      {****************************************}
      {* PROCESSA LISTA COM PRODUTOS DO GRUPO *}
      {*************************************JC*}
      For intContad := 0 To stlItens.Count -1 Do
      Begin

        {*************************************}
        {* RETORNA PRECOS ANTERIORES DO ITEM *}
        {**********************************JC*}
        pDadosItem(stlItens[intContad]);

        {***************************************}
        {* SE ATUALIZOU OS PRECOS CORRETAMENTE *}
        {* GRAVA NA TABELA DE PRECOS ALTERADOS *}
        {************************************JC*}
        If fUpdate(stlItens[intContad]) And (Not VS_blnPreAltViaTrigger) Then
        Begin

          fGravaPreAlt(fGenIte('ITE_CODITE').AsString,
                       fGenIte('ITE_PRECUS').AsFloat,
                       fIteger('ITE_PRECUS').AsFloat,
                       fGenIte('ITE_PREVE1').AsFloat,
                       fIteger('ITE_PREVE1').AsFloat,
                       fGenIte('ITE_MARBR1').AsFloat,
                       fIteger('ITE_MARBR1').AsFloat,
                       fGenIte('ITE_PREVE2').AsFloat,
                       fIteger('ITE_PREVE2').AsFloat,
                       fGenIte('ITE_MARBR2').AsFloat,
                       fIteger('ITE_MARBR2').AsFloat,
                       fGenIte('ITE_PREVE3').AsFloat,
                       fIteger('ITE_PREVE3').AsFloat,
                       fGenIte('ITE_MARBR3').AsFloat,
                       fIteger('ITE_MARBR3').AsFloat,
                       fGenIte('ITE_PREVE4').AsFloat,
                       fIteger('ITE_PREVE4').AsFloat,
                       fGenIte('ITE_MARBR4').AsFloat,
                       fIteger('ITE_MARBR4').AsFloat,
                       fGenIte('ITE_PREVE5').AsFloat,
                       fIteger('ITE_PREVE5').AsFloat,
                       fGenIte('ITE_MARBR5').AsFloat,
                       fIteger('ITE_MARBR5').AsFloat,
                       fGenIte('ITE_PREVE6').AsFloat,
                       fIteger('ITE_PREVE6').AsFloat,
                       fGenIte('ITE_MARBR6').AsFloat,
                       fIteger('ITE_MARBR6').AsFloat,
                       fGenIte('ITE_PREVE7').AsFloat,
                       fIteger('ITE_PREVE7').AsFloat,
                       fGenIte('ITE_MARBR7').AsFloat,
                       fIteger('ITE_MARBR7').AsFloat,
                       fGenIte('ITE_PRECOM').AsFloat,
                       fIteger('ITE_PRECOM').AsFloat,
                       'GRUPO DE PREÇOS - ' + strNomFrm,
                       Nil,
                       '',
                       strLoginUsuarioLogado);

        End;

      End;

    End;

  End;

  {************************************}
  {* DESTROI OBJETOS USADOS NA FUNCAO *}
  {*********************************JC*}
  FreeAndNil(qryIteger);
  FreeAndNil(qryGenIte);
  FreeAndNil(qryUpdate);
  FreeAndNil(stlItens);

end;

function fRetornaSQLDupAgrupadas: String;
Begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  DUPAGR.*, ';
  Result := Result + '  FORMAT(CTR_VALDUP, 2) AS CTR_VALFOR, ';
  Result := Result + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_DUPPAR, ';
  Result := Result + '  CONCAT(CTR_CODCLI, " - ", CLI_NOMCLI) AS CTR_NOMCLI, ';
  Result := Result + '  "N" AS PROMOC ';
  Result := Result + 'FROM ';
  Result := Result + '  DUPAGR, ';
  Result := Result + '  CADCLI ';
  Result := Result + 'WHERE ';
  Result := Result + '  CTR_CODCLI = CLI_CODCLI AND ';
  Result := Result + '  CTR_NUMAGR = :NUMAGR    AND ';
  Result := Result + '  CTR_CODCLI = :CODCLI    AND ';
  Result := Result + '  CTR_EMPAGR = :EMPAGR ';
End;

function fRetornaSQLDupAgrupadasTotal: String;
Begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + ' ROUND(SUM(CTR_VALDUP),2) AS TOTFOR  ';
  Result := Result + 'FROM ';
  Result := Result + '  DUPAGR, ';
  Result := Result + '  CADCLI ';
  Result := Result + 'WHERE ';
  Result := Result + '  CTR_CODCLI = CLI_CODCLI AND ';
  Result := Result + '  CTR_NUMAGR = :NUMAGR    AND ';
  Result := Result + '  CTR_CODCLI = :CODCLI    AND ';
  Result := Result + '  CTR_EMPAGR = :EMPAGR ';
  Result := Result + 'GROUP BY CTR_NUMAGR           ';
End;

function fRetornaTotalPromocaoPorDocumento(strNumDoc, strEspDoc, strCodEmp,
  strCodCli: String): Double;
var
  qryConsulta: TUniQuery;
  strSql: String;
begin
  Result      := 0;
  qryConsulta := fCriaQuery();

  strSql := ' SELECT ' +
            '    COALESCE(SUM(DET_TOTITE), 0) AS TOTPRO ' +
            '  FROM ' +
            '    MOVDET ' +
            '  WHERE DET_PROMOC = "S" ' +
            '    AND ( ' +
            '      LOCATE(DET_ESPDOC, "TM_ML_PR_RO_") <= 0 ' +
            '    ) ' +
            '    AND DET_PROEMB <> "S" ' +
            '    AND DET_TIP_FC = "C" ' +
            '    AND DET_CODCLI NOT IN (' + VS_strCliFil + ') ' +
            '    AND DET_NUMDOC = :NUMDOC ' +
            '    AND DET_ESPDOC = :ESPDOC ' +
            '    AND DET_CODEMP = :CODEMP ' +
            '    AND DET_CODCLI = :CODCLI ';

  strSQL := strSQL + ' UNION ALL ' +  AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET');

  qryConsulta.Sql.Clear;
  qryConsulta.Sql.Text := strSql;

  QryConsulta.ParamByName('NUMDOC').AsString := strNumDoc;
  QryConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
  QryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
  QryConsulta.ParamByName('CODCLI').AsString := strCodCli;

  QryConsulta.Open;

  if Not QryConsulta.IsEmpty then
  Begin
    while Not QryConsulta.Eof  do
    Begin
      Result := Result + QryConsulta.FieldByName('TOTPRO').AsFloat;

      QryConsulta.Next;
    End;
  End;

  FreeAndNil(QryConsulta);
end;

function fGetCfgCalculoBaseICMSNotaImportacao: TConjCalculoBaseICMSNotaImp;
var lValCfg: String;
begin
  Result := [];
  lValCfg := fCfgSis('BICMNI');
  If lValCfg = '' Then
    Exit;
  Result := [];
  lValCfg := StringReplace(lValCfg, ';', ',', [] ) + ',';
  If Pos(',0,', lValCfg) >  0 Then
    Result := Result + [cbiniII];
  If Pos(',1,', lValCfg) >  0 Then
    Result := Result + [cbiniIPI];
  If Pos(',2,', lValCfg) >  0 Then
    Result := Result + [cbiniPIS_COFINS];
  If Pos(',3,', lValCfg) >  0 Then
    Result := Result + [cbiniSiscomex];
  If Pos(',4,', lValCfg) >  0 Then
    Result := Result + [cbiniAFRMM];
  If Pos(',5,', lValCfg) >  0 Then
    Result := Result + [cbiniDespeasAduaneira];
end;

end.

unit untRelGeraOR;

interface

uses StrUtils, SysUtils, Classes, Forms, DB, untFuncoesSimples, Uni, Controls,
  UniClientDataSet, StdCtrls, ComCtrls, ExtCtrls, untAtualizaOcorrenciasCRM,
  TypesRel, untTypesSistema, untZClient, untFuncoesRel, Math, cxProgressBar,
  untRelEstItemsAbaixoMin_ItensOrc, untAlteraOrcamento, untEnderecoEntrega;

Type
  TpAbreQueryItens = Procedure(strCodEmp: String; qryItens: TZClient; strCodEmpCD: String='') Of Object;

  TTipoEstoqueSeguranca = (tpesIndefinido, tpesMaximo, tpesMinimo);

  TTipoMultiplo = (tpmlCompra, tpmlVenda, tpmlIndefinido);
  TTipoOrdem = (toDescricao, toGrupo, toFornecedor, toMarca, toLocalizacao, toGrupoUnidade, toUnidade);

  TMesesVenda = Record
    Coluna: integer;
    MesAno: String;
  End;

  TListaMesesVenda = array of TMesesVenda;

  TRelGeraOR = Class (TComponent)
  Private
    fGravaFatGor : TfGravaFatGor;
    fGravaFatDor : TfGravaFatDor;
    pAbreQueryItens: TpAbreQueryItens;

    blnEmpFat: Boolean;
    blnGerou : Boolean;
    prgProgre: TcxProgressBar;

    strEmp_CD,
    strEspDoc,
    strConfirma,
    strMen001,
    strMen002,
    strCodTra,
    strTipFre,
    strTipPed,
    strEntFat,
    strCliFil: String;
    dtaPrevis: TDate;
    FQryEmpresasDestino: TZClient;

    fltValFre: Double;
    FblnMinMaxSeg: Boolean;
    FtpesMinMaxSeg: TTipoEstoqueSeguranca;

    objOcoCrm : TAtuOcoCrm;
    blnENT_CD: Boolean;

    sltOrcamentos: TStringList;
    frmAlteraOrcamento: TfrmAlteraOrcamento;
    objEndEnt: TEnderecoEntrega;

    intDecUni: Integer;

    intDecQtd: Integer;

    function fTemPedidosEmAbertos(strClienteFilial: String): Boolean;


    procedure pGravaOrcamentos(strCodEmp: String; edtCodigo: TCustomEdit;
        arrLinha: TConsultasArray; strCodEmpCD: String=''; blnAutomatico: Boolean = False;
        prgProgresso: TcxProgressBar = Nil; blnGirEst: Boolean = False; intQtdGirEst: Integer = 0);

    procedure pGravaOrcamentosMax(strCodEmp: String; edtCodigo: TCustomEdit;
                                  arrLinha: TConsultasArray; strEspDoc: String = '');
    procedure pGravaOrcamentosMaxDistribuido;

    Function fSQLCamposSaldoCD: String;
    Procedure pLimparEnderecoEntrega;
    Function fFormataUnitar(fltValor: Double): Double;

  Public
    blnApenasSaldoCDMenorSaldoEmp: Boolean;
    strEmp_TE: String;
    tpTipoMultiplo: TTipoMultiplo;
    blnLimSal: Boolean;
    blnAutoma: Boolean;
    strAliquotaSaldoCD: string;
    tipSaldoCD: TTipoSaldoCDGrid;
    strEmpCd_ext: String;
    strEmpCdDes_ext: String;

    strEmpresas: String;
    strEmpresas_ext: String;

    cdsSaldoCD: TZClient;

    blnQuebraPorGrupoUnidade: Boolean;

    blnQtdVen,
    blnCalcVendaPorDia: Boolean;
    objListaMesesVenda: TListaMesesVenda;
    strQuebra: string;
    tipOrdem: TTipoOrdem;

    Constructor Create(Owner: TComponent;
                       fGravaFatGorA: TfGravaFatGor;
                       fGravaFatDorA: TfGravaFatDor;
                       pAbreQueryItensA: TpAbreQueryItens); Reintroduce;

    Destructor Destroy; Reintroduce;

    Class Function fSQLUnitario(strEmpOri, strEmpDes: String): String; OverLoad;
    Class Function fSQLUnitarioAlias(strAlias, strEmpOri: String): String; OverLoad;
    class function fRetTabelaPreco(strCodCli, strCodVen: String): String;

    procedure pAlteraPedido(cdsItensOrc: TUniClientDataSet;
                           strNumDoc, strEspDoc, strAutInc: String;
                           prgProgresso: TcxProgressBar);

    procedure pIncluiPedido(cdsConsulta  : TUniClientDataSet; strUniGru: String = ''; strCodEmp: String = ''; blnQuantidadeJaCalculada: Boolean = False);
    procedure pIncluiPedidoPorGrupoUnidade(cdsConsulta  : TUniClientDataSet; strCodEmp: String = ''; blnQuantidadeJaCalculada: Boolean = False);

    procedure pAlteraOrcamento(strEmpCD: string = ''; blnDescSalResCD: boolean = False; strEmp: string = ''; blnDescSalResEmp: boolean = False;  strMotFut: string = '');

    procedure pGeraOrcamento(strCodEmp: String; edtCodigo: TCustomEdit; arrLinha: TConsultasArray;
                             blnAutomatico: Boolean = False;
                             tipCalculo: TOpcTipoCalculoOrcamento = opcAbaixoMinimo;
                             prgProgresso: TcxProgressBar = Nil;
                             aQryEmpresasDestino: TZClient =  nil;
                             blnGirEst: Boolean = False;
                             intQtdGirEst: Integer = 0);

    Function fRetQuantidade(    cdsItens: TDataSet;
                                tpMultiplo: TTipoMultiplo;
                                blnLimSal: Boolean;
                            Var blnLimita: Boolean;
                                fltSaldoCD,
                                fltPerGra: Double;
                            Var fltCalcul: Double;
                            Var blnAtingiuEstMin: Boolean;
                            Var blnSaldoEmpMenoSaldoCD: Boolean;
                                blnUsaNecOri: Boolean = False;
                                blnRelatorio: Boolean = False;
                                TipoEstoqueSeguranca: TTipoEstoqueSeguranca = tpesIndefinido): Double;

    function fCarregarConfigParaGerarOrcamento(var strConPgtMas, strCodConPgt: string): boolean;

    function fChecaItensComLote(cdsItensOrc: TUniClientDataSet): boolean;

  end;

implementation

Uses
  untFuncoesCRM, untFuncoesConsulta,
  untRelDigDocumento,
  untConfGeraOrcPed,
  untRelEstItemsAcimaMax_ItensOrc, untTipoFreteAtc,
  untMsgValidacaoGeracaoOrcPed, untFuncFatImp, untFuncFatTypes, untTypesCRM,
  untTFatReprocessarSaldoItem, untConstantes;

Destructor TRelGeraOR.Destroy;
Begin
  sltOrcamentos.Clear;
  FreeAndNil(sltOrcamentos);
  If Assigned(objEndEnt) Then FreeAndNil(objEndEnt);
End;

Constructor TRelGeraOR.Create(Owner: TComponent;
                              fGravaFatGorA : TfGravaFatGor;
                              fGravaFatDorA : TfGravaFatDor;
                              pAbreQueryItensA: TpAbreQueryItens);
Begin
  tipOrdem        := toDescricao;
  blnEmpFat       := fCfgSis('EMPFAT', varBoolean);
  fGravaFatGor    := fGravaFatGorA;
  fGravaFatDor    := fGravaFatDorA;
  pAbreQueryItens := pAbreQueryItensA;
  blnQtdVen       := False;
  blnAutoma       := False;
  tpTipoMultiplo  := tpmlCompra;
  blnLimSal       := True;
  strEmp_CD       := '';
  strEmp_TE       := '';
  blnQuebraPorGrupoUnidade := False;

  dtaPrevis := 0;

  sltOrcamentos := TStringList.Create;

  cdsSaldoCD := TZClient.Create(Self, fSQLCamposSaldoCD);

  cdsSaldoCD.fAbreClient(True, '[TRelGeraOR.Create]');
  cdsSaldoCD.EmptyDataSet;
  cdsSaldoCD.IndexFieldNames := 'CODITE';

  strEmpresas := '';
  strEmpresas_ext := '';
  objEndEnt := TEnderecoEntrega.Create(Self);

  intDecUni := fCfgSis('DECUNI', varInteger);
  intDecQtd := fCfgSis('DECQTD', varInteger);
End;

Function TRelGeraOR.fSQLCamposSaldoCD: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST("00000"  AS CHAR(7)) AS CODITE, ';
  strSQL := strSQL + '   0.0000  AS SALDOS  ';

  Result := strSQL;
End;

function TRelGeraOR.fChecaItensComLote(cdsItensOrc: TUniClientDataSet): boolean;
  Var
    strCodIte: String;
Begin
  Result := True;

  strCodIte := '';

  With cdsItensOrc Do
  Begin
    Filter   := 'MARDES = ' + QuotedStr('M') + ' AND TEMLOT = ' + QuotedStr('S') + ' AND NUMLOT = ' + QuotedStr('');
    Filtered := True;
    First;

    If Not IsEmpty Then
    Begin
      strCodIte := FieldByName('CODITE').AsString;
      Result := False;
      pMensagemOk('Informe o número de lote para o item ' + strCodIte + ' - ' + FieldByName('DESITE').AsString + '!');
    End;

    Filtered := False;

    If strCodIte <> '' Then
      Locate('CODITE', strCodIte, []);
  End;
End;

procedure TRelGeraOR.pAlteraPedido(cdsItensOrc: TUniClientDataSet;
                                   strNumDoc, strEspDoc, strAutInc: String;
                                   prgProgresso: TcxProgressBar);
  Var
    cdsItens: TUniClientDataSet;
    strSQL  : String;
    qryGen  : TUniQuery;
    strCodConPgt: String;
    strConPgtMas: String;
    fltQtdIte   : Double;
    fltTotGer   : Double;
    fltTotCus   : Double;
    fltTotMed   : Double;
    fltTotPes   : Double;
    fltTotVol   : Double;
    strTabPre   : String;
    strAutLdg,
    strAutIncFdo: String;
    blnConfirma : Boolean;
    recServicos : TDadosServicos;
    strGerPen   : String;
    strNumDoc_, strEspDoc_, strCodEmp_, strCodCli, strEntFat: String;
    arrDuplic   : TarrDuplicata;
    intQtdAut: Integer;

  procedure pRetChaveDoc(Out strNumDoc, strEspDoc, strCodEmp : String);
  var
    LQryGet : TUniQuery;
  begin

    strNumDoc := '';
    strEspDoc := '';
    strCodEmp := '';

    LQryGet := fCriaQuery(Self);

    Try

      LQryGet.Close;
      LQryGet.SQL.Clear;
      LQryGet.SQL.Add('SELECT FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP FROM FATGOR WHERE AUTOINCREM = :AUTINC');
      LQryGet.ParamByName('AUTINC').AsString := cdsItens.FieldByName('FDO_SEQGER').AsString;
      LQryGet.Open;

      If Not LQryGet.IsEmpty Then
      Begin
        strNumDoc := LQryGet.FieldByName('FGO_NUMDOC').AsString;
        strEspDoc := LQryGet.FieldByName('FGO_ESPDOC').AsString;
        strCodEmp := LQryGet.FieldByName('FGO_CODEMP').AsString;
      End;

    Finally
      FreeAndNil(LQryGet);
    End;

  end;

Begin
  Try
    if not fCarregarConfigParaGerarOrcamento(strConPgtMas, strCodConPgt) then
       Exit;
    strGerPen := cdsItensOrc.FieldByName('GERPEN').AsString;
    strTipPed := cdsItensOrc.FieldByName('TIPPED').AsString;
    strCodCli := cdsItensOrc.FieldByName('FDO_CODCLI').AsString;
    strEntFat := cdsItensOrc.FieldByName('ENTFAT').AsString;
    dtaPrevis := cdsItensOrc.FieldByName('FGO_PREVIS').AsDateTime;

    pLimparEnderecoEntrega;
    If SameText(strEntFat, 'S') And fCfgSis('ENTFAT', varBoolean) Then
      If Not objEndEnt.fAlteraEnderecoEntrega(True,strCodCli,True,True,True,True,True,strEspDoc) Then
        Exit;

    fStartTransaction;
    cdsItens := TUniClientDataSet.Create(Self);
    cdsItens.DisableControls;
    cdsItens.Data := frmAlteraOrcamento.cdsConsulta.Data;
    prgProgresso.Properties.Max := Succ(cdsItens.RecordCount);

    fltQtdIte := 0;
    While Not cdsItens.Eof Do
    Begin
      fltQtdIte := fFormataFloat(cdsItens.FieldByName('FDO_QTDITE').AsFloat, intDecQtd);
      cdsItens.Next;
    End;

    {**********************************************************}
    {* APAGA O ORÇAMENTO E INCLUI NOVAMENTE COM AS ALTERAÇÕES *}
    {* O NOVO ORÇAMENTO TERÁ O MESMO NÚMERO DE DOCUMENTO      *}
    {*******************************************************LU*}
    If fltQtdIte > 0 Then
    Begin
      {************************}
      {* APAGANDO O ORÇAMENTO *}
      {*********************LU*}
      qryGen := fCriaQuery(Self);

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM FATGOR ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  AUTOINCREM = :AUTINC' ;

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsString := cdsItens.FieldByName('FDO_SEQGER').AsString;

        pRetChaveDoc(strNumDoc_, strEspDoc_, strCodEmp_);

        If Not fEmptyStr(strNumDoc_) And
           Not fEmptyStr(strEspDoc_) And
           Not fEmptyStr(strCodEmp_) Then
        Begin
          {Reprocessar Saldos}
          TReprocessarSaldoItem.New
            .AddItensDoDocumento(
              TItensReprocessarDoDocumento.New
                .Documento(strNumDoc_)
                .Especie(strEspDoc_)
                .Empresa(strCodEmp_)
              ).NotificarRoboParaReprocessarSaldos;
        End;

        ExecSQL;
        Close;
      End;

      {******************************}
      {* INCLUINDO O NOVO ORÇAMENTO *}
      {***************************LU*}
      cdsItens.First;

      fltTotGer := 0.0;
      fltTotCus := 0.0;
      fltTotMed := 0.0;
      fltTotPes := 0.0;
      fltTotVol := 0.0;

      intQtdAut := 0;

      While Not cdsItens.Eof Do
      Begin
        Application.ProcessMessages;
        fltQtdIte := fFormataFloat(cdsItens.FieldByName('FDO_QTDITE').AsFloat, intDecQtd);

        If fltQtdIte > 0 Then
         Begin
           Inc(intQtdAut);

           fltTotGer := fltTotGer + fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('FDO_UNITAR').AsFloat)), 2);
           fltTotCus := fltTotCus + fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('FDO_PRECUS').AsFloat)), 2);
           fltTotMed := fltTotMed + fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('FDO_PREMED').AsFloat)), 2);
           fltTotPes := fltTotPes + fFormataFloat((fltQtdIte * cdsItens.FieldByName('FDO_PESOIT').AsFloat), 2);
           fltTotVol := fltTotVol + fCalcVolumes(cdsItens.FieldByName('FDO_QTDITE').AsString, fltQtdIte, fCampoTabela('ITE_EMBALA', 'CADITE', ['ITE_CODITE'], [cdsItens.FieldByName('FDO_QTDITE').AsString], False));
         End;
         
         cdsItens.Next;
      End;

       strTabPre := fRetTabelaPreco(cdsItens.FieldByName('FDO_CODCLI').AsString, strLoginUsuarioLogado);

       {******************}
       {* GRAVA - FATGOR *}
       {***************LU*}
       strAutInc := fstrEspaco(' ', 20);

       If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
          objOcoCrm := fAtualizaInformacoesCRM(strNumDoc,strEspDoc,VS_strCodEmp,cdsItens.FieldByName('FDO_CODCLI').AsString,'','',strLoginUsuarioLogado,afcOrcamento);

       FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

       If Assigned(objOcoCrm) Then
         objOcoCrm.strNomFrm := Self.Name;

       blnConfirma := fGravaFatGor(strAutInc,
                    VS_strCodEmp,
                    strNumDoc,
                    strEspDoc,
                    cdsItens.FieldByName('FDO_CODCLI').AsString,
                    strLoginUsuarioLogado,
                    '',
                    '',
                    VS_Date,
                    fTime(),
                    strConPgtMas,
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    0,
                    '',
                    '',
                    '',
                    '',
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    fltTotGer,
                    fltTotGer,
                    fltTotCus,
                    fltTotMed,
                    '1',
                    0.0,

                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                    0.0,

                    fltTotPes,
                    fltTotPes,
                    fltTotVol,
                    arrDuplic,
                    '',
                    '',
                    '',
                    '',
                    False,
                    '',
                    '',
                    '',
                    0,
                    '',
                    '',
                    0.0,
                    0.0,
                    strLoginUsuarioLogado,
                    strCodConPgt,
                    IIF(fCfgSis('USAFPG', varBoolean), fCfgSis('FPORPD'), ''),
                    recServicos,
                    'N',
                    dtaPrevis,
                    0,
                    VS_Date,
                    '',
                    strTipPed,
                    '',
                    0,
                    strEntFat,
                    0,
                    strTabPre,
                    'N',
                    0.0,
                    '',
                    cdsItens.FieldByName('FGO_EMP_CD').AsString,
                    SameText(cdsItens.FieldByName('FGO_ENT_CD').AsString, 'S'),
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    FALSE,
                    VS_Date,
                    'N',
                    'V',
                    VS_Date,
                    'P',
                    0,
                    objEndEnt.recEndere.strIncrem,             //strAutEnt -> Endereço Entrega
                    '',
                    '',
                    False,
                    '',
                    Nil,
                    cdsItens.FieldByName('FGO_EMPFOR').AsString,
                    cdsItens.FieldByName('FGO_EMP_TE').AsString,
                    0,
                    0,
                    0,
                    '',
                    objOcoCrm,
                    strGerPen,
//                    IFThen(((fCfgSis('UTIPEN', VarBoolean))
//                      And (Pos(fCfgSis('TIPEXP'), '3_4_') > 0)), fCfgSis('GERPEN', varString) , ''),  // strgerpen // gera pendencia // grava sugestao
                    0,
                    0,
                    '',
                    '',
                    0,
                    '',
                    0,
                    '',
                    '',
                    '',
                    'N',
                    '',
                    '',
                    '',
                    '',
                    '',
                    '',
                    'S',
                     False,            // blnGravarDavPv
                     false,            // blnAlterado
                     0,                // dtaImpSep
                     0,                // horImpSep
                     '',               // strNumPedRefOR
                     '',               // strEmpPedRefOR
                     '',               // strLatitu
                     '',               // strLongit
                     '',               // strRaio__
                     nil,              // objFazenda
                     'S',              // strEnvLib
                     0,                // fltFreRat
                     '',               // strNumPedAba
                     '',               // strEspPedAba
                     '',               // strEmpPedAba
                     '',               // strObsL01
                     '',               // strObsL02
                     'N',              // strVenPre
                     'N',              // strTemBri
                     'N',              // strEdiPes
                     0,                // fltTaxEnt
                     '',               // strCodSup
                     'N',              // strOrcEsp
                     '',               // strProspe
                     '',               // strCodOco
                     False,            // blnImpSfaPag
                     '',               // strCodEmbarcacao
                     0,                // fltDesOpeGor
                     '',               // strCliCon
                     '',               // strInRqCp
                     '',               // strOriGor
                     '',               // strBarCom
                     'S',              // strPD_Exp
                     0,                // dtaValOrc
                     '',               // strCodRot
                     0,                // fltTotBri
                     0,                // fltBolAdt
                     False,            // blnBolVen
                     0,                // fltTaxJur
                     'N',              // strFatTot
                     '',               // strTraRdp
                     '',               // strCliLoj
                     '',               // strSeqDmp
                     0,                // dtaDtFiCo
                     0,                // dtaDtInCo
                     0,                // dtaDtInSe
                     0,                // dtaDtBxSe
                     0,                // hraHrFiCo
                     0,                // hraHrInCo
                     0,                // hraHrInSe
                     0,                // hraHrBxSe
                     nil,              // cdsExpRet
                     'N',              // strUsaQue
                     '',               // strDocQue
                     '',               // strCodPrj
                     '',               // strTpOper
                     '',               // strNLeads
                     '',               // strCupDes
                     'S',              // strNotPau
                     0,                // dtaDtCtVn
                     0,                // fltVlCtVn
                     '',               // strCodCat
                     '',               // strMen003
                     '',               // strMen004
                     'GERACAO TE');    // strMen005

       prgProgresso.Position := prgProgresso.Position + 1;
       Application.ProcessMessages;

       {******************}
       {* GRAVA - FATDOR *}
       {***************LU*}
       strAutIncFdo := fRetAutoIncrem('FATDOR', VS_strCodEmp, intQtdAut);
       strAutLdg    := fRetAutoIncrem('LOGDOR', VS_strCodEmp, intQtdAut);

       cdsItens.First;

       While Not cdsItens.Eof Do
       Begin
         Application.ProcessMessages;
         fltQtdIte := fFormataFloat(cdsItens.FieldByName('FDO_QTDITE').AsFloat, intDecQtd);

         If fltQtdIte > 0 Then
         Begin
           fltTotGer := fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('FDO_UNITAR').AsFloat)), 2);
           fltTotCus := fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('FDO_PRECUS').AsFloat)), 2);
           fltTotMed := fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('FDO_PREMED').AsFloat)), 2);
           fltTotPes := fFormataFloat((fltQtdIte * cdsItens.FieldByName('FDO_PESOIT').AsFloat), 2);

              blnConfirma := blnConfirma And fGravaFatDor(strAutIncFdo,
                        strAutInc,
                        VS_strCodEmp,
                        cdsItens.FieldByName('FDO_CODCLI').AsString,
                        strLoginUsuarioLogado,
                        cdsItens.FieldByName('FDO_CODITE').AsString,
                        cdsItens.FieldByName('FDO_CODMAR').AsString,
                        '',
                        strNumDoc,
                        strEspDoc,
                        '',
                        VS_Date,
                        fTime(),
                        strConPgtMas,
                        '',
                        cdsItens.FieldByName('FDO_DESCRI').AsString,
                        cdsItens.FieldByName('FDO_REFERE').AsString,
                        cdsItens.FieldByName('FDO_UNIDAD').AsString,
                        cdsItens.FieldByName('FDO_FORITE').AsString,
                        fltQtdIte,
                        fFormataUnitar(cdsItens.FieldByName('FDO_UNITAR').AsFloat),
                        fFormataUnitar(cdsItens.FieldByName('FDO_UNITAR').AsFloat),
                        fFormataUnitar(cdsItens.FieldByName('FDO_UNITAR').AsFloat),
                        fltTotGer,
                        fltTotGer,
                        fltTotCus,
                        fltTotMed,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        strLoginUsuarioLogado,
                        '',
                        0.0,
                        0.0,
                        0.0,
                        copy(VS_strClaVen,1,4),
                        '000',
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                        fltTotGer,
                        0.0,
                        0.0,
                        0.0,
                        fltTotPes,
                        0.0,
                        0.0,
                        False,
                        '',
                        '',
                        '',
                        0,
                        '',
                        '',
                        0.0,
                        'NOR',
                        cdsItens.FieldByName('FDO_INCPIS').AsString,
                        strLoginUsuarioLogado,
                        strCodConPgt,
                        '',
                        IIF(fCfgSis('USAFPG', varBoolean), fCfgSis('FPORPD'), ''),
                        '',
                        '',
                        '',
                        '',
                        0.0,
                        0.0,
                        '',
                        0.0,
                        0.0,
                        0.0,
                        '',
                        '',
                        0,
                        'N',
                        '',
                        0.0,
                        0,
                        0.0,
                        fFormataUnitar(cdsItens.FieldByName('FDO_UNITAR').AsFloat),
                        '',
                        0.0,
                        '',
                        '',
                        FALSE,
                        strTabPre,
                        '',
                        '',
                        '',
                        0.0,
                        '',
                        0.0,
                        cdsItens.FieldByName('ENTRET').AsString,
                        '',
                        'N',
                        '',
                        VS_date,
                        fltTotCus,
                        0,
                        0,
                        '',
                        cdsItens.FieldByName('FDO_NUMLOT').AsString,
                        '',
                        False,
                        IIF(blnEmpFat, IIF(((Not fEmptyStr(strEmp_CD)) And (fCfgSis('ENT_CD', VarBoolean))), strEmp_CD, VS_strCodEmp), IIf(strEmp_CD = '', VS_strCodEmp, strEmp_CD)),
                        '',
                        '',
                        '',
                        cdsItens.FieldByName('FDO_EMPFOR').AsString,
                        '',
                        0,
                        0,
                        '',
                        '',
                        0,
                        '',
                        '',
                        0,
                        0,
                        cdsItens.FieldByName('FDO_PESOIT').AsFloat,
                        'N', // strAltPCo: String = 'N';
                        'N', // strCliBus: string = 'N';
                        '',  // strTurEnt: String = '';
                        0,   // fltVal_RT: Double = 0;
                        0,   // fltTaxJur: Double = 0;
                        False, // blnInseridoOuAlterado: Boolean=False;
                        '',  // strLotAba: String = '';
                        '',  // strLotAnt: String = '';
                        '',  // strIncFut: String = '';
                        0,   // fltSerRat: Double = 0;
                        '',  // strSepExp: String = '';
                        0,   // fltFreRat: Double = 0;
                        'N', // strPigBas: String = 'N';
                        '',  // strIncDev: String = '';
                        '',  // strSeqOpI: String = '';
                        'N', // strBrinde: String = 'N';
                        '',  // strCodPar: String = '';
                        '',  // strTipBri: String = '';
                        '',  // strBaqtze: String = '';
                        0,   // fltDesMax: Double = 0;
                        0,   // fltValFle: Double = 0;
                        'N', // strPegou_: String = 'N';
                        0,   // fltTaxEnt: Double = 0;
                        'N', // strAtivac: String = 'N';
                        0,   // intSeqCom: Integer = 0;
                        0,   // fltQtdAti: Double = 0;
                        0,   // fltQtdCom: Double = 0;
                        '',  // strTabCom: String = '';
                        '',  // strDesNes: String = '';
                        False, // blnIcmSai: Boolean = False;
                        0,   // fltIcmPav: Double = 0;
                        0,   // fltIcmSai: Double = 0;
                        0,   // fltImpFed: Double = 0;
                        0,   // fltDesOpe: Double = 0;
                        0,   // fltAlDifa: Double = 0;
                        '',  // strAutDet: String = '';
                        0,   // fltValFCP: Double = 0;
                        0,   // fltPesBru: Double = 0;
                        0,   // intSeqUlt: Integer = 0;
                        0,   // intQDEntr: Integer = 0;
                        '',  // strNcmTin: String = '';
                        '',  // strNotC17: String = '';
                        0,   // fltAlq922: Double = 0;
                        '',  // strCodCmg: String = '';
                        0,   // fltQtdSep: Double = 0;
                        0,   // fltDesCnd: Double = 0;
                        0,   // intSeqEst: Integer = 0;
                        '',  // strIteEst: String = '';
                        0,   // fltUniEst: Double = 0;
                        0,   // fltQtdSbi: Double = 0;
                        0,   // fltUniSbi: Double = 0;
                        0,   // fltFreMkp: Double = 0;
                        0,   // fltComMkp: Double = 0;
                        '',  // strProEsp: String = '';
                        '',  // strVenCbo: String = '';
                        '',  // strCodPro: String = '';
                        0,   // fltUniDol: Double = 0;
                        0,   // fltTotDol: Double = 0;
                        0,   // fltQtdRco: Double = 0;
                        True, // blnExiBSe: Boolean = True;
                        '',  // strAIdKitPromocao : String = '';
                        '',  // strOpBxSe: String = '';
                        0,   // dtaDtBxSe: TDateTime = 0;
                        0,   // dtaHrBxSe: TDateTime = 0;
                        '',  // strEmpCar: String = '';
                        0,   // fltDesBai: Double = 0;
                        '',  // strTemNumSerie: String = '';
                        0,   // fltVDesST: Double = 0;
                        '',  // strMDesST: String = '';
                        'S', // strReserv: String = 'S';
                        0,   // intSeqInv: Integer = 0 ;
                        '',  // strSeqEql: String = '';
                        '',  // strNumDrw: String = '';
                        False, // blnMntPrc: Boolean = False;
                        0,   // fltQtdRet: Double = 0;
                        '',  // strNumPla: String = '';
                        '',  // strParNum: String = '';
                        '',  // strReqCom: String = '';
                        '',  // strAutEnd: String = '';
                        '',  // strRegEsp: String = '';
                        0,   // fltFreCot: Double = 0;
                        False, // blnAltEst: Boolean = False;
                        0,   // intSeqPer: Integer = 0;
                        False, // blnRatEst: Boolean = False;
                        '',  // strObsRco: String = '';
                        '',  // strNumPok: String = '';
                        '',  // strDocOri: String = '';
                        '',  // strEspOri: String = '';
                        '',  // strEmpOri: String = '';
                        '',  // strOpeSep: String = '';
                        '',  // strOpeExp: String = '';
                        '',  // strEmpDmp: String = '';
                        0,   // fltUnDiDe: Double = 0;
                        '',  // strBasTro: String = '';
                        0,   // dtaDtaCmp: TDateTime = 0;
                        0,   // fltOutValPD: Double = 0;
                        0,   // fltFreEntPD: Double = 0;
                        0,   // fltAcpProPD: Double = 0;
                        0,   // fltAcpTxcPD: Double = 0;
                        0,   // fltAcpVctPD: Double = 0;
                        0,   // fltAcpResPD: Double = 0;
                        0,   // fltAcpMarPD: Double = 0;
                        '',  // strTckQbt: String = '';
                        '',  // strSeqPre: String = '';
                        0,   // fltSomaColorantes : Double = 0;
                        strAutLdg);

           strAutIncFdo := fNextAutoIncrem(strAutIncFdo);
           strAutLdg    := fNextAutoIncrem(strAutLdg);

         End; {If fltQtdIte > 0 Then}

         If Not blnConfirma Then
           Break;

         cdsItens.Next;
         prgProgresso.Position := prgProgresso.Position + 1;
         Application.ProcessMessages;
       End;

       If blnConfirma Then
       Begin
         fCommit;

         TReprocessarSaldoItem.New
           .AddItensDoDocumento(
              TItensReprocessarDoDocumento.New
                .Documento(strNumDoc)
                .Especie(strEspDoc)
                .Empresa(VS_strCodEmp)
              ).ReprocessarSaldoPedidos(prgProgresso);

         If strEspDoc = 'OR' Then
           fMensagem('', 'Orçamento alterado com sucesso!', ['&O k'])
         Else
           fMensagem('', 'Pedido alterado com sucesso!', ['&O k']);

       End Else
       Begin
         fRollBack;
       End;

      FreeAndNil(cdsItens);
      FreeAndNil(qryGen);

    End
    Else
    Begin
      If cdsItens.IsEmpty Then
      Begin

        If strEspDoc = 'OR' Then
          fMensagem('', 'Alteração de Orçamento não realizada!' + #13#10 + 'O Orçamento deve conter ao menos um item.', ['&O k'])
        Else
          fMensagem('', 'Alteração de Pedido não realizada!' + #13#10 + 'O Pedido deve conter ao menos um item.', ['&O k']);

        FreeAndNil(cdsItens);
      End;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TRelGeraOR.pAlteraPedido]');
    End;
  End;
End;

function TRelGeraOR.fCarregarConfigParaGerarOrcamento(var strConPgtMas, strCodConPgt: string): boolean;
var
  qryGen : TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  try
    try
      strConPgtMas := '';
      strCodConPgt := '';
      Result := TfrmMsgValidacaoGeraOrdOp.fMsgValidacaoGeracaoOrcPed(veNaoValida, '', False);
      if not Result then
         Exit;

      If fCfgSis('USACND', varBoolean) Then
      begin
        strCodConPgt := fCfgSis('CCONPG');
        With qryGen Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(' SELECT SQL_NO_CACHE CND_CNDPAG FROM CADCND   ');
          SQL.Add(' WHERE CND_CODIGO = "' + fCfgSis('CCONPG') + '"');
          SQL.Add(' ORDER BY CND_CODIGO             ');
          Open;
          strConPgtMas := FieldByName('CND_CNDPAG').AsString;
       end;
      end
      Else
      Begin

        strCodConPgt := '';
        strConPgtMas := fCfgSis('CNDORP');
      End;
    Except
      on e: exception do
      begin
        Result := False;
        pMensagensErro(e.message, '[RelGeraOR.fCarregarConfigParaGerarOrcamento]');
      end;
    end;
  finally
     FreeAndNil(qryGen);
  end;
end;


procedure TRelGeraOR.pAlteraOrcamento(strEmpCD: string;
                                      blnDescSalResCD: boolean;
                                      strEmp: string;
                                      blnDescSalResEmp: boolean;
                                      strMotFut: string);
{***************************************************************************************************}
{* strEmpCD             = Considera a Empresa CD o valor deste parametro                           *}
{* blnDescSalResCD      = Quando True Desconta o Saldo Reservado no saldo CD                       *}
{* strEmp: string;      = Lista de Empresa Declarado da Seguinte Forma 001_002_003_                *}
{*                       o saldo sera carregado de acordo com a empresa que tiver neste parametro  *}
{*                       caso não o tenha ira considerar o código da empresa logada                *}
{* blnDescSalResEmp     = Desconta o Saldo reservado da Empresa                                    *}
{* strMotFut            = Valores possiveis "F" "A" "P" separado por virgula vide                  *}
{*                       untRelEstItemsAbaixoMin.fGetMotEntFut sera usado como parametro na        *}
{*                       criação da temporaria portanto tem que ser o padrao                       *}
{*                       where <campo> IN('')                                                      *}
{*                       Quando tiver este campo preenchido o saldo da empresa sera somado com     *}
{*                       entregas futuras                                                          *}
{*                       Quando Valor '"F"' encontrado Falta Produto                               *}
{*                                    '"P"' Previsão de Entrega                                    *}
{*                                    '"A"' Aguardando Cliente                                     *}
{************************************************************************************************WG*}
Var
  strSQL      : String;
  strNumDoc   : String;
  strEspDoc   : String;
  strAutInc   : String;
  blnConfirma : Boolean;
  qryGen      : TUniQuery;
  frmRelDigDocumento: TfrmRelDigDocumento;

  function fSQLSaldo: string;
  Begin
    If strEmp = VS_strCodEmp Then
      Result := ' I.ITE_SALDOS '
    Else
    Begin
      Result := Result + '(SELECT SUM(I2.ITE_SALDOS) ' ;
      Result := Result + '   FROM ITEGER I2 ';
      Result := Result + '  WHERE I2.ITE_CODITE = I.ITE_CODITE ';
      Result := Result + '    AND LOCATE(I2.ITE_CODEMP, "' + strEmp + '") > 0) ';
    End;
  End;

  function fSQLSalEntFut(blnSaldoCD: Boolean = False; strAlias: string = 'I'): String;
  begin
    Result := '';

    If (fCfgSis('BEFTRG', VarBoolean)) Then
      Result := Result + ' - ' + fGetSQLSomaCamposEntregaFutura(strAlias);

    If blnSaldoCD Then
    Begin
      Case fCfgSis('CALSAL', varInteger) Of
        1: Result := Result + ' + IFNULL(' + strAlias + '.ITE_QTEF_A, 0) + IFNULL(' + strAlias + '.ITE_QTEF_F, 0) + IFNULL(' + strAlias + '.ITE_QTEF_P, 0) ';
        2: ;
        3: Result := Result + ' + IFNULL(' + strAlias + '.ITE_QTEF_F, 0) ';
        4: Result := Result + ' + IFNULL(' + strAlias + '.ITE_QTEF_A, 0) + IFNULL(' + strAlias + '.ITE_QTEF_P, 0) ';
        5: Result := Result + ' + IFNULL(' + strAlias + '.ITE_QTEF_A, 0) + IFNULL(' + strAlias + '.ITE_QTEF_F, 0) ';
      End;
    End
    Else
    Begin
      If Pos('A', strMotFut) > 0 Then
        Result := Result + ' + IFNULL(' + strAlias + '.ITE_QTEF_A, 0)';

      If Pos('F', strMotFut) > 0 Then
        Result := Result + ' + IFNULL(' + strAlias + '.ITE_QTEF_F, 0)';

      If Pos('P', strMotFut) > 0 Then
        Result := Result + ' + IFNULL(' + strAlias + '.ITE_QTEF_P, 0)';

    End;
    If fEmptyStr(Result) Then
      Result := ' 0 ';

    Result := '(' + Result + ')';
  End;

  function fSQLSalRes(blnCD: boolean = False): string;
    var
      strEmpInterna: string;
  begin
    (****************************************************************)
    (*blnCD: TRUE  - Quer dizer que vai pegar o sado reservado do CD*)
    (*        FALSE - Da Empresa Destino                            *)
    (*************************************************************WG*)
    Result := ' 0 ';
    If (blnCD and not blnDescSalResCD) or ((not blnCD and not blnDescSalResEmp)) Then
      Exit;
    Result := '';

    Result := Result + '((COALESCE( ';
    Result := Result + '   (SELECT SUM(COALESCE(FDO_QTDITE, 0) - COALESCE(FDO_QTDBAI, 0)) SALRES ';
    Result := Result + '      FROM FATDOR ';
    Result := Result + '      JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
    Result := Result + '      LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
    Result := Result + '     WHERE FDO_CODITE = I.ITE_CODITE ';
    Result := Result + '       AND FDO_ESPDOC = "PD" ';

    //Verifica se no pedido tem emprsa fornecedor, se tiver verica se a empresa fornecedor é a empresa de destino, para poder pegar o saldo reservado
    strEmpInterna := strEmpCd;
    if fEmptyStr(strEmpCD) Then
      strEmpInterna := fCfgSis('EMPMAT');

    If blnCD Then
    Begin
      Result := Result + ' AND ((((IF(IFNULL(FGO_EMPFOR, "") = "", FDO_CODEMP, FGO_EMPFOR) = ' + QuotedStr(strEmpInterna) + ')';
      Result := Result + '              AND (IFNULL(FDO_EMPITE, "") = "")) OR (IF(IFNULL(FGO_EMPFOR, "") = "",';
      Result := Result + '                                                     FDO_EMPITE,  FGO_EMPFOR) = ' + QuotedStr(strEmpInterna) +'))';
      Result := Result + '      AND IFNULL(FGO_ENT_CD, "N") = "N")';
    End
    Else
    Begin
      Result := Result + '        AND ((((LOCATE(IF(IFNULL(FGO_EMPFOR, "") = "", FDO_CODEMP, FGO_EMPFOR), "' + IfThen(fEmptyStr(strEmp), VS_StrCodEmp, strEmp) + '") > 0) AND (IFNULL(FDO_EMPITE, "") = ""))';
      Result := Result + '         OR (LOCATE(IF(IFNULL(FGO_EMPFOR, "") = "", FDO_EMPITE, FGO_EMPFOR), "' + IfThen(fEmptyStr(strEmp), VS_StrCodEmp, strEmp) + '") > 0)) AND IFNULL(FGO_ENT_CD, "N") = "N")';
    End;
    Result := Result + '  AND FDO_JAFATU = 0';
    Result := Result + '  AND IFNULL(FGO_CORTE_, "") <> "S" ), 0)';
    Result := Result + ' + ';

    Result := Result + ' COALESCE((SELECT ';
    Result := Result + '      SUM(COALESCE(GAD_QTDREQ, 0) - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = D.AUTOINCREM ),0) ) SALRES2 ';
    Result := Result + '     FROM MOVGAG G ';
    Result := Result + '    INNER JOIN MOVGAD D ON G.AUTOINCREM = D.GAD_SEQGAG ';
    Result := Result + '    WHERE GAD_CODITE = I.ITE_CODITE ';
    Result := Result + '      AND LOCATE(GAG_CODEMP, "' + IfThen(fEmptyStr(strEmp), VS_StrCodEmp, strEmp) + ' ") > 0 ), 0)))';
  end;

begin
  inherited;

  Try
    pCriarFormularios(TfrmRelDigDocumento, frmRelDigDocumento);
    frmRelDigDocumento.showModal;

    blnConfirma := frmRelDigDocumento.blnConfirma;
    strAutInc   := frmRelDigDocumento.strAutInc;
    strNumDoc   := frmRelDigDocumento.strNumDoc;
    strEspDoc   := frmRelDigDocumento.strEspDoc;

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmRelEstItemsAbaixoMin.btnAltOrcClick]');
    End;
  End;

  pFreeAndNil(frmRelDigDocumento);

  If blnConfirma Then
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   F.AUTOINCREM, ';
    strSQL := strSQL + '   FDO_SEQGER, ';
    strSQL := strSQL + '   FDO_NUMLOT, ';
    strSQL := strSQL + '   FDO_CODCLI, ';
    strSQL := strSQL + '   FDO_FORITE, ';
    strSQL := strSQL + '   FDO_CODMAR, ';
    strSQL := strSQL + '   FDO_CODITE, ';
    strSQL := strSQL + '   FDO_DESCRI, ';
    strSQL := strSQL + '   FDO_REFERE, ';
    strSQL := strSQL + '   FDO_UNIDAD, ';
    strSQL := strSQL + '   UNI_SIGUNI, ';
    strSQL := strSQL + '   UNI_ITEFRA, ';
    strSQL := strSQL + '   FDO_QTDITE, ';
    strSQL := strSQL + '   FDO_UNITAR, ';
    strSQL := strSQL + '   FDO_TOTITE, ';
    strSQL := strSQL + '   (FDO_TOTCUS/FDO_QTDITE) AS FDO_PRECUS, ';
    strSQL := strSQL + '   (FDO_TOTMED/FDO_QTDITE) AS FDO_PREMED, ';
    strSQL := strSQL + '   (FDO_TOTPES/FDO_QTDITE) AS FDO_PESOIT, ';
    strSQL := strSQL + '   FDO_INCPIS, ';
    strSQL := strSQL + '   IFNULL(E.FDO_EMPFOR, "")  AS FDO_EMPFOR,  ';
    strSQL := strSQL + '   G.FGO_ENT_CD,  ';
    strSQL := strSQL + '   G.FGO_PREVIS,  ';
    strSQL := strSQL + '   G.FGO_EMPFOR,  ';
    strSQL := strSQL + '   T.FGO_EMP_TE,  ';
    strSQL := strSQL + '   IFNULL(T.FGO_EMP_CD, "")  AS FGO_EMP_CD,  ';
    strSQL := strSQL + '   IF(IFNULL(C.ITE_MLTCOM, 0) <= 0, 1, C.ITE_MLTCOM) AS MLTCOM,  ';
    strSQL := strSQL + '   I.ITE_ESTMIN AS ESTMIN,  ';
    strSQL := strSQL + '   (' + fSQLSaldo + ' + ' + fSQLSalEntFut() + ') - ' + fSQLSalRes(False) + '   AS SALDOS,  ';

    strSQL := strSQL + '  (IFNULL((SELECT SQL_NO_CACHE SUM(ITEGER.ITE_SALDOS + ' + fSQLSalEntFut(True, 'ITEGER') + ') ';
    strSQL := strSQL + '          FROM ITEGER ';
    strSQL := strSQL + '          WHERE ITEGER.ITE_CODITE = FDO_CODITE AND ';
    if fEmptyStr(strEmpCD) Then
    Begin
      strSQL := strSQL + '                ITEGER.ITE_CODEMP = IF(IFNULL(FGO_EMP_CD, "") <> "",  ';
      strSQL := strSQL + '     FGO_EMP_CD, ' + QuotedStr(fCfgSis('EMPMAT')) + ')';
    End
    Else
      strSQL := strSQL + ' ITEGER.ITE_CODEMP = "' + strEmpCD +'"';

    strSQL := strSQL + '), 0))   - ' + fSQLSalRes(True) + ' AS SALDCD, ';

    strSQL := strSQL + '  FGO_GERPEN AS GERPEN, ';
    strSQL := strSQL + '  E.FDO_ENTRET AS ENTRET, ';
    strSQL := strSQL + '  G.FGO_ENTFAT AS ENTFAT, ';
    strSQL := strSQL + '  FGO_TIPPED AS TIPPED ';


    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   FATDOR F ';
    strSQL := strSQL + '   JOIN CADUNI ON FDO_UNIDAD = UNI_CODUNI ';

    strSQL := strSQL + '   INNER JOIN CADITE C ON C.ITE_CODITE = FDO_CODITE   ';
    strSQL := strSQL + '   INNER JOIN ITEGER I ON I.ITE_CODITE = FDO_CODITE   ';
    strSQL := strSQL + '                        AND I.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
    strSQL := strSQL + '   LEFT  JOIN EXTDOR E ON E.FDO_SEQFDO = F.AUTOINCREM ';

    strSQL := strSQL + '   INNER JOIN FATGOR G ON G.AUTOINCREM = F.FDO_SEQGER ';
    strSQL := strSQL + '   LEFT  JOIN EXTGOR T ON T.FGO_SEQFGO = G.AUTOINCREM ';

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FDO_NUMDOC = ' + QuotedStr(strNumDoc) + ' AND ';
    strSQL := strSQL + '   FDO_ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ';
    strSQL := strSQL + '   FDO_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
    strSQL := strSQL + '   FDO_CODCLI IN (' + VS_strCliFil + ') AND ';
    strSQL := strSQL + '   FDO_QTDITE > 0                       AND ';
    strSQL := strSQL + '   FDO_JAFATU = FALSE ';

    qryGen := fCriaQuery(Self);

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      fMensagem('', 'Orçamento/Pedido inválido ou não encontrado!', ['&O k']);
      FreeAndNil(qryGen);
      Exit;
    End;

    {*****************************************************}
    {* EXIBE OS ITENS PARA O USUARIO ALTERAR OU APAGAR   *}
    {**************************************************LU*}
    Try
      pCriarFormularios(TfrmAlteraOrcamento, frmAlteraOrcamento);
      frmAlteraOrcamento.objGeraOr := Self;

      frmAlteraOrcamento.strNumDoc := strNumDoc;
      frmAlteraOrcamento.strEspDoc := strEspDoc;
      frmAlteraOrcamento.strAutInc := strAutInc;
      frmAlteraOrcamento.strSQLGen := strSQL;
      frmAlteraOrcamento.Caption := 'Alteração do Documento:  ' + strNumDoc + '-' + strEspDoc;
      frmAlteraOrcamento.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmRelEstItemsAbaixoMin.btnAltOrcClick]');
      End;
    End;

    pFreeAndNil(frmAlteraOrcamento);
  End;

  FreeAndNil(qryGen);
end;

procedure TRelGeraOR.pGeraOrcamento(strCodEmp: String; edtCodigo: TCustomEdit;
   arrLinha: TConsultasArray; blnAutomatico: Boolean = False;
   tipCalculo: TOpcTipoCalculoOrcamento = opcAbaixoMinimo; prgProgresso: TcxProgressBar = Nil;
   aQryEmpresasDestino: TZClient =  nil;
   blnGirEst: Boolean = False; intQtdGirEst: Integer = 0);
Begin
  Try
    pCriarFormularios(TfrmConfGeraOrcPed, frmConfGeraOrcPed);
    FQryEmpresasDestino := aQryEmpresasDestino;
    frmConfGeraOrcPed.edtCodEmpresa.Text := strEmpCd_ext;
    frmConfGeraOrcPed.edtDesEmpresa.Text := strEmpCdDes_ext;
    frmConfGeraOrcPed.edtCodEmpresa.Enabled := fEmptyStr(strEmpCd_ext);

    If not fEmptyStr(strEmpresas_ext) then
      frmConfGeraOrcPed.strEmpresas := strEmpresas_ext;

    If Not blnAutomatico Then
    Begin
      frmConfGeraOrcPed.pnlEmpCD.Visible := tipCalculo in [opcAbaixoMinimo, opcVendaReposicao];
      frmConfGeraOrcPed.ShowModal;
      strEmp_CD := frmConfGeraOrcPed.edtCodEmpresa.Text;
      If tipCalculo = opcVendaReposicao Then
        strEmp_TE := frmConfGeraOrcPed.edtCodEmpresa.Text;
    End Else
    Begin
      frmConfGeraOrcPed.cmbTipFre.ItemIndex := frmConfGeraOrcPed.cmbTipFre.Items.IndexOf(fDescricaoFrete('1'));
      frmConfGeraOrcPed.rdgTipo.ItemIndex := 1;
      frmConfGeraOrcPed.btnConfirmaDados.Click;
    End;


    If (tipCalculo = opcAbaixoMinimo) And (strEmp_CD = '') Then
      strEmp_CD  := strEmpCd_ext;

    strEspDoc   := frmConfGeraOrcPed.strTipoDoc;
    strConfirma := frmConfGeraOrcPed.strConfirma;
    strMen001   := frmConfGeraOrcPed.strMen001;
    strMen002   := frmConfGeraOrcPed.strMen002;
    strCodTra   := frmConfGeraOrcPed.strCodTra;
    fltValFre   := frmConfGeraOrcPed.fltValFre;
    strTipFre   := frmConfGeraOrcPed.strTipFre;
    strTipPed   := frmConfGeraOrcPed.strTipPed;
    strEntFat   := frmConfGeraOrcPed.strEntFat;
    dtaPrevis   := frmConfGeraOrcPed.dtaPreVis;

    pLimparEnderecoEntrega;
    If (SameText(strEntFat,'S')) And (fCfgSis('ENTFAT', varBoolean)) And (Not fEmptyStr(edtCodigo.Text)) And (Not fEmptyStr(fRetornaClienteFilial(edtCodigo.Text, 'C'))) Then
      objEndEnt.fAlteraEnderecoEntrega(True,fRetornaClienteFilial(edtCodigo.Text, 'C'),True,True,True,True,True,strEspDoc);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRelGeraOR.pGeraOrcamento]');
    End;
  End;

  pFreeAndNil(frmConfGeraOrcPed);

  If (strConfirma = 'S') And (tipCalculo in [opcAbaixoMinimo, opcVendaReposicao]) Then
    pGravaOrcamentos(strCodEmp, edtCodigo, arrLinha, strEmp_CD, blnAutomatico, prgProgresso, blnGirEst, intQtdGirEst)
  Else If (strConfirma = 'S') And (tipCalculo = opcAcimaMax) Then
    pGravaOrcamentosMax(strCodEmp, edtCodigo, arrLinha, strEspDoc);
End;

Function TRelGeraOR.fRetQuantidade(    cdsItens: TDataSet;
                                tpMultiplo: TTipoMultiplo;
                                blnLimSal: Boolean;
                            Var blnLimita: Boolean;
                                fltSaldoCD,
                                fltPerGra: Double;
                            Var fltCalcul: Double;
                            Var blnAtingiuEstMin: Boolean;
                            Var blnSaldoEmpMenoSaldoCD: Boolean;
                                blnUsaNecOri: Boolean = False;
                                blnRelatorio: Boolean = False;
                                TipoEstoqueSeguranca: TTipoEstoqueSeguranca = tpesIndefinido): Double;
  Var
    fltMltCom,
    fltMltVen,
    fltQtdIte,
    fltResto    : Double;
    strFieldMaxMinSeg: String;
Begin
  Result := 0;
  Try

    strFieldMaxMinSeg := IIf(TipoEstoqueSeguranca = tpesMaximo, 'CD_ESTMAX','CD_ESTMIN');

    fltCalcul := 0;
    Result := 0;
    blnLimita := False;

    FblnMinMaxSeg := TipoEstoqueSeguranca <> tpesIndefinido;
    FtpesMinMaxSeg := TipoEstoqueSeguranca;

    fltMltCom := 0;
    fltMltVen := 0;

    With cdsItens Do
    Begin

      Try

        If blnRelatorio Then
          Result := fieldbyname('NECCOM').AsFloat
        Else If (blnLimSal)  Then
          Result := fieldbyname('NECORI').AsFloat
        Else
          Result := fieldbyname('NECCOM').AsFloat;

        If blnUsaNecOri Then
        Begin
          If (FieldByName('PERACU').AsFloat >= 100) Then
            Exit;
        End;

        fltMltCom := RoundTo(fieldbyname('MLTCOM').AsFloat, -6);

        If fltMltCom = 0 Then
          fltMltCom := 1;

        If (Assigned(cdsItens.FindField('MLTVEN'))) Then
          fltMltVen := cdsItens.FindField('MLTVEN').AsFloat
        Else
          fltMltVen := 1;

        If fltMltVen = 0 Then
          fltMltVen := 1;

        If blnLimSal Then
        Begin
          If fltSaldoCD = 0 Then
            Exit;

          If (tpMultiplo = tpmlCompra) And SameText(fieldbyname('ABAMLT').AsString, 'S') And (fltSaldoCD < fltMltCom) Then
            Exit;

          If (tpMultiplo = tpmlVenda) And (Assigned(cdsItens.FindField('MLTVEN'))) And (fltSaldoCD < fltMltVen) Then
            Exit;
        End;

        If blnUsaNecOri Then
        Begin

          If fltPerGra > 0 Then
          Begin
            Result := Fieldbyname('NECORI').AsFloat * (fltPerGra / 100);
            Result := Ceil(Result);
          End Else
          Begin
            Result := Fieldbyname('NECORI').AsFloat;
          End;

        End;

        If (tpMultiplo = tpmlCompra) And SameText(fieldbyname('ABAMLT').AsString, 'S') Then
        Begin
          fltQtdIte := Trunc(Result / fltMltCom);

          fltResto := RoundTo(Result - fltQtdIte * fltMltCom, -4);

          If fltResto > 0 Then
            Result := (fltQtdIte + 1) * fltMltCom;

          If blnLimSal Then
          Begin

            While (fltSaldoCD < Result) And (fltQtdIte > 0) Do
            Begin
              blnLimita := True;

              Result := fltQtdIte * fltMltCom;
              fltQtdIte := fltQtdIte - 1;
            End;

          End;

        End

        Else If (tpMultiplo = tpmlVenda) And (Assigned(cdsItens.FindField('MLTVEN'))) Then
        Begin

          fltQtdIte := Trunc(Result / fltMltVen);

          fltResto := RoundTo(Result - fltQtdIte * fltMltVen, -4);

          If fltResto > 0 Then
            Result := (fltQtdIte + 1) * fltMltVen;

          If blnLimSal Then
          Begin

            While (fltSaldoCD < Result) And (fltQtdIte > 0) Do
            Begin
              blnLimita := True;

              Result := fltQtdIte * fltMltVen;
              fltQtdIte := fltQtdIte - 1;
            End;

          End;

        End;
      Finally

      If FblnMinMaxSeg Then
        blnSaldoEmpMenoSaldoCD := ((cdsItens.fieldbyname('SALDCD').AsFloat - cdsItens.fieldbyname(strFieldMaxMinSeg).AsFloat) < Result)
      Else
        blnSaldoEmpMenoSaldoCD := (cdsItens.fieldbyname('SALDCD').AsFloat < Result);

        If (Result > fltSaldoCD) And blnLimSal Then
        Begin
          blnLimita := True;

          If fltSaldoCD < 0 Then
            Result := 0
          Else
            Result := fltSaldoCD;
        End;

        fltCalcul := Result;

        If fltPerGra > 0 Then
        Begin
          Result := fieldbyname('NECCOM').AsFloat + Result;

          If tpMultiplo = tpmlIndefinido Then
          Begin

            If Result > fieldbyname('NECORI').AsFloat Then
            Begin
              fltCalcul := fltCalcul - (Result - fieldbyname('NECORI').AsFloat);
              Result    := fieldbyname('NECORI').AsFloat;
            End;

          End;
        End;

        If FblnMinMaxSeg Then
        Begin
          If (blnAtingiuEstMin) Then
          Begin
            fltCalcul := 0;
          End;

          If (cdsItens.fieldbyname('SALDCD').AsFloat >= cdsItens.fieldbyname(strFieldMaxMinSeg).AsFloat) Then
          Begin
            If ((cdsItens.fieldbyname('SALDCD').AsFloat - Result) < cdsItens.fieldbyname(strFieldMaxMinSeg).AsFloat) Then
            Begin
              If (Not blnAtingiuEstMin) Then
                fltCalcul := Result - (Result - (cdsItens.fieldbyname(strFieldMaxMinSeg).AsFloat - (cdsItens.fieldbyname('SALDCD').AsFloat - Result)));

              blnAtingiuEstMin := True;

              Result :=  Result - (cdsItens.fieldbyname(strFieldMaxMinSeg).AsFloat - (cdsItens.fieldbyname('SALDCD').AsFloat - Result));

              If (Result = 0) And (fltSaldoCD > 0) Then
              Begin
                fltCalcul := fltSaldoCD;
              End;

              If (tpMultiplo = tpmlCompra) And SameText(fieldbyname('ABAMLT').AsString, 'S') Then
              Begin
                fltQtdIte := Trunc(Result / fltMltCom);

                fltResto := RoundTo(Result - fltQtdIte * fltMltCom, -4);

                If fltResto > 0 Then
                  Result := (fltQtdIte - 1) * fltMltCom;
              End;

              If (tpMultiplo = tpmlVenda) And (Assigned(cdsItens.FindField('MLTVEN'))) Then
              Begin
                fltQtdIte := Trunc(Result / fltMltVen);

                fltResto := RoundTo(Result - fltQtdIte * fltMltVen, -4);

                If fltResto > 0 Then
                  Result := (fltQtdIte - 1) * fltMltVen;
              End;
            End;
          End
          Else
          Begin
             Result := 0;
             blnAtingiuEstMin := True;
          End;
        End;

      End;
    End;
  Finally
    If Result < 0 Then
      Result := 0;
    If (Result > 0) And (FblnMinMaxSeg) And (blnSaldoEmpMenoSaldoCD) And
       ((cdsItens.fieldbyname('SALDCD').AsFloat - cdsItens.fieldbyname(strFieldMaxMinSeg).AsFloat) >= Result) Then
      blnSaldoEmpMenoSaldoCD := False;

    Result := fFormataFloat(Result, intDecQtd); 
  End;
End;

procedure TRelGeraOR.pIncluiPedidoPorGrupoUnidade(cdsConsulta: TUniClientDataSet; strCodEmp: String = ''; blnQuantidadeJaCalculada: Boolean = False);
  Var
    cdsItens: TUniClientDataSet;
    stlGrupos: TStringList;
    intGrupo: Integer;
begin
  If cdsConsulta.FindField('UNIGRU') = Nil Then
  Begin
    pIncluiPedido(cdsConsulta, '', strCodEmp, blnQuantidadeJaCalculada);
    Exit;
  End;

  cdsItens := TUniClientDataSet.Create(Self);
  cdsItens.Data := cdsConsulta.Data;
  cdsItens.DisableControls;

  cdsItens.Filter   := 'MARDES = ' + QuotedStr('M') + IIF(fEmptyStr(strCodEmp), '', ' AND CODEMP = ' + QuotedStr(strCodEmp));

  cdsItens.Filtered := True;

  stlGrupos := TStringList.Create;
  stlGrupos.Sorted := True;
  stlGrupos.Duplicates := dupIgnore;

  cdsItens.First;
  While Not cdsItens.Eof Do
  Begin
    stlGrupos.Add(cdsItens.FieldByName('UNIGRU').AsString);
    cdsItens.Next;
  End;

  For intGrupo := 0 To stlGrupos.Count -1 Do
    pIncluiPedido(cdsConsulta, stlGrupos[intGrupo], strCodEmp, blnQuantidadeJaCalculada);

  FreeAndNil(cdsItens);
  FreeAndNil(stlGrupos);
end;

procedure TRelGeraOR.pLimparEnderecoEntrega;
begin
  FillChar(objEndEnt.recEndere, SizeOf(objEndEnt.recEndere), #0);
end;

procedure TRelGeraOR.pIncluiPedido(cdsConsulta: TUniClientDataSet; strUniGru: String = ''; strCodEmp: String = ''; blnQuantidadeJaCalculada: Boolean = False);
  Var
    qryAux      : TUniQuery;
    strCodConPgt: String;
    strConPgtMas: String;
    strNumDoc   : String;
    fltCalcul,
    fltTotGer   : Double;
    fltQtdIte   : Double;
    fltTotCus   : Double;
    fltTotMed   : Double;
    fltTotPes   : Double;
    fltTotVol   : Double;
    strTabPre   : String;
    strAutInc   : String;
    strAutLdg,
    strAutIncFdo: String;
    strIndice   : String;
    strEntRet   : String;
    cdsItens    : TUniClientDataSet;
    blnLimita   : Boolean;
    blnConfirma : Boolean;
    blnAtingiuEstoqueMinimo: Boolean;
    recServicos : TDadosServicos;
    intIndex,
    intContador,
    intContItem,
    intItensPorPedido,
    intPosIniQryItens,
    intQtdPedidos : Integer;
    impSeparacao  : TFatVendaImp;
    ArrRecSepara  : Array of TDadosImpressaoVenda;
    blnSaldoEmpMenoSaldoCD: Boolean;
    arrDuplic : TarrDuplicata;

    intQtdAut: Integer;

    function fRetDesIte(strDesIte, strRefIte : String) : String;
    begin
      If (fCfgSis('IMPREF', varBoolean)) Then
      Begin
        If (fCfgSis('MONDES', varString) = '1') Then
          Result := strDesIte + IIF(Not fEmptyStr(strRefIte),' ' + strRefIte,'')
        Else
          Result := IIF(Not fEmptyStr(strRefIte),strRefIte + ' ','') + strDesIte;
      End
      Else
        Result :=  strDesIte;
    end;

Begin
  blnConfirma := False;
  Try
    if not fCarregarConfigParaGerarOrcamento(strConPgtMas, strCodConPgt) then
       Exit;

    fStartTransaction;
    SetLength(ArrRecSepara, 0);

    strIndice := cdsConsulta.IndexFieldNames;
    If (strIndice = '') Then
      strIndice := 'DESITE';

    cdsItens := TUniClientDataSet.Create(Self);
    cdsItens.Data := cdsConsulta.Data;
    cdsItens.DisableControls;

    cdsItens.Filter := 'MARDES = ' + QuotedStr('M') + IIF(fEmptyStr(strCodEmp), '', ' AND CODEMP = ' + QuotedStr(strCodEmp));

    If Not fEmptyStr(strUniGru) Then
      cdsItens.Filter := cdsItens.Filter + ' AND UNIGRU = ' + QuotedStr(strUniGru);

    cdsItens.Filtered := True;

    If strIndice <> '' Then
      cdsItens.IndexFieldNames := strIndice;

    qryAux      := fCriaQuery(Self);

    blnGerou := True;

    cdsItens.First;

    If Not cdsItens.IsEmpty Then
      strCliFil := fCampoTabela('EMP_CLIFIL', 'CADEMP', ['EMP_CODEMP'], [cdsItens.FieldByName('CODEMP').AsString]);

    intItensPorPedido := fCfgSis('QTIPDV', varInteger);
    if intItensPorPedido <= 0 Then
      intItensPorPedido := cdsItens.RecordCount;

    intQtdPedidos     := cdsItens.RecordCount Div intItensPorPedido;

    intContador := 0;

    While (Not(cdsItens.Eof)) And (intContador <= intQtdPedidos) Do
    Begin
      If SameText('OR', strEspDoc) Then
        strNumDoc := fRetSequencial('PRO_OR', '', fTamDocCadRec)
      Else
        strNumDoc := fRetSequencialPedido;

      intPosIniQryItens := cdsItens.RecNo;
      fltQtdIte := 0;
      intContItem := 1;

      While (Not(cdsItens.Eof)) And (intContItem <= intItensPorPedido) Do
      Begin
        If blnQuantidadeJaCalculada Then
          fltQtdIte := fltQtdIte + fFormataFloat(cdsItens.Fieldbyname('NECCOM').AsFloat, intDecQtd)
        Else
          fltQtdIte := fltQtdIte + fRetQuantidade(cdsItens, tpTipoMultiplo, blnAutoma, blnLimita, cdsItens.Fieldbyname('SALDCD').AsFloat, 0, fltCalcul, blnAtingiuEstoqueMinimo, blnSaldoEmpMenoSaldoCD);

        cdsItens.Next;
        Inc(intContItem);
      End;

      If fltQtdIte > 0 Then
      Begin
        //Quando EoF ao definir a linha no cds a property DataSet.Eof não volta para false
        //Fazendo-se necessario esta valição
        If cdsItens.Eof Then
          cdsItens.Prior;
        {----------------------------------}

        cdsItens.RecNo := intPosIniQryItens;


        fltTotGer := 0.0;
        fltTotCus := 0.0;
        fltTotMed := 0.0;
        fltTotPes := 0.0;
        fltTotVol := 0.0;

        intQtdAut := 0;

        intContItem := 1;
        While (Not(cdsItens.Eof)) And (intContItem <= intItensPorPedido) Do
        Begin
          Application.ProcessMessages;

          If blnQuantidadeJaCalculada Then
            fltQtdIte := fFormataFloat(cdsItens.Fieldbyname('NECCOM').AsFloat, intDecQtd)
          Else
            fltQtdIte := fRetQuantidade(cdsItens, tpTipoMultiplo, blnAutoma, blnLimita, cdsItens.Fieldbyname('SALDCD').AsFloat, 0, fltCalcul, blnAtingiuEstoqueMinimo, blnSaldoEmpMenoSaldoCD);

          If fltQtdIte > 0 Then
          Begin
            Inc(intQtdAut);

            fltTotGer := fltTotGer + fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat)), 2);
            fltTotCus := fltTotCus + fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('PRECUS').AsFloat)), 2);
            fltTotMed := fltTotMed + fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('PREMED').AsFloat)), 2);
            fltTotPes := fltTotPes + fFormataFloat((fltQtdIte * cdsItens.FieldByName('PESOIT').AsFloat), 2);
            fltTotVol := fltTotVol + fCalcVolumes(cdsItens.FieldByName('CODITE').AsString, fltQtdIte, fCampoTabela('ITE_EMBALA', 'CADITE', ['ITE_CODITE'], [cdsItens.FieldByName('CODITE').AsString], False));
          End;
          inc(intContItem);
          cdsItens.Next;
        End;

        strTabPre := fRetTabelaPreco(strCliFil, strLoginUsuarioLogado);

        {******************}
        {* GRAVA - FATGOR *}
        {***************LU*}
        strAutInc := fstrEspaco(' ', 20);

        If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
          objOcoCrm := fAtualizaInformacoesCRM(strNumDoc,strEspDoc,VS_strCodEmp,strCliFil,'','',strLoginUsuarioLogado,IIF(strEspDoc = 'OR',afcOrcamento,afcPedido));

        SetLength(ArrRecSepara, Length(ArrRecSepara) + 1);
        ArrRecSepara[High(ArrRecSepara)].strNumDoc := strNumDoc;
        ArrRecSepara[High(ArrRecSepara)].strEspDoc := strEspDoc;
        ArrRecSepara[High(ArrRecSepara)].strCodCli := strCliFil;
        ArrRecSepara[High(ArrRecSepara)].strEmpDoc := VS_strCodEmp;
        ArrRecSepara[High(ArrRecSepara)].strCodVen := strLoginUsuarioLogado;

        sltOrcamentos.Add(strEspDoc + '-' + strNumDoc + '-' + VS_strCodEmp);

        FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

        //IIF(fCfgSis('ENT_CD', VarBoolean), blnAutoma Or (Not fEmptyStr(strEmp_CD)), False)  ,  // Entrega pelo CD
        blnENT_CD := False;
        If fCfgSis('ENT_CD', VarBoolean) And blnAutoma Then
         blnENT_CD := True
        Else If (Not fEmptyStr(strEmp_CD)) And fCfgSis('ENT_CD', VarBoolean, strEmp_CD ) And (strEmp_CD = fCfgSis('EMP_CD', varString, strEmp_CD)) Then
          blnENT_CD := True;

        blnConfirma := fGravaFatGor(strAutInc,
                     VS_strCodEmp,
                     strNumDoc,
                     strEspDoc,
                     strCliFil,
                     strLoginUsuarioLogado,
                     strCodTra,
                     '',
                     VS_Date,
                     fTime(),
                     strConPgtMas,
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     0,
                     '',
                     '',
                     '',
                     '',
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     fltTotGer,
                     fltTotGer,
                     fltTotCus,
                     fltTotMed,
                     IIF(strEspDoc = 'OR', '1', strTipFre),
                     fltValFre,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     0.0,
                     fltTotPes,
                     fltTotPes,
                     fltTotVol,
                     arrDuplic,
                     '',
                     '',
                     strMen001,
                     strMen002,
                     False,
                     '',
                     '',
                     '',
                     0,
                     '',
                     '',
                     0.0,
                     0.0,
                     strLoginUsuarioLogado,
                     strCodConPgt,
                     IIF(fCfgSis('USAFPG', varBoolean), fCfgSis('FPORPD'), ''),
                     recServicos,
                     'N',
                     dtaPrevis,
                     0,
                     VS_Date,
                     '',
                     strTipPed,
                     '',
                     0,
                     strEntFat,
                     0,
                     strTabPre,
                     'N',
                     0.0,
                     '',
                     IIF(fCfgSis('ENT_CD', VarBoolean), IIF(blnAutoma, fCfgSis('EMP_CD'), strEmp_CD), ''),  // Empresa CD
                     blnENT_CD,  //IIF(fCfgSis('ENT_CD', VarBoolean), blnAutoma Or (Not fEmptyStr(strEmp_CD)), False)  ,  // Entrega pelo CD
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     FALSE,
                     VS_Date,
                     'N',
                     'V',
                     VS_Date,
                     'P',
                     0,
                     objEndEnt.recEndere.strIncrem,             //strAutEnt -> Endereço Entrega
                     '',
                     '',
                     False,
                     '',
                     Nil,
                     IIF(blnAutoma, fCfgSisL('EMP_CD'), strEmp_CD),
                     strEmp_TE,
                     0,
                     0,
                     0,
                     '',
                     objOcoCrm,
                     IFThen(((fCfgSis('UTIPEN', VarBoolean))
                        And (Pos(fCfgSis('TIPEXP'), '3_4_') > 0)), fCfgSis('PENTRA', varString) , ''),  // strgerpen // gera pendencia // grava sugestao,
                     0,
                     0,
                     '',
                     '',
                     0,
                     '',
                     0,
                     '',
                     '',
                     '',
                     'N',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     'S',
                     False,            // blnGravarDavPv
                     false,            // blnAlterado
                     0,                // dtaImpSep
                     0,                // horImpSep
                     '',               // strNumPedRefOR
                     '',               // strEmpPedRefOR
                     '',               // strLatitu
                     '',               // strLongit
                     '',               // strRaio__
                     nil,              // objFazenda
                     'S',              // strEnvLib
                     0,                // fltFreRat
                     '',               // strNumPedAba
                     '',               // strEspPedAba
                     '',               // strEmpPedAba
                     '',               // strObsL01
                     '',               // strObsL02
                     'N',              // strVenPre
                     'N',              // strTemBri
                     'N',              // strEdiPes
                     0,                // fltTaxEnt
                     '',               // strCodSup
                     'N',              // strOrcEsp
                     '',               // strProspe
                     '',               // strCodOco
                     False,            // blnImpSfaPag
                     '',               // strCodEmbarcacao
                     0,                // fltDesOpeGor
                     '',               // strCliCon
                     '',               // strInRqCp
                     '',               // strOriGor
                     '',               // strBarCom
                     'S',              // strPD_Exp
                     0,                // dtaValOrc
                     '',               // strCodRot
                     0,                // fltTotBri
                     0,                // fltBolAdt
                     False,            // blnBolVen
                     0,                // fltTaxJur
                     'N',              // strFatTot
                     '',               // strTraRdp
                     '',               // strCliLoj
                     '',               // strSeqDmp
                     0,                // dtaDtFiCo
                     0,                // dtaDtInCo
                     0,                // dtaDtInSe
                     0,                // dtaDtBxSe
                     0,                // hraHrFiCo
                     0,                // hraHrInCo
                     0,                // hraHrInSe
                     0,                // hraHrBxSe
                     nil,              // cdsExpRet
                     'N',              // strUsaQue
                     '',               // strDocQue
                     '',               // strCodPrj
                     '',               // strTpOper
                     '',               // strNLeads
                     '',               // strCupDes
                     'S',              // strNotPau
                     0,                // dtaDtCtVn
                     0,                // fltVlCtVn
                     '',               // strCodCat
                     '',               // strMen003
                     '',               // strMen004
                     'GERACAO TE');    // strMen005

        prgProgre.Properties.Max := Succ(cdsItens.RecordCount);
        prgProgre.Position := prgProgre.Position + 1;
        Application.ProcessMessages;

        {******************}
        {* GRAVA - FATDOR *}
        {***************LU*}
        //Quando EoF ao definir a linha no cds a property DataSet.Eof não volta para false
        //Fazendo-se necessario esta valição
        If cdsItens.Eof Then
          cdsItens.Prior;
        {----------------------------------}
        cdsItens.RecNo := intPosIniQryItens;

        intContItem := 1;

        strEntRet := '';
        If fCfgSis('ENTFAT', varBoolean) Then
        Begin
          If SameText(strEntFat,'S') Then
            strEntRet := 'E'
          Else
            strEntRet := 'R';
        End
        Else
        Begin
          If fCfgSis('TPITEX', VarString) = 'T' Then
            strEntRet := 'E'
          Else
            strEntRet := fCfgSis('TPITEX');
        End;

        strAutIncFdo := fRetAutoIncrem('FATDOR', VS_strCodEmp, intQtdAut);
        strAutLdg    := fRetAutoIncrem('LOGDOR', VS_strCodEmp, intQtdAut);

        While (Not cdsItens.Eof) And (intContItem <= intItensPorPedido) Do
        Begin
          Application.ProcessMessages;
          Inc(intContItem);

          If blnQuantidadeJaCalculada Then
            fltQtdIte := fFormataFloat(cdsItens.Fieldbyname('NECCOM').AsFloat, intDecQtd)
          Else
            fltQtdIte := fRetQuantidade(cdsItens, tpTipoMultiplo, blnAutoma, blnLimita, cdsItens.Fieldbyname('SALDCD').AsFloat, 0, fltCalcul, blnAtingiuEstoqueMinimo, blnSaldoEmpMenoSaldoCD);

          If fltQtdIte > 0 Then
          Begin
            fltTotGer := fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat)), 2);
            fltTotCus := fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('PRECUS').AsFloat)), 2);
            fltTotMed := fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('PREMED').AsFloat)), 2);
            fltTotPes := fFormataFloat((fltQtdIte * cdsItens.FieldByName('PESOIT').AsFloat), 2);

            blnConfirma := blnConfirma And fGravaFatDor(strAutIncFdo,
                         strAutInc,
                         VS_strCodEmp,
                         strCliFil,
                         strLoginUsuarioLogado,
                         cdsItens.FieldByName('CODITE').AsString,
                         cdsItens.FieldByName('CODMAR').AsString,
                         '',
                         strNumDoc,
                         strEspDoc,
                         '',
                         VS_Date,
                         fTime(),
                         strConPgtMas,
                         '',
                         fRetDesIte(cdsItens.FieldByName('DESITE').AsString, cdsItens.FieldByName('REFERE').AsString),
                         cdsItens.FieldByName('REFERE').AsString,
                         cdsItens.FieldByName('UNIDAD').AsString,
                         cdsItens.FieldByName('CODFOR').AsString,
                         fltQtdIte,
                         fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat),
                         fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat),
                         fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat),
                         fltTotGer,
                         fltTotGer,
                         fltTotCus,
                         fltTotMed,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         strLoginUsuarioLogado,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         copy(VS_strClaVen,1,4),
                         '000',
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         0.0,
                         fltTotGer,
                         0.0,
                         0.0,
                         0.0,
                         fltTotPes,
                         0.0,
                         0.0,
                         False,
                         '',
                         '',
                         '',
                         0,
                         '',
                         '',
                         0.0,
                         'NOR',
                         cdsItens.FieldByName('INCPIS').AsString,
                         strLoginUsuarioLogado,
                         strCodConPgt,
                         '',
                         IIF(fCfgSis('USAFPG', varBoolean), fCfgSis('FPORPD'), ''),
                         '',
                         '',
                         '',
                         '',
                         0.0,
                         0.0,
                         '',
                         0.0,
                         0.0,
                         0.0,
                         '',
                         '',
                         0,
                         'N',
                         '',
                         0.0,
                         0,
                         0.0,
                         fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat),
                         '',
                         0.0,
                         '',
                         '',
                         FALSE,
                         strTabPre,
                         '',
                         '',
                         '',
                         0.0,
                         '',
                         0.0,
                         strEntRet,
                         '',
                         'N',
                         '',
                         VS_date,
                         fltTotCus,
                         0,
                         0,
                         '',
                         cdsItens.FieldByName('NUMLOT').AsString,
                         '',
                         False,
                         IIF(blnEmpFat, IIF(((Not fEmptyStr(strEmp_CD)) And (fCfgSis('ENT_CD', VarBoolean))), strEmp_CD, VS_strCodEmp), IIf(strEmp_CD = '', VS_strCodEmp, strEmp_CD)),
                         '',
                         '',
                         '',
                         IIF(blnAutoma, fCfgSisL('EMP_CD'), strEmp_CD),
                         '',
                         0,
                         0,
                         '',
                         '',
                         0,
                         '',
                         '',
                         0,
                         0,
                        cdsItens.FieldByName('PESOIT').AsFloat,
                        'N', // strAltPCo: String = 'N';
                        'N', // strCliBus: string = 'N';
                        '',  // strTurEnt: String = '';
                        0,   // fltVal_RT: Double = 0;
                        0,   // fltTaxJur: Double = 0;
                        False, // blnInseridoOuAlterado: Boolean=False;
                        '',  // strLotAba: String = '';
                        '',  // strLotAnt: String = '';
                        '',  // strIncFut: String = '';
                        0,   // fltSerRat: Double = 0;
                        '',  // strSepExp: String = '';
                        0,   // fltFreRat: Double = 0;
                        'N', // strPigBas: String = 'N';
                        '',  // strIncDev: String = '';
                        '',  // strSeqOpI: String = '';
                        'N', // strBrinde: String = 'N';
                        '',  // strCodPar: String = '';
                        '',  // strTipBri: String = '';
                        '',  // strBaqtze: String = '';
                        0,   // fltDesMax: Double = 0;
                        0,   // fltValFle: Double = 0;
                        'N', // strPegou_: String = 'N';
                        0,   // fltTaxEnt: Double = 0;
                        'N', // strAtivac: String = 'N';
                        0,   // intSeqCom: Integer = 0;
                        0,   // fltQtdAti: Double = 0;
                        0,   // fltQtdCom: Double = 0;
                        '',  // strTabCom: String = '';
                        '',  // strDesNes: String = '';
                        False, // blnIcmSai: Boolean = False;
                        0,   // fltIcmPav: Double = 0;
                        0,   // fltIcmSai: Double = 0;
                        0,   // fltImpFed: Double = 0;
                        0,   // fltDesOpe: Double = 0;
                        0,   // fltAlDifa: Double = 0;
                        '',  // strAutDet: String = '';
                        0,   // fltValFCP: Double = 0;
                        0,   // fltPesBru: Double = 0;
                        0,   // intSeqUlt: Integer = 0;
                        0,   // intQDEntr: Integer = 0;
                        '',  // strNcmTin: String = '';
                        '',  // strNotC17: String = '';
                        0,   // fltAlq922: Double = 0;
                        '',  // strCodCmg: String = '';
                        0,   // fltQtdSep: Double = 0;
                        0,   // fltDesCnd: Double = 0;
                        0,   // intSeqEst: Integer = 0;
                        '',  // strIteEst: String = '';
                        0,   // fltUniEst: Double = 0;
                        0,   // fltQtdSbi: Double = 0;
                        0,   // fltUniSbi: Double = 0;
                        0,   // fltFreMkp: Double = 0;
                        0,   // fltComMkp: Double = 0;
                        '',  // strProEsp: String = '';
                        '',  // strVenCbo: String = '';
                        '',  // strCodPro: String = '';
                        0,   // fltUniDol: Double = 0;
                        0,   // fltTotDol: Double = 0;
                        0,   // fltQtdRco: Double = 0;
                        True, // blnExiBSe: Boolean = True;
                        '',  // strAIdKitPromocao : String = '';
                        '',  // strOpBxSe: String = '';
                        0,   // dtaDtBxSe: TDateTime = 0;
                        0,   // dtaHrBxSe: TDateTime = 0;
                        '',  // strEmpCar: String = '';
                        0,   // fltDesBai: Double = 0;
                        '',  // strTemNumSerie: String = '';
                        0,   // fltVDesST: Double = 0;
                        '',  // strMDesST: String = '';
                        'S', // strReserv: String = 'S';
                        0,   // intSeqInv: Integer = 0 ;
                        '',  // strSeqEql: String = '';
                        '',  // strNumDrw: String = '';
                        False, // blnMntPrc: Boolean = False;
                        0,   // fltQtdRet: Double = 0;
                        '',  // strNumPla: String = '';
                        '',  // strParNum: String = '';
                        '',  // strReqCom: String = '';
                        '',  // strAutEnd: String = '';
                        '',  // strRegEsp: String = '';
                        0,   // fltFreCot: Double = 0;
                        False, // blnAltEst: Boolean = False;
                        0,   // intSeqPer: Integer = 0;
                        False, // blnRatEst: Boolean = False;
                        '',  // strObsRco: String = '';
                        '',  // strNumPok: String = '';
                        '',  // strDocOri: String = '';
                        '',  // strEspOri: String = '';
                        '',  // strEmpOri: String = '';
                        '',  // strOpeSep: String = '';
                        '',  // strOpeExp: String = '';
                        '',  // strEmpDmp: String = '';
                        0,   // fltUnDiDe: Double = 0;
                        '',  // strBasTro: String = '';
                        0,   // dtaDtaCmp: TDateTime = 0;
                        0,   // fltOutValPD: Double = 0;
                        0,   // fltFreEntPD: Double = 0;
                        0,   // fltAcpProPD: Double = 0;
                        0,   // fltAcpTxcPD: Double = 0;
                        0,   // fltAcpVctPD: Double = 0;
                        0,   // fltAcpResPD: Double = 0;
                        0,   // fltAcpMarPD: Double = 0;
                        '',  // strTckQbt: String = '';
                        '',  // strSeqPre: String = '';
                        0,   // fltSomaColorantes : Double = 0;
                        strAutLdg);

            strAutIncFdo := fNextAutoIncrem(strAutIncFdo);
            strAutLdg    := fNextAutoIncrem(strAutLdg);
          End; {If fltQtdIte > 0 Then}

          If Not blnConfirma Then
            Break;

          cdsItens.Next;

          prgProgre.Position := prgProgre.Position + 1;
          Application.ProcessMessages;
        End;

      End;
      If Not blnConfirma Then
        Break;
      Inc(intContador);
    End;

    If blnConfirma Then
    Begin
      fCommit;

      TReprocessarSaldoItem.New
        .AddItensDoDocumento(
           TItensReprocessarDoDocumento.New
             .Documento(strNumDoc)
             .Especie(strEspDoc)
             .Empresa(VS_strCodEmp)
           ).ReprocessarSaldoPedidos(prgProgre);

      if (strEspDoc = 'PD') And (fMensagem('ATENÇÃO', 'Deseja imprimir Separação?', ['&Sim', '&Não'], 2) = 1) Then
      Begin
        For intIndex := 0 to Length(ArrRecSepara) -1 Do
        Begin
          impSeparacao := TFatVendaImp.Create;
          Try
            impSeparacao.fImprimeSeparacao(ArrRecSepara[intIndex], '', '', False);
          Finally
            FreeAndNil(impSeparacao);
          End;
        End;
      End;
    End
    Else
      fRollBack;

    FreeAndNil(qryAux);
    FreeAndNil(cdsItens);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TRelGeraOR.pIncluiPedido]');
    End;
  End;
End;

procedure TRelGeraOR.pGravaOrcamentos(strCodEmp: String; edtCodigo: TCustomEdit;
   arrLinha: TConsultasArray; strCodEmpCD: String=''; blnAutomatico: Boolean = False;
   prgProgresso: TcxProgressBar = Nil; blnGirEst: Boolean = False; intQtdGirEst: Integer = 0);
Var
  strAviso,
  strSQL      : String;
  qryEmpresas : TUniQuery;
  qryItens    : TZClient;
  strEmp      : String;
  stlLisEmp   : TStringList;
  intIndex    : Integer;
  frmRelEstItemsAbaixoMin_ItensOrc: TfrmRelEstItemsAbaixoMin_ItensOrc;
Begin
  Try

    Try
      blnAutoma := blnAutomatico;

      If (Not Assigned(fGravaFatGor)) Or (Not Assigned(fGravaFatDor)) Then
      Begin
        fMensagem('AVISO','Relatório não pode ser gerado.', ['&O K']);
        Exit;
      End;

      qryEmpresas := fCriaQuery(Self);
      qryItens    := TZClient.Create(Self);

      With TAggregateField.Create(qryItens) Do
      Begin
        Name          := 'SUM_NECCOM';
        FieldName     := 'SUM_NECCOM';
        Expression    := 'SUM(NECTOT)';
        DisplayFormat := '#,##0.00';
        DataSet       := qryItens;
        Active        := True;
        Alignment     := Classes.taRightJustify;
      End;

      With TAggregateField.Create(qryItens) Do
      Begin
        Name          := 'SUM_PESTOT';
        FieldName     := 'SUM_PESTOT';
        Expression    := 'SUM(PESTOT)';
        DisplayFormat := '#,##0.000';
        DataSet       := qryItens;
        Active        := True;
        Alignment     := Classes.taRightJustify;
      End;

      blnGerou    := False;

      {*********************************************}
      {* BUSCA AS EMPRESAS E SEUS CLIENTES FILIAIS *}
      {******************************************LU*}
      strSQL := '';
      strSQL := strSQL + ' SELECT SQL_NO_CACHE ' ;
      strSQL := strSQL + '   EMP_CODEMP, ' ;
      strSQL := strSQL + '   EMP_CLIFIL ' ;
      strSQL := strSQL + ' FROM ' ;
      strSQL := strSQL + '   CADEMP ' ;
      strSQL := strSQL + ' WHERE ' ;

      If Assigned(arrLinha) Then
        strSQL := strSQL + fStrLocate(edtCodigo, arrLinha, 'EMP_CODEMP', 'CODEMP', True)
      Else
      Begin
        If Not fEmptyStr(strCodEmp) Then
          strSQL := strSQL + '  EMP_CODEMP = :CODEMP '
        Else
          strSQL := strSQL + '  LOCATE(EMP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
      End;

      With qryEmpresas Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        If Assigned(arrLinha) Then
          pSetaParam(edtCodigo.Text, arrLinha, strEmp, 'CODEMP', qryEmpresas)
        Else
        Begin
          If Not fEmptyStr(strCodEmp) Then
            ParamByName('CODEMP').AsString := strCodEmp;
        End;

        Open;
      End;

      sltOrcamentos.Clear;

      If Not fCfgSis('TRPDAB', VarBoolean) Then
      Begin
        strAviso := '';

        stlLisEmp := TStringList.Create;
        stlLisEmp.CommaText := strEmpresas;

        While Not qryEmpresas.Eof Do
        Begin

          If fTemPedidosEmAbertos(qryEmpresas.FieldByName('EMP_CLIFIL').AsString) Then
          Begin
            strAviso := strAviso + ' ' + qryEmpresas.FieldByName('EMP_CODEMP').AsString;

            If stlLisEmp.Find(qryEmpresas.FieldByName('EMP_CODEMP').AsString, intIndex) Then
              stlLisEmp.Delete(intIndex);
          End;

          qryEmpresas.Next;
        End;

        If Not fEmptyStr(strAviso) Then
        Begin
          pMensagemOk('A(s) empresa(s) ' + Trim(strAviso) + ' tem documento(s) ' +
                      'de transferência que não foram faturados.' + #13 + 'Não serão emitidos novos documentos!');
        End;

        strEmpresas := stlLisEmp.CommaText;

        FreeAndNil(stlLisEmp);

      End;

      If fEmptyStr(strEmpresas) Then
        Exit;

        {******************************************************}
        {* BUSCANDO OS ITENS DOS ORÇAMENTOS PARA CADA EMPRESA *}
        {***************************************************LU*}
        pCriarFormularios(TfrmRelEstItemsAbaixoMin_ItensOrc, frmRelEstItemsAbaixoMin_ItensOrc);
        frmRelEstItemsAbaixoMin_ItensOrc.strEmpCD := strEmp_TE;
        frmRelEstItemsAbaixoMin_ItensOrc.strEspDoc := strEspDoc;
        frmRelEstItemsAbaixoMin_ItensOrc.blnApenasSaldoCDMenorSaldoEmp := blnApenasSaldoCDMenorSaldoEmp;

        frmRelEstItemsAbaixoMin_ItensOrc.pSetaTipoSaldoCD(tipSaldoCD, strAliquotaSaldoCD);

        frmRelEstItemsAbaixoMin_ItensOrc.blnCalcVendaPorDia := blnCalcVendaPorDia;
        frmRelEstItemsAbaixoMin_ItensOrc.objGeraOr           := Self;

        frmRelEstItemsAbaixoMin_ItensOrc.strCodEmpCD := strCodEmpCD;

        If Not Assigned(prgProgresso) Then
          prgProgresso := frmRelEstItemsAbaixoMin_ItensOrc.prbProgesso;

        pAbreQueryItens(strEmpresas, qryItens, strCodEmpCD);

        pSetaClient(qryItens);
        frmRelEstItemsAbaixoMin_ItensOrc.FblnMinMaxSeg := (FtpesMinMaxSeg <> tpesIndefinido);
        frmRelEstItemsAbaixoMin_ItensOrc.FstrFieldMaxMinSeg := IIf(FtpesMinMaxSeg = tpesMaximo, 'CD_ESTMAX','CD_ESTMIN');

        If Not qryItens.IsEmpty Then
        Begin

          frmRelEstItemsAbaixoMin_ItensOrc.cdsConsulta.Data := qryItens.Data;

          frmRelEstItemsAbaixoMin_ItensOrc.cdsConsulta.FieldByName('CODITE').Alignment := taCenter;
          frmRelEstItemsAbaixoMin_ItensOrc.cdsConsulta.FieldByName('CODEMP').Alignment := taCenter;

          frmRelEstItemsAbaixoMin_ItensOrc.cdsConsulta.IndexFieldNames := qryItens.IndexFieldNames;
          frmRelEstItemsAbaixoMin_ItensOrc.cdsConsultaAfterOpen(frmRelEstItemsAbaixoMin_ItensOrc.cdsConsulta);

          if blnGirEst then
          begin
            frmRelEstItemsAbaixoMin_ItensOrc.cxColGIRITE.Caption := 'Giro ' + IntToStr(intQtdGirEst) + ' meses';
            frmRelEstItemsAbaixoMin_ItensOrc.cxColGIRITE.Visible := True;
          end
          else
            frmRelEstItemsAbaixoMin_ItensOrc.cxColGIRITE.Visible := False;

          {*****************************************************}
          {* EXIBE OS ITENS PARA O USUARIO MARCAR OU DESMARCAR *}
          {**************************************************LU*}
          Try

            frmRelEstItemsAbaixoMin_ItensOrc.lblEmpresa.Caption := 'EMPRESA: ' +
                                                                   qryEmpresas.FieldByName('EMP_CODEMP').AsString + ' - ' +
                                                                   fRetNomeEmpresa(qryEmpresas.FieldByName('EMP_CODEMP').AsString);
            If Not blnAutomatico Then
            Begin
              prgProgre := frmRelEstItemsAbaixoMin_ItensOrc.prbProgesso;

              frmRelEstItemsAbaixoMin_ItensOrc.cxColNECORI.Visible := blnLimSal;
              frmRelEstItemsAbaixoMin_ItensOrc.blnNECORIVisible := blnLimSal;

              If blnLimSal Then
                frmRelEstItemsAbaixoMin_ItensOrc.cxColNECCOM.Caption := 'A Comprar';
              If Not frmRelEstItemsAbaixoMin_ItensOrc.cdsConsulta.IsEmpty Then
                frmRelEstItemsAbaixoMin_ItensOrc.ShowModal;
            End
            Else
            Begin
              prgProgre := prgProgresso;
              frmRelEstItemsAbaixoMin_ItensOrc.pApagarSemSaldoCD;
              frmRelEstItemsAbaixoMin_ItensOrc.btnMarcaTodos.Click;
              frmRelEstItemsAbaixoMin_ItensOrc.btnGravar.Click;
            End;

          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '[TRelGeraOR.pGravaOrcamentos]');
            End;
          End;

        End;

        pFreeAndNil(frmRelEstItemsAbaixoMin_ItensOrc);

     //   qryEmpresas.Next;

    //  End;

      If blnGerou Then
      Begin
        If strEspDoc = 'OR' Then
          fMensagem('','Orçamentos gerados com sucesso! (' + sltOrcamentos.CommaText + ')', ['&OK'])
        Else
          fMensagem('','Pedidos gerados com sucesso! (' + sltOrcamentos.CommaText + ')', ['&OK']);
      End
      Else
      Begin
        If strEspDoc = 'OR' Then
          fMensagem('','Nenhum Orçamento foi gerado!', ['&OK'])
        Else
          fMensagem('','Nenhum Pedido foi gerado!', ['&OK']);
      End;

    Finally

      FreeAndNil(qryEmpresas);
      FreeAndNil(qryItens);

    End;

  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryEmpresas);
      FreeAndNil(qryItens);
			pMensagensErro(E.Message,'[TRelGeraOR.pGravaOrcamentos]');
    End;
  End;
End;

procedure TRelGeraOR.pGravaOrcamentosMaxDistribuido;
  var
   qryEmpresas: TUniQuery;
   qryItens    : TZClient;
   cdsItens    : TUniClientDataSet;

   strNumDoc,
   strTabPre,
   strAutInc,
   strAutLdg,
   strAutIncFdo,
   strConPgtMas,
   strCodConPgt : String;
   blnConfirma,
   blnGerOrc: Boolean;
   fltTotGer,
   fltTotCus,
   fltTotMed,
   fltQtdIte,
   fltTotPes: Double;
   recServicos : TDadosServicos;
   frmRelEstItemsAcimaMax_ItensOrc: TfrmRelEstItemsAcimaMax_ItensOrc;
   arrDuplic   : TarrDuplicata;

   intQtdAut: Integer;
begin
  cdsItens := TUniClientDataSet.Create(Self);
  cdsItens.DisableControls;

  qryItens    := TZClient.Create(Self);

  blnGerOrc   := False;

  qryEmpresas := fCriaQuery(Self);
  Try
    if not fCarregarConfigParaGerarOrcamento(strConPgtMas, strCodConPgt) then
      Exit;


    qryEmpresas.SQL.Add(' SELECT SQL_NO_CACHE ');
    qryEmpresas.SQL.Add('   EMP_CODEMP, ');
    qryEmpresas.SQL.Add('   EMP_CLIFIL ');
    qryEmpresas.SQL.Add(' FROM ');
    qryEmpresas.SQL.Add('   CADEMP ');
    qryEmpresas.SQL.Add(' WHERE ');
    qryEmpresas.SQL.Add('  LOCATE(EMP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ');

    qryEmpresas.Open;

    If qryEmpresas.IsEmpty Then
      Exit;

    pCriarFormularios(TfrmRelEstItemsAcimaMax_ItensOrc, frmRelEstItemsAcimaMax_ItensOrc);
    frmRelEstItemsAcimaMax_ItensOrc.dspConsulta.DataSet := qryItens;

    pAbreQueryItens(VS_strCodEmp, qryItens);
    pSetaClient(qryItens);

    If Not qryItens.IsEmpty Then
    Begin
      frmRelEstItemsAcimaMax_ItensOrc.cdsConsulta.Open;

      frmRelEstItemsAcimaMax_ItensOrc.blnDistribuido := True;
      frmRelEstItemsAcimaMax_ItensOrc.dtsEmpresaDistribuicao :=  FQryEmpresasDestino;
      frmRelEstItemsAcimaMax_ItensOrc.ShowModal;

      blnConfirma := frmRelEstItemsAcimaMax_ItensOrc.blnConfirma;

      If Not blnConfirma Then
        Exit;

      cdsItens.Data := frmRelEstItemsAcimaMax_ItensOrc.cdsConsulta.Data;
      //strIndice := frmRelEstItemsAcimaMax_ItensOrc.cdsConsulta.IndexFieldNames;

      cdsItens.Filter := 'MARDES = ' + QuotedStr('M');
      cdsItens.Filtered := True;

      FQryEmpresasDestino.IndexFieldNames := 'ITE_CODEMP;CODITE';


      While not qryEmpresas.Eof Do
      Begin
        FQryEmpresasDestino.Filtered := False;
        FQryEmpresasDestino.Filter := 'ITE_CODEMP = ' + QuotedStr(qryEmpresas.FieldByName('EMP_CODEMP').AsString) +  ' AND ITE_SALTRA > 0';
        FQryEmpresasDestino.Filtered := True;

        If  FQryEmpresasDestino.IsEmpty Then
        Begin
          qryEmpresas.Next;
          Continue;
        End;
        cdsItens.First;

        fltTotGer := 0.0;
        fltTotCus := 0.0;
        fltTotMed := 0.0;
        fltTotPes := 0.0;

        FQryEmpresasDestino.First;

        intQtdAut := 0;

        While not FQryEmpresasDestino.Eof Do
        Begin
          If cdsItens.Locate('CODITE', FQryEmpresasDestino.FieldByName('CODITE').AsString,[]) Then
          Begin
            fltQtdIte := fFormataFloat(FQryEmpresasDestino.FieldByName('ITE_SALTRA').AsFloat, intDecQtd);

            If fltQtdIte > 0 Then
            Begin
              Inc(intQtdAut);

              fltTotGer := fltTotGer + fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat)), 2);
              fltTotCus := fltTotCus + fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('PRECUS').AsFloat)), 2);
              fltTotMed := fltTotMed + fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('PREMED').AsFloat)), 2);
              fltTotPes := fltTotPes + fFormataFloat((fltQtdIte * cdsItens.FieldByName('PESOIT').AsFloat), 2);
            End;
          End;
          FQryEmpresasDestino.Next;
        End;


        If SameText('OR', strEspDoc) Then
           strNumDoc := fRetSequencial('PRO_OR', '', fTamDocCadRec)
        Else
           strNumDoc := fRetSequencialPedido;

        strTabPre := fRetTabelaPreco(qryEmpresas.FieldByName('EMP_CLIFIL').AsString, strLoginUsuarioLogado);

        strAutInc := fstrEspaco(' ', 20);

        If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
           objOcoCrm := fAtualizaInformacoesCRM(strNumDoc,strEspDoc,VS_strCodEmp,qryEmpresas.FieldByName('EMP_CLIFIL').AsString,'','',strLoginUsuarioLogado,IIF(strEspDoc = 'OR',afcOrcamento,afcPedido));

        sltOrcamentos.Add(strEspDoc + '-' + strNumDoc + '-' + VS_strCodEmp);

        fStartTransaction;
        Try

          FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

          blnConfirma := fGravaFatGor(strAutInc,
                                      VS_strCodEmp,
                                      strNumDoc,
                                      strEspDoc,
                                      qryEmpresas.FieldByName('EMP_CLIFIL').AsString,
                                      strLoginUsuarioLogado,
                                      strCodTra,
                                      '',
                                      VS_Date,
                                      fTime(),
                                      strConPgtMas,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      0,
                                      '',
                                      '',
                                      '',
                                      '',
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      fltTotGer,
                                      fltTotGer,
                                      fltTotCus,
                                      fltTotMed,
                                      IIF(strEspDoc = 'OR', '1', strTipFre),
                                      fltValFre,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      fltTotPes,
                                      fltTotPes,
                                      0,
                                      arrDuplic,
                                      '',
                                      '',
                                      strMen001,
                                      strMen002,
                                      False,
                                      '',
                                      '',
                                      '',
                                      0,
                                      '',
                                      '',
                                      0.0,
                                      0.0,
                                      strLoginUsuarioLogado,
                                      strCodConPgt,
                                      IIF(fCfgSis('USAFPG', varBoolean), fCfgSis('FPORPD'), ''),
                                      recServicos,
                                      'N',
                                      dtaPrevis,
                                      0,
                                      VS_Date,
                                      '',
                                      strTipPed,
                                      '',
                                      0,
                                      strEntFat,
                                      0,
                                      strTabPre,
                                      'N',
                                      0.0,
                                      '',
                                      '',
                                      False,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      FALSE,
                                      VS_Date,
                                      'N',
                                      'V',
                                      VS_Date,
                                      'P',
                                      0,
                                      '',
                                      '',
                                      '',
                                      False,
                                      '',
                                      Nil,
                                      '',
                                      '',
                                      0,
                                      0,
                                      0,
                                      '',
                                      objOcoCrm,
                                      '',
                                      0,
                                      0,
                                      '',
                                      '',
                                      0,
                                      '',
                                      0,
                                      '',
                                      '',
                                      '',
                                      'N',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      'S',
                                      False,            // blnGravarDavPv
                                      false,            // blnAlterado
                                      0,                // dtaImpSep
                                      0,                // horImpSep
                                      '',               // strNumPedRefOR
                                      '',               // strEmpPedRefOR
                                      '',               // strLatitu
                                      '',               // strLongit
                                      '',               // strRaio__
                                      nil,              // objFazenda
                                      'S',              // strEnvLib
                                      0,                // fltFreRat
                                      '',               // strNumPedAba
                                      '',               // strEspPedAba
                                      '',               // strEmpPedAba
                                      '',               // strObsL01
                                      '',               // strObsL02
                                      'N',              // strVenPre
                                      'N',              // strTemBri
                                      'N',              // strEdiPes
                                      0,                // fltTaxEnt
                                      '',               // strCodSup
                                      'N',              // strOrcEsp
                                      '',               // strProspe
                                      '',               // strCodOco
                                      False,            // blnImpSfaPag
                                      '',               // strCodEmbarcacao
                                      0,                // fltDesOpeGor
                                      '',               // strCliCon
                                      '',               // strInRqCp
                                      '',               // strOriGor
                                      '',               // strBarCom
                                      'S',              // strPD_Exp
                                      0,                // dtaValOrc
                                      '',               // strCodRot
                                      0,                // fltTotBri
                                      0,                // fltBolAdt
                                      False,            // blnBolVen
                                      0,                // fltTaxJur
                                      'N',              // strFatTot
                                      '',               // strTraRdp
                                      '',               // strCliLoj
                                      '',               // strSeqDmp
                                      0,                // dtaDtFiCo
                                      0,                // dtaDtInCo
                                      0,                // dtaDtInSe
                                      0,                // dtaDtBxSe
                                      0,                // hraHrFiCo
                                      0,                // hraHrInCo
                                      0,                // hraHrInSe
                                      0,                // hraHrBxSe
                                      nil,              // cdsExpRet
                                      'N',              // strUsaQue
                                      '',               // strDocQue
                                      '',               // strCodPrj
                                      '',               // strTpOper
                                      '',               // strNLeads
                                      '',               // strCupDes
                                      'S',              // strNotPau
                                      0,                // dtaDtCtVn
                                      0,                // fltVlCtVn
                                      '',               // strCodCat
                                      '',               // strMen003
                                      '',               // strMen004
                                      'GERACAO TE');    // strMen005




          If blnConfirma Then
          Begin
            blnGerOrc := True;
            FQryEmpresasDestino.First;
            cdsItens.First;
            FQryEmpresasDestino.First;

            strAutIncFdo := fRetAutoIncrem('FATDOR', VS_strCodEmp, intQtdAut);
            strAutLdg    := fRetAutoIncrem('LOGDOR', VS_strCodEmp, intQtdAut);

            While Not FQryEmpresasDestino.Eof Do
            Begin
              Application.ProcessMessages;
              fltQtdIte := fFormataFloat(FQryEmpresasDestino.FieldByName('ITE_SALTRA').AsFloat, intDecQtd);

              If (fltQtdIte > 0) And (cdsItens.Locate('CODITE', FQryEmpresasDestino.FieldByName('CODITE').AsString,[])) Then
              Begin
                fltTotGer := fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat)), 2);
                fltTotCus := fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('PRECUS').AsFloat)), 2);
                fltTotMed := fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('PREMED').AsFloat)), 2);
                fltTotPes := fFormataFloat((fltQtdIte * cdsItens.FieldByName('PESOIT').AsFloat), 2);

                blnConfirma := blnConfirma And fGravaFatDor(strAutIncFdo,
                                                            strAutInc,
                                                            VS_strCodEmp,
                                                            qryEmpresas.FieldByName('EMP_CLIFIL').AsString,
                                                            strLoginUsuarioLogado,
                                                            cdsItens.FieldByName('CODITE').AsString,
                                                            cdsItens.FieldByName('CODMAR').AsString,
                                                            '',
                                                            strNumDoc,
                                                            strEspDoc,
                                                            '',
                                                            VS_Date,
                                                            fTime(),
                                                            strConPgtMas,
                                                            '',
                                                            cdsItens.FieldByName('DESITE').AsString,
                                                            cdsItens.FieldByName('REFERE').AsString,
                                                            cdsItens.FieldByName('UNIDAD').AsString,
                                                            cdsItens.FieldByName('CODFOR').AsString,
                                                            fltQtdIte,
                                                            fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat),
                                                            fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat),
                                                            fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat),
                                                            fltTotGer,
                                                            fltTotGer,
                                                            fltTotCus,
                                                            fltTotMed,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            strLoginUsuarioLogado,
                                                            '',
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            copy(VS_strClaVen,1,4),
                                                            '000',
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            fltTotGer,
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            fltTotPes,
                                                            0.0,
                                                            0.0,
                                                            False,
                                                            '',
                                                            '',
                                                            '',
                                                            0,
                                                            '',
                                                            '',
                                                            0.0,
                                                            'NOR',
                                                            cdsItens.FieldByName('INCPIS').AsString,
                                                            strLoginUsuarioLogado,
                                                            strCodConPgt,
                                                            '',
                                                            IIF(fCfgSis('USAFPG', varBoolean), fCfgSis('FPORPD'), ''),
                                                            '',
                                                            '',
                                                            '',
                                                            '',
                                                            0.0,
                                                            0.0,
                                                            '',
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            '',
                                                            '',
                                                            0,
                                                            'N',
                                                            '',
                                                            0.0,
                                                            0,
                                                            0.0,
                                                            fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat),
                                                            '',
                                                            0.0,
                                                            '',
                                                            '',
                                                            FALSE,
                                                            strTabPre,
                                                            '',
                                                            '',
                                                            '',
                                                            0.0,
                                                            '',
                                                            0.0,
                                                            '',
                                                            '',
                                                            'N',
                                                            '',
                                                            0,
                                                            fltTotCus,
                                                            0,
                                                            0,
                                                            '',
                                                            cdsItens.FieldByName('NUMLOT').AsString,
                                                            '',
                                                            False,
                                                            IIF(blnEmpFat, IIF(((Not fEmptyStr(strEmp_CD)) And (fCfgSis('ENT_CD', VarBoolean))), strEmp_CD, VS_strCodEmp), IIf(strEmp_CD = '', VS_strCodEmp, strEmp_CD)),
                                                            '',
                                                            '',
                                                            '',
                                                            '',
                                                            '',
                                                            0,
                                                            0,
                                                            '',
                                                            '',
                                                            0,
                                                            '',
                                                            '',
                                                            0,
                                                            0,
                                                            cdsItens.FieldByName('PESOIT').AsFloat,
                                                            'N', // strAltPCo: String = 'N';
                                                            'N', // strCliBus: string = 'N';
                                                            '',  // strTurEnt: String = '';
                                                            0,   // fltVal_RT: Double = 0;
                                                            0,   // fltTaxJur: Double = 0;
                                                            False, // blnInseridoOuAlterado: Boolean=False;
                                                            '',  // strLotAba: String = '';
                                                            '',  // strLotAnt: String = '';
                                                            '',  // strIncFut: String = '';
                                                            0,   // fltSerRat: Double = 0;
                                                            '',  // strSepExp: String = '';
                                                            0,   // fltFreRat: Double = 0;
                                                            'N', // strPigBas: String = 'N';
                                                            '',  // strIncDev: String = '';
                                                            '',  // strSeqOpI: String = '';
                                                            'N', // strBrinde: String = 'N';
                                                            '',  // strCodPar: String = '';
                                                            '',  // strTipBri: String = '';
                                                            '',  // strBaqtze: String = '';
                                                            0,   // fltDesMax: Double = 0;
                                                            0,   // fltValFle: Double = 0;
                                                            'N', // strPegou_: String = 'N';
                                                            0,   // fltTaxEnt: Double = 0;
                                                            'N', // strAtivac: String = 'N';
                                                            0,   // intSeqCom: Integer = 0;
                                                            0,   // fltQtdAti: Double = 0;
                                                            0,   // fltQtdCom: Double = 0;
                                                            '',  // strTabCom: String = '';
                                                            '',  // strDesNes: String = '';
                                                            False, // blnIcmSai: Boolean = False;
                                                            0,   // fltIcmPav: Double = 0;
                                                            0,   // fltIcmSai: Double = 0;
                                                            0,   // fltImpFed: Double = 0;
                                                            0,   // fltDesOpe: Double = 0;
                                                            0,   // fltAlDifa: Double = 0;
                                                            '',  // strAutDet: String = '';
                                                            0,   // fltValFCP: Double = 0;
                                                            0,   // fltPesBru: Double = 0;
                                                            0,   // intSeqUlt: Integer = 0;
                                                            0,   // intQDEntr: Integer = 0;
                                                            '',  // strNcmTin: String = '';
                                                            '',  // strNotC17: String = '';
                                                            0,   // fltAlq922: Double = 0;
                                                            '',  // strCodCmg: String = '';
                                                            0,   // fltQtdSep: Double = 0;
                                                            0,   // fltDesCnd: Double = 0;
                                                            0,   // intSeqEst: Integer = 0;
                                                            '',  // strIteEst: String = '';
                                                            0,   // fltUniEst: Double = 0;
                                                            0,   // fltQtdSbi: Double = 0;
                                                            0,   // fltUniSbi: Double = 0;
                                                            0,   // fltFreMkp: Double = 0;
                                                            0,   // fltComMkp: Double = 0;
                                                            '',  // strProEsp: String = '';
                                                            '',  // strVenCbo: String = '';
                                                            '',  // strCodPro: String = '';
                                                            0,   // fltUniDol: Double = 0;
                                                            0,   // fltTotDol: Double = 0;
                                                            0,   // fltQtdRco: Double = 0;
                                                            True, // blnExiBSe: Boolean = True;
                                                            '',  // strAIdKitPromocao : String = '';
                                                            '',  // strOpBxSe: String = '';
                                                            0,   // dtaDtBxSe: TDateTime = 0;
                                                            0,   // dtaHrBxSe: TDateTime = 0;
                                                            '',  // strEmpCar: String = '';
                                                            0,   // fltDesBai: Double = 0;
                                                            '',  // strTemNumSerie: String = '';
                                                            0,   // fltVDesST: Double = 0;
                                                            '',  // strMDesST: String = '';
                                                            'S', // strReserv: String = 'S';
                                                            0,   // intSeqInv: Integer = 0 ;
                                                            '',  // strSeqEql: String = '';
                                                            '',  // strNumDrw: String = '';
                                                            False, // blnMntPrc: Boolean = False;
                                                            0,   // fltQtdRet: Double = 0;
                                                            '',  // strNumPla: String = '';
                                                            '',  // strParNum: String = '';
                                                            '',  // strReqCom: String = '';
                                                            '',  // strAutEnd: String = '';
                                                            '',  // strRegEsp: String = '';
                                                            0,   // fltFreCot: Double = 0;
                                                            False, // blnAltEst: Boolean = False;
                                                            0,   // intSeqPer: Integer = 0;
                                                            False, // blnRatEst: Boolean = False;
                                                            '',  // strObsRco: String = '';
                                                            '',  // strNumPok: String = '';
                                                            '',  // strDocOri: String = '';
                                                            '',  // strEspOri: String = '';
                                                            '',  // strEmpOri: String = '';
                                                            '',  // strOpeSep: String = '';
                                                            '',  // strOpeExp: String = '';
                                                            '',  // strEmpDmp: String = '';
                                                            0,   // fltUnDiDe: Double = 0;
                                                            '',  // strBasTro: String = '';
                                                            0,   // dtaDtaCmp: TDateTime = 0;
                                                            0,   // fltOutValPD: Double = 0;
                                                            0,   // fltFreEntPD: Double = 0;
                                                            0,   // fltAcpProPD: Double = 0;
                                                            0,   // fltAcpTxcPD: Double = 0;
                                                            0,   // fltAcpVctPD: Double = 0;
                                                            0,   // fltAcpResPD: Double = 0;
                                                            0,   // fltAcpMarPD: Double = 0;
                                                            '',  // strTckQbt: String = '';
                                                            '',  // strSeqPre: String = '';
                                                            0,   // fltSomaColorantes : Double = 0;
                                                            strAutLdg);

               strAutIncFdo := fNextAutoIncrem(strAutIncFdo);
               strAutLdg    := fNextAutoIncrem(strAutLdg);
              End; {If fltQtdIte > 0 Then}
              FQryEmpresasDestino.Next;
            End;
          End;

          If blnConfirma Then
            FCommit
          Else
            fRollback;


          If blnConfirma Then
          Begin
            TReprocessarSaldoItem.New
              .AddItensDoDocumento(
                 TItensReprocessarDoDocumento.New
                   .Documento(strNumDoc)
                   .Especie(strEspDoc)
                   .Empresa(VS_strCodEmp)
                 ).ReprocessarSaldoPedidos(prgProgre);
          End;
        Except
          On E:Exception do
            pMensagensErro(E.Message, '[TRelGeraOR.pGravaOrcamentosMaxDistribuido]');
        End;

        qryEmpresas.Next;
      End;

    End;
    If blnGerOrc Then
    Begin
      If strEspDoc = 'OR' Then
        fMensagem('','Orçamento gerado com sucesso!', ['&OK'])
      Else
        fMensagem('','Pedido gerado com sucesso!', ['&OK']);
    End
    Else
    Begin
      If strEspDoc = 'OR' Then
        fMensagem('','Nenhum Orçamento foi gerado!', ['&OK'])
      Else
        fMensagem('','Nenhum Pedido foi gerado!', ['&OK']);
    End;

  Finally
    FreeAndNil(qryEmpresas);
    FreeAndNil(qryItens);
    FreeAndNil(cdsItens);
  End;

end;


procedure TRelGeraOR.pGravaOrcamentosMax(strCodEmp: String; edtCodigo: TCustomEdit; arrLinha: TConsultasArray; strEspDoc: String = '');
Var
  frmRelEstItemsAcimaMax_ItensOrc: TfrmRelEstItemsAcimaMax_ItensOrc;
  strSQL      : String;
  strNumDoc   : String;
  strAutInc   : String;
  strAutLdg,
  strAutIncFdo: String;
  strCodConPgt: String;
  strConPgtMas: string;
  fltTotGer   : Double;
  fltQtdIte   : Double;
  fltTotCus   : Double;
  fltTotMed   : Double;
  fltTotPes   : Double;
  qryEmpresas : TUniQuery;
  qryItens    : TZClient;
  qryAux      : TUniQuery;
  blnConfirma : Boolean;
  cdsItens    : TUniClientDataSet;
  blnGerOrc   : Boolean;
  strEmp      : String;
  strIndice   : String;
  strTabPre   : String;
  recServicos: TDadosServicos;
  arrDuplic : TarrDuplicata;
  intQtdAut: Integer;
Begin
  Try
    blnConfirma := True;

    If (Not Assigned(fGravaFatGor)) Or (Not Assigned(fGravaFatDor)) Then
    Begin
      fMensagem('AVISO','Relatório não pode ser gerado.', ['&O K']);
      Exit;
    End;

    If Assigned(FQryEmpresasDestino) And (Not FQryEmpresasDestino.IsEmpty) Then
    Begin
      pGravaOrcamentosMaxDistribuido;
      Exit;
    End;

    If not fCarregarConfigParaGerarOrcamento(strConPgtMas, strCodConPgt) Then
      Exit;

    cdsItens := TUniClientDataSet.Create(Self);
    cdsItens.DisableControls;

    qryEmpresas := fCriaQuery(Self);
    qryItens    := TZClient.Create(Self);
    qryAux      := fCriaQuery(Self);

    blnGerOrc   := False;

    {*********************************************}
    {* BUSCA AS EMPRESAS E SEUS CLIENTES FILIAIS *}
    {******************************************LU*}
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ' ;
    strSQL := strSQL + '   EMP_CODEMP, ' ;
    strSQL := strSQL + '   EMP_CLIFIL ' ;
    strSQL := strSQL + ' FROM ' ;
    strSQL := strSQL + '   CADEMP ' ;
    strSQL := strSQL + ' WHERE ' ;

    If Assigned(arrLinha) Then
      strSQL := strSQL + fStrLocate(edtCodigo, arrLinha, 'EMP_CODEMP', 'CODEMP', True)
    Else
    Begin
      If Not fEmptyStr(strCodEmp) Then
        strSQL := strSQL + '  EMP_CODEMP = :CODEMP '
      Else
        strSQL := strSQL + '  LOCATE(EMP_CODEMP,' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
    End;

    With qryEmpresas Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Assigned(arrLinha) Then
        pSetaParam(edtCodigo.Text, arrLinha, strEmp, 'CODEMP', qryEmpresas)
      Else
      Begin
        If Not fEmptyStr(strCodEmp) Then
          ParamByName('CODEMP').AsString := strCodEmp;
      End;

      Open;
    End;

    While Not qryEmpresas.Eof Do
    Begin
      Application.ProcessMessages;

      pCriarFormularios(TfrmRelEstItemsAcimaMax_ItensOrc, frmRelEstItemsAcimaMax_ItensOrc);
      frmRelEstItemsAcimaMax_ItensOrc.dspConsulta.DataSet := qryItens;

      pAbreQueryItens(VS_strCodEmp, qryItens);
      pSetaClient(qryItens);

      If Not qryItens.IsEmpty Then
      Begin
        frmRelEstItemsAcimaMax_ItensOrc.cdsConsulta.Open;

        Try

          frmRelEstItemsAcimaMax_ItensOrc.lblEmpresa.Caption := 'EMPRESA: ' + VS_strCodEmp + ' - ' + fRetNomeEmpresa(VS_strCodEmp);

          frmRelEstItemsAcimaMax_ItensOrc.strEmpresaAbastecedo := VS_strCodEmp;
          If Assigned(arrLinha) Then
            frmRelEstItemsAcimaMax_ItensOrc.strEmpresaAbastecida := arrLinha[0].strCodigo
          Else If Not fEmptyStr(strCodEmp) Then
            frmRelEstItemsAcimaMax_ItensOrc.strEmpresaAbastecida := strCodEmp;

          frmRelEstItemsAcimaMax_ItensOrc.strEspDoc:= strEspDoc;
          frmRelEstItemsAcimaMax_ItensOrc.ShowModal;

          cdsItens.Data := frmRelEstItemsAcimaMax_ItensOrc.cdsConsulta.Data;
          strIndice := frmRelEstItemsAcimaMax_ItensOrc.cdsConsulta.IndexFieldNames;
          If (strIndice = '') Then
            strIndice := 'DESITE';
          cdsItens.DisableControls;
          blnConfirma := frmRelEstItemsAcimaMax_ItensOrc.blnConfirma;
        Except
          On E: Exception Do
          Begin
            blnConfirma := False;
            pMensagensErro(E.Message, '');
          End;
        End;

        cdsItens.Filter := 'MARDES = ' + QuotedStr('M');
        cdsItens.Filtered := True;

        If (Not cdsItens.IsEmpty) And (blnConfirma) Then
        Begin
          blnGerOrc := True;
          If SameText('OR', strEspDoc) Then
            strNumDoc := fRetSequencial('PRO_OR', '', fTamDocCadRec)
          Else
            strNumDoc := fRetSequencialPedido;

          cdsItens.First;

          fltTotGer := 0.0;
          fltTotCus := 0.0;
          fltTotMed := 0.0;
          fltTotPes := 0.0;

          intQtdAut := 0;

          While Not cdsItens.Eof Do
          Begin
            Application.ProcessMessages;
            fltQtdIte := fFormataFloat(cdsItens.FieldByName('NECCOM').AsFloat, intDecQtd);

            If fltQtdIte > 0 Then
            Begin
              Inc(intQtdAut);

              fltTotGer := fltTotGer + fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat)), 2);
              fltTotCus := fltTotCus + fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('PRECUS').AsFloat)), 2);
              fltTotMed := fltTotMed + fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('PREMED').AsFloat)), 2);
              fltTotPes := fltTotPes + fFormataFloat((fltQtdIte * cdsItens.FieldByName('PESOIT').AsFloat), 2);
            End;

            cdsItens.Next;
          End;

          strTabPre := fRetTabelaPreco(qryEmpresas.FieldByName('EMP_CLIFIL').AsString, strLoginUsuarioLogado);

          strAutInc := fstrEspaco(' ', 20);

          If (VS_strHabilitarCRM) And (Not fEmptyStr(fCfgSis('VENORC', varString))) And (Not fEmptyStr(fCfgSis('VENPED', varString))) Then
            objOcoCrm := fAtualizaInformacoesCRM(strNumDoc,strEspDoc,VS_strCodEmp,qryEmpresas.FieldByName('EMP_CLIFIL').AsString,'','',strLoginUsuarioLogado,IIF(strEspDoc = 'OR',afcOrcamento,afcPedido));

          sltOrcamentos.Add(strEspDoc + '-' + strNumDoc + '-' + VS_strCodEmp);

          fStartTransaction;

          FillChar(arrDuplic, Sizeof(arrDuplic) , #0);

          blnConfirma := fGravaFatGor(strAutInc,
                                      VS_strCodEmp,
                                      strNumDoc,
                                      strEspDoc,
                                      qryEmpresas.FieldByName('EMP_CLIFIL').AsString,
                                      strLoginUsuarioLogado,
                                      strCodTra,
                                      '',
                                      VS_Date,
                                      fTime(),
                                      strConPgtMas,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      0,
                                      '',
                                      '',
                                      '',
                                      '',
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      fltTotGer,
                                      fltTotGer,
                                      fltTotCus,
                                      fltTotMed,
                                      IIF(strEspDoc = 'OR', '1', strTipFre),
                                      fltValFre,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      0.0,
                                      fltTotPes,
                                      fltTotPes,
                                      0,
                                      arrDuplic,
                                      '',
                                      '',
                                      strMen001,
                                      strMen002,
                                      False,
                                      '',
                                      '',
                                      '',
                                      0,
                                      '',
                                      '',
                                      0.0,
                                      0.0,
                                      strLoginUsuarioLogado,
                                      strCodConPgt,
                                      IIF(fCfgSis('USAFPG', varBoolean), fCfgSis('FPORPD'), ''),
                                      recServicos,
                                      'N',
                                      dtaPrevis,
                                      0,
                                      VS_Date,
                                      '',
                                      strTipPed,
                                      '',
                                      0,
                                      strEntFat,
                                      0,
                                      strTabPre,
                                      'N',
                                      0.0,
                                      '',
                                      '',
                                      False,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      FALSE,
                                      VS_Date,
                                      'N',
                                      'V',
                                      VS_Date,
                                      'P',
                                      0,
                                      '',
                                      '',
                                      '',
                                      False,
                                      '',
                                      Nil,
                                      '',
                                      '',
                                      0,
                                      0,
                                      0,
                                      '',
                                      objOcoCrm,
                                      '',
                                      0,
                                      0,
                                      '',
                                      '',
                                      0,
                                      '',
                                      0,
                                      '',
                                      '',
                                      '',
                                      'N',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      'S',
                                      False,            // blnGravarDavPv
                                      false,            // blnAlterado
                                      0,                // dtaImpSep
                                      0,                // horImpSep
                                      '',               // strNumPedRefOR
                                      '',               // strEmpPedRefOR
                                      '',               // strLatitu
                                      '',               // strLongit
                                      '',               // strRaio__
                                      nil,              // objFazenda
                                      'S',              // strEnvLib
                                      0,                // fltFreRat
                                      '',               // strNumPedAba
                                      '',               // strEspPedAba
                                      '',               // strEmpPedAba
                                      '',               // strObsL01
                                      '',               // strObsL02
                                      'N',              // strVenPre
                                      'N',              // strTemBri
                                      'N',              // strEdiPes
                                      0,                // fltTaxEnt
                                      '',               // strCodSup
                                      'N',              // strOrcEsp
                                      '',               // strProspe
                                      '',               // strCodOco
                                      False,            // blnImpSfaPag
                                      '',               // strCodEmbarcacao
                                      0,                // fltDesOpeGor
                                      '',               // strCliCon
                                      '',               // strInRqCp
                                      '',               // strOriGor
                                      '',               // strBarCom
                                      'S',              // strPD_Exp
                                      0,                // dtaValOrc
                                      '',               // strCodRot
                                      0,                // fltTotBri
                                      0,                // fltBolAdt
                                      False,            // blnBolVen
                                      0,                // fltTaxJur
                                      'N',              // strFatTot
                                      '',               // strTraRdp
                                      '',               // strCliLoj
                                      '',               // strSeqDmp
                                      0,                // dtaDtFiCo
                                      0,                // dtaDtInCo
                                      0,                // dtaDtInSe
                                      0,                // dtaDtBxSe
                                      0,                // hraHrFiCo
                                      0,                // hraHrInCo
                                      0,                // hraHrInSe
                                      0,                // hraHrBxSe
                                      nil,              // cdsExpRet
                                      'N',              // strUsaQue
                                      '',               // strDocQue
                                      '',               // strCodPrj
                                      '',               // strTpOper
                                      '',               // strNLeads
                                      '',               // strCupDes
                                      'S',              // strNotPau
                                      0,                // dtaDtCtVn
                                      0,                // fltVlCtVn
                                      '',               // strCodCat
                                      '',               // strMen003
                                      '',               // strMen004
                                      'GERACAO TE');    // strMen005

          If (cdsItens.FieldByName(strIndice).AsString <> '') Then
            cdsItens.IndexFieldNames := strIndice;
          cdsItens.First;

          strAutIncFdo := fRetAutoIncrem('FATDOR', VS_strCodEmp, intQtdAut);
          strAutLdg    := fRetAutoIncrem('LOGDOR', VS_strCodEmp, intQtdAut);

          While Not cdsItens.Eof Do
          Begin
            Application.ProcessMessages;
            fltQtdIte := fFormataFloat(cdsItens.FieldByName('NECCOM').AsFloat, intDecQtd);

            If fltQtdIte > 0 Then
            Begin
            fltTotGer := fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat)), 2);
            fltTotCus := fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('PRECUS').AsFloat)), 2);
            fltTotMed := fFormataFloat((fltQtdIte * fFormataUnitar(cdsItens.FieldByName('PREMED').AsFloat)), 2);
            fltTotPes := fFormataFloat((fltQtdIte * cdsItens.FieldByName('PESOIT').AsFloat), 2);

              blnConfirma := blnConfirma And fGravaFatDor(strAutIncFdo,
                                                          strAutInc,
                                                          VS_strCodEmp,
                                                          qryEmpresas.FieldByName('EMP_CLIFIL').AsString,
                                                          strLoginUsuarioLogado,
                                                          cdsItens.FieldByName('CODITE').AsString,
                                                          cdsItens.FieldByName('CODMAR').AsString,
                                                          '',
                                                          strNumDoc,
                                                          strEspDoc,
                                                          '',
                                                          VS_Date,
                                                          fTime(),
                                                          strConPgtMas,
                                                          '',
                                                          cdsItens.FieldByName('DESITE').AsString,
                                                          cdsItens.FieldByName('REFERE').AsString,
                                                          cdsItens.FieldByName('UNIDAD').AsString,
                                                          cdsItens.FieldByName('CODFOR').AsString,
                                                          fltQtdIte,
                                                          fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat),
                                                          fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat),
                                                          fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat),
                                                          fltTotGer,
                                                          fltTotGer,
                                                          fltTotCus,
                                                          fltTotMed,
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                          strLoginUsuarioLogado,
                                                          '',
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                          copy(VS_strClaVen,1,4),
                                                          '000',
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                          fltTotGer,
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                          fltTotPes,
                                                          0.0,
                                                          0.0,
                                                          False,
                                                          '',
                                                          '',
                                                          '',
                                                          0,
                                                          '',
                                                          '',
                                                          0.0,
                                                          'NOR',
                                                          cdsItens.FieldByName('INCPIS').AsString,
                                                          strLoginUsuarioLogado,
                                                          strCodConPgt,
                                                          '',
                                                          IIF(fCfgSis('USAFPG', varBoolean), fCfgSis('FPORPD'), ''),
                                                          '',
                                                          '',
                                                          '',
                                                          '',
                                                          0.0,
                                                          0.0,
                                                          '',
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                          '',
                                                          '',
                                                          0,
                                                          'N',
                                                          '',
                                                          0.0,
                                                          0,
                                                          0.0,
                                                          fFormataUnitar(cdsItens.FieldByName('UNITAR').AsFloat),
                                                          '',
                                                          0.0,
                                                          '',
                                                          '',
                                                          FALSE,
                                                          strTabPre,
                                                          '',
                                                          '',
                                                          '',
                                                          0.0,
                                                          '',
                                                          0.0,
                                                          '',
                                                          '',
                                                          'N',
                                                          '',
                                                          0,
                                                          fltTotCus,
                                                          0,
                                                          0,
                                                          '',
                                                          cdsItens.FieldByName('NUMLOT').AsString,
                                                          '',
                                                          False,
                                                          IIF(blnEmpFat, IIF(((Not fEmptyStr(strEmp_CD)) And (fCfgSis('ENT_CD', VarBoolean))), strEmp_CD, VS_strCodEmp), IIf(strEmp_CD = '', VS_strCodEmp, strEmp_CD)),
                                                          '',
                                                          '',
                                                          '',
                                                          '',
                                                          '',
                                                          0,
                                                          0,
                                                          '',
                                                          '',
                                                          0,
                                                          '',
                                                          '',
                                                          0,
                                                          0,
                                                          cdsItens.FieldByName('PESOIT').AsFloat,
                                                          'N', // strAltPCo: String = 'N';
                                                          'N', // strCliBus: string = 'N';
                                                          '',  // strTurEnt: String = '';
                                                          0,   // fltVal_RT: Double = 0;
                                                          0,   // fltTaxJur: Double = 0;
                                                          False, // blnInseridoOuAlterado: Boolean=False;
                                                          '',  // strLotAba: String = '';
                                                          '',  // strLotAnt: String = '';
                                                          '',  // strIncFut: String = '';
                                                          0,   // fltSerRat: Double = 0;
                                                          '',  // strSepExp: String = '';
                                                          0,   // fltFreRat: Double = 0;
                                                          'N', // strPigBas: String = 'N';
                                                          '',  // strIncDev: String = '';
                                                          '',  // strSeqOpI: String = '';
                                                          'N', // strBrinde: String = 'N';
                                                          '',  // strCodPar: String = '';
                                                          '',  // strTipBri: String = '';
                                                          '',  // strBaqtze: String = '';
                                                          0,   // fltDesMax: Double = 0;
                                                          0,   // fltValFle: Double = 0;
                                                          'N', // strPegou_: String = 'N';
                                                          0,   // fltTaxEnt: Double = 0;
                                                          'N', // strAtivac: String = 'N';
                                                          0,   // intSeqCom: Integer = 0;
                                                          0,   // fltQtdAti: Double = 0;
                                                          0,   // fltQtdCom: Double = 0;
                                                          '',  // strTabCom: String = '';
                                                          '',  // strDesNes: String = '';
                                                          False, // blnIcmSai: Boolean = False;
                                                          0,   // fltIcmPav: Double = 0;
                                                          0,   // fltIcmSai: Double = 0;
                                                          0,   // fltImpFed: Double = 0;
                                                          0,   // fltDesOpe: Double = 0;
                                                          0,   // fltAlDifa: Double = 0;
                                                          '',  // strAutDet: String = '';
                                                          0,   // fltValFCP: Double = 0;
                                                          0,   // fltPesBru: Double = 0;
                                                          0,   // intSeqUlt: Integer = 0;
                                                          0,   // intQDEntr: Integer = 0;
                                                          '',  // strNcmTin: String = '';
                                                          '',  // strNotC17: String = '';
                                                          0,   // fltAlq922: Double = 0;
                                                          '',  // strCodCmg: String = '';
                                                          0,   // fltQtdSep: Double = 0;
                                                          0,   // fltDesCnd: Double = 0;
                                                          0,   // intSeqEst: Integer = 0;
                                                          '',  // strIteEst: String = '';
                                                          0,   // fltUniEst: Double = 0;
                                                          0,   // fltQtdSbi: Double = 0;
                                                          0,   // fltUniSbi: Double = 0;
                                                          0,   // fltFreMkp: Double = 0;
                                                          0,   // fltComMkp: Double = 0;
                                                          '',  // strProEsp: String = '';
                                                          '',  // strVenCbo: String = '';
                                                          '',  // strCodPro: String = '';
                                                          0,   // fltUniDol: Double = 0;
                                                          0,   // fltTotDol: Double = 0;
                                                          0,   // fltQtdRco: Double = 0;
                                                          True, // blnExiBSe: Boolean = True;
                                                          '',  // strAIdKitPromocao : String = '';
                                                          '',  // strOpBxSe: String = '';
                                                          0,   // dtaDtBxSe: TDateTime = 0;
                                                          0,   // dtaHrBxSe: TDateTime = 0;
                                                          '',  // strEmpCar: String = '';
                                                          0,   // fltDesBai: Double = 0;
                                                          '',  // strTemNumSerie: String = '';
                                                          0,   // fltVDesST: Double = 0;
                                                          '',  // strMDesST: String = '';
                                                          'S', // strReserv: String = 'S';
                                                          0,   // intSeqInv: Integer = 0 ;
                                                          '',  // strSeqEql: String = '';
                                                          '',  // strNumDrw: String = '';
                                                          False, // blnMntPrc: Boolean = False;
                                                          0,   // fltQtdRet: Double = 0;
                                                          '',  // strNumPla: String = '';
                                                          '',  // strParNum: String = '';
                                                          '',  // strReqCom: String = '';
                                                          '',  // strAutEnd: String = '';
                                                          '',  // strRegEsp: String = '';
                                                          0,   // fltFreCot: Double = 0;
                                                          False, // blnAltEst: Boolean = False;
                                                          0,   // intSeqPer: Integer = 0;
                                                          False, // blnRatEst: Boolean = False;
                                                          '',  // strObsRco: String = '';
                                                          '',  // strNumPok: String = '';
                                                          '',  // strDocOri: String = '';
                                                          '',  // strEspOri: String = '';
                                                          '',  // strEmpOri: String = '';
                                                          '',  // strOpeSep: String = '';
                                                          '',  // strOpeExp: String = '';
                                                          '',  // strEmpDmp: String = '';
                                                          0,   // fltUnDiDe: Double = 0;
                                                          '',  // strBasTro: String = '';
                                                          0,   // dtaDtaCmp: TDateTime = 0;
                                                          0,   // fltOutValPD: Double = 0;
                                                          0,   // fltFreEntPD: Double = 0;
                                                          0,   // fltAcpProPD: Double = 0;
                                                          0,   // fltAcpTxcPD: Double = 0;
                                                          0,   // fltAcpVctPD: Double = 0;
                                                          0,   // fltAcpResPD: Double = 0;
                                                          0,   // fltAcpMarPD: Double = 0;
                                                          '',  // strTckQbt: String = '';
                                                          '',  // strSeqPre: String = '';
                                                          0,   // fltSomaColorantes : Double = 0;
                                                          strAutLdg);

              strAutIncFdo := fNextAutoIncrem(strAutIncFdo);
              strAutLdg    := fNextAutoIncrem(strAutLdg);
            End; {If fltQtdIte > 0 Then}

            If Not blnConfirma Then
              Break;

            cdsItens.Next;
          End; {While Not cdsItens.Eof Do}
        End;
      End;

      If blnConfirma Then
        fCommit
      Else
        fRollBack;

      If blnConfirma Then
      Begin
        TReprocessarSaldoItem.New
          .AddItensDoDocumento(
             TItensReprocessarDoDocumento.New
               .Documento(strNumDoc)
               .Especie(strEspDoc)
               .Empresa(VS_strCodEmp)
             ).ReprocessarSaldoPedidos(prgProgre);
      End;

      pFreeAndNil(frmRelEstItemsAcimaMax_ItensOrc);

      qryEmpresas.Next;
    End; {While Not qryEmpresas.Eof Do}

    If blnGerOrc Then
    Begin
      If strEspDoc = 'OR' Then
        fMensagem('','Orçamento gerado com sucesso!', ['&OK'])
      Else
        fMensagem('','Pedido gerado com sucesso!', ['&OK']);
    End
    Else
    Begin
      If strEspDoc = 'OR' Then
        fMensagem('','Nenhum Orçamento foi gerado!', ['&OK'])
      Else
        fMensagem('','Nenhum Pedido foi gerado!', ['&OK']);
    End;

    FreeAndNil(qryEmpresas);
    FreeAndNil(qryItens);
    FreeAndNil(qryAux);
    FreeAndNil(cdsItens);

  Except
    On E: Exception Do
    Begin
      fRollBack;
      FreeAndNil(qryEmpresas);
      FreeAndNil(qryItens);
      FreeAndNil(cdsItens);
      FreeAndNil(qryAux);
			pMensagensErro(E.Message, '');
    End;
  End;
end;

class Function TRelGeraOR.fRetTabelaPreco(strCodCli, strCodVen: String): String;
  Var
    strTabPre,
    strTabSuj,
    strTabCli: String;
Begin
  strTabPre := '1';
  strTabCli := fCampoTabela('CLI_TABPRE', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);

  If fEmptyStr(strTabCli) And fCfgSis('HIETAB', VarBoolean) Then
    strTabCli := fCampoTabela('OPE_TABPRE', 'CADOPE', ['OPE_CODOPE'], [strCodVen], False);

  If (fCfgSis('UTAPTB') <> '0') Then
    strTabPre := fCfgSis('UTAPTB')
  Else If fCfgSis('SUGTBP', varBoolean) Then
  Begin
    strTabSuj := fCfgSis('TBPSUG');

    If strTabSuj <> '0' Then
    Begin
      strTabPre := strTabSuj;
    End
    Else If Not fEmptyStr(strTabCli) Then
      strTabPre := strTabCli
    Else If (fEmptyStr(strTabCli)) Then
    Begin
      If (Not fEmptyStr(fCfgSis('TBPRPD', varString))) Then
        strTabPre := fCfgSis('TBPRPD', varString);
    End;
  End
  Else If Not fEmptyStr(strTabCli) Then
    strTabPre := strTabCli
  Else If (fEmptyStr(strTabCli)) Then
  Begin
    If (Not fEmptyStr(fCfgSis('TBPRPD', varString))) Then
      strTabPre := fCfgSis('TBPRPD', varString);
  End;

  Result := strTabPre;
End;

Class Function TRelGeraOR.fSQLUnitario(strEmpOri, strEmpDes: String): String;
Begin
  Result := fGetTEPREV(strEmpOri, fRetornaClienteFilial(strEmpDes));

  If fEmptyStr(Result) Then
    Result := 'ITE_PRECUS'

  Else If Result = 'IMP' Then
    Result := 'ITE_IMPULT'

  Else If Result = 'SIC' Then
    Result := 'ITE_MEDSIC'

  Else
    Result := 'ITE_PRE' + Result;

  Result := Result + ' * IFNULL( ';
  Result := Result + '   IF(LOCATE( ';
  Result := Result + '      (SELECT ABF_CODSIT_SAI_CCO FROM ABFICM ';
  Result := Result + '       WHERE ABF_CODABF = ';

  If fCfgSis('TIPABF') = '1' Then
    Result := Result + '      (SELECT ITE_CODABF FROM CADITE WHERE ITE_CODITE = G.ITE_CODITE) '
  Else
    Result := Result + '      (SELECT ITE_CODABF FROM ITEGER WHERE ITE_CODITE = G.ITE_CODITE AND ITE_CODEMP = "'+ strEmpOri +'") ';

  Result := Result + '       AND ABF_ESTADO = "'+ fRetUFEmpresa(strEmpOri) +'"), ';
  Result := Result + '      "'+ CST_SUBSTITUICAO +'") > 0, '; //end LOCATE

  Result := Result + '      (SELECT IF(IFNULL(CON_FATTE2,0) = 0, 1, CON_FATTE2) FROM CONEMP ';
  Result := Result + '       WHERE CON_EMPORI = "'+ strEmpOri +'" AND CON_EMPDES = G.ITE_CODEMP), ';

  Result := Result + '      (SELECT IF(IFNULL(CON_FAT_TE,0) = 0, 1, CON_FAT_TE) FROM CONEMP ';
  Result := Result + '       WHERE CON_EMPORI = "'+ strEmpOri +'" AND CON_EMPDES = G.ITE_CODEMP)) '; //end IF
  Result := Result + ' ,1)'; //end IFNULL
End;

Class Function TRelGeraOR.fSQLUnitarioAlias(strAlias, strEmpOri: String): String;
Begin
  Result := '';
  Result := Result + ' ((CASE (IFNULL((SELECT IF(CON_CODTEP = "", NULL, CON_CODTEP) ';
  Result := Result + '              FROM CONEMP ';
  Result := Result + '              WHERE       ';
  Result := Result + '                    CON_EMPORI = "' +  strEmpOri + '" ';
  Result := Result + '                AND CON_EMPDES = G.ITE_CODEMP), ';
  Result := Result + '             (SELECT IFNULL(SIS_VALCFG, "") FROM CFGSIS WHERE SIS_CODCFG = "CFG_TEPREV" AND SIS_CODEMP = "' +  VS_strCodEmp + '"))) ';

  Result := Result + '  WHEN "IMP" THEN XX.ITE_IMPULT ';

  Result := Result + '  WHEN "ULT" THEN XX.ITE_PREULT ';

  Result := Result + '  WHEN "MED" THEN XX.ITE_PREMED ';

  Result := Result + '  WHEN "VE1" THEN XX.ITE_PREVE1 ';
  Result := Result + '  WHEN "VE2" THEN XX.ITE_PREVE2 ';
  Result := Result + '  WHEN "VE3" THEN XX.ITE_PREVE3 ';
  Result := Result + '  WHEN "VE4" THEN XX.ITE_PREVE4 ';
  Result := Result + '  WHEN "VE5" THEN XX.ITE_PREVE5 ';
  Result := Result + '  WHEN "VE6" THEN XX.ITE_PREVE6 ';
  Result := Result + '  WHEN "VE7" THEN XX.ITE_PREVE7 ';

  Result := Result + '  ELSE            XX.ITE_PRECUS ';

  Result := Result + '  END) * IFNULL( ';

  Result := Result + '  IF(LOCATE( ';
  Result := Result + '     (SELECT ABF_CODSIT_SAI_CCO FROM ABFICM ';
  Result := Result + '      WHERE ABF_CODABF = ';

  If fCfgSis('TIPABF') = '1' Then
    Result := Result + '      (SELECT ITE_CODABF FROM CADITE WHERE ITE_CODITE = G.ITE_CODITE) '
  Else
    Result := Result + '      (SELECT ITE_CODABF FROM ITEGER WHERE ITE_CODITE = G.ITE_CODITE AND ITE_CODEMP = "'+ strEmpOri +'") ';

  Result := Result + '      AND ABF_ESTADO = "'+ fRetUFEmpresa(strEmpOri) +'"), ';
  Result := Result + '     "'+ CST_SUBSTITUICAO +'") > 0, '; //end LOCATE

  Result := Result + '     (SELECT IF(IFNULL(CON_FATTE2,0) = 0, 1, CON_FATTE2) FROM CONEMP ';
  Result := Result + '      WHERE CON_EMPORI = "'+ strEmpOri +'" AND CON_EMPDES = G.ITE_CODEMP), ';

  Result := Result + '     (SELECT IF(IFNULL(CON_FAT_TE,0) = 0, 1, CON_FAT_TE) FROM CONEMP ';
  Result := Result + '      WHERE CON_EMPORI = "'+ strEmpOri +'" AND CON_EMPDES = G.ITE_CODEMP)) '; //end IF
  Result := Result + ' ,1)) '; //end IFNULL

  Result := AnsiReplaceStr(Result, 'XX.', strAlias);
End;

function TRelGeraOR.fTemPedidosEmAbertos(strClienteFilial: String): Boolean;
  Var
    qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  With qryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT COUNT(1) AS QTD');
    SQL.Add('FROM FATGOR F ');
    SQL.Add('INNER JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM ');
    SQL.Add('WHERE FGO_CODEMP = :CODEMP ');
    SQL.Add('AND   FGO_CODCLI = :CLIFIL ');
    SQL.Add('AND   FGO_RELABA = "S"     ');
    SQL.Add('AND   FGO_JAFATU = 0       ');
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ParamByName('CLIFIL').AsString := strClienteFilial;
    Open;

    Result := FieldByName('QTD').AsInteger > 0;
  End;

  FreeAndNil(qryAux);
end;

function TRelGeraOR.fFormataUnitar(fltValor: Double): Double;
begin
  Result := fFormataFloat(fltValor, intDecUni);
end;

end.

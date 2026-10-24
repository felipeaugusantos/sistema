unit untImprimeEtiquetas;

interface

uses Classes, Windows, Forms, SysUtils, Dialogs, Controls, frxClass, DB, Uni,
  UniClientDataSet, UniDataSetProvider, frxDBSet, Math, StrUtils, dxCore,
  untZClient, untCfgRel, untFuncoesEditorFast, System.Variants, frxExportPDF, TypesRel;

procedure pGridDocumentos(prmDllRel: Pointer); stdcall;
procedure pEtiquetasItemCPF(prmDllRel: Pointer); stdcall;
procedure peditoretiquetas(prmDllRel: Pointer); stdcall;
function fSVN_RevisionEditorEtiq: String; stdcall;
function fimprimeetiquetas(prmDllRel: Pointer): Boolean; stdcall;

function fImprimeEtiquetasDespachoPDF(modRecMod          : TRecModulos;
                                      VS_Date            : TDateTime;
                                      strLoginUsuarioLogado,
                                      VS_strCodEmp,
                                      strChaveAcesso,
                                      strDiretorioSalvar : String): Boolean; stdcall;

function fTransportadoraRealizaColetaB2WEntrega(const strCodTra : String) : Boolean;
function fRetornaLayoutEtiquetaDespachoB2W(const strNumDoc, strEspDoc, strCodEmp : String; VS_strCodEmp : String) : String;

function fimprimeetiquetaitens(prmDllEtq: Pointer): Boolean; stdcall;
function fimprimeetiquetaentradamerc(prmDllEtq: Pointer): Boolean; stdcall;
function fImprimeEtiquetaGeral(prmDllEtq: Pointer): Boolean; stdcall;
function fImprimeEtiquetasLoteProduto(prmDllEti: Pointer): Boolean; stdcall;
function fImprimeEtiquetasSeparacaoQtdRestante(prmDllEti: Pointer): Boolean; stdcall;
function fImprimeEtiquetasRastreamentoProduto(prmDllEti: Pointer): Boolean; stdcall;
function fImprimeEtiquetaLocalizacao(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaPlanoRecebimento(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaSequencialSeparacaoWMS(prmDllEtq: Pointer): Boolean;

procedure pCriaDataSetCliente(Var cdsImpEti: TUniClientDataSet; Self: TComponent);
procedure pImprimeEtiquetaCaixas(prmDllRel: Pointer); stdcall;
procedure pImprimeEtiquetaMontagemCaixas(prmDllRel: Pointer); stdcall;
procedure pGeraCopiasDeEtiquetas(Var cdsEtique: TUniClientDataSet; objDllEtq: TParamDllEtiquetas);
function fImprimeEtiquetaCliente(prmDllRel: Pointer): Boolean;
function fImprimeEtiquetaFuncionario(prmDllRel: Pointer): Boolean;
function fImprimeEtiquetaItensOrcPed(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaDespacho(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaDespachoProduto(prmDllEtq: Pointer): Boolean;
function fImprimeLaserArgox(prmDllEti: Pointer): Boolean;
function fImprimeEtiquetaGeralAux(prmDllEtq: Pointer; blnChamadaForaDaDll: Boolean): Boolean;
function fImprimeEtiquetaOS(prmDllRel: Pointer): Boolean;
function fImprimeEtiquetaOSVenda(prmDllRel: Pointer): Boolean;
function fImprimeEtiquetaEmpresa(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaOrdemProducao(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaArmazenamento(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaSeparacaoErrada(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaCodBarrasProduto(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaLocalArmazenamentoWms(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaRegiao(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaProdutosControladorVendas(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaUnidadesRestantesAux(prmDllEtq: Pointer): Boolean;
function fImprimeEtiquetaIDPlanoDeRecebimento(prmDllEtq: Pointer) : Boolean;
function fImprimeEtiquetaProdutoQtdFracionada(prmDllEtq: Pointer) : Boolean;
function fQuantidadeEmb: String;
procedure pPreenchePREPRA(AcdsDadEti: TUniClientDataSet; AintPreTab, AintParcel: Integer; AstrCndPag, AstrNumPar, AstrValAcr: String; AstrTipoAlter: Integer = 0 );

Type TFrxMetodos = class
  cdsFrxDataSet: TUniClientDataSet;
  intContEti: integer;
  procedure frxUserDataSetCheckEOF(Sender: TObject; var Eof: Boolean);
  procedure frxUserDataSetFirst(Sender: TObject);
  procedure frxUserDataSetNext(Sender: TObject);
  procedure frxUserDataSetPrior(Sender: TObject);
  procedure frxUserDataSetGetValue(const VarName: string; var Value: Variant);
  procedure frxUserDataSetNewGetValue(Sender: TObject; const VarName: string; var Value: Variant);
  constructor create();
end;

//procedure dxInitializeEti;
//procedure dxFinalizeEti;

implementation

uses MaskUtils, untEditorFast,
  untFuncoesSimples, untEditorEtiquetasPrinc, untGridDocumentos,
  untEditorFastImpressao, untTypesSistema, untEtiquetasItemCPF, untDespacho,
  untImpEtiquetaCaixas, untConstantes, untCadPro, untConfiguraEtiquetasFuncoes;

{************************************************}
{* CARREGA O FORMULARIO DE EDICAO DAS ETIQUETAS *}
{************************************************}
procedure peditoretiquetas(prmDllRel: Pointer);
  Var
    objDllRel: TParamDllEtiquetas;
Begin
  Try
    objDllRel := prmDllRel;
    With objDllRel Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);
      arrProCod := arrPrxCod;
      dicConfiguracoes.Remove('IMPAG' + VS_strCodEmp);

      pCarregaVsTemFil;
      pAtuVarGlobaisSimples;

      pCriarFormularios(TfrmEditorEtiquetasPrinc, frmEditorEtiquetasPrinc);
      frmEditorEtiquetasPrinc.strTipImp := strTipImp;
      frmEditorEtiquetasPrinc.strCodLayDoc := strLayDoc;

      With frmEditorEtiquetasPrinc Do
      Begin
        tpeCodEti := tpeTipEtq;
        ShowModal;
        strLayDoc := strCodLayDoc;
      End;
      FreeAndNil(frmEditorEtiquetasPrinc);

      pLiberaModulos;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[peditoretiquetas]');
    End;
  End;

End;


{************************************************}
{* CRIA O CLIENTDATASET DA ETIQUETA DE CLIENTES *}
{************************************************}
procedure pCriaDataSetCliente(Var cdsImpEti: TUniClientDataSet; Self: TComponent);
Begin
  cdsImpEti := TUniClientDataSet.Create(Self);
  With cdsImpEti, FieldDefs Do
  Begin
    With AddFieldDef Do Begin Name := 'NOME';   DataType := ftString; Size := 100; Required := False; End;
    With AddFieldDef Do Begin Name := 'ENDERE'; DataType := ftString; Size := 100; Required := False; End;
    With AddFieldDef Do Begin Name := 'BAIRRO'; DataType := ftString; Size := 100; Required := False; End;
    With AddFieldDef Do Begin Name := 'C_E_P_'; DataType := ftString; Size := 040; Required := False; End;
    With AddFieldDef Do Begin Name := 'NOMCID'; DataType := ftString; Size := 100; Required := False; End;
    With AddFieldDef Do Begin Name := 'ENDNUM'; DataType := ftString; Size := 010; Required := False; End;
    With AddFieldDef Do Begin Name := 'ENDCOM'; DataType := ftString; Size := 100; Required := False; End;
    With AddFieldDef Do Begin Name := 'CODCLI'; DataType := ftString; Size := 008; Required := False; End;
    With AddFieldDef Do Begin Name := 'ESTCLI'; DataType := ftString; Size := 002; Required := False; End;
    With AddFieldDef Do Begin Name := 'C_G_C_'; DataType := ftString; Size := 080; Required := False; End;
    With AddFieldDef Do Begin Name := 'EMAIL_'; DataType := ftString; Size := 255; Required := False; End;
    With AddFieldDef Do Begin Name := 'CELULA'; DataType := ftString; Size := 015; Required := False; End;

    With AddFieldDef Do Begin Name := 'NOMCTT'; DataType := ftString; Size := 050; Required := False; End;
    With AddFieldDef Do Begin Name := 'ENDCTT'; DataType := ftString; Size := 050; Required := False; End;
    With AddFieldDef Do Begin Name := 'BAICTT'; DataType := ftString; Size := 040; Required := False; End;
    With AddFieldDef Do Begin Name := 'CIDCTT'; DataType := ftString; Size := 040; Required := False; End;
    With AddFieldDef Do Begin Name := 'TELCTT'; DataType := ftString; Size := 016; Required := False; End;
    With AddFieldDef Do Begin Name := 'EMACTT'; DataType := ftString; Size := 100; Required := False; End;
    With AddFieldDef Do Begin Name := 'EMPCTT'; DataType := ftString; Size := 003; Required := False; End;
    With AddFieldDef Do Begin Name := 'CELCTT'; DataType := ftString; Size := 016; Required := False; End;
    With AddFieldDef Do Begin Name := 'FAXCTT'; DataType := ftString; Size := 016; Required := False; End;
    With AddFieldDef Do Begin Name := 'DEPCTT'; DataType := ftString; Size := 025; Required := False; End;
    With AddFieldDef Do Begin Name := 'NASCTT'; DataType := ftString; Size := 010; Required := False; End;
    With AddFieldDef Do Begin Name := 'OBSCTT'; DataType := ftString; Size := 100; Required := False; End;
    With AddFieldDef Do Begin Name := 'CGOCTT'; DataType := ftString; Size := 005; Required := False; End;
    With AddFieldDef Do Begin Name := 'DPTCTT'; DataType := ftString; Size := 005; Required := False; End;
    With AddFieldDef Do Begin Name := 'TFUCTT'; DataType := ftString; Size := 005; Required := False; End;
    With AddFieldDef Do Begin Name := 'HOBCTT'; DataType := ftString; Size := 005; Required := False; End;
    With AddFieldDef Do Begin Name := 'ESCCTT'; DataType := ftString; Size := 005; Required := False; End;
    With AddFieldDef Do Begin Name := 'TMSGTT'; DataType := ftString; Size := 010; Required := False; End;
    With AddFieldDef Do Begin Name := 'TMEPTT'; DataType := ftString; Size := 010; Required := False; End;
    With AddFieldDef Do Begin Name := 'GMUCTT'; DataType := ftString; Size := 005; Required := False; End;
    With AddFieldDef Do Begin Name := 'ECICTT'; DataType := ftString; Size := 005; Required := False; End;
    With AddFieldDef Do Begin Name := 'QTFITT'; DataType := ftString; Size := 011; Required := False; End;
    With AddFieldDef Do Begin Name := 'CERCTT'; DataType := ftString; Size := 100; Required := False; End;
    With AddFieldDef Do Begin Name := 'CPF_TT'; DataType := ftString; Size := 011; Required := False; End;
    With AddFieldDef Do Begin Name := 'NRG_TT'; DataType := ftString; Size := 015; Required := False; End;
    With AddFieldDef Do Begin Name := 'CAIPOS'; DataType := ftString; Size := 005; Required := False; End;

    With AddFieldDef Do Begin Name := 'FONE01'; DataType := ftString; Size := 015; Required := False; End;
    With AddFieldDef Do Begin Name := 'FONE02'; DataType := ftString; Size := 015; Required := False; End;

    CreateDataSet;
    Open;
    EmptyDataSet;
    Filter   := '';
    Filtered := FALSE;
  End;
End;

{**********************************}
{* IMPRIME A ETIQUETA DE CLIENTES *}
{**********************************}
function fImprimeEtiquetaCliente(prmDllRel: Pointer): Boolean;
  Var
    intContador: Integer;
    efsEdiFas: TEditorFast;
    qryCfgRel,
    qryEtique: TUniQuery;
    strNomImp: String;
    cdsImpEti: TUniClientDataSet;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataSet;
    objDllRel: TParamDllEtiquetas;

  procedure pLiberaRecursos;
  begin
    FreeAndNil(cdsImpEti);
    FreeAndNil(frxReport);
    FreeAndNil(qryEtique);
    FreeAndNil(frxDatSet);
    FreeAndNil(efsEdiFas);
    pLiberaModulos;
  end;

begin
  Try
    objDllRel := prmDllRel;

    With objDllRel Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      arrProCod := arrPrxCod;

      Result := True;

      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataSet.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';
      qryEtique := fCriaQuery;

      pCriaDataSetCliente(cdsImpEti, Nil);

      qryCfgRel := fCriaQuery;
      pCarregaConfImpr(qryCfgRel, 'frmImpEtiquetas');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      FreeAndNil(qryCfgRel);

      efsEdiFas := TEditorFast.Create(Nil,
                                      frxReport,
                                      frxDatSet,
                                      tpeTipEtq);

      efsEdiFas.pAbreCliente(qryEtique, blnEdrCob, String(strCamBus), False, String(strLisReg), intQtdEti, strCodCli);

      With qryEtique Do
      Begin
        If (IsEmpty) Then
        Begin
          Close;
          fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um cliente!', ['&Ok']);
          Result := False;
          pLiberaRecursos;
          Exit;
        End
        Else
        Begin

          {********************************************}
          {* CARREGA O CLIENTDATASET COM AS ETIQUETAS *}
          {* DESAGRUPANDO POR QUATIDADE               *}
          {*****************************************JB*}
          cdsImpEti.EmptyDataSet;

          While Not Eof Do
          Begin
            For intContador := 1 To FieldByName('QTDETI').asInteger Do
            Begin
              cdsImpEti.Append;
              cdsImpEti.FieldByName('NOME').AsString   := FieldByName('NOME').AsString;
              cdsImpEti.FieldByName('ENDERE').AsString := FieldByName('ENDERE').AsString;
              cdsImpEti.FieldByName('BAIRRO').AsString := FieldByName('BAIRRO').AsString;
              cdsImpEti.FieldByName('C_E_P_').AsString := FieldByName('C_E_P_').AsString;
              cdsImpEti.FieldByName('NOMCID').AsString := FieldByName('NOMCID').AsString;
              cdsImpEti.FieldByName('ENDNUM').AsString := FieldByName('ENDNUM').AsString;
              cdsImpEti.FieldByName('ENDCOM').AsString := FieldByName('ENDCOM').AsString;
              cdsImpEti.FieldByName('CODCLI').AsString := FieldByName('CODCLI').AsString;
              cdsImpEti.FieldByName('ESTCLI').AsString := FieldByName('ESTCLI').AsString;
              cdsImpEti.FieldByName('C_G_C_').AsString := FieldByName('C_G_C_').AsString;
              cdsImpEti.FieldByName('EMAIL_').AsString := FieldByName('EMAIL_').AsString;
              cdsImpEti.FieldByName('CELULA').AsString := FieldByName('CELULA').AsString;

              cdsImpEti.FieldByName('NOMCTT').AsString := FieldByName('NOMCTT').AsString;
              cdsImpEti.FieldByName('ENDCTT').AsString := FieldByName('ENDCTT').AsString;
              cdsImpEti.FieldByName('BAICTT').AsString := FieldByName('BAICTT').AsString;
              cdsImpEti.FieldByName('CIDCTT').AsString := FieldByName('CIDCTT').AsString;
              cdsImpEti.FieldByName('TELCTT').AsString := FieldByName('TELCTT').AsString;
              cdsImpEti.FieldByName('EMACTT').AsString := FieldByName('EMACTT').AsString;
              cdsImpEti.FieldByName('EMPCTT').AsString := FieldByName('EMPCTT').AsString;
              cdsImpEti.FieldByName('CELCTT').AsString := FieldByName('CELCTT').AsString;
              cdsImpEti.FieldByName('FAXCTT').AsString := FieldByName('FAXCTT').AsString;
              cdsImpEti.FieldByName('DEPCTT').AsString := FieldByName('DEPCTT').AsString;
              cdsImpEti.FieldByName('NASCTT').AsString := FieldByName('NASCTT').AsString;
              cdsImpEti.FieldByName('OBSCTT').AsString := FieldByName('OBSCTT').AsString;
              cdsImpEti.FieldByName('CGOCTT').AsString := FieldByName('CGOCTT').AsString;
              cdsImpEti.FieldByName('DPTCTT').AsString := FieldByName('DPTCTT').AsString;
              cdsImpEti.FieldByName('TFUCTT').AsString := FieldByName('TFUCTT').AsString;
              cdsImpEti.FieldByName('HOBCTT').AsString := FieldByName('HOBCTT').AsString;
              cdsImpEti.FieldByName('ESCCTT').AsString := FieldByName('ESCCTT').AsString;
              cdsImpEti.FieldByName('TMSGTT').AsString := FieldByName('TMSGTT').AsString;
              cdsImpEti.FieldByName('TMEPTT').AsString := FieldByName('TMEPTT').AsString;
              cdsImpEti.FieldByName('GMUCTT').AsString := FieldByName('GMUCTT').AsString;
              cdsImpEti.FieldByName('ECICTT').AsString := FieldByName('ECICTT').AsString;
              cdsImpEti.FieldByName('QTFITT').AsString := FieldByName('QTFITT').AsString;
              cdsImpEti.FieldByName('CERCTT').AsString := FieldByName('CERCTT').AsString;
              cdsImpEti.FieldByName('CPF_TT').AsString := FieldByName('CPF_TT').AsString;
              cdsImpEti.FieldByName('NRG_TT').AsString := FieldByName('NRG_TT').AsString;
              cdsImpEti.FieldByName('CAIPOS').AsString := FieldByName('CAIPOS').AsString;
              cdsImpEti.FieldByName('FONE01').AsString := FieldByName('FONE01').AsString;
              cdsImpEti.FieldByName('FONE02').AsString := FieldByName('FONE02').AsString;

              cdsImpEti.Post;
            End;

            Next;
          End;

          cdsImpEti.First;
        End;

      End;

      frxDatSet.DataSet := cdsImpEti;

      If (not fEmptyStr(strLayDoc)) Then
        efsEdiFas.fLeEtiqueta(False, strLayDoc)
      else
        efsEdiFas.fLeEtiqueta;

      If Not fEmptyStr(strNomImp) Then
        frxReport.PrintOptions.Printer  := strNomImp;

      frxReport.PrintOptions.ShowDialog := True;

      If frxReport.PrepareReport Then
        pPreviewReport('frmImpEtiquetas', tpeTipEtq.GetName(), frxReport);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fimprimeetiquetacliente]');
    End;
  End;

  pLiberaRecursos;
end;

{**********************************}
{* IMPRIME A ETIQUETA DE CAIXAS *}
{**********************************}
procedure pImprimeEtiquetaCaixas(prmDllRel: Pointer);
  Var
     strEAN39: String;
    efsEdiFas: TEditorFast;
    qryCfgRel,
    qryEtique: TUniQuery;
    strNomImp: String;
    cdsImpEti: TUniClientDataSet;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataSet;
    objDllRel: TParamDllEtiquetas;
    blnResult: Boolean;
    intTipEti: Integer;

  procedure pLiberaRecursos;
  begin
    FreeAndNil(cdsImpEti);
    FreeAndNil(frxReport);
    FreeAndNil(qryEtique);
    FreeAndNil(frxDatSet);
    FreeAndNil(efsEdiFas);
    pLiberaModulos;
  end;

  procedure pCriaDataSetCaixas(Var cdsImpEti: TUniClientDataSet; Self: TComponent);
  Begin
    cdsImpEti := TUniClientDataSet.Create(Self);
    With cdsImpEti, FieldDefs Do
    Begin

      With AddFieldDef Do Begin Name := 'CODBAR'; DataType := ftString; Size := 015; Required := False; End;
      With AddFieldDef Do Begin Name := 'CODEMP'; DataType := ftString; Size := 003; Required := False; End;
      With AddFieldDef Do Begin Name := 'NOMEMP'; DataType := ftString; Size := 060; Required := False; End;
      With AddFieldDef Do Begin Name := 'ENDEMP'; DataType := ftString; Size := 100; Required := False; End;
      With AddFieldDef Do Begin Name := 'ENEMP2'; DataType := ftString; Size := 100; Required := False; End;
      With AddFieldDef Do Begin Name := 'CEPEMP'; DataType := ftString; Size := 010; Required := False; End;
      With AddFieldDef Do Begin Name := 'CIDEMP'; DataType := ftString; Size := 060; Required := False; End;
      With AddFieldDef Do Begin Name := 'FONEMP'; DataType := ftString; Size := 015; Required := False; End;

      CreateDataSet;
      Open;
      EmptyDataSet;
      Filter   := '';
      Filtered := FALSE;
    End;
  End;

begin
  Try
    objDllRel := prmDllRel;

    With objDllRel Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      arrProCod := arrPrxCod;

      pCriarFormularios(TfrmImpEtiquetaCaixas, frmImpEtiquetaCaixas);
      blnResult := (frmImpEtiquetaCaixas.ShowModal = mrOk );
      arrEAN39  := frmImpEtiquetaCaixas.arrEAN39;
      intTipEti := frmImpEtiquetaCaixas.rdgTipEti.ItemIndex;
      FreeAndNil(frmImpEtiquetaCaixas);

      If blnResult Then
      Begin
        frxReport := TfrxReport.Create(Nil);
        frxDatSet := TfrxDBDataSet.Create(Nil);
        frxDatSet.Name := 'frxDBImpEti';
        qryEtique := fCriaQuery;

        pCriaDataSetCaixas(cdsImpEti, Nil);

        qryCfgRel := fCriaQuery;
        pCarregaConfImpr(qryCfgRel, 'frmImpEtiquetas');
        strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
        FreeAndNil(qryCfgRel);

        If intTipEti = 0 Then
          tpeTipEtq := tpeCaixasLaser
        Else
          tpeTipEtq := tpeCaixasArgox;

        efsEdiFas := TEditorFast.Create(Nil,
                                        frxReport,
                                        frxDatSet,
                                        tpeTipEtq);

        efsEdiFas.pAbreCaixas(qryEtique);

        If qryEtique.isEmpty Then
        Begin
          pLiberaRecursos;
          Exit;
        End;

        With qryEtique Do
        Begin
          cdsImpEti.EmptyDataSet;

          For strEAN39 in arrEAN39 Do
          Begin
            cdsImpEti.Append;
            cdsImpEti.FieldByName('CODBAR').AsString   := strEAN39;
            cdsImpEti.FieldByName('CODEMP').AsString   := FieldByName('CODEMP').AsString;
            cdsImpEti.FieldByName('NOMEMP').AsString   := FieldByName('NOMEMP').AsString;
            cdsImpEti.FieldByName('ENDEMP').AsString   := FieldByName('ENDEMP').AsString;
            cdsImpEti.FieldByName('ENEMP2').AsString   := FieldByName('ENEMP2').AsString;
            cdsImpEti.FieldByName('CEPEMP').AsString   := FieldByName('CEPEMP').AsString;
            cdsImpEti.FieldByName('CIDEMP').AsString   := FieldByName('CIDEMP').AsString;
            cdsImpEti.FieldByName('FONEMP').AsString   := FieldByName('FONEMP').AsString;
            cdsImpEti.Post;
          End;

          cdsImpEti.First;

        End;

        frxDatSet.DataSet := cdsImpEti;

        efsEdiFas.fLeEtiqueta;

        If Not fEmptyStr(strNomImp) Then
          frxReport.PrintOptions.Printer  := strNomImp;

        frxReport.PrintOptions.ShowDialog := True;

        If frxReport.PrepareReport Then
          pPreviewReport('frmImpEtiquetas', tpeTipEtq.GetName(), frxReport);
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fimprimeetiquetacaixas]');
    End;
  End;

  pLiberaRecursos;
end;

{********************************************}
{* IMPRIME A ETIQUETA DE MONTAGEM DE CAIXAS *}
{********************************************}
procedure pImprimeEtiquetaMontagemCaixas(prmDllRel: Pointer);
  Var
    efsEdiFas: TEditorFast;
    qryCfgRel: TUniQuery;
    strNomImp: String;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataSet;
    objDllRel: TParamDllEtiquetas;
    cdsEtique: TUniCLientDataSet;

  procedure pLiberaRecursos;
  begin
    FreeAndNil(frxReport);
    FreeAndNil(frxDatSet);
    FreeAndNil(efsEdiFas);
    pLiberaModulos;
  end;

begin
  Try
    objDllRel := prmDllRel;

    With objDllRel Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      arrProCod := arrPrxCod;

      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataSet.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      qryCfgRel := fCriaQuery;
      pCarregaConfImpr(qryCfgRel, 'frmImpEtiquetas', '', '', strOpeImp);
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      FreeAndNil(qryCfgRel);

      tpeTipEtq := tpeMontagemCaixasLaser;
      If fCfgSis('MTACAX', varString) = 'A' Then
        tpeTipEtq := tpeMontagemCaixasArgox
      else if fCfgSis('MTACAX', varString) = 'Z' Then
        tpeTipEtq := tpeMontagemCaixasZebra;

      if ( fCfgSis('IMPCAI', varInteger) = 3 ) Then
      begin
        tpeTipEtq := tpeMontagemCaixasLaserCodBarras;
        If fCfgSis('MTACAX', varString) = 'Z' Then
          tpeTipEtq := tpeMontagemCaixasZebra;
      end;

      if ( fCfgSis('IMPCAI', varInteger) = 4 ) Then
      begin
        tpeTipEtq := tpeMontagemCaixasLaserPackList;
        If fCfgSis('MTACAX', varString) = 'Z' Then
          tpeTipEtq := tpeMontagemCaixasZebraPackList;
      end;

      efsEdiFas := TEditorFast.Create(Nil,
                                      frxReport,
                                      frxDatSet,
                                      tpeTipEtq);

      cdsEtique := TUniClientDataSet.Create(nil);
      Try
        cdsEtique.Data := objDllRel.cdsDadosEtiqueta.Data;

        if efsEdiFas.fLeEtiqueta then
        begin
          frxDatSet.DataSet := cdsEtique;

          If Not fEmptyStr(strNomImp) Then
            frxReport.PrintOptions.Printer  := strNomImp;

          frxReport.PrintOptions.ShowDialog := True;

          If frxReport.PrepareReport Then
          Begin
            If blnImpEti Then
              pPreviewReport('frmImpEtiquetas', tpeTipEtq.GetName(), frxReport)
            Else
              pPrintReport('frmImpEtiquetas', tpeTipEtq.GetName(), strNomImp, frxReport);
          End;
        end;
      finally
        FreeAndNil(cdsEtique) ;
      end;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pImprimeEtiquetaMontagemCaixas]');
    End;
  End;

  pLiberaRecursos;
end;

{*******************************}
{* IMPRIME A ETIQUETA DE ITENS *}
{****************************AN*}
function fimprimeetiquetaitens(prmDllEtq: Pointer): Boolean;

  Var
    blnLocalizouItebar: Boolean;
    ArrOrdEti: TStringArray;
    intOpcOrd: Integer;

  function fCriaClient: TUniClientDataSet;
    Var
      intIndex : Integer;
  begin
    Result := TUniClientDataSet.Create(nil);
    With Result, FieldDefs Do
    Begin
      With AddFieldDef Do Begin Name := 'CODEMP'; DataType := ftString;  Size := 3;   Required := False; End;
      With AddFieldDef Do Begin Name := 'NOMEMP'; DataType := ftString;  Size := 60;  Required := False; End;
      With AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString;  Size := fTamCodIte;   Required := False; End;
      With AddFieldDef Do Begin Name := 'NUMDOC'; DataType := ftString;  Size := 12;  Required := False; End;
      With AddFieldDef Do Begin Name := 'ESPDOC'; DataType := ftString;  Size := 2;   Required := False; End;
      With AddFieldDef Do Begin Name := 'SERIE_'; DataType := ftString;  Size := 3;   Required := False; End;
      With AddFieldDef Do Begin Name := 'DESITE'; DataType := ftString;  Size := 100;  Required := False; End;
      With AddFieldDef Do Begin Name := 'DESSIM'; DataType := ftString;  Size := 70;  Required := False; End;
      With AddFieldDef Do Begin Name := 'REFERE'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'SIGUNI'; DataType := ftString;  Size := 6;   Required := False; End;
      With AddFieldDef Do Begin Name := 'DESMAR'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'DTAEMI'; DataType := ftDateTime;             Required := False; End;
      With AddFieldDef Do Begin Name := 'QTDETI'; DataType := ftInteger;              Required := False; End;
      With AddFieldDef Do Begin Name := 'VALITE'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'EXEVAL'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'MINQTD'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'PREPRO'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'PROTOT'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'CONPAG'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'TAXJUR'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'PREPRA'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'PARPRA'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'PROMOC'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'PERDES'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'QTDMIN'; DataType := ftFloat;                Required := False; End;

      With AddFieldDef Do Begin Name := 'DTAALT'; DataType := ftDateTime;             Required := False; End;
      With AddFieldDef Do Begin Name := 'CODMAR'; DataType := ftString;  Size := 6;   Required := False; End;
      With AddFieldDef Do Begin Name := 'AMZETI'; DataType := ftString;  Size := 3;   Required := False; End;
      With AddFieldDef Do Begin Name := 'ITEATI'; DataType := ftString;  Size := 1;   Required := False; End;

      With AddFieldDef Do Begin Name := 'PREVE1'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'PREVE2'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'PREVE3'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'PREVE4'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'PREVE5'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'PREVE6'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'PREVE7'; DataType := ftFloat;                Required := False; End;

      With AddFieldDef Do Begin Name := 'IBPIT1'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPIT2'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPIT3'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPIT4'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPIT5'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPIT6'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPIT7'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'PROIMG'; DataType := ftBlob;                 Required := False; End;

      With AddFieldDef Do Begin Name := 'IBPFT1'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPFT2'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPFT3'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPFT4'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPFT5'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPFT6'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPFT7'; DataType := ftFloat;                Required := False; End;

      With AddFieldDef Do Begin Name := 'IBPET1'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPET2'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPET3'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPET4'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPET5'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPET6'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPET7'; DataType := ftFloat;                Required := False; End;

      With AddFieldDef Do Begin Name := 'IBPMT1'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPMT2'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPMT3'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPMT4'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPMT5'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPMT6'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IBPMT7'; DataType := ftFloat;                Required := False; End;

      With AddFieldDef Do Begin Name := 'TOTPRA'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'PREVIS'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'VALPAR'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'QTDPAR'; DataType := ftInteger;              Required := False; End;

      With AddFieldDef Do Begin Name := 'VALVIS'; DataType := ftString;               Required := False; End;
      With AddFieldDef Do Begin Name := 'CODFAB'; DataType := ftString;  Size := 35;  Required := False; End;
      With AddFieldDef Do Begin Name := 'CODBAR'; DataType := ftString;  Size := 72;  Required := False; End;
      With AddFieldDef Do Begin Name := 'LOCFIS'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'LOCSUP'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'EMPCGC'; DataType := ftString;  Size := 50;  Required := False; End;
      With AddFieldDef Do Begin Name := 'FABMAR'; DataType := ftString;  Size := 100; Required := False; End;
      With AddFieldDef Do Begin Name := 'CODGRU'; DataType := ftString;  Size := 6;   Required := False; End;
      With AddFieldDef Do Begin Name := 'APLICA'; DataType := ftMemo;                 Required := False; End;

      With AddFieldDef Do Begin Name := 'LOTECR'; DataType := ftString;  Size := 05;  Required := False; End;
      With AddFieldDef Do Begin Name := 'EMBALA'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'EMBPRE'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'TABEMF'; DataType := ftString;  Size := 1;   Required := False; End;
      With AddFieldDef Do Begin Name := 'DESFEC'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'EMBFEC'; DataType := ftFloat;                Required := False; End;

      With AddFieldDef Do Begin Name := 'SALDOS'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'FONDA1'; DataType := ftString;  Size := 15;  Required := False; End;
      With AddFieldDef Do Begin Name := 'FONDA2'; DataType := ftString;  Size := 12;  Required := False; End;
      With AddFieldDef Do Begin Name := 'CODAMZ'; DataType := ftString;  Size := 03;  Required := False; End;
      With AddFieldDef Do Begin Name := 'DESEMB'; DataType := ftString;  Size := 70;  Required := False; End;
      With AddFieldDef Do Begin Name := 'CODSEM'; DataType := ftString;  Size := 255; Required := False; End;

      With AddFieldDef Do Begin Name := 'VALIDA'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'ITESAC'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'COMPOS'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'PAISOR'; DataType := ftString;  Size := 30;  Required := False; End;

      With AddFieldDef Do Begin Name := 'ESTMIN'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'ESTMAX'; DataType := ftFloat;                Required := False; End;

      With AddFieldDef Do Begin Name := 'MENFIS'; DataType := ftString;  Size := 255; Required := False; End;

      With AddFieldDef Do Begin Name := 'MSGLV1'; DataType := ftString;  Size := 50;  Required := False; End;
      With AddFieldDef Do Begin Name := 'MSGLV2'; DataType := ftString;  Size := 50;  Required := False; End;

      With AddFieldDef Do Begin Name := 'OBSIMP'; DataType := ftString;  Size := 50;  Required := False; End;

      With AddFieldDef Do Begin Name := 'CODFOR'; DataType := ftString;  Size := 08;  Required := False; End;
      With AddFieldDef Do Begin Name := 'NOMFOR'; DataType := ftString;  Size := 60;  Required := False; End;
      With AddFieldDef Do Begin Name := 'MLTVEN'; DataType := ftFloat;                Required := False; End;
      With AddFieldDef Do Begin Name := 'IPISAI'; DataType := ftFloat;                Required := False; End;

      With AddFieldDef Do Begin Name := 'ATICOM'; DataType := ftString;  Size := 1;   Required := False; End;

      For intIndex := 0 To 9 Do
      Begin
        With AddFieldDef Do Begin Name := 'QTDEM' + IntToStr(intIndex); DataType := ftFloat;    Required := False; End;
        With AddFieldDef Do Begin Name := 'DESCO' + IntToStr(intIndex); DataType := ftFloat;    Required := False; End;
        With AddFieldDef Do Begin Name := 'TABPR' + IntToStr(intIndex); DataType := ftString;   Size := 5; Required := False; End;
        With AddFieldDef Do Begin Name := 'UNITA' + IntToStr(intIndex); DataType := ftFloat;    Required := False; End;
      End;

      With AddFieldDef Do Begin Name := 'DESCOR'; DataType := ftFloat;    Required := False; End;
      With AddFieldDef Do Begin Name := 'EMBFTO'; DataType := ftFloat;    Required := False; End;
      With AddFieldDef Do Begin Name := 'EMBFUN'; DataType := ftFloat;    Required := False; End;
      With AddFieldDef Do Begin Name := 'QTDEMR'; DataType := ftFloat;    Required := False; End;
      With AddFieldDef Do Begin Name := 'EXPEMB'; DataType := ftString;   Size := 150; Required := False; End;

      With AddFieldDef Do Begin Name := 'OPEIMP'; DataType := ftString;  Size := 03;  Required := False; End;
      With AddFieldDef Do Begin Name := 'NOMOPE'; DataType := ftString;  Size := 30;  Required := False; End;

      With AddFieldDef Do Begin Name := 'PRDGRU'; DataType := ftString;  Size := 06;  Required := False; End;
      With AddFieldDef Do Begin Name := 'DESGRU'; DataType := ftString;  Size := 70;  Required := False; End;
      With AddFieldDef Do Begin Name := 'CGCFOR'; DataType := ftString;  Size := 18;  Required := False; End;
      With AddFieldDef Do Begin Name := 'CATPRO'; DataType := ftString;  Size := 10;  Required := False; End;

      With AddFieldDef Do Begin Name := 'TAMLCF'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'TAMLCS'; DataType := ftString;  Size := 30;  Required := False; End;
      With AddFieldDef Do Begin Name := 'DTAULT'; DataType := ftString;  Size := 30;  Required := False; End;

      With AddFieldDef Do Begin Name := 'QRCODE'; DataType := ftString;  Size := 250;  Required := False; End;
      With AddFieldDef Do Begin Name := 'URLIMG'; DataType := ftString;  Size := 250;  Required := False; End;
      With AddFieldDef Do Begin Name := 'NUMGAR'; DataType := ftString;  Size := 30;   Required := False; End;
      With AddFieldDef Do Begin Name := 'DTAENT'; DataType := ftString;  Size := 10;   Required := False; End;
      With AddFieldDef Do Begin Name := 'OBSER1'; DataType := ftString;  Size := 50;   Required := False; End;
      With AddFieldDef Do Begin Name := 'OBSER2'; DataType := ftString;  Size := 50;   Required := False; End;

      With AddFieldDef Do Begin Name := 'DESPRO'; DataType := ftString;  Size := 60;   Required := False; End;
      With AddFieldDef Do Begin Name := 'PROINI'; DataType := ftString;  Size := 10;   Required := False; End;
      With AddFieldDef Do Begin Name := 'PROFIN'; DataType := ftString;  Size := 10;   Required := False; End;

      With AddFieldDef Do Begin Name := 'PONEXP'; DataType := ftFloat;   Required := False; End;
      With AddFieldDef Do Begin Name := 'ITEPRO'; DataType := ftString;  Size := 1;   Required := False; End;

      With AddFieldDef Do Begin Name := 'DOLCOM'; DataType := ftString;  Size := 20;   Required := False; End;
      With AddFieldDef Do Begin Name := 'DOLVEN'; DataType := ftString;  Size := 20;   Required := False; End;
      With AddFieldDef Do Begin Name := 'MOEEMP'; DataType := ftString;  Size := 60;   Required := False; End;
      With AddFieldDef Do Begin Name := 'DTAMOE'; DataType := ftDateTime;              Required := False; End;

      With AddFieldDef Do Begin Name := 'CUSPRE'; DataType := ftString;  Size := 30;   Required := False; End;
      With AddFieldDef Do Begin Name := 'DESUNI'; DataType := ftString;  Size := 15;   Required := False; End;
      With AddFieldDef Do Begin Name := 'NVLGIR'; DataType := ftString;  Size := 01;   Required := False; End;
      With AddFieldDef Do Begin Name := 'VALOBR'; DataType := ftString;  Size := 01;   Required := False; End;
      With AddFieldDef Do Begin Name := 'SEQETI'; DataType := ftInteger;               Required := False; End;
      With AddFieldDef Do Begin Name := 'CODITF'; DataType := ftString;  Size := 50;   Required := False; End;

      With AddFieldDef Do Begin Name := 'BAIRRO'; DataType := ftString;  Size := 25;   Required := False; End;
      With AddFieldDef Do Begin Name := 'CEPEMP'; DataType := ftString;  Size := 9;    Required := False; End;
      With AddFieldDef Do Begin Name := 'CIDEMP'; DataType := ftString;  Size := 40;   Required := False; End;
      With AddFieldDef Do Begin Name := 'EMPNOM'; DataType := ftString;  Size := 60;   Required := False; End;
      With AddFieldDef Do Begin Name := 'ENDCMP'; DataType := ftString;  Size := 25;   Required := False; End;
      With AddFieldDef Do Begin Name := 'ENDEMP'; DataType := ftString;  Size := 40;   Required := False; End;
      With AddFieldDef Do Begin Name := 'ENDNUM'; DataType := ftString;  Size := 5;    Required := False; End;
      With AddFieldDef Do Begin Name := 'ESTEMP'; DataType := ftString;  Size := 2;    Required := False; End;
      With AddFieldDef Do Begin Name := 'FANEMP'; DataType := ftString;  Size := 60;   Required := False; End;
      With AddFieldDef Do Begin Name := 'IESEMP'; DataType := ftString;  Size := 18;   Required := False; End;
      With AddFieldDef Do Begin Name := 'DESMAX'; DataType := ftFloat; Required := False; End;
      With AddFieldDef Do Begin Name := 'DESMVM'; DataType := ftFloat; Required := False; End;
      With AddFieldDef Do Begin Name := 'LOCGER'; DataType := ftString;  Size := 30;   Required := False; End;
      With AddFieldDef Do Begin Name := 'DESFAB'; DataType := ftString;  Size := 250;  Required := False; End;
      With AddFieldDef Do Begin Name := 'LOCADI'; DataType := ftString;  Size := 256;  Required := False; End;
      With AddFieldDef Do Begin Name := 'LFAPRC'; DataType := ftString;  Size := 20;   Required := False; End;
      With AddFieldDef Do Begin Name := 'DTAEPI'; DataType := ftString;  Size := 10;   Required := False; End;

      CreateDataSet;
      Open;
      EmptyDataSet;
      Filter := '';
      Filtered := False;
    End;
  end;

  function fRetLocFisicaAmz(strCodIte, strCodAmz: String): String;
    Var
      qryTmp : TUniQuery;
  Begin
    qryTmp := fCriaQuery;
    qryTmp.SQL.Add('  SELECT LOT_LOCFIS            ');
    qryTmp.SQL.Add('    FROM CADLOT                ');
    qryTmp.SQL.Add('   WHERE LOT_NUMLOT = :CODAMZ  ');
    qryTmp.SQL.Add('     AND LOT_CODITE = :CODITE  ');
    qryTmp.SQL.Add('     AND LOT_CODEMP = :CODEMP  ');
    qryTmp.ParamByName('CODAMZ').AsString := strCodAmz;
    qryTmp.ParamByName('CODITE').AsString := strCodIte;
    qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTmp.Open;
    Result := qryTmp.FieldByName('LOT_LOCFIS').AsString;
    qryTmp.Close;
    FreeAndNil(qryTmp);
  End;

  Var
    intNext : Integer;
    ListaProcessado: TStringList;
    strNomImp : String;
    efsEdiFas : TEditorFast;
    frxReport : TfrxReport;
    frxDatSet : TfrxDBDataSet;
    objDllEtq : TParamDllEtiquetas;
    qryCfgRel : TUniQuery;
    qryEtique : TUniQuery;
    cdsEtique : TUniClientDataSet;
    qryBarEmb : TUniQuery;
    strIndex  : String;
    blnPreProInterna: Boolean;
    fltPreCus,
    fltPreVen,
    fltComVar,
    fltComAta,
    fltComDis,
    fltQtdDis,
    fltDesF07: Double;
    strComPro: String;
    strCodPro: String;
    blnParticiona,
    blnPromo: Boolean;

  procedure pLiberaRecursos;
  begin
    FreeAndNil(qryCfgRel);
    FreeAndNil(qryEtique);
    FreeAndNil(cdsEtique);

    FreeAndNil(frxReport);
    FreeAndNil(frxDatSet);

    If Assigned(efsEdiFas) Then
      FreeAndNil(efsEdiFas);

    pLiberaModulos;
  end;

  Function fSQLBarEmp: String;
  Begin
    Result := '';
    Result := Result + ' SELECT   ';
    Result := Result + '   BAR_EMBALA, ';
    Result := Result + '   BAR_PREVEN, ';
    Result := Result + '   BAR_TABPRE, ';
    Result := Result + '   BAR_DESCRI  ';
    Result := Result + ' FROM     ';
    Result := Result + '   ITEBAR ';
    Result := Result + ' WHERE    ';
    Result := Result + '   BAR_CODITE = :CODITE AND ';
    Result := Result + '   BAR_CODBAR = :CODBAR     ';
  End;

  function fAchaIteBar(strCodIte :String = ''; strCodBar :String = ''): Boolean;
  Begin
    With qryBarEmb Do
    Begin
      Close;

      If (not strCodIte.IsEmpty) And
         (not strCodBar.IsEmpty)
      Then
      Begin
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODBAR').AsString := strCodBar;
      End
      Else
      Begin
        ParamByName('CODITE').AsString := qryEtique.FieldByName('CODITE').AsString;
        ParamByName('CODBAR').AsString := qryEtique.FieldByName('CODBAR').AsString;
      End;

      Open;

      Result := Not IsEmpty;
    End;
  End;
  function fProcessado(strCodIteVer: String): Boolean;
  begin
    Result :=  ListaProcessado.IndexOf(strCodIteVer) > -1;
    If Not Result Then
      ListaProcessado.Add(strCodIteVer);
  End;

  function fRetornaCampoPrecoPromocoaoPorPreco( strTabela: String ) : String;
  Begin
    Result := ' IPR_PREVEN ';
  End;

  function fGetSQLCondicaoPromocaoPorDesconto: String;
  begin
    Result := ' ((CADPRO.PRO_PREDES = "D" AND CADPRO.PRO_IDXPRO <> '+IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoComDescontoAdicional])+')'+
              '  OR (CADPRO.PRO_IDXPRO IN ('+IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpDescon])+','+IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoQuantidadeColetiva])+'))) '
  end;

  Function fRetPrecoTotalPromocao(strCodIte, strTabela : String): String;
  Var
  qryAux : TUniQuery;
  strSQL : String;
  strTotPro : String;
  begin
    If SameText(strTabela, '0') Then
      strTabela := '1';

    strSQL :=   '  SELECT ( ROUND(IF('+fGetSQLCondicaoPromocaoPorDesconto+', (1 - (ITEPRO.IPR_PERDES / 100)) * ITEGER.ITE_PREVE' + strTabela + ', '+fRetornaCampoPrecoPromocoaoPorPreco(strTabela)+'), '+fCfgSis('DECUNI', varString)+') * IPR_QTDMIN ) AS PROTOT '+
                '  FROM ITEPRO                                          '+
                '  JOIN CADPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER '+
                '  JOIN ITEGER ON ITEGER.ITE_CODITE = ITEPRO.IPR_CODITE '+
                '             AND ITEGER.ITE_CODEMP = ITEPRO.IPR_CODEMP '+
                '  WHERE IPR_CODITE = :CODITE                           '+
                '  AND IPR_CODEMP = :CODEMP                             '+
                '  AND :DTAPRO BETWEEN CADPRO.PRO_DTAINI                '+
                '  AND CADPRO.PRO_DTAFIN                                '+
                '  ORDER BY IPR_QTDMIN ASC                              ';

    qryAux := fCriaQuery();
    Try
      qryAux.Close;
      qryAux.SQl.Text := strSQL;
      qryAux.ParamByName('CODITE').AsString := strCodIte;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.ParamByName('DTAPRO').AsDateTime := VS_date;
      qryAux.Open;

      While not qryAux.eof do
      Begin
        strTotPro :=  strTotPro + FormatFloat('#,##0.00',(qryAux.FieldByName('PROTOT').AsFloat)) + #13#10;
        qryAux.Next;
      End;


	    Result := strTotPro;

    Finally
      FreeAndNil(qryAux);
    End;
  end;


  Function fRetPrecoPromocao(strCodIte, strTabela : String): String;
  Var
  qryAux : TUniQuery;
  strSQL : String;
  strPrePro : String;
  begin

   If SameText(strTabela,'0') Then
    strTabela := '1';

    strSQL :=   '  SELECT ( ROUND(IF('+fGetSQLCondicaoPromocaoPorDesconto+', (1 - (ITEPRO.IPR_PERDES / 100)) * ITEGER.ITE_PREVE' + strTabela + ', '+fRetornaCampoPrecoPromocoaoPorPreco(strTabela)+'), '+fCfgSis('DECUNI', varString)+') ) AS PREVEN '+
                '  FROM ITEPRO                                          '+
                '  JOIN CADPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER '+
                '  JOIN PROEMP ON PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM '+
                '  JOIN ITEGER ON ITEGER.ITE_CODITE = ITEPRO.IPR_CODITE '+
                '             AND ITEGER.ITE_CODEMP = ITEPRO.IPR_CODEMP '+
                '  WHERE IPR_CODITE = :CODITE                           '+
                '  AND ((IPR_CODEMP = :CODEMP) OR                       '+
                '       (PROEMP.PRO_CODEMP = :CODEMP))                  '+
                '  AND :DTAPRO BETWEEN CADPRO.PRO_DTAINI                '+
                '  AND CADPRO.PRO_DTAFIN                                '+
                '  ORDER BY IPR_QTDMIN ASC                              '+
                '  LIMIT 1                                              ';

    qryAux := fCriaQuery();
    Try
      qryAux.Close;
      qryAux.SQl.Text := strSQL;
      qryAux.ParamByName('CODITE').AsString := strCodIte;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.ParamByName('DTAPRO').AsDateTime := VS_date;
      qryAux.Open;

      While not qryAux.eof do
      Begin
        strPrePro :=  strPrePro + FormatFloat('#,##0.00',(qryAux.FieldByName('PREVEN').AsFloat)) + #13#10;
        qryAux.Next;
      End;


	    Result := strPrePro;

    Finally
      FreeAndNil(qryAux);
    End;
  end;


  Function fRetQtdMinPromocao(strCodIte : String): String;
  Var
  qryAux : TUniQuery;
  strSQL, strQtdMin : String;
  begin
    strSQL :=   '  SELECT IPR_QTDMIN AS QTDMIN                       	  '+
                '  FROM ITEPRO                                          '+
                '  JOIN CADPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER '+
                '  WHERE IPR_CODITE = :CODITE                           '+
                '  AND IPR_CODEMP = :CODEMP                             '+
                '  AND :DTAPRO BETWEEN CADPRO.PRO_DTAINI                '+
                '  AND CADPRO.PRO_DTAFIN                                '+
                '  ORDER BY IPR_QTDMIN ASC                              ';

    qryAux := fCriaQuery();
    Try
      qryAux.Close;
      qryAux.SQl.Text := strSQL;
      qryAux.ParamByName('CODITE').AsString := strCodIte;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.ParamByName('DTAPRO').AsDateTime := VS_date;
      qryAux.Open;

      While not qryAux.eof do
      Begin
        strQtdMin :=  strQtdMin + FormatFloat('#,##0.00',(qryAux.FieldByName('QTDMIN').AsFloat)) + #13#10;
        qryAux.Next;
      End;

	    Result := strQtdMin;

    Finally
      FreeAndNil(qryAux);
    End;
  end;

  procedure pAtualizaDtaHorImp(strCodIte, strCodEmp: String);
  Var
    strUpdDtaHorAltera: String;
    qryGenTmp: TUniQuery;
  Begin
    strUpdDtaHorAltera := '';
    strUpdDtaHorAltera := strUpdDtaHorAltera + 'UPDATE   ';
    strUpdDtaHorAltera := strUpdDtaHorAltera + '  ITEGER ';
    strUpdDtaHorAltera := strUpdDtaHorAltera + 'SET ';
    strUpdDtaHorAltera := strUpdDtaHorAltera + '  ITE_DTAETI = :DTAETI, ';
    strUpdDtaHorAltera := strUpdDtaHorAltera + '  ITE_HORETI = :HORETI ';
    strUpdDtaHorAltera := strUpdDtaHorAltera + ' WHERE ';
    strUpdDtaHorAltera := strUpdDtaHorAltera + '  ITE_CODITE = :CODITE AND ';
    strUpdDtaHorAltera := strUpdDtaHorAltera + '  ITE_CODEMP = :CODEMP ';

    qryGenTmp := fCriaQuery;
    try
      qryGenTmp.Close;
      qryGenTmp.SQL.Clear;
      qryGenTmp.SQL.Add(strUpdDtaHorAltera);
      qryGenTmp.ParamByName('CODITE').AsString   := strCodIte;
      qryGenTmp.ParamByName('CODEMP').AsString   := strCodEmp;
      qryGenTmp.ParamByName('DTAETI').AsDate     := VS_date;
      qryGenTmp.ParamByName('HORETI').AsDateTime := fnow;
      qryGenTmp.ExecSQL;
      qryGenTmp.Close;
    finally
      FreeAndNil(qryGenTmp);
    end;
  End;

  procedure pGrava(intQtdEtiqueta: Integer);
    var     intCon, intIndex, intCon2: Integer;
  Begin
    For intCon := 1 To intQtdEtiqueta Do
    Begin
      With objDllEtq, qryEtique Do
      Begin
        cdsEtique.Insert;
        cdsEtique.FieldByName('CODEMP').AsString := VS_strCodEmp;
        cdsEtique.FieldByName('NOMEMP').AsString := FieldByName('NOMEMP').AsString;
        cdsEtique.FieldByName('APLICA').AsString := FieldByName('APLICA').AsString;
        cdsEtique.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
        cdsEtique.FieldByName('NUMDOC').AsString := iif(FieldByName('NUMDOC').AsString = 'Número Doc.', '', FieldByName('NUMDOC').AsString);
        cdsEtique.FieldByName('ESPDOC').AsString := iif(FieldByName('ESPDOC').AsString = 'Esp Doc.'   , '', FieldByName('ESPDOC').AsString);
        cdsEtique.FieldByName('SERIE_').AsString := iif(FieldByName('SERIE_').AsString = 'Série Doc.' , '', FieldByName('SERIE_').AsString);
        cdsEtique.FieldByName('DESITE').AsString := FieldByName('DESITE').AsString;
        cdsEtique.FieldByName('DESSIM').AsString := FieldByName('DESSIM').AsString;
        cdsEtique.FieldByName('REFERE').AsString := FieldByName('REFERE').AsString;
        cdsEtique.FieldByName('SIGUNI').AsString := FieldByName('SIGUNI').AsString;
        cdsEtique.FieldByName('DESMAR').AsString := FieldByName('DESMAR').AsString;
        cdsEtique.FieldByName('QTDETI').AsString := IntToStr(intQtdEti);
        cdsEtique.FieldByName('VALITE').AsFloat  := FieldByName('VALITE').AsFloat;
        cdsEtique.FieldByName('EXEVAL').AsFloat  := FieldByName('EXEVAL').AsFloat;
        cdsEtique.FieldByName('MINQTD').AsString := fRetQtdMinPromocao(qryEtique.FieldByName('CODITE').AsString);
        cdsEtique.FieldByName('PREPRO').AsString := fRetPrecoPromocao(qryEtique.FieldByName('CODITE').AsString, IntToStr(objDllEtq.intTabPre));
        cdsEtique.FieldByName('PROTOT').AsString := fRetPrecoTotalPromocao(qryEtique.FieldByName('CODITE').AsString, IntToStr(objDllEtq.intTabPre));
        cdsEtique.FieldByName('CONPAG').AsString := FieldByName('CONPAG').AsString;
        cdsEtique.FieldByName('TAXJUR').AsFloat  := FieldByName('TAXJUR').AsFloat;
        cdsEtique.FieldByName('PREPRA').AsString := FieldByName('PREPRA').AsString;
        cdsEtique.FieldByName('PARPRA').AsString := FieldByName('PARPRA').AsString;
        cdsEtique.FieldByName('PROMOC').AsFloat  := FieldByName('PROMOC').AsFloat;
        If Assigned(FieldByName('PERDES')) Then
          cdsEtique.FieldByName('PERDES').AsFloat  := FieldByName('PERDES').AsFloat;
        If Assigned(FieldByName('QTDMIN')) Then
          cdsEtique.FieldByName('QTDMIN').AsFloat  := FieldByName('QTDMIN').AsFloat;

        cdsEtique.FieldByName('PREVE1').AsFloat  := FieldByName('PREVE1').AsFloat;
        cdsEtique.FieldByName('PREVE2').AsFloat  := FieldByName('PREVE2').AsFloat;
        cdsEtique.FieldByName('PREVE3').AsFloat  := FieldByName('PREVE3').AsFloat;
        cdsEtique.FieldByName('PREVE4').AsFloat  := FieldByName('PREVE4').AsFloat;
        cdsEtique.FieldByName('PREVE5').AsFloat  := FieldByName('PREVE5').AsFloat;
        cdsEtique.FieldByName('PREVE6').AsFloat  := FieldByName('PREVE6').AsFloat;
        cdsEtique.FieldByName('PREVE7').AsFloat  := FieldByName('PREVE7').AsFloat;

        cdsEtique.FieldByName('DTAEMI').AsString := FieldByName('DTAEMI').AsString;
        cdsEtique.FieldByName('DTAALT').AsString := FieldByName('DTAALT').AsString;
        cdsEtique.FieldByName('CODMAR').AsString := FieldByName('CODMAR').AsString;
        cdsEtique.FieldByName('AMZETI').AsString := FieldByName('AMZETI').AsString;
        cdsEtique.FieldByName('ITEATI').AsString := FieldByName('ITEATI').AsString;

        cdsEtique.FieldByName('IBPIT1').AsFloat  := FieldByName('IBPIT1').AsFloat;
        cdsEtique.FieldByName('IBPIT2').AsFloat  := FieldByName('IBPIT2').AsFloat;
        cdsEtique.FieldByName('IBPIT3').AsFloat  := FieldByName('IBPIT3').AsFloat;
        cdsEtique.FieldByName('IBPIT4').AsFloat  := FieldByName('IBPIT4').AsFloat;
        cdsEtique.FieldByName('IBPIT5').AsFloat  := FieldByName('IBPIT5').AsFloat;
        cdsEtique.FieldByName('IBPIT6').AsFloat  := FieldByName('IBPIT6').AsFloat;
        cdsEtique.FieldByName('IBPIT7').AsFloat  := FieldByName('IBPIT7').AsFloat;
        cdsEtique.FieldByName('PROIMG').Value    := FieldByName('PROIMG').Value;

        cdsEtique.FieldByName('IBPFT1').AsFloat  := FieldByName('IBPFT1').AsFloat;
        cdsEtique.FieldByName('IBPFT2').AsFloat  := FieldByName('IBPFT2').AsFloat;
        cdsEtique.FieldByName('IBPFT3').AsFloat  := FieldByName('IBPFT3').AsFloat;
        cdsEtique.FieldByName('IBPFT4').AsFloat  := FieldByName('IBPFT4').AsFloat;
        cdsEtique.FieldByName('IBPFT5').AsFloat  := FieldByName('IBPFT5').AsFloat;
        cdsEtique.FieldByName('IBPFT6').AsFloat  := FieldByName('IBPFT6').AsFloat;
        cdsEtique.FieldByName('IBPFT7').AsFloat  := FieldByName('IBPFT7').AsFloat;

        cdsEtique.FieldByName('IBPET1').AsFloat  := FieldByName('IBPET1').AsFloat;
        cdsEtique.FieldByName('IBPET2').AsFloat  := FieldByName('IBPET2').AsFloat;
        cdsEtique.FieldByName('IBPET3').AsFloat  := FieldByName('IBPET3').AsFloat;
        cdsEtique.FieldByName('IBPET4').AsFloat  := FieldByName('IBPET4').AsFloat;
        cdsEtique.FieldByName('IBPET5').AsFloat  := FieldByName('IBPET5').AsFloat;
        cdsEtique.FieldByName('IBPET6').AsFloat  := FieldByName('IBPET6').AsFloat;
        cdsEtique.FieldByName('IBPET7').AsFloat  := FieldByName('IBPET7').AsFloat;

        cdsEtique.FieldByName('IBPMT1').AsFloat  := FieldByName('IBPMT1').AsFloat;
        cdsEtique.FieldByName('IBPMT2').AsFloat  := FieldByName('IBPMT2').AsFloat;
        cdsEtique.FieldByName('IBPMT3').AsFloat  := FieldByName('IBPMT3').AsFloat;
        cdsEtique.FieldByName('IBPMT4').AsFloat  := FieldByName('IBPMT4').AsFloat;
        cdsEtique.FieldByName('IBPMT5').AsFloat  := FieldByName('IBPMT5').AsFloat;
        cdsEtique.FieldByName('IBPMT6').AsFloat  := FieldByName('IBPMT6').AsFloat;
        cdsEtique.FieldByName('IBPMT7').AsFloat  := FieldByName('IBPMT7').AsFloat;

        cdsEtique.FieldByName('TOTPRA').AsFloat  := FieldByName('TOTPRA').AsFloat;
        cdsEtique.FieldByName('PREVIS').AsFloat  := FieldByName('PREVIS').AsFloat;
        cdsEtique.FieldByName('VALPAR').AsFloat  := FieldByName('VALPAR').AsFloat;
        cdsEtique.FieldByName('QTDPAR').AsInteger := FieldByName('QTDPAR').AsInteger;

        cdsEtique.FieldByName('EMPCGC').AsString := FieldByName('EMPCGC').AsString;
        cdsEtique.FieldByName('FABMAR').AsString := FieldByName('FABMAR').AsString;
        cdsEtique.FieldByName('CODGRU').AsString := FieldByName('CODGRU').AsString;

        cdsEtique.FieldByName('LOTECR').AsString := FieldByName('LOTECR').AsString;
        cdsEtique.FieldByName('EMBALA').AsFloat  := FieldByName('EMBALA').AsFloat;
        cdsEtique.FieldByName('EMBPRE').AsFloat  := FieldByName('EMBPRE').AsFloat;
        cdsEtique.FieldByName('SALDOS').AsFloat  := FieldByName('SALDOS').AsFloat;
        cdsEtique.FieldByName('FONDA1').AsString := FieldByName('FONDA1').AsString;
        cdsEtique.FieldByName('FONDA2').AsString := FieldByName('FONDA2').AsString;
        cdsEtique.FieldByName('LOCSUP').AsString := FieldByName('LOCSUP').AsString;
        cdsEtique.FieldByName('DESEMB').AsString := FieldByName('DESEMB').AsString;
        cdsEtique.FieldByName('CODSEM').AsString := FieldByName('CODSEM').AsString;

        cdsEtique.FieldByName('TABEMF').AsString := FieldByName('TABEMF').AsString;
        cdsEtique.FieldByName('DESFEC').AsFloat  := FieldByName('DESFEC').AsFloat;
        cdsEtique.FieldByName('EMBFEC').AsFloat  := FieldByName('EMBFEC').AsFloat;

        cdsEtique.FieldByName('MENFIS').AsString := FieldByName('MENFIS').AsString;

        cdsEtique.FieldByName('MSGLV1').AsString := FieldByName('MSGLV1').AsString;
        cdsEtique.FieldByName('MSGLV2').AsString := FieldByName('MSGLV2').AsString;

        If Assigned(FieldByName('OBSIMP')) Then
          cdsEtique.FieldByName('OBSIMP').AsString := FieldByName('OBSIMP').AsString;

        cdsEtique.FieldByName('VALIDA').AsString := FieldByName('VALIDA').AsString;
        cdsEtique.FieldByName('ITESAC').AsString := FieldByName('ITESAC').AsString;
        cdsEtique.FieldByName('COMPOS').AsString := FieldByName('COMPOS').AsString;
        cdsEtique.FieldByName('PAISOR').AsString := FieldByName('PAISOR').AsString;

        cdsEtique.FieldByName('ESTMIN').AsFloat := FieldByName('ESTMIN').AsFloat;
        cdsEtique.FieldByName('ESTMAX').AsFloat := FieldByName('ESTMAX').AsFloat;

        If Assigned(FieldByName('CODFOR')) Then
          cdsEtique.FieldByName('CODFOR').AsString := FieldByName('CODFOR').AsString;
        If Assigned(FieldByName('NOMFOR')) Then
          cdsEtique.FieldByName('NOMFOR').AsString := FieldByName('NOMFOR').AsString;

        If Assigned(FieldByName('MLTVEN')) Then
          cdsEtique.FieldByName('MLTVEN').AsFloat := FieldByName('MLTVEN').AsFloat;

        If Assigned(FieldByName('IPISAI')) Then
          cdsEtique.FieldByName('IPISAI').AsFloat := FieldByName('IPISAI').AsFloat;

        If Assigned(FieldByName('ATICOM')) Then
          cdsEtique.FieldByName('ATICOM').AsString := FieldByName('ATICOM').AsString;

        {*******************************}
        {* CARREGA O VALOR PROMOCIONAL *}
        {****************************PZ*}
        cdsEtique.FieldByName('ITEPRO').AsString := 'N';
        If (blnPromoc) And (Assigned(cdsPromoc)) And (Not cdsPromoc.isEmpty) Then
        Begin
          cdsPromoc.Filtered := False;
          cdsPromoc.Filter   := 'ITE_CODITE = ' + QuotedStr(FieldByName('CODITE').AsString);
          cdsPromoc.Filtered := True;

          cdsEtique.FieldByName('VALITE').AsFloat := cdsPromoc.FieldByName('ITE_PREPRO').AsFloat;
          cdsEtique.FieldByName('ITEPRO').AsString := 'S';
        End Else
        Begin
          cdsEtique.FieldByName('VALITE').AsFloat := qryEtique.FieldByName('VALITE').AsFloat;
          If fEmptyStr(fTiraCaracEspeciais(objDllEtq.strDtaPro)) Then
             objDllEtq.strDtaPro := DateToStr(fNow);

          blnPreProInterna := blnPrePro And (fRetornaPrecosPromocao(FieldByName('CODITE').AsString, '',
                StrToDate(objDllEtq.strDtaPro), 1, 0, 0, 0, fltPreCus, fltPreVen, fltComVar, fltComAta,
               fltComDis, fltQtdDis, fltDesF07, strComPro, strCodPro,
               blnParticiona, blnPromo, IntToStr(objDllEtq.intTabPre), ''));

          if blnPreProInterna And (fltPreVen > 0)  Then
          begin
            If cdsEtique.FieldByName('PROMOC').AsFloat <> cdsEtique.FieldByName('VALITE').AsFloat Then
              cdsEtique.FieldByName('VALITE').AsFloat := fltPreVen;
            cdsEtique.FieldByName('ITEPRO').AsString := 'S';
          end
          Else If blnPreProInterna And (qryEtique.FieldByName('PROMOC').AsFloat > 0)Then
          begin
            cdsEtique.FieldByName('VALITE').AsFloat := qryEtique.FieldByName('PROMOC').AsFloat;
            cdsEtique.FieldByName('ITEPRO').AsString := 'S';
          end;

        End;

        {***************************************************}
        {* CALCULO DO VALVIS : VALITE MENOS PCT DE DESCONTO*}
        {************************************************JB*}
        cdsEtique.FieldByName('VALVIS').AsFloat := FieldByName('VALITE').AsFloat -
                                                       ( (fStrToFloat(strPerDes) * FieldByName('VALITE').AsFloat) / 100);

        cdsEtique.FieldByName('CODFAB').AsString := FieldByName('CODFAB').AsString;
        If Assigned(FieldByName('CGCFOR')) Then
          cdsEtique.FieldByName('CGCFOR').AsString := FieldByName('CGCFOR').AsString;

        If Assigned(FieldByName('CATPRO')) Then
          cdsEtique.FieldByName('CATPRO').AsString := FieldByName('CATPRO').AsString;

        If Assigned(FieldByName('QRCODE')) Then
          cdsEtique.FieldByName('QRCODE').AsString := FieldByName('QRCODE').AsString;

        If Assigned(FieldByName('URLIMG')) Then
          cdsEtique.FieldByName('URLIMG').AsString := FieldByName('URLIMG').AsString;

        If Assigned(FieldByName('NUMGAR')) Then
          cdsEtique.FieldByName('NUMGAR').AsString := '';

        If Assigned(FieldByName('DTAENT')) Then
        Begin
          If not SameText(strNomFrm,'frmImpEtiquetas') Then
            cdsEtique.FieldByName('DTAENT').AsString := FieldByName('DTAENT').AsString
          Else
            cdsEtique.FieldByName('DTAENT').AsString := '';
        End;

        If Assigned(FieldByName('OBSER1')) Then
          cdsEtique.FieldByName('OBSER1').AsString := '';

        If Assigned(FieldByName('OBSER2')) Then
          cdsEtique.FieldByName('OBSER2').AsString := '';

        If Assigned(FieldByName('DESPRO')) Then
          cdsEtique.FieldByName('DESPRO').AsString := FieldByName('DESPRO').AsString;
        If Assigned(FieldByName('PROINI')) Then
          cdsEtique.FieldByName('PROINI').AsString := FieldByName('PROINI').AsString;
        If Assigned(FieldByName('PROFIN')) Then
          cdsEtique.FieldByName('PROFIN').AsString := FieldByName('PROFIN').AsString;

        If Assigned(FieldByName('PONEXP')) Then
          cdsEtique.FieldByName('PONEXP').AsFloat := FieldByName('PONEXP').AsFloat;

        If Assigned(FieldByName('CUSPRE')) Then
          cdsEtique.FieldByName('CUSPRE').AsString := FieldByName('CUSPRE').AsString;

        If Assigned(FieldByName('DESUNI')) Then
          cdsEtique.FieldByName('DESUNI').AsString := FieldByName('DESUNI').AsString;

        If Assigned(FieldByName('CODITF')) Then
          cdsEtique.FieldByName('CODITF').AsString := FieldByName('CODITF').AsString;

        If Assigned(FieldByName('BAIRRO')) Then
          cdsEtique.FieldByName('BAIRRO').AsString := FieldByName('BAIRRO').AsString;

        If Assigned(FieldByName('CEPEMP')) Then
          cdsEtique.FieldByName('CEPEMP').AsString := FieldByName('CEPEMP').AsString;

        If Assigned(FieldByName('CIDEMP')) Then
          cdsEtique.FieldByName('CIDEMP').AsString := FieldByName('CIDEMP').AsString;

        If Assigned(FieldByName('EMPNOM')) Then
          cdsEtique.FieldByName('EMPNOM').AsString := FieldByName('EMPNOM').AsString;

        If Assigned(FieldByName('ENDCMP')) Then
          cdsEtique.FieldByName('ENDCMP').AsString := FieldByName('ENDCMP').AsString;

        If Assigned(FieldByName('ENDEMP')) Then
          cdsEtique.FieldByName('ENDEMP').AsString := FieldByName('ENDEMP').AsString;

        If Assigned(FieldByName('ENDNUM')) Then
          cdsEtique.FieldByName('ENDNUM').AsString := FieldByName('ENDNUM').AsString;

        If Assigned(FieldByName('ESTEMP')) Then
          cdsEtique.FieldByName('ESTEMP').AsString := FieldByName('ESTEMP').AsString;

        If Assigned(FieldByName('FANEMP')) Then
          cdsEtique.FieldByName('FANEMP').AsString := FieldByName('FANEMP').AsString;

        If Assigned(FieldByName('IESEMP')) Then
          cdsEtique.FieldByName('IESEMP').AsString := FieldByName('IESEMP').AsString;

        blnLocalizouItebar := False;

        If Assigned(cdsCodBar) And (Not cdsCodBar.IsEmpty) And
           cdsCodBar.Locate('CODITE', FieldByName('CODITE').AsString, []) Then
        Begin
          If cdsCodBar.RecordCount > 0 Then
          Begin
            cdsCodBar.Filter := 'CODITE = ' +FieldByName('CODITE').AsString;
            cdsCodBar.Filtered := True;

            cdsCodBar.First;

            for intCon2 := 1 To intNext Do
              cdsCodBar.Next;

            cdsEtique.FieldByName('CODBAR').AsString := cdsCodBar.FieldByName('CODBAR').AsString;

            If fAchaIteBar(cdsCodBar.FieldByName('CODITE').AsString ,cdsCodBar.FieldByName('CODBAR').AsString) Then
            Begin
              cdsEtique.FieldByName('EMBALA').AsFloat  := qryBarEmb.FieldByName('BAR_EMBALA').AsFloat;
              cdsEtique.FieldByName('EMBPRE').AsFloat  := qryBarEmb.FieldByName('BAR_PREVEN').AsFloat;
              cdsEtique.FieldByName('DESEMB').AsString := qryBarEmb.FieldByName('BAR_DESCRI').AsString;

              blnLocalizouItebar := True;

              If (fCfgSis('PRVEMB') = 'S') And (Not blnPreProInterna) Then
              Begin
                If (fCfgSis('PREEMB') = '1') And ((qryBarEmb.FieldByName('BAR_PREVEN').AsFloat)  > 0) Then
                  cdsEtique.FieldByName('VALITE').AsFloat := qryBarEmb.FieldByName('BAR_PREVEN').AsFloat
                Else
                Begin
                  If (qryBarEmb.FieldByName('BAR_TABPRE').AsString = 'F') Or (qryBarEmb.FieldByName('BAR_TABPRE').AsString = '') Then
                    cdsEtique.FieldByName('VALITE').AsFloat := FieldByName('PREVE1').AsFloat
                  Else
                    cdsEtique.FieldByName('VALITE').AsFloat := FieldByName('PREVE' +(qryBarEmb.FieldByName('BAR_TABPRE').AsString)).AsFloat;
                End;
              End;
            End;

            cdsCodBar.Filter := '';
            cdsCodBar.Filtered := False;

            If cdsEtique.IndexFieldNames.IsEmpty Then
              strIndex := 'CODITE;CODBAR';
          End
          Else
            cdsEtique.FieldByName('CODBAR').AsString := cdsCodBar.FieldByName('CODBAR').AsString;

          If cdsCodBar.RecordCount > 0 Then
          Begin
            cdsCodBar.Filter := 'CODITE = ' +FieldByName('CODITE').AsString;
            cdsCodBar.Filtered := True;

            If (intCon mod (Trunc(FieldByName('QTDETI').AsInteger/cdsCodBar.RecordCount))) = 0 Then
              Inc(intNext);

            cdsCodBar.Filter := '';
            cdsCodBar.Filtered := False;

          End;

          If (Not blnLocalizouItebar) And fAchaIteBar Then
          Begin
            cdsEtique.FieldByName('EMBALA').AsFloat  := qryBarEmb.FieldByName('BAR_EMBALA').AsFloat;
            cdsEtique.FieldByName('EMBPRE').AsFloat  := qryBarEmb.FieldByName('BAR_PREVEN').AsFloat;
            cdsEtique.FieldByName('DESEMB').AsString := qryBarEmb.FieldByName('BAR_DESCRI').AsString;
          End;

        End
        Else
        Begin
          cdsEtique.FieldByName('CODBAR').AsString := FieldByName('CODBAR').AsString;
        End;

        {*************************************************************}
        {* QUANDO USA LOTE EM ARMAZEM, LOCALIZAÇÃO FISICA É DIFERENTE*}
        {**********************************************************RN*}
        If (fCfgSis('CTLEST') = '2') And (Assigned(cdsArmaze)) Then
        Begin
          cdsArmaze.Filtered := False;
          cdsArmaze.Filter := 'CODITE = ' + QuotedStr(FieldByName('CODITE').AsString);
          cdsArmaze.Filtered := True;

          cdsEtique.FieldByName('CODAMZ').AsString := cdsArmaze.FieldByName('CODAMZ').AsString;
          cdsEtique.FieldByName('LOCFIS').AsString := fRetLocFisicaAmz(FieldByName('CODITE').AsString, cdsArmaze.FieldByName('CODAMZ').AsString);
        End
        Else
          cdsEtique.FieldByName('LOCFIS').AsString := FieldByName('LOCFIS').AsString;

        For intIndex := 0 To 9 Do
        Begin
         cdsEtique.FieldByName('QTDEM' + IntToStr(intIndex)).AsFloat :=   FieldByName('QTDEM' + IntToStr(intIndex)).AsFloat;
         cdsEtique.FieldByName('DESCO' + IntToStr(intIndex)).AsFloat :=   FieldByName('DESCO' + IntToStr(intIndex)).AsFloat;
         cdsEtique.FieldByName('TABPR' + IntToStr(intIndex)).AsString :=  FieldByName('TABPR' + IntToStr(intIndex)).AsString;
         cdsEtique.FieldByName('UNITA' + IntToStr(intIndex)).AsString :=  FieldByName('UNITA' + IntToStr(intIndex)).AsString;
        End;
        cdsEtique.FieldByName('DESCOR').AsFloat := FieldByName('DESCOR').AsFloat;
        cdsEtique.FieldByName('EMBFTO').AsFloat := FieldByName('EMBFTO').AsFloat;
        cdsEtique.FieldByName('EMBFUN').AsFloat := FieldByName('EMBFUN').AsFloat;
        cdsEtique.FieldByName('QTDEMR').AsFloat := FieldByName('QTDEMR').AsFloat;
        cdsEtique.FieldByName('EXPEMB').AsString := FieldByName('EXPEMB').AsString;


        cdsEtique.FieldByName('NOMOPE').AsString := FieldByName('NOMOPE').AsString;
        cdsEtique.FieldByName('OPEIMP').AsString := FieldByName('OPEIMP').AsString;


        cdsEtique.FieldByName('NOMOPE').AsString := FieldByName('NOMOPE').AsString;
        cdsEtique.FieldByName('OPEIMP').AsString := FieldByName('OPEIMP').AsString;

        cdsEtique.FieldByName('PRDGRU').AsString := FieldByName('PRDGRU').AsString;
        cdsEtique.FieldByName('DESGRU').AsString := FieldByName('DESGRU').AsString;

        cdsEtique.FieldByName('TAMLCF').AsString := FieldByName('TAMLCF').AsString;
        cdsEtique.FieldByName('TAMLCS').AsString := FieldByName('TAMLCS').AsString;
        cdsEtique.FieldByName('DTAULT').AsString := FieldByName('DTAULT').AsString;

        If Assigned(FieldByName('DOLCOM')) Then
          cdsEtique.FieldByName('DOLCOM').AsString := FieldByName('DOLCOM').AsString;
        If Assigned(FieldByName('DOLVEN')) Then
          cdsEtique.FieldByName('DOLVEN').AsString := FieldByName('DOLVEN').AsString;
        If Assigned(FieldByName('MOEEMP')) Then
          cdsEtique.FieldByName('MOEEMP').AsString := FieldByName('MOEEMP').AsString;
        If Assigned(FieldByName('DTAMOE')) Then
          cdsEtique.FieldByName('DTAMOE').AsString := FieldByName('DTAMOE').AsString;

        If Assigned(FieldByName('NVLGIR')) Then
           cdsEtique.FieldByName('NVLGIR').AsString := FieldByName('NVLGIR').AsString;

        cdsEtique.FieldByName('VALOBR').AsString  := FieldByName('VALOBR').AsString;
        cdsEtique.FieldByName('SEQETI').AsInteger := FieldByName('SEQETI').AsInteger;
        cdsEtique.FieldByName('DESMAX').AsFloat   := FieldByName('DESMAX').AsFloat;
        cdsEtique.FieldByName('DESMVM').AsFloat   := FieldByName('DESMVM').AsFloat;
        cdsEtique.FieldByName('LOCGER').AsString  := FieldByName('LOCGER').AsString;
        cdsEtique.FieldByName('DESFAB').AsString  := FieldByName('DESFAB').AsString;

        If Assigned(FieldByName('LOCADI')) Then
           cdsEtique.FieldByName('LOCADI').AsString := FieldByName('LOCADI').AsString;

        If Assigned(FindField('LFAPRC')) Then
          cdsEtique.FieldByName('LFAPRC').AsString := FieldByName('LFAPRC').AsString;
        If Assigned(FindField('DTAEPI')) Then
          cdsEtique.FieldByName('DTAEPI').AsString := FieldByName('DTAEPI').AsString;

        cdsEtique.Post;
      End;
    End;
  End;

begin
  ListaProcessado := TStringList.Create;

  Try
    blnPreProInterna := False;

    Result := False;

    objDllEtq := prmDllEtq;

    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      If Assigned(cdsCodBar) And (Not cdsCodBar.IsEmpty) Then
      Begin
        qryBarEmb := fCriaQuery;
        qryBarEmb.SQL.Text := fSQLBarEmp;
      End;

      strTipImp := fCfgSis('TIPETI');

      frxReport := TfrxReport.Create(nil);
      frxDatSet := TfrxDBDataSet.Create(nil);
      frxDatSet.Name := 'frxDBImpEti';

      qryEtique := fCriaQuery;
      qryCfgRel := fCriaQuery;
      cdsEtique := fCriaClient;

      If fEmptyStr(strNomFrm) Then
        strNomFrm := 'frmImpEtiquetas';

      pCarregaConfImpr(qryCfgRel, strNomFrm);

      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      pCarregaConfImpr(qryCfgRel, 'frmImpEtiquetas_ITE');
      If Not fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString) Then
      Begin
        strNomFrm := 'frmImpEtiquetas_ITE';
        strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      End;

      efsEdiFas := TEditorFast.Create(nil, frxReport, frxDatSet, tpeTipEtq);
      efsEdiFas.pAbreItens(qryEtique, intTabPre, False, strTabela, strLisReg, intTabPra, intParcel, strValAcr, strValDes, String(strCodEmp), strDtaPro, blnEtiNFe, strTipoAlter, TipoOrigemEtiquetaAbreItens, blnPrePro, strCodIte, strCodCnd, strCndDes, strNumPar,
        blnImpGrp, strLisGrpPre);

      With qryEtique Do
      Begin
        strIndex := '';

        If (IsEmpty) Then
        Begin
          Close;
          If not blnImpAut Then
            fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um Item', ['&Ok']);
          pLiberaRecursos;
          Exit;
        End
        Else
        Begin
          While Not Eof Do
          Begin
            intNext := 0;

            If strNomFrm = 'frmImpEtiqNotaEntradaItens' Then
            Begin
              If Not fProcessado(qryEtique.FieldByName('CODITE').AsString) Then
              Begin
                objDllEtq.dtsImpres.Filtered := False;
                objDllEtq.dtsImpres.Filter := 'CODITE = ' + QuotedStr(qryEtique.FieldByName('CODITE').AsString);
                objDllEtq.dtsImpres.Filtered := True;
                While not objDllEtq.dtsImpres.Eof Do
                Begin
                  pGrava(objDllEtq.dtsImpres.FieldByName('QTDITE').asInteger);
                  objDllEtq.dtsImpres.Next;
                End;
              End;
            End
            Else
             begin
              If qryEtique.FieldByName('QTDETI').asInteger = 0 Then
                pGrava(1)
              Else
                pGrava(qryEtique.FieldByName('QTDETI').asInteger);
              pAtualizaDtaHorImp(qryEtique.FieldByName('CODITE').AsString, qryEtique.FieldByName('NOMEMP').AsString);
            end;
            Next;

          End;

        End;

        if not fEmptyStr(strIndex) then
          cdsEtique.IndexFieldNames := strIndex
        else if not fEmptyStr(objDllEtq.strIdxFld) then
        begin

          strIndex := string(copy(objDllEtq.strIdxFld, length(objDllEtq.strIdxFld) - 5, length(objDllEtq.strIdxFld)));

          with cdsEtique.IndexDefs.AddIndexDef do
          begin
            Name := strIndex;
            Fields := strIndex;
            if blnSoDesc then
              Options := [ixDescending];
          end;

          cdsEtique.IndexName := strIndex;

        end;

        if fEmptyStr(objDllEtq.strIdxFld) and (blnEtiNFe) then
        begin
          cdsEtique.IndexDefs.Clear;
          cdsEtique.IndexFieldNames := '';
        end;
        If not blnImpAut Then
        Begin
          if fCfgSis('DEFORD', varBoolean) then
          begin

            SetLength(ArrOrdEti, 0);
            pAddDados(ArrOrdEti, 'Ordem de Inclusão');
            pAddDados(ArrOrdEti, 'Descrição do Produto');
            pAddDados(ArrOrdEti, 'Código do Produto');

            intOpcOrd := fGetMenu('Deseja ordenar por :', ArrOrdEti, 1);

            Case intOpcOrd Of
              1 : cdsEtique.IndexFieldNames := 'SEQETI';
              2 : cdsEtique.IndexFieldNames := 'DESITE';
              3 : cdsEtique.IndexFieldNames := 'CODITE';
            End;
          End; 


        end;

        cdsEtique.Open;

        frxDatSet.DataSet := cdsEtique;
      End;

      If efsEdiFas.fLeEtiqueta Then
      Begin
        If efsEdiFas.fTemParametro('INFADI') Then
          frxReport.Script.Variables['INFADI'] := fInformacaoAdicionalEtiquetaItens;

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := strNomImp;
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If frxReport.PrepareReport Then
        Begin
          If fEmptyStr(strNomImp) Then
            pPreviewReport(strNomFrm, tpeTipEtq.GetName(), frxReport)
          Else
            pPrintReport(strNomFrm, tpeTipEtq.GetName(), strNomImp, frxReport);

          Result := True;
        End;
      End;

      If Assigned(cdsCodBar) And (Not cdsCodBar.IsEmpty) Then
        FreeAndNil(qryBarEmb);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaItens]');
    End;
  End;

  pLiberaRecursos;
  FreeAndNil(ListaProcessado);

end;

function fImprimeEtiquetaItensOrcPed(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    efsEdiFas: TEditorFast;
    qryCfgRel: TUniQuery;
    qryEtique: TUniQuery;
    cdsEtique: TUniClientDataSet;
    arrEtique: Array Of Variant;
    strNomImp: String;
    intOpcFormato: Integer;
    intQtd  : Integer;
    intCont : Integer;
    strAutIcr: String;
    strDelimt: String;
    strFiltro: String;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      if fEmptyStr(strTipImp) then
        strTipImp := fCfgSis('TIPETI');

      frxReport := TfrxReport.Create(nil);
      frxDatSet := TfrxDBDataSet.Create(nil);
      frxDatSet.Name := 'frxDBImpEti';

      qryCfgRel := fCriaQuery(nil);
      qryEtique := fCriaQuery(nil);

      pCarregaConfImpr(qryCfgRel, 'frmImpEtiquetas');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      {*******************************************}
      {* SE FOR LASER COMUM                      *}
      {*************************************MV,JB*}
      If (strTipImp = 'L') Then
      Begin

        If (fCfgSis('ETIBAR', varBoolean)) Then
          tpeTipEtq := tpeItensOrcPedLaserCodBar
        Else
          tpeTipEtq := tpeItensOrcPedLaser;

      End

      {*******************************************}
      {* SE FOR ZEBRA / ARGOX                    *}
      {****************************************MV*}
      Else
      Begin

        intOpcFormato := fGetMenu('Escolha o Formato:', ['Gondola Com Preço', 'Cód. Barra Com Preço', 'Cód. Barra Sem Preço', 'Gondola Sem Preço'], 1);

        {*******************************************}
        {* SE FOR ZEBRA                            *}
        {****************************************MV*}
        If (strTipImp = 'Z') Then
        Begin
          Case intOpcFormato Of
            1: tpeTipEtq := tpeItensOrcPedZebraGondolaCPre;
            2: tpeTipEtq := tpeItensOrcPedZebraCodBarCPre;
            3: tpeTipEtq := tpeItensOrcPedZebraCodBarSPre;
            4: tpeTipEtq := tpeItensOrcPedZebraGondolaSPre;
          End;
        End

        {*******************************************}
        {* SE FOR ARGOX                            *}
        {****************************************MV*}
        Else If (strTipImp = 'A') Then
        Begin
          Case intOpcFormato Of
            1: tpeTipEtq := tpeItensOrcPedArgoxGondolaCPre;
            2: tpeTipEtq := tpeItensOrcPedArgoxCodBarCPre;
            3: tpeTipEtq := tpeItensOrcPedArgoxCodBarSPre;
            4: tpeTipEtq := tpeItensOrcPedArgoxGondolaSPre;
          End;
        End;

      End;

      {**************************************************************}
      {* PESQUISA OS ITENS SELECIONADOS PARA IMPRIMIR AS ETIQUETAS  *}
      {***********************************************************MA*}
      strAutIcr := '';
      strDelimt := '';
      cdsPromoc.Filtered := False;
      cdsPromoc.Filter   := 'IMPRME = ' + QuotedStr('S');
      cdsPromoc.Filtered := True;
      cdsPromoc.First;
      While not cdsPromoc.Eof Do
      Begin
        strAutIcr := strAutIcr + strDelimt + QuotedStr(cdsPromoc.FieldByName('AUTOINCREM').AsString);
        strDelimt := ',';
        cdsPromoc.Next;
      End;

      efsEdiFas := TEditorFast.Create(nil, frxReport, frxDatSet, tpeTipEtq);
      efsEdiFas.pAbreItensOrcPed(qryEtique, False, String(strNumDoc), String(strEspDoc), String(strCodEmp), String(strAutIcr), strIdxFld);

      pSetaClient(qryEtique);
      qryEtique.Open;
      cdsEtique := fCriaClientDatset(qryEtique);

      cdsPromoc.First;
      While not cdsPromoc.Eof Do
      Begin
       {*********************************************************}
       {* CLONANDO AS LINHAS CONFORME A QUANTIDADE DE ETIQUETAS *}
       {******************************************************AN*}
        strFiltro := 'AUTOINCREM = ' + QuotedStr(cdsPromoc.FieldByName('AUTOINCREM').AsString);
        If Not SameText(cdsEtique.Filter, strFiltro) Then
        Begin
          cdsEtique.Filtered := False;
          cdsEtique.Filter := strFiltro;
          cdsEtique.Filtered := True;
        End;
        intQtd := Ceil(cdsPromoc.FieldByName('QTDIMP').AsFloat);
        SetLength(arrEtique, 0);
        While Not (cdsEtique.RecordCount = intQtd) Do
        Begin
          For intCont := 0 To cdsEtique.Fields.Count -1 Do
          Begin
            SetLength(arrEtique, Length(arrEtique) +1);
            arrEtique[intCont] := cdsEtique.Fields[intCont].Value;
          End;
          cdsEtique.Append;
          For intCont := 0 To cdsEtique.Fields.Count -1 Do
            cdsEtique.Fields[intCont].Value := arrEtique[intCont];
          cdsEtique.Post;
          SetLength(arrEtique, 0);
          Application.ProcessMessages;
        End;
        cdsPromoc.Next;
      End;
      cdsEtique.Filtered := False;

      If fEmptyStr(strIdxFld) Then
         cdsEtique.IndexFieldNames := 'DESITE'
      Else If cdsEtique.FindField(strIdxFld) <> Nil Then
         cdsEtique.IndexFieldNames := strIdxFld;

      frxDatSet.DataSet := cdsEtique;

      If efsEdiFas.fLeEtiqueta Then
      Begin
        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := strNomImp;
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If frxReport.PrepareReport Then
        Begin
          pPreviewReport(strNomFrm, tpeTipEtq.GetName(), frxReport);
          Result := True;
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaItensOrcPed]');
    End;
  End;

  FreeAndNil(efsEdiFas);
  FreeAndNil(qryCfgRel);
  FreeAndNil(qryEtique);
  FreeAndNil(cdsEtique);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  pLiberaModulos;
end;

function fImprimeEtiquetaDespacho(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    qryEtique: TUniQuery;
    cdsEtique: TZClient;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
    blnPadrao: Boolean;
    frxPDFExport: TfrxPDFExport;
    intIndice : Integer;

  function fCriaClientDespacho(strNomTab, strTipoFC: String): TZClient;
  Begin
    Result := TZClient.Create(Nil, fSQLDespacho(False, strNomTab, strTipoFC, '', '', True));
    Result.fAbreClient(True, 'fCriaClientDespacho');
  End;

  function fGetCodigoBarrasVolume(qryEtique: TUniQuery; strEspDoc: String; intContador: Integer; intQtdVol: Integer): String;
    Var
      strNumDoc: String;
  begin
    With qryEtique Do
    Begin
      strNumDoc := LeftStr(FieldByName('NUMDOC').AsString, 15);

      If fEmptyStr(strNumDoc) Then
        strNumDoc := FieldByName('PEDVEN').AsString;

      If (Not fEmptyStr(RightStr(strNumDoc, 2))) And
         (Not fIsNumber(RightStr(strNumDoc, 2))) Then
      Begin
        strEspDoc := RightStr(strNumDoc, 2);
      End;

      Result := LeftStr(strNumDoc, fTamDocCadRec()) +
                fRetCodigoEspecieBarraRomaneio(strEspDoc) +
                FieldByName('CODEMP').AsString +
                fStrZero(intContador, 3) + fStrZero(intQtdVol, 3);
    End;
  end;

  function fRetTotVolumes(strNumDoc, strEspDoc, strCodEmp, strMultPed: String): Integer;
  var
    qryEtiquetas,
    qryItens: TUniQuery;
    strTabela,
    strPrefixo: String;
    intTotVolumeComExpedicao,
    intTotVolumeSemExpedicao: Integer;

  begin

    qryEtiquetas := fCriaQuery;
    qryItens := fCriaQuery;

    intTotVolumeSemExpedicao := 0;
    intTotVolumeComExpedicao := 0;

    try
      If strEspDoc = 'PD' Then
      Begin
        strTabela := 'FATDOR';
        strPrefixo := 'FDO_';
      End
      Else
      Begin
        strTabela := 'MOVDET';
        strPrefixo := 'DET_';
      End;

      qryEtiquetas.Close;
      qryEtiquetas.SQL.Clear;
      qryEtiquetas.SQL.Add('SELECT EVC_VOLUME');
      qryEtiquetas.SQL.Add('FROM '+strTabela+'');
      qryEtiquetas.SQL.Add('INNER JOIN CADITE');
      qryEtiquetas.SQL.Add('ON('+strPrefixo+'CODITE = ITE_CODITE)');
      qryEtiquetas.SQL.Add('INNER JOIN ETIVOL');

      If strEspDoc = 'PD' Then
        qryEtiquetas.SQL.Add('ON(FATDOR.FDO_NUMDOC = ETIVOL.VOL_NUMPED AND FATDOR.FDO_ESPDOC = ETIVOL.VOL_ESPPED AND FATDOR.FDO_CODEMP = ETIVOL.VOL_EMPPED)')
      Else
        qryEtiquetas.SQL.Add('ON(MOVDET.DET_NUM_PD = ETIVOL.VOL_NUMPED AND MOVDET.DET_ESP_PD = ETIVOL.VOL_ESPPED AND MOVDET.DET_EMP_PD = ETIVOL.VOL_EMPPED)');

      qryEtiquetas.SQL.Add('INNER JOIN ETIEVC');
      qryEtiquetas.SQL.Add('ON(ETIVOL.VOL_CODIGO = ETIEVC.EVC_CODIGO)');

      if fEmptyStr(strMultPed) then
        qryEtiquetas.SQL.Add('WHERE '+strPrefixo+'NUMDOC = :NUMDOC')
      else
        qryEtiquetas.SQL.Add('WHERE '+strPrefixo+'NUMDOC IN ('+strMultPed+')');

      qryEtiquetas.SQL.Add('AND '+strPrefixo+'ESPDOC = :ESPDOC');
      qryEtiquetas.SQL.Add('AND '+strPrefixo+'CODEMP = :CODEMP');
      qryEtiquetas.SQL.Add('GROUP BY EVC_SIGLA_');


      if fEmptyStr(strMultPed) then
        qryEtiquetas.ParamByName('NUMDOC').AsString := strNumDoc;

      qryEtiquetas.ParamByName('ESPDOC').AsString := strEspDoc;
      qryEtiquetas.ParamByName('CODEMP').AsString := strCodEmp;

      qryEtiquetas.Open;

      while not qryEtiquetas.Eof do
      begin
        intTotVolumeComExpedicao := intTotVolumeComExpedicao + qryEtiquetas.FieldByName('EVC_VOLUME').AsInteger;
        qryEtiquetas.Next;
      end;

      qryItens.Close;
      qryItens.SQL.Clear;
      qryItens.SQL.Add('SELECT '+strPrefixo+'QTDITE');
      qryItens.SQL.Add('FROM '+strTabela+'');
      qryItens.SQL.Add('INNER JOIN CADITE');
      qryItens.SQL.Add('ON('+strPrefixo+'CODITE = ITE_CODITE)');
      qryItens.SQL.Add('INNER JOIN ETIVOL');

      If strEspDoc = 'PD' Then
        qryItens.SQL.Add('ON(FATDOR.FDO_NUMDOC = ETIVOL.VOL_NUMPED AND FATDOR.FDO_ESPDOC = ETIVOL.VOL_ESPPED AND FATDOR.FDO_CODEMP = ETIVOL.VOL_EMPPED)')
      Else
        qryItens.SQL.Add('ON(MOVDET.DET_NUM_PD = ETIVOL.VOL_NUMPED AND MOVDET.DET_ESP_PD = ETIVOL.VOL_ESPPED AND MOVDET.DET_EMP_PD = ETIVOL.VOL_EMPPED)');

      if fEmptyStr(strMultPed) then
        qryItens.SQL.Add('WHERE '+strPrefixo+'NUMDOC = :NUMDOC')
      else
        qryItens.SQL.Add('WHERE '+strPrefixo+'NUMDOC IN ('+strMultPed+')');

      qryItens.SQL.Add('AND '+strPrefixo+'ESPDOC = :ESPDOC');
      qryItens.SQL.Add('AND '+strPrefixo+'CODEMP = :CODEMP');
      qryItens.SQL.Add('AND ITE_NECEXP = "S"');

      if fEmptyStr(strMultPed) then
        qryItens.ParamByName('NUMDOC').AsString := strNumDoc;

      qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
      qryItens.ParamByName('CODEMP').AsString := strCodEmp;

      qryItens.Open;

      while not qryItens.Eof do
      begin
        intTotVolumeSemExpedicao := intTotVolumeSemExpedicao + Trunc(qryItens.FieldByName(strPrefixo+'QTDITE').AsFloat);
        qryItens.Next;
      end;

      result := (intTotVolumeComExpedicao + intTotVolumeSemExpedicao);

    finally
      FreeAndNil(qryEtiquetas);
      FreeAndNil(qryItens);
    end;

  end;

  procedure pCriaListaEtiqueta(var intTotVolume: Integer; var lstEtiquetas: TStringList; strNumDoc, strEspDoc, strCodEmp, strMultPed: String);
    var
      qryEtiquetas: TUniQuery;
      strTabela: String;
      strPrefixo: String;
  begin
    qryEtiquetas := fCriaQuery;

    try
      If strEspDoc = 'PD' Then
      Begin
        strTabela := 'FATDOR';
        strPrefixo := 'FDO_';
      End
      Else
      Begin
        strTabela := 'MOVDET';
        strPrefixo := 'DET_';
      End;

      qryEtiquetas.Close;
      qryEtiquetas.SQL.Clear;
      qryEtiquetas.SQL.Add('SELECT EVC_DESCRI, EVC_VOLUME');
      qryEtiquetas.SQL.Add('FROM '+strTabela+'');
      qryEtiquetas.SQL.Add('INNER JOIN CADITE');
      qryEtiquetas.SQL.Add('ON('+strPrefixo+'CODITE = ITE_CODITE)');
      qryEtiquetas.SQL.Add('INNER JOIN ETIVOL');

      If strEspDoc = 'PD' Then
        qryEtiquetas.SQL.Add('ON(FATDOR.FDO_NUMDOC = ETIVOL.VOL_NUMPED AND FATDOR.FDO_ESPDOC = ETIVOL.VOL_ESPPED AND FATDOR.FDO_CODEMP = ETIVOL.VOL_EMPPED)')
      Else
        qryEtiquetas.SQL.Add('ON(MOVDET.DET_NUM_PD = ETIVOL.VOL_NUMPED AND MOVDET.DET_ESP_PD = ETIVOL.VOL_ESPPED AND MOVDET.DET_EMP_PD = ETIVOL.VOL_EMPPED)');

      qryEtiquetas.SQL.Add('INNER JOIN ETIEVC');
      qryEtiquetas.SQL.Add('ON(ETIVOL.VOL_CODIGO = ETIEVC.EVC_CODIGO)');

      if fEmptyStr(strMultPed) then
        qryEtiquetas.SQL.Add('WHERE '+strPrefixo+'NUMDOC = :NUMDOC')
      else
        qryEtiquetas.SQL.Add('WHERE '+strPrefixo+'NUMDOC IN ('+strMultPed+')');

      qryEtiquetas.SQL.Add('AND '+strPrefixo+'ESPDOC = :ESPDOC');
      qryEtiquetas.SQL.Add('AND '+strPrefixo+'CODEMP = :CODEMP');
      qryEtiquetas.SQL.Add('GROUP BY EVC_SIGLA_');
      qryEtiquetas.SQL.Add('ORDER BY EVC_DESCRI');

      if fEmptyStr(strMultPed) then
        qryEtiquetas.ParamByName('NUMDOC').AsString := strNumDoc;

      qryEtiquetas.ParamByName('ESPDOC').AsString := strEspDoc;
      qryEtiquetas.ParamByName('CODEMP').AsString := strCodEmp;

      qryEtiquetas.Open;

      if qryEtiquetas.IsEmpty then
        Exit;

      while not qryEtiquetas.Eof do
      begin
        lstEtiquetas.Add(fstrEspaco(Copy(qryEtiquetas.FieldByName('EVC_DESCRI').AsString, 1, 20), 25) + fStrZero(qryEtiquetas.FieldByName('EVC_VOLUME').AsInteger, 3));
        intTotVolume := intTotVolume + qryEtiquetas.FieldByName('EVC_VOLUME').AsInteger;

        qryEtiquetas.Next;
      end;
    finally
      FreeAndNil(qryEtiquetas);
    end;
  end;

  procedure pCriaListaItens(var intTotVolume: Integer; var lstItens: TStringList; strNumDoc, strEspDoc, strCodEmp, strMultPed: String);
    var
      qryItens: TUniQuery;
      strTabela: String;
      strPrefixo: String;
  begin
    qryItens := fCriaQuery;

    try
      If strEspDoc = 'PD' Then
      Begin
        strTabela := 'FATDOR';
        strPrefixo := 'FDO_';
      End
      Else
      Begin
        strTabela := 'MOVDET';
        strPrefixo := 'DET_';
      End;

      qryItens.Close;
      qryItens.SQL.Clear;
      qryItens.SQL.Add('SELECT '+strPrefixo+'DESCRI, '+strPrefixo+'QTDITE');
      qryItens.SQL.Add('FROM '+strTabela+'');
      qryItens.SQL.Add('INNER JOIN CADITE');
      qryItens.SQL.Add('ON('+strPrefixo+'CODITE = ITE_CODITE)');
      qryItens.SQL.Add('INNER JOIN ETIVOL');

      If strEspDoc = 'PD' Then
        qryItens.SQL.Add('ON(FATDOR.FDO_NUMDOC = ETIVOL.VOL_NUMPED AND FATDOR.FDO_ESPDOC = ETIVOL.VOL_ESPPED AND FATDOR.FDO_CODEMP = ETIVOL.VOL_EMPPED)')
      Else
        qryItens.SQL.Add('ON(MOVDET.DET_NUM_PD = ETIVOL.VOL_NUMPED AND MOVDET.DET_ESP_PD = ETIVOL.VOL_ESPPED AND MOVDET.DET_EMP_PD = ETIVOL.VOL_EMPPED)');

      if fEmptyStr(strMultPed) then
        qryItens.SQL.Add('WHERE '+strPrefixo+'NUMDOC = :NUMDOC')
      else
        qryItens.SQL.Add('WHERE '+strPrefixo+'NUMDOC IN ('+strMultPed+')');

      qryItens.SQL.Add('AND '+strPrefixo+'ESPDOC = :ESPDOC');
      qryItens.SQL.Add('AND '+strPrefixo+'CODEMP = :CODEMP');
      qryItens.SQL.Add('AND ITE_NECEXP = "S"');

      if fEmptyStr(strMultPed) then
        qryItens.ParamByName('NUMDOC').AsString := strNumDoc;

      qryItens.ParamByName('ESPDOC').AsString := strEspDoc;
      qryItens.ParamByName('CODEMP').AsString := strCodEmp;

      qryItens.Open;

      if qryItens.IsEmpty then
        Exit;

      while not qryItens.Eof do
      begin
        lstItens.Add(fstrEspaco(Copy(qryItens.FieldByName(strPrefixo+'DESCRI').AsString, 1, 40), 45) + fStrZero(Trunc(qryItens.FieldByName(strPrefixo+'QTDITE').AsFloat), 3));
        intTotVolume := intTotVolume + Trunc(qryItens.FieldByName(strPrefixo+'QTDITE').AsFloat);

        qryItens.Next;
      end;
    finally
      FreeAndNil(qryItens);
    end;
  end;

  procedure pProcessaClientDataSet(qryEtique: TUniQuery; cdsEtique: TZClient; intQtdVol: Integer; strEspDoc: String; blnTodosRegistros : Boolean = False; blnEtiquetaDespachoVolumeIndividual: Boolean = False;
                                   strNumDoc: String = ''; strCodEmp: String = ''; strMultPed: String = ''; cdsDespachoAmbiente: TUniClientDataSet = nil );
   Var
      intContador,
      intCampos,
      intTotVolume,
      intAmbien: Integer;
  begin
    intTotVolume := 0;

    if not Assigned(cdsDespachoAmbiente) then
      intTotVolume := fRetTotVolumes(strNumDoc, strEspDoc, strCodEmp, strMultPed);

    With qryEtique Do
    Begin

      While Not Eof Do
      Begin
        if blnEtiquetaDespachoVolumeIndividual then
          intQtdVol := qryEtique.FieldByName('EVCVOL').AsInteger;

        For intContador := 1 To intQtdVol Do
        Begin
          if intContador < objDllEtq.intEtqInicial then
            Continue;

          cdsEtique.Append;

          For intCampos := 0 To qryEtique.FieldCount - 1 Do
            cdsEtique.Fields[intCampos].Value := qryEtique.Fields[intCampos].Value;

          cdsEtique.FieldByName('SEQVOL').AsInteger := intContador;
          cdsEtique.FieldByName('QTDVOL').AsString := IntToStr(intContador) + '/' + IntToStr(intQtdVol) + IIF(objDllEtq.blnSepExclusiva, ' SEP. EXCLUSIVA', '');
          cdsEtique.FieldByName('CODBAR').AsString := fGetCodigoBarrasVolume(qryEtique, strEspDoc, intContador, intQtdVol);
          cdsEtique.FieldByName('QTDVO2').AsString := fStrZero(intQtdVol * RecNo, 3) + '/' + fStrZero(intQtdVol * RecordCount, 3);
          if not Assigned(cdsDespachoAmbiente) then
            cdsEtique.FieldByName('TOTVOL').AsString := fStrZero(intTotVolume, 3);

          cdsEtique.Post;

          Application.ProcessMessages;
        End;

        If Not blnTodosRegistros Then
          Last;

        Next;
      End;

      if Assigned(cdsDespachoAmbiente) then
      begin
        cdsDespachoAmbiente.First;
        cdsEtique.First;
        while not cdsDespachoAmbiente.Eof do
        begin
          for intAmbien := 1 to cdsDespachoAmbiente.FieldByName('VOLUME').asInteger do
          begin
            cdsEtique.Edit;
            cdsEtique.FieldByName('SEQVOL').AsString := fStrZero(intAmbien, 3);
            cdsEtique.FieldByName('TOTVOL').AsString := fStrZero(cdsDespachoAmbiente.FieldByName('VOLUME').asInteger, 3);
            cdsEtique.Next;
          end;
          cdsDespachoAmbiente.Next;
        end;

      end;

    End;
  end;

  procedure pProcessaClientDataSetEtiquetaVolumeGeral(qryEtique: TUniQuery; cdsEtique: TZClient; strEspDoc, strMultPed: String);
   Var
     intQtdItePorEtiqueta,
     intQtdEtiquetas,
     intQtdItens,
     intTotEtiquetas,
     intContadorEtiquetas,
     intPosicaoEtiqueta,
     intContadorItens,
     intPosicaoItens,
     intTotVolume,
     intContador,
     intCampos: Integer;

     lstEtiquetas,
     lstItens: TStringList;

     strEtiquetas,
     strItens: String;
  begin
    lstEtiquetas := TStringList.Create;
    lstItens := TStringList.Create;

    try
      intQtdItePorEtiqueta := fCfgSis('QTDEVC', varInteger);
      intPosicaoEtiqueta := 0;
      intPosicaoItens := 0;

      With qryEtique Do
      Begin
        While Not Eof Do
        Begin
          intTotVolume := 0;
          pCriaListaEtiqueta(intTotVolume, lstEtiquetas, qryEtique.FieldByName('NUMDOCXML').AsString, strEspDoc, qryEtique.FieldByName('CODEMP').AsString, strMultPed);
          pCriaListaItens(intTotVolume, lstItens, qryEtique.FieldByName('NUMDOCXML').AsString, strEspDoc, qryEtique.FieldByName('CODEMP').AsString, strMultPed);

          if lstEtiquetas.Count <= intQtdItePorEtiqueta then
          begin
            intQtdEtiquetas := 1;
          end
          else
          begin
            intQtdEtiquetas := (lstEtiquetas.Count div intQtdItePorEtiqueta);

            if (lstEtiquetas.Count mod intQtdItePorEtiqueta) > 0 then
              Inc(intQtdEtiquetas);
          end;

          if lstItens.Count <= intQtdItePorEtiqueta then
          begin
            intQtdItens := 1;
          end
          else
          begin
            intQtdItens := (lstItens.Count div intQtdItePorEtiqueta);

            if (lstItens.Count mod intQtdItePorEtiqueta) > 0 then
              Inc(intQtdItens);
          end;

          intTotEtiquetas := Max(intQtdEtiquetas, intQtdItens);


          For intContador := 1 To intTotEtiquetas Do
          Begin
            strEtiquetas := EmptyStr;
            strItens := EmptyStr;

            if intContador < objDllEtq.intEtqInicial then
              Continue;

            cdsEtique.Append;

            For intCampos := 0 To qryEtique.FieldCount - 1 Do
              cdsEtique.Fields[intCampos].Value := qryEtique.Fields[intCampos].Value;

            cdsEtique.FieldByName('SEQVOL').AsInteger := 1;
            cdsEtique.FieldByName('QTDVOL').AsString := '001/001';
            cdsEtique.FieldByName('CODBAR').AsString := fGetCodigoBarrasVolume(qryEtique, strEspDoc, 1, 1);
            cdsEtique.FieldByName('QTDVO2').AsString := '001/001';

            intContadorEtiquetas := 1;
            while intContadorEtiquetas <= intQtdItePorEtiqueta do
            begin
              Inc(intContadorEtiquetas);

              if intPosicaoEtiqueta >= lstEtiquetas.Count then
                Break;

              if not fEmptyStr(strEtiquetas) then
                strEtiquetas := strEtiquetas + sLineBreak;

              strEtiquetas := strEtiquetas + lstEtiquetas[intPosicaoEtiqueta];
              Inc(intPosicaoEtiqueta);
            end;

            intContadorItens := 1;
            while intContadorItens <= intQtdItePorEtiqueta do
            begin
              Inc(intContadorItens);

              if intPosicaoItens >= lstItens.Count then
                Break;

              if not fEmptyStr(strItens) then
                strItens := strItens + sLineBreak;

              strItens := strItens + lstItens[intPosicaoItens];
              Inc(intPosicaoItens);
            end;

            cdsEtique.FieldByName('ETIVOL').AsString := strEtiquetas;
            cdsEtique.FieldByName('ETIITE').AsString := strItens;
            cdsEtique.FieldByName('TOTVOL').AsString := fStrZero(intTotVolume, 3);

            cdsEtique.Post;

            Application.ProcessMessages;
          End;

          Next;
        End;
      End;
    finally
      FreeAndNil(lstEtiquetas);
      FreeAndNil(lstItens);
    end;
  end;

begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      qryEtique := fCriaQuery;
      frxReport := TfrxReport.Create(nil);
      frxDatSet := TfrxDBDataset.Create(nil);
      frxDatSet.Name := 'frxDBImpEti';

      if not(blnImpAut) then
      begin
        If blnSepExclusiva Then
        Begin
          pCarregaConfImpr(qryCfgRel, 'frmImpEtiDespacho_SEP_EXC');

          If fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString) Then
            pCarregaConfImpr(qryCfgRel, 'frmImpEtiDespacho');
        End
        Else
          pCarregaConfImpr(qryCfgRel, 'frmImpEtiDespacho');
      end
      else
      begin
        If Not fEmptyStr(strNomFil) Then
          strNomImp := strNomFil
        else
          strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      end;

      if (not blnPDF_Gerar) and (not blnImpAut) then
        fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, 'I', False, strUltimaFilaUtilizada);

      efsEdiFas := TEditorFast.Create(nil, frxReport, frxDatSet, tpeTipEtq);

      cdsEtique := fCriaClientDespacho(String(strNomTab), String(strTipoFC));

      efsEdiFas.pAbreDespacho(qryEtique, False, String(strNomTab), String(strTipoFC), String(strNumDoc), String(strEspDoc), False, String(strCodEmp), false, strCodCli);

      If (blnB2W) Then
      Begin
        efsEdiFas.pAbreDespacho(qryEtique, False, String(strNomTab), String(strTipoFC), String(strNumDoc), String(strEspDoc), False, String(strCodEmp), blnB2W, strCodCli, strMultPed);
        blnPadrao := False;
        pProcessaClientDataSet(qryEtique, cdsEtique, 1, String(strEspDoc), True);
      End
      Else
      Begin

        If fEmptyStr(strLayDoc) Then
        Begin
          efsEdiFas.pAbreDespacho(qryEtique, False, String(strNomTab), String(strTipoFC), String(strNumDoc), String(strEspDoc), False, String(strCodEmp), false, strCodCli, strMultPed);
          blnPadrao := True;

          if (tpeTipEtq = tpeEtiquetaDespachoVolumeIndividualArgox) or (tpeTipEtq = tpeEtiquetaDespachoVolumeIndividualLaser) then
            pProcessaClientDataSet(qryEtique, cdsEtique, 1, String(strEspDoc), True, True, String(strNumDoc), String(strCodEmp), strMultPed)
          else if (tpeTipEtq = tpeEtiquetaDespachoVolumeGeralArgox) or (tpeTipEtq = tpeEtiquetaDespachoVolumeGeralLaser) then
            pProcessaClientDataSetEtiquetaVolumeGeral(qryEtique, cdsEtique, String(strEspDoc), strMultPed)
          else
            pProcessaClientDataSet(qryEtique, cdsEtique, objDllEtq.intQtdVol, String(strEspDoc), False, False, '', '', '', objDllEtq.cdsDespachoPorAmbiente);
        End
        Else if objDllEtq.blnImpAut then
        Begin
          if objDllEtq.intQtdVol = 0 then
            objDllEtq.intQtdVol := 1;

          efsEdiFas.pAbreDespacho(qryEtique, False, String(strNomTab), String(strTipoFC), String(strNumDoc), String(strEspDoc), True, String(strCodEmp), false, strCodCli, strMultPed);
          blnPadrao := strLayDoc.IsEmpty;
          pProcessaClientDataSet(qryEtique, cdsEtique, objDllEtq.intQtdVol, String(strEspDoc), True);
        End
        Else
        Begin
          efsEdiFas.pAbreDespacho(qryEtique, False, String(strNomTab), String(strTipoFC), String(strNumDoc), String(strEspDoc), True, String(strCodEmp), false, strCodCli, strMultPed);
          blnPadrao := False;
          pProcessaClientDataSet(qryEtique, cdsEtique, 1, String(strEspDoc), True);
        End;

      End;

      frxDatSet.DataSet := cdsEtique;

      If efsEdiFas.fLeEtiqueta(blnPadrao, strLayDoc) Then
      Begin
        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := strNomImp;
          frxReport.PrintOptions.ShowDialog := False;
        End;

        {Ajuste devido a BUG do FAST REPORT:
         Ao exportar um relatório em PDF estava aplicando os frames nos TfrxMemoView,
         mesmo com o Width do mesmo zerado, em Show Report o problema não ocorre,
         porém limpando o .Typ foi solucionado.
         Precisa ser executado antes do PrepareReport!
        }
        If (blnPDF_Gerar) Then
          For intIndice := 0 To frxReport.ComponentCount -1 Do
            If (frxReport.Components[intIndice] Is TfrxMemoView) Then
              If (TfrxMemoView(frxReport.Components[intIndice]).Frame.Width = 0) Then
                TfrxMemoView(frxReport.Components[intIndice]).Frame.Typ := [];

        If frxReport.PrepareReport Then
        Begin

          {PDF}
          If (blnPDF_Gerar) Then
          Begin

            frxPDFExport := TfrxPDFExport.Create(nil);

            Try

              frxPDFExport.Subject       := 'Exportando Etiquetas para PDF';
              frxPDFExport.ShowProgress  := False;

              frxPDFExport.FileName   := strPDF_Diretorio;
              frxPDFExport.ShowDialog := False;

              frxReport.PrintOptions.ShowDialog := False;
              frxReport.Export(frxPDFExport);

              If (blnPDF_Apresentar) Then
                pPreviewReport('frmImpEtiDespacho', tpeTipEtq.GetName(), frxReport);

            Finally
              frxPDFExport.Free;
            End;

          End
          Else
          Begin

            If blnImpEti or blnImpAut Then
              pPrintReport('frmImpEtiDespacho', tpeTipEtq.GetName(), strNomImp, frxReport)
            Else
              pPreviewReport('frmImpEtiDespacho', tpeTipEtq.GetName(), frxReport);

          End;

          Result := True;

          strUltimaFilaUtilizada := strNomImp;
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaDespacho]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(qryEtique);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  FreeAndNil(cdsEtique);
  pLiberaModulos;
end;

function fImprimeEtiquetaDespachoProduto(prmDllEtq: Pointer): Boolean;
  Var
    objDllEti: TParamDllEtiquetas;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataSet;
    qryCfgRel: TUniQuery;
    qryEtique: TUniQuery;
    dspEtique: TUniDataSetProvider;
    cdsEtique: TUniClientDataSet;
    strNomImp: String;
begin
  Try
    Result := False;

    objDllEti := prmDllEtq;
    With objDllEti Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      frxReport := TfrxReport.Create(nil);
      frxDatSet := TfrxDBDataset.Create(nil);
      frxDatSet.Name := 'frxDBImpEti';

      qryCfgRel := fCriaQuery;
      qryEtique := fCriaQuery;
      dspEtique := TUniDataSetProvider.Create(nil);
      cdsEtique := TUniClientDataSet.Create(nil);
      dspEtique.DataSet := qryEtique;
      cdsEtique.SetProvider(dspEtique);

      {********************************************}
      {* CARREGANDO AS CONFIGURACOES DE IMPRESSAO *}
      {*****************************************AN*}
      pCarregaConfImpr(qryCfgRel, 'frmImpEtiDespachoProduto');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      if not blnPDF_Gerar and blnImpEti then
        fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, 'I');

      {****************************}
      {* CRIANDO O EDITOR DO FAST *}
      {*************************AN*}
      efsEdiFas := TEditorFast.Create(nil, frxReport, frxDatSet, tpeTipEtq);

      efsEdiFas.pAbreDespachoProduto(qryEtique, False, String(strNomTab), String(strTipoFC), String(strNumDoc), String(strEspDoc), String(strCodEmp));

      pSetaClient(qryEtique);
      cdsEtique.Open;

      With cdsEtique Do
      Begin
        If Not IsEmpty Then
        Begin
          cdsEtique.IndexFieldNames := 'AUTINCDET';
          frxDatSet.DataSet := cdsEtique;

          If efsEdiFas.fLeEtiqueta Then
          Begin
            If Not fEmptyStr(strNomImp) Then
            Begin
              frxReport.PrintOptions.Printer    := strNomImp;
              frxReport.PrintOptions.ShowDialog := False;
            End;

            If frxReport.PrepareReport Then
            begin
              If blnImpEti Then
                pPrintReport('frmImpEtiDespachoProduto', tpeTipEtq.GetName(), strNomImp, frxReport)
              Else
                pPreviewReport('frmImpEtiDespachoProduto', tpeTipEtq.GetName(), frxReport);
            end;

            Result := True;
          End;
        End
        Else
        Begin
          Close;
          fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um Registro!', ['&Ok']);
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaDespachoProduto]');
      Result := False;
    End;
  End;

  FreeAndNil(efsEdiFas);
  FreeAndNil(qryCfgRel);
  FreeAndNil(qryEtique);
  FreeAndNil(dspEtique);
  FreeAndNil(cdsEtique);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  pLiberaModulos;
end;

function fImprimeLaserArgox(prmDllEti: Pointer): Boolean;
  Var
    objDllEti: TParamDllEtiquetas;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataSet;
    qryCfgRel: TUniQuery;
    qryEtique: TUniQuery;
    dspEtique: TUniDataSetProvider;
    cdsEtique: TUniClientDataSet;
    arrEtique: Array Of Variant;
    intQtd   : Integer;
    intRecNo : Integer;
    intCont1 : Integer;
    intCont2 : Integer;
    strNomImp: String;
begin
  Try
    Result := False;

    objDllEti := prmDllEti;
    With objDllEti Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      frxReport := TfrxReport.Create(nil);
      frxDatSet := TfrxDBDataset.Create(nil);
      frxDatSet.Name := 'frxDBImpEti';

      qryCfgRel := fCriaQuery;
      qryEtique := fCriaQuery;
      dspEtique := TUniDataSetProvider.Create(nil);
      cdsEtique := TUniClientDataSet.Create(nil);
      dspEtique.DataSet := qryEtique;
      cdsEtique.SetProvider(dspEtique);

      {********************************************}
      {* CARREGANDO AS CONFIGURACOES DE IMPRESSAO *}
      {*****************************************AN*}
      pCarregaConfImpr(qryCfgRel, 'frmImpEtiquetas');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      {****************************}
      {* CRIANDO O EDITOR DO FAST *}
      {*************************AN*}
      efsEdiFas := TEditorFast.Create(nil, frxReport, frxDatSet, tpeTipEtq);

      Case tpeTipEtq Of
        {* FORNECEDOR *}
        tpeFornecedorLaser,
        tpeFornecedorArgox: efsEdiFas.pAbreFornecedor(qryEtique);

        {* OPERADOR *}
        tpeOperadorLaser: efsEdiFas.pAbreOperador(qryEtique);

        {* DIVERSOS *}
        tpeDiversosLaser,
        tpeDiversosArgox: efsEdiFas.pAbreDiversos(qryEtique);

        {* ESTRUTURA *}
        tpeEstruturaArgox: efsEdiFas.pAbreEstrutura(qryEtique);
      End;

      pSetaClient(qryEtique);
      cdsEtique.Open;

      With cdsEtique Do
      Begin
        If Not IsEmpty Then
        Begin
          First;
          SetLength(arrEtique, 0);
          cdsEtique.Tag := cdsEtique.RecordCount;

          {*********************************************************}
          {* CLONANDO AS LINHAS CONFORME A QUANTIDADE DE ETIQUETAS *}
          {******************************************************AN*}
          While Not Eof Do
          Begin
            intRecNo := RecNo;
            intQtd := FieldByName('QTDETI').AsInteger -1;

            For intCont1 := 1 To intQtd Do
            Begin
              For intCont2 := 0 To Fields.Count -1 Do
              Begin
                SetLength(arrEtique, Length(arrEtique) +1);
                arrEtique[intCont2] := Fields[intCont2].Value;
              End;

              Append;
              For intCont2 := 0 To Fields.Count -1 Do
              Begin
                Fields[intCont2].Value := arrEtique[intCont2];
              End;
              Post;

              SetLength(arrEtique, 0);
            End;

            Application.ProcessMessages;
            If intRecNo = cdsEtique.Tag Then
            Begin
              Break;
            End;

            RecNo := intRecNo;
            Next;
          End;

          cdsEtique.IndexFieldNames := String(strIdxFld);
          frxDatSet.DataSet := cdsEtique;

          If efsEdiFas.fLeEtiqueta Then
          Begin
            If Not fEmptyStr(strNomImp) Then
            Begin
              frxReport.PrintOptions.Printer    := strNomImp;
              frxReport.PrintOptions.ShowDialog := False;
            End;

            If frxReport.PrepareReport Then
              pPreviewReport('frmImpEtiquetas', tpeTipEtq.GetName(), frxReport);

            Result := True;
          End;
        End
        Else
        Begin
          Close;
          fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um Registro!', ['&Ok']);
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeLaserArgox]');
      Result := False;
    End;
  End;

  FreeAndNil(efsEdiFas);
  FreeAndNil(qryCfgRel);
  FreeAndNil(qryEtique);
  FreeAndNil(dspEtique);
  FreeAndNil(cdsEtique);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  pLiberaModulos;
end;

function fImprimeEtiquetaEntregaTinta(prmDllEtq: Pointer): Boolean;
var
  objDllEtq: TParamDllEtiquetas;
  qryCfgRel: TUniQuery;
  efsEdiFas: TEditorFast;
  frxReport: TfrxReport;
  frxDatSet: TfrxDBDataset;
  strNomImp: String;
  intTotEtq: integer;
  cdsEtique: TUniClientDataSet;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(nil);
      frxDatSet := TfrxDBDataset.Create(nil);
      frxDatSet.Name := 'frxDBImpEti';

      pCarregaConfImpr(qryCfgRel, 'frmFatFormulacaoItens');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(nil, frxReport, frxDatSet, tpeTipEtq);
      efsEdiFas.pAbreEntregaTintaMaquina(qryImpres,
                                         String(strAutInc), String(strNumDoc), String(strEspDoc),
                                         tptTipTin, objDllEtq);
      If blnImprim Then
      Begin
        cdsEtique := fCriaClientDatset(qryImpres, True);
        try
          If efsEdiFas.fLeEtiqueta Then
          Begin
            frxDatSet.DataSet := cdsEtique;
            efsEdiFas.pSetaInfoCodBar(frxReport.Script.Variables['CODBAR']);
            fPreImpressao(qryCfgRel, strNomImp, strTipImp, False);
            for intTotEtq := 1 to intNumCop do
            begin
              If Not fEmptyStr(strNomImp) Then
              Begin
                frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
                frxReport.PrintOptions.ShowDialog := False;
              End;
              frxReport.Variables['NROETI'] := FormatFloat('###', intTotEtq);
              If frxReport.PrepareReport Then
              Begin
                pPrintReport('frmFatFormulacaoItens', tpeTipEtq.GetName(), strNomImp, frxReport);
                Result := True;
              End;
            end;
          End;
        finally
          FreeAndNil(cdsEtique) ;
        end;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaEntregaTinta]');
    End;  
  End;

  If Assigned(qryCfgRel) Then FreeAndNil(qryCfgRel);
  If Assigned(frxReport) Then FreeAndNil(frxReport);
  If Assigned(frxDatSet) Then FreeAndNil(frxDatSet);
  If Assigned(efsEdiFas) Then FreeAndNil(efsEdiFas);

  pLiberaModulos;
end;

function fImprimeEtiquetaFormulacao(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    cdsDadEti: TUniClientDataSet;
    dspDadEti: TUniDataSetProvider;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';
      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeFomulacaoTinta);

      If efsEdiFas.fLeEtiqueta Then
      Begin
        efsEdiFas.pAbreFormulacaoTinta(ftiDadEti, objDllEtq);

        Try
          cdsDadEti := TUniClientDataSet.Create(Nil);
          dspDadEti := TUniDataSetProvider.Create(Nil);

          dspDadEti.DataSet := dtsImpres;
          cdsDadEti.SetProvider(dspDadEti);
          cdsDadEti.Open;

          frxDatSet.DataSet := cdsDadEti;
          frxReport.PrintOptions.Printer := ftiDadEti.strNomImp;
          Application.ProcessMessages;

          If ftiDadEti.strNomFrm.IsEmpty Then
            ftiDadEti.strNomFrm := 'frmFatFormulacaoItens_FORMUL';

          If fEmptyStr(ftiDadEti.strNomImp) Then
            pPreviewReport(ftiDadEti.strNomFrm, tpeTipEtq.GetName(), frxReport)
          Else
          Begin
            frxReport.PrintOptions.ShowDialog := False;

            If frxReport.PrepareReport Then
              pPrintReport(ftiDadEti.strNomFrm, tpeTipEtq.GetName(), ftiDadEti.strNomImp, frxReport);
          End;
        Finally
          FreeAndNil(cdsDadEti);
          FreeAndNil(dspDadEti);
        End;

      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaEntregaTinta]');
    End;
  End;

  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  pLiberaModulos;
end;

function fImprimeEtiquetaProducaoTintaMaquina(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      pCarregaConfImpr(qryCfgRel, 'frmFatFormulacaoItens_EtiqProd');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeProducaoTintaMaquina);

      If efsEdiFas.fLeEtiqueta Then
      Begin
        efsEdiFas.pAbreProducaoTinta(ftiDadEti);

        frxDatSet.DataSet := dtsImpres;

        Application.ProcessMessages;

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If fEmptyStr(strNomImp) Then
          pPreviewReport('frmFatFormulacaoItens_EtiqProd', tpeTipEtq.GetName(), frxReport)
        Else
        Begin
          frxReport.PrintOptions.ShowDialog := False;

          If frxReport.PrepareReport Then
            pPrintReport('frmFatFormulacaoItens_EtiqProd', tpeTipEtq.GetName(), strNomImp, frxReport);
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaProducaoTintaMaquina]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  pLiberaModulos;
end;

function fImprimeEtiquetaEmpresa(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      pCarregaConfImpr(qryCfgRel, 'frmImpEtiEmpresa');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

      If efsEdiFas.fLeEtiqueta Then
      Begin

        frxDatSet.DataSet := dtsImpres;

        Application.ProcessMessages;

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If fEmptyStr(strNomImp) Then
          pPreviewReport('frmImpEtiEmpresa', tpeTipEtq.GetName(), frxReport)
        Else
        Begin
          frxReport.PrintOptions.ShowDialog := False;

          If frxReport.PrepareReport Then
            pPrintReport('frmImpEtiEmpresa', tpeTipEtq.GetName(), strNomImp, frxReport);
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaProducaoTintaMaquina]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  pLiberaModulos;
end;

function fImprimeEtiquetaOrdemProducao(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
    qryImpEti: TUniQuery;
    cdsEtique: TUniCLientDataSet;
    i        : Integer;
begin
  cdsEtique := nil;
  qryImpEti := nil;
   Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      qryImpEti := fCriaQuery(nil);

      Case tpeTipEtq Of
        tpeOrdemProducao      : strNomImp := fGetFilaImpressaoEtiquetas('ETIORD', tpiLaser);
        tpeOrdemProducaoZebra : strNomImp := fGetFilaImpressaoEtiquetas('ETIORD', tpiZebra);
        tpeOrdemProducaoArgox : strNomImp := fGetFilaImpressaoEtiquetas('ETIORD', tpiArgox);
      End;

      If fEmptyStr(strNomImp) Then
      Begin
        pCarregaConfImpr(qryCfgRel, 'frmImpEtiOrdPro');
        strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      End;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

      if not Assigned(dtsImpres) then
      begin
        efsEdiFas.pAbreOrdemProducao(qryImpEti, False, strOrdPro, strCodEmp);
        pSetaClient(qryImpEti);
        cdsEtique := fCriaClientDatset(qryImpEti, True);

        if intQtdEti < 1 then
          intQtdEti := 1;

        for i := 1 to intQtdEti do
        begin
          qryImpEti.First;
          while not qryImpEti.Eof do
          begin
            pCopiaRegistroDataSet(qryImpEti, cdsEtique);

            cdsEtique.Edit;
            cdsEtique.FieldByName('SEQDET').AsString := IntToStr(i) + '/' + IntToStr(intQtdEti);
            cdsEtique.Post;

            qryImpEti.Next;
          end;
        end;
      end
      else
      Begin
        cdsEtique := TUniClientDataSet.Create(nil);
        cdsEtique.Data := TUniClientDataSet(dtsImpres).Data;
      End;

       If efsEdiFas.fLeEtiqueta Then
       Begin
         frxDatSet.DataSet := cdsEtique;
        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If fEmptyStr(strNomImp) Then
          pPreviewReport('frmImpEtiOrdPro', tpeTipEtq.GetName(), frxReport)
        Else
        Begin
          frxReport.PrintOptions.ShowDialog := False;

          If frxReport.PrepareReport Then
            pPrintReport('frmImpEtiOrdPro', tpeTipEtq.GetName(), strNomImp, frxReport);
        End;
       End;
     End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaProducaoTintaMaquina]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  FreeAndNil(qryImpEti);
  if Assigned(cdsEtique) then
    FreeAndNil(cdsEtique);
  pLiberaModulos;
end;



function fImprimeEtiquetaArmazenamento(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
    cdsEtique: TUniCLientDataSet;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      pCarregaConfImpr(qryCfgRel, ETIQUETA_ARMAZENAMENTO);
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

      cdsEtique := TUniClientDataSet.Create(nil);
      Try
        cdsEtique.Data := TUniClientDataSet(dtsImpres).Data;

        If efsEdiFas.fLeEtiqueta Then
        Begin

          frxDatSet.DataSet := cdsEtique;

          Application.ProcessMessages;

          If Not fEmptyStr(strNomImp) Then
          Begin
            frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
            frxReport.PrintOptions.ShowDialog := False;
          End;

          If fEmptyStr(strNomImp) Then
            pPreviewReport(ETIQUETA_ARMAZENAMENTO, tpeTipEtq.GetName(), frxReport)
          Else
          Begin
            frxReport.PrintOptions.ShowDialog := False;

          If frxReport.PrepareReport Then
             pPrintReport(ETIQUETA_ARMAZENAMENTO, tpeTipEtq.GetName(), strNomImp, frxReport);
          End;
        End;
      finally
        FreeAndNil(cdsEtique) ;
      end;

    End;

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaProducaoTintaMaquina]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);

  pLiberaModulos;

end;

function fImprimeEtiquetaSeparacaoErrada(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      pCarregaConfImpr(qryCfgRel, 'frmImpEtiLocalizacao');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

      If efsEdiFas.fLeEtiqueta Then
      Begin

        frxDatSet.DataSet := dtsImpres;

        Application.ProcessMessages;

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If fEmptyStr(strNomImp) Then
          pPreviewReport('frmImpEtiLocalizacao', tpeTipEtq.GetName(), frxReport)
        Else
        Begin
          frxReport.PrintOptions.ShowDialog := False;

          If frxReport.PrepareReport Then
            pPrintReport('frmImpEtiLocalizacao', tpeTipEtq.GetName(), strNomImp, frxReport);
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaSeparacaoErrada]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  pLiberaModulos;
end;

function fImprimeEtiquetaCodBarrasProduto(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
    cdsEtique: TUniCLientDataSet;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      pCarregaConfImpr(qryCfgRel, 'frmFatExpedicaoItens');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

      cdsEtique := TUniClientDataSet.Create(nil);

      pGeraCopiasDeEtiquetas(cdsEtique, objDllEtq);

      try
        If efsEdiFas.fLeEtiqueta Then
        Begin

          frxDatSet.DataSet := cdsEtique;

          Application.ProcessMessages;

          If Not fEmptyStr(strNomImp) Then
          Begin
            frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
            frxReport.PrintOptions.ShowDialog := False;
          End;

          If fEmptyStr(strNomImp) Then
            pPreviewReport('frmFatExpedicaoItens', tpeTipEtq.GetName(), frxReport)
          Else
          Begin
            frxReport.PrintOptions.ShowDialog := False;

            If frxReport.PrepareReport Then
              pPrintReport('frmFatExpedicaoItens', tpeTipEtq.GetName(), strNomImp, frxReport);
          End;
        End;
      finally
        FreeAndNil(cdsEtique);
      end;
    End;

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaCodBarrasProduto]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  pLiberaModulos;
end;

function fImprimeEtiquetaLocalArmazenamentoWms(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      pCarregaConfImpr(qryCfgRel, 'frmImpEtiLocalArmazenamentoWms');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

      If efsEdiFas.fLeEtiqueta Then
      Begin

        frxDatSet.DataSet := dtsImpres;

        Application.ProcessMessages;

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If fEmptyStr(strNomImp) Then
          pPreviewReport('frmImpEtiLocalArmazenamentoWms', tpeTipEtq.GetName(), frxReport)
        Else
        Begin
          frxReport.PrintOptions.ShowDialog := False;

          If frxReport.PrepareReport Then
            pPrintReport('frmImpEtiLocalArmazenamentoWms', tpeTipEtq.GetName(), strNomImp, frxReport);
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaLocalArmazenamentoWms]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  pLiberaModulos;
end;

function fImprimeEtiquetaProdutosControladorVendas(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      pCarregaConfImpr(qryCfgRel, 'frmEtiquetasProdutosControlados');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

      If efsEdiFas.fLeEtiqueta Then
      Begin

        frxDatSet.DataSet := dtsImpres;

        Application.ProcessMessages;

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If fEmptyStr(strNomImp) Then
          pPreviewReport('frmImpEtiRegiao', tpeTipEtq.GetName(), frxReport)
        Else
        Begin
          frxReport.PrintOptions.ShowDialog := False;

          If frxReport.PrepareReport Then
            pPrintReport('frmImpEtiRegiao', tpeTipEtq.GetName(), strNomImp, frxReport);
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaProdutosControladorVendas]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  pLiberaModulos;
end;

function fImprimeEtiquetaRegiao(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      pCarregaConfImpr(qryCfgRel, 'frmImpEtiRegiao');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

      If efsEdiFas.fLeEtiqueta Then
      Begin

        frxDatSet.DataSet := dtsImpres;

        Application.ProcessMessages;

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If fEmptyStr(strNomImp) Then
          pPreviewReport('frmImpEtiRegiao', tpeTipEtq.GetName(), frxReport)
        Else
        Begin
          frxReport.PrintOptions.ShowDialog := False;
          If frxReport.PrepareReport Then
            pPrintReport('frmImpEtiRegiao', tpeTipEtq.GetName(), strNomImp, frxReport);
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaRegiao]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  pLiberaModulos;
end;

function fImprimeEtiquetaFuncionario(prmDllRel: Pointer): Boolean;
  Var
    intCampos,
    intContador: Integer;
    efsEdiFas: TEditorFast;
    qryCfgRel,
    qryEtique: TUniQuery;
    strNomImp: String;
    cdsImpEti: TZClient;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataSet;
    objDllRel: TParamDllEtiquetas;

  procedure pLiberaRecursos;
  begin
    FreeAndNil(frxReport);
    FreeAndNil(qryEtique);
    FreeAndNil(frxDatSet);
    FreeAndNil(efsEdiFas);
    pLiberaModulos;
  end;

begin
  Try
    objDllRel := prmDllRel;

    With objDllRel Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      arrProCod := arrPrxCod;

      Result := True;

      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataSet.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';
      qryEtique := fCriaQuery;

      qryCfgRel := fCriaQuery;
      pCarregaConfImpr(qryCfgRel, 'frmImpEtiquetas');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      FreeAndNil(qryCfgRel);

      efsEdiFas := TEditorFast.Create(Nil,
                                      frxReport,
                                      frxDatSet,
                                      tpeTipEtq);

      efsEdiFas.pAbreFuncionario(qryEtique, String(strCamBus), False, String(strLisReg), intQtdEti);

      cdsImpEti := TZClient.Create(Nil, efsEdiFas.fSQLFuncionario(True, intQtdEti) + ' WHERE FALSE');
      cdsImpEti.fAbreClient(True, 'fImprimeEtiquetaFuncionario');

      With qryEtique Do
      Begin
        If (IsEmpty) Then
        Begin
          Close;
          fMensagem('ATENÇÃO!', 'É necessário selecionar pelo menos um funcionário!', ['&Ok']);
          Result := False;
          pLiberaRecursos;
          Exit;
        End
        Else
        Begin

          {********************************************}
          {* CARREGA O CLIENTDATASET COM AS ETIQUETAS *}
          {* DESAGRUPANDO POR QUATIDADE               *}
          {*****************************************JB*}
          cdsImpEti.EmptyDataSet;

          While Not Eof Do
          Begin
            For intContador := 1 To FieldByName('QTDETI').asInteger Do
            Begin
              cdsImpEti.Append;

              For intCampos := 0 To cdsImpEti.Fields.Count - 1 Do
                cdsImpEti.Fields[intCampos].Value := Fields[intCampos].Value;

              cdsImpEti.Post;
            End;

            Next;
          End;

          cdsImpEti.First;
        End;

      End;

      frxDatSet.DataSet := cdsImpEti;

      efsEdiFas.fLeEtiqueta;

      If Not fEmptyStr(strNomImp) Then
        frxReport.PrintOptions.Printer  := strNomImp;

      frxReport.PrintOptions.ShowDialog := True;

      If frxReport.PrepareReport Then
        pPreviewReport('frmImpEtiquetas', tpeTipEtq.GetName(), frxReport);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fimprimeEtiquetaFuncionario]');
    End;
  End;

  pLiberaRecursos;
end;


function fimprimeetiquetas(prmDllRel: Pointer): Boolean;
  Var
    objDllRel: TParamDllEtiquetas;
begin
  Try
    Result := False;

    objDllRel := prmDllRel;

    With objDllRel Do
    Begin
      Case tpeTipEtq Of
        tpeUnidadesRestantesArgoxFat,
        tpeUnidadesRestantesArgoxAvu: fImprimeEtiquetaUnidadesRestantesAux(prmDllRel);
        {* CLIENTE *}
        tpeClienteLaser,
        tpeClienteArgox: Result := fimprimeetiquetacliente(prmDllRel);

        tpeFuncionarioLaser,
        tpeFuncionarioArgox: Result := fimprimeEtiquetaFuncionario(prmDllRel);

        {* GENERICO *}
        tpeFornecedorLaser,
        tpeFornecedorArgox,
        tpeOperadorLaser,
        tpeDiversosLaser,
        tpeDiversosArgox,
        tpeEstruturaArgox: Result := fImprimeLaserArgox(prmDllRel);

        {* ITENS DE ORC/PED *}
        tpeItensOrcPedLaser: Result := fImprimeEtiquetaItensOrcPed(prmDllRel);

        {* DESPACHO DE MERCADORIAS *}
        tpeDespachoLaser,
        tpeDespachoLaserECommerce,
        tpeDespachoArgox,
        tpeEtiquetaDespachoVolumeGeralArgox,
        tpeEtiquetaDespachoVolumeGeralLaser,
        tpeEtiquetaDespachoVolumeIndividualArgox,
        tpeEtiquetaDespachoVolumeIndividualLaser,
        tpeDespachoFaturarExpedidoLaser,
        tpeDespachoFaturarExpedidoArgox: Result := fImprimeEtiquetaDespacho(prmDllRel);

        tpeDespachoProdutoArgox: Result := fImprimeEtiquetaDespachoProduto(prmDllRel);

        {* ORDEM DE SERVIÇO *}
        tpeOrdemServicoLaser,
        tpeOrdemServicoArgox,
        tpeOrdemServicoZebra: Result := fImprimeEtiquetaOS(prmDllRel);

        {* ORDEM DE SERVIÇO VENDA *}
        tpeOrdemServicoVendaLaser,
        tpeOrdemServicoVendaArgox,
        tpeOrdemServicoVendaZebra: Result := fImprimeEtiquetaOSVenda(prmDllRel);

        (* TINTA DE MAQUINA *)
        tpeEntregaTintaMaquina: Result := fImprimeEtiquetaEntregaTinta(prmDllRel);
        tpeFomulacaoTinta     : Result := fImprimeEtiquetaFormulacao(prmDllRel);
        tpeProducaoTintaMaquina: Result := fImprimeEtiquetaProducaoTintaMaquina(prmDllRel);

        tpeEmpresaLazer,
        tpeEmpresaArgox : Result := fImprimeEtiquetaEmpresa(prmDllRel);

        tpeOrdemProducao,
        tpeOrdemProducaoArgox,
        tpeOrdemProducaoZebra : Result := fImprimeEtiquetaOrdemProducao(prmDllRel);

        tpeLocFisLaser,
        tpeLocFisArgox  : Result := fImprimeEtiquetaLocalizacao(prmDllRel);

        tpePlanoRecebWMSLaser,
        tpePlanoRecebWMSArgox: Result := fImprimeEtiquetaPlanoRecebimento(prmDllRel);

        tpeSeqSeparacaoWMSLaser,
        tpeSeqSeparacaoWMSArgox : Result := fImprimeEtiquetaSequencialSeparacaoWMS(prmDllRel);

        tpeArmazenamento,
        tpeArmazenamentoArgox,
        tpeArmazenamentoZebra  : Result := fImprimeEtiquetaArmazenamento(prmDllRel);

        tpeCodBarrasProduto : Result := fImprimeEtiquetaCodBarrasProduto(prmDllRel);

        tpeSepErrLaser,
        tpeSepErrArgox  : Result := fImprimeEtiquetaSeparacaoErrada(prmDllRel);

        tpeLocalArmazenamentoWmsLaser,
        tpeLocalArmazenamentoWmsArgox  : Result := fImprimeEtiquetaLocalArmazenamentoWms(prmDllRel);

        tpeRegiaoLaser,
        tpeRegiaoArgox  : Result := fImprimeEtiquetaRegiao(prmDllRel);

        tpeProdutosControladosVendasArgox,
        tpeProdutosControladosVendasLaser,
        tpeProdutosControladosVendasZebra  : Result := fImprimeEtiquetaProdutosControladorVendas(prmDllRel);

        tpePlanoDeRecebimentoEtiquetaIDLaser,
        tpePlanoDeRecebimentoEtiquetaIDArgox: Result := fImprimeEtiquetaIDPlanoDeRecebimento(prmDllRel);

        tpeProdutoQuantidadeFracionadaLaser,
        tpeProdutoQuantidadeFracionadaArgox: Result := fImprimeEtiquetaProdutoQtdFracionada(prmDllRel);
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fimprimeetiquetas]');
    End;
  End;

End;

function fGetIntegrarComJadlog(strCodTra: String): Boolean;
var
  LblnTransportadoraIntegraComJadlog : Boolean;
begin
  Result := False;

  if not fEmptyStr(strCodTra) then
  begin
    LblnTransportadoraIntegraComJadlog := fCampoTabela('TRA_ETIDES', 'CADTRA', ['TRA_CODTRA'], [strCodTra]) = 'JADLOG';

    if (LblnTransportadoraIntegraComJadlog) and (fCfgSis('USAJAD', varBoolean)) then
      Result := True;
  end;
end;

function fGetIntegrarComMandae(strCodTra, strEspDoc: String): Boolean;
  var
    LblnTransportadoraIntegraComMandae : Boolean;
begin
  Result := False;

  if not fEmptyStr(strCodTra) then
  Begin
    LblnTransportadoraIntegraComMandae := fCampoTabela('TRA_ETIDES', 'CADTRA', ['TRA_CODTRA'], [strCodTra]) = 'MANDAE';

    if (LblnTransportadoraIntegraComMandae) And
       (fCfgSis('MANUSA', varBoolean)) And
       (fEmptyStr(fCfgSis('MANESP')) or (Pos(strEspDoc, fTransform(fCfgSis('MANESP'), 2)) > 0)) then
      Result := True;
  End;

end;

function fImprimeEtiquetasDespachoPDF(modRecMod          : TRecModulos;
                                      VS_Date            : TDateTime;
                                      strLoginUsuarioLogado,
                                      VS_strCodEmp,
                                      strChaveAcesso,
                                      strDiretorioSalvar : String): Boolean; stdcall;

Var
  objDllRel : TParamDllEtiquetas;
  qryPar    : TUniQuery;

  strSerCor,
  strNumDoc,
  strEspDoc,
  strEmpDoc,
  strTabela,
  strTip_FC,
  strCodTra,
  strLayDoc : String;

  intQtdVol : Integer;

  strNumPok,
  strPedSit,
  strNumPed,
  strEmpPed,
  strCodCli : String;

Const

 strSQL = 'SELECT                    ' +
          '  "MOVGER"     AS TABELA, ' +
          '  G.GER_NUMDOC AS NUMDOC, ' +
          '  G.GER_ESPDOC AS ESPDOC, ' +
          '  G.GER_CODEMP AS EMPDOC, ' +
          '  G.GER_VOLUME AS VOLUME, ' +
          '  G.GER_TIP_FC AS TIP_FC, ' +
          '  G.GER_CODTRA AS CODTRA  ' +
          'FROM                      ' +
          '  MOVGER G                ' +
          '  INNER JOIN LOGNFE L ON (L.NFE_NUMDOC = G.GER_NUMDOC AND ' +
          '                          L.NFE_ESPDOC = G.GER_ESPDOC AND ' +
          '                          L.NFE_CODEMP = G.GER_CODEMP AND ' +
          '                          L.NFE_CODCLI = G.GER_CODCLI AND ' +
          '                          L.NFE_SERIE_ = G.GER_SERIE_)    ' +
          'WHERE                     ' +
          '  L.NFE_ACESSO = :CODACE  ' +

          'UNION ALL                 ' +

          'SELECT                    ' +
          '  "NOTGER"     AS TABELA, ' +
          '  G.GER_NUMDOC AS NUMDOC, ' +
          '  G.GER_ESPDOC AS ESPDOC, ' +
          '  G.GER_CODEMP AS EMPDOC, ' +
          '  G.GER_VOLUME AS VOLUME, ' +
          '  G.GER_TIP_FC AS TIP_FC, ' +
          '  G.GER_CODTRA AS CODTRA  ' +
          'FROM                      ' +
          '  NOTGER G                ' +
          '  INNER JOIN LOGNFE L ON (L.NFE_NUMDOC = G.GER_NUMDOC AND ' +
          '                          L.NFE_ESPDOC = G.GER_ESPDOC AND ' +
          '                          L.NFE_CODEMP = G.GER_CODEMP AND ' +
          '                          L.NFE_CODCLI = G.GER_CODCLI AND ' +
          '                          L.NFE_SERIE_ = G.GER_SERIE_)    ' +
          'WHERE                     ' +
          '  L.NFE_ACESSO = :CODACE  ';

begin

  Result := False;

  Try

    If fEmptyStr(strChaveAcesso) Then
      Exit(False);

    If fEmptyStr(strDiretorioSalvar) Then
      Exit(False);

    pSetaModulos(modRecMod);

    objDllRel := TParamDllEtiquetas.Create;

    {Variáveis}
    objDllRel.varRecVar.VS_Date                := VS_Date;
    objDllRel.varRecVar.strLoginUsuarioLogado  := strLoginUsuarioLogado;
    objDllRel.varRecVar.strDescriUsuarioLogado := fRetNomeOperador(strLoginUsuarioLogado);
    objDllRel.varRecVar.VS_strCodEmp           := VS_strCodEmp;
    untFuncoesSimples.pSetaEmpresaLogada(VS_strCodEmp);

    {Módulo de Conexão}
    objDllRel.modRecMod := modRecMod;

    objDllRel.blnB2W := False;

    qryPar := fCriaQuery;

    Try

      qryPar.Close;
      qryPar.SQL.Clear;
      qryPar.SQL.Add(strSQL);
      qryPar.ParamByName('CODACE').AsString := strChaveAcesso;
      qryPar.Open;

      If qryPar.IsEmpty Then
        Exit(False);

      strNumDoc := qryPar.FieldByName('NUMDOC').AsString;
      strEspDoc := qryPar.FieldByName('ESPDOC').AsString;
      strEmpDoc := qryPar.FieldByName('EMPDOC').AsString;
      intQtdVol := qryPar.FieldByName('VOLUME').AsInteger;
      strTabela := qryPar.FieldByName('TABELA').AsString;
      strTip_FC := qryPar.FieldByName('TIP_FC').AsString;
      strCodTra := qryPar.FieldByName('CODTRA').AsString;

      strNumPok := '';
      strPedSit := '';

      If (fCfgSis('UTEECO', varBoolean, VS_strCodEmp)) Then
      Begin

        strNumPok := fCampoTabela('FGO_NUMPOK', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [strNumDoc, strEspDoc, strEmpDoc]);
        strPedSit := fCampoTabela('FGO_PEDSIT', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [strNumDoc, strEspDoc, strEmpDoc]);

        If fEmptyStr(strNumPok) And fEmptyStr(strPedSit) Then
        Begin
          strCodCli := fCampoTabela('NFE_CODCLI', 'LOGNFE', ['NFE_ACESSO'], [strChaveAcesso]);
          pRetNumeroPedidoVenda(strNumDoc, strEspDoc, strEmpDoc, strCodCli, strNumPed, strEmpPed);
          If Not fEmptyStr(strNumPed) And Not fEmptyStr(strEmpPed) Then
          Begin
            strNumPok := fCampoTabela('FGO_NUMPOK', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [strNumPed, 'PD', strEmpPed]);
            strPedSit := fCampoTabela('FGO_PEDSIT', 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [strNumPed, 'PD', strEmpPed]);
          End;
        End;
      End;

      If fEmptyStr(strNumPok) And fEmptyStr(strPedSit) Then
        objDllRel.tpeTipEtq := IIF(fCfgSis('ETIDES', varString, VS_strCodEmp) = 'L', tpeDespachoLaser, tpeDespachoArgox)
      Else
      Begin

        objDllRel.tpeTipEtq := tpeDespachoLaserECommerce;

        //fMensagem('ATENÇÃO!', 'O modelo da etiqueta de despacho Laser E-Commerce (código 139) não está disponível para a empresa ('+edtCodEmp.Text+')!', ['&OK']);
        If fCampoTabela('COUNT(*) AS QTD', 'LAYETI', ['LAY_PADRAO', 'LAY_TIPLAY'], ['S', '139']) = 0 Then
          Exit(False);

      End;

      If fGetIntegrarComMandae(strCodTra, strEspDoc) Then
      Begin
        strLayDoc := fCampoTabela('TRA_MANLAY', 'CADTRA', ['TRA_CODTRA'], [strCodTra]);
      End
      Else If fGetIntegrarComJadlog(strCodTra) Then
      Begin
        strLayDoc := fCampoTabela('TRA_JADLAY', 'CADTRA', ['TRA_CODTRA'], [strCodTra]);
      End
      Else If (fCfgSis('B2WIMP', varString, VS_strCodEmp) = 'S') And fTransportadoraRealizaColetaB2WEntrega(strCodTra) Then
      Begin
        strLayDoc        := fRetornaLayoutEtiquetaDespachoB2W(strNumDoc, strEspDoc, strEmpDoc, VS_strCodEmp);
        objDllRel.blnB2W := True;
      End
      Else If Pos(fCfgSis('USIGEP', varString, VS_strCodEmp), 'S_A') > 0 Then
      Begin
        strSerCor := fCampoTabela('TRA_CODSER', 'CORTRA', ['TRA_CODTRA', 'TRA_CODEMP'], [strCodTra, strEmpDoc]);
        strLayDoc := fCampoTabela('CSE_CODLAY', 'CORSER', ['CSE_CODIGO'], [strSerCor]);
      End
      Else If (fCfgSis('USIGEP', varString, VS_strCodEmp) = 'O') Then
      Begin
        strLayDoc := fCampoTabela('TRA_LAYETQ', 'CADTRA', ['TRA_CODTRA'], [strCodTra]);
      End;

      objDllRel.strLayDoc := strLayDoc;
      objDllRel.strNumDoc := AnsiString(strNumDoc);
      objDllRel.strEspDoc := AnsiString(strEspDoc);
      objDllRel.strCodEmp := AnsiString(strEmpDoc);
      objDllRel.intQtdVol := intQtdVol;
      objDllRel.blnImpEti := False;
      objDllRel.strNomTab := AnsiString(strTabela);
      objDllRel.strTipoFC := AnsiString(strTip_FC);
      objDllRel.intEtqInicial := 1;

      {PDF}
      objDllRel.blnPDF_Gerar      := True;
      objDllRel.strPDF_Diretorio  := strDiretorioSalvar;
      objDllRel.blnPDF_Apresentar := False;

    Finally
      FreeAndNil(qryPar);
    End;

    With objDllRel Do
    Begin

      Case tpeTipEtq Of

        {* DESPACHO DE MERCADORIAS *}
        tpeDespachoLaser,
        tpeDespachoLaserECommerce,
        tpeDespachoArgox: Result := fImprimeEtiquetaDespacho(objDllRel);

      End;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fimprimeetiquetasDespachoPDF]');
    End;
  End;

End;

function fTransportadoraRealizaColetaB2WEntrega(const strCodTra : String) : Boolean;
var
  qryAux : TUniQuery;
const
  SQL_CADTRA = 'SELECT TRA_ETIDES FROM CADTRA WHERE TRA_CODTRA = :CODTRA';
begin

  If (strCodTra.IsEmpty) Then
    Exit(False);

  qryAux := fCriaQuery;

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(SQL_CADTRA);
    qryAux.ParamByName('CODTRA').AsString := strCodTra;
    qryAux.Open;

    Result := (Not qryAux.IsEmpty) And (qryAux.FieldByName('TRA_ETIDES').AsString = 'B2W');

  Finally
    FreeAndNil(qryAux);
  End;

end;

function fRetornaLayoutEtiquetaDespachoB2W(const strNumDoc, strEspDoc, strCodEmp : String; VS_strCodEmp : String) : String;
var
  strMarket : String;
  qryAux    : TUniQuery;

  strNumPed,
  strEspPed,
  strEmpPed : String;

const
  SQL_MKPPED = 'SELECT       ' +
               '  MKP_MARKET ' +
               'FROM         ' +
               '  MKPPED     ' +
               'WHERE        ' +
               '  MKP_NUMPED = :NUMPED AND ' +
               '  MKP_ESPPED = :ESPPED AND ' +
               '  MKP_EMPPED = :EMPPED ';

  SQL_FATGOR = 'SELECT       ' +
               '  *          ' +
               'FROM         ' +
               '  FATGOR     ' +
               'WHERE        ' +
               '  FGO_NUMFAT = :NUMDOC AND ' +
               '  FGO_TIPFAT = :ESPDOC AND ' +
               '  FGO_EMPFAT = :EMPDOC';


  SQL_HUB_CADMKP_POR_EMPRESA = 'SELECT * FROM HUB_CADMKP WHERE MKP_CODMKP = :CODMKP AND MKP_CODEMP = :CODEMP';
  SQL_HUB_CADMKP_GERAL       = 'SELECT * FROM HUB_CADMKP WHERE MKP_CODMKP = :CODMKP';

begin

  Result := '';

  If (strNumDoc.IsEmpty) Then
    Exit;

  If (strEspDoc.IsEmpty) Then
    Exit;

  If (strCodEmp.IsEmpty) Then
    Exit;

  qryAux := fCriaQuery;

  If (strEspDoc = 'PD') Then
  Begin
    strNumPed := strNumDoc;
    strEspPed := strEspDoc;
    strEmpPed := strCodEmp;
  End
  Else
  Begin

    {Identifica PD do documento de venda}
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(SQL_FATGOR);
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('EMPDOC').AsString := strCodEmp;
    qryAux.Open;

    If (Not qryAux.IsEmpty) Then
    Begin
      strNumPed := qryAux.FieldByName('FGO_NUMDOC').AsString;
      strEspPed := qryAux.FieldByName('FGO_ESPDOC').AsString;
      strEmpPed := qryAux.FieldByName('FGO_CODEMP').AsString;
    End;

  End;

  Try

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(SQL_MKPPED);
    qryAux.ParamByName('NUMPED').AsString := strNumPed;
    qryAux.ParamByName('ESPPED').AsString := strEspPed;
    qryAux.ParamByName('EMPPED').AsString := strEmpPed;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
    Begin

      strMarket := qryAux.FieldByName('MKP_MARKET').AsString;

      qryAux.Close;
      qryAux.SQL.Clear;

      If (fCfgSis('ETIEMP', varString, VS_strCodEmp) = 'S') Then
        qryAux.SQL.Add(SQL_HUB_CADMKP_POR_EMPRESA)
      Else
        qryAux.SQL.Add(SQL_HUB_CADMKP_GERAL);

      qryAux.ParamByName('CODMKP').AsString := strMarket;

      If (fCfgSis('ETIEMP', varString, VS_strCodEmp) = 'S') Then
        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryAux.Open;

      If Not qryAux.IsEmpty Then
        Result := qryAux.FieldByName('MKP_CODLAY').AsString;

    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function fimprimeetiquetaentradamerc(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    frxReport: TfrxReport;
    efsEdiFas: TEditorFast;
    qryCfgRel: TUniQuery;
    strNomImp: String;
    cdsDadEti: TUniClientDataSet;
    dspDadEti: TUniDataSetProvider;
    intIndice: Integer;
    frxDatSet: TfrxDBDataSet;
Begin

  Try
    Result := False;

    objDllEtq := prmDllEtq;

    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      pCarregaConfImprRel('frmEntEtiquetas', strNomImp, strTipImp);

      Begin
        frxReport := TfrxReport.Create(nil);
        frxUserDd.Name := 'frxDBImpEti';

        cdsDadEti := TUniClientDataSet.Create(Nil);
        dspDadEti := TUniDataSetProvider.Create(Nil);

        dspDadEti.DataSet := qryImpres;
        cdsDadEti.SetProvider(dspDadEti);
        cdsDadEti.Open;
        cdsDadEti.EmptyDataSet;

        frxUserDd.First;
        While Not frxUserDd.Eof Do
        Begin
          cdsDadEti.Append;

          For intIndice := 0 To cdsDadEti.Fields.Count - 1 Do
            cdsDadEti.Fields[intIndice].Value := frxUserDd.Value[cdsDadEti.Fields[intIndice].FieldName];

          cdsDadEti.Post;

          frxUserDd.Next;
        End;

        If strTipTipoEtiqueta = etqLotePrecos Then
          pPreenchePREPRA(cdsDadEti, intTabPre, intParcel, strCndDes, strNumPar, strValAcr, strTipoAlter);

        cdsDadEti.First;

        frxDatSet := TfrxDBDataSet.Create(Nil);
        frxDatSet.Name := 'frxDBImpEti';
        frxDatSet.DataSet := cdsDadEti;

        efsEdiFas := TEditorFast.Create(nil, frxReport, frxDatSet, tpeTipEtq);

        If efsEdiFas.fLeEtiqueta Then
        Begin
          If efsEdiFas.fTemParametro('INFADI') Then
            frxReport.Script.Variables['INFADI'] := fInformacaoAdicionalEtiquetaItens;

         If Not fEmptyStr(strNomImp) Then
          Begin
            frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
            frxReport.PrintOptions.ShowDialog := False;
          End;

          If fEmptyStr(strNomImp) Then
          begin
            pPreviewReport('frmEntEtiquetas', tpeTipEtq.GetName(), frxReport);
            Result := True;
          end
          Else
          Begin
            frxReport.PrintOptions.ShowDialog := False;
  
            If frxReport.PrepareReport Then
            begin
              pPrintReport('frmEntEtiquetas', tpeTipEtq.GetName(), strNomImp, frxReport);
              Result := True;
            end;
          End;
        End;

        FreeAndNil(efsEdiFas);
        FreeAndNil(frxDatSet);
        FreeAndNil(qryCfgRel);
        FreeAndNil(frxReport);
        FreeAndNil(cdsDadEti);
        FreeAndNil(dspDadEti);
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fimprimeetiquetaentradamerc]');
    End;
  End;

  pLiberaModulos;
End;

function fImprimeEtiquetaGeral(prmDllEtq: Pointer): Boolean;
Begin
  Result := fImprimeEtiquetaGeralAux(prmDllEtq, True);
End;

function fImprimeEtiquetaOS(prmDllRel: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    efsEdiFas: TEditorFast;
    qryCfgRel: TUniQuery;
    qryEtique: TUniQuery;
    strNomImp: String;
begin
  Try
    Result := False;

    objDllEtq := prmDllRel;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      frxReport := TfrxReport.Create(nil);
      frxDatSet := TfrxDBDataSet.Create(nil);
      frxDatSet.Name := 'frxDBImpEti';

      qryCfgRel := fCriaQuery(nil);
      qryEtique := fCriaQuery(nil);

      pCarregaConfImpr(qryCfgRel, 'frmFatManConsertoEquip_Eti');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(nil, frxReport, frxDatSet, tpeTipEtq);
      efsEdiFas.pAbreOS(qryEtique, False, String(strNumDoc), String(strCodEmp));

      pSetaClient(qryEtique);
      qryEtique.Open;

      frxDatSet.DataSet := qryEtique;

      If efsEdiFas.fLeEtiqueta Then
      Begin
        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := strNomImp;
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If frxReport.PrepareReport Then
        Begin
          If blnImpEti Then
            pPrintReport('frmFatManConsertoEquip_Eti', tpeTipEtq.GetName(), strNomImp, frxReport)
          Else
            pPreviewReport('frmFatManConsertoEquip_Eti', tpeTipEtq.GetName(), frxReport);

          Result := True;
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaItensOrcPed]');
    End;
  End;

  FreeAndNil(efsEdiFas);
  FreeAndNil(qryCfgRel);
  FreeAndNil(qryEtique);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  pLiberaModulos;
end;

function fImprimeEtiquetaOSVenda(prmDllRel: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    efsEdiFas: TEditorFast;
    qryCfgRel: TUniQuery;
    qryEtique: TUniQuery;
    strNomImp: String;
begin
  Try
    Result := False;

    objDllEtq := prmDllRel;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      frxReport := TfrxReport.Create(nil);
      frxDatSet := TfrxDBDataSet.Create(nil);
      frxDatSet.Name := 'frxDBImpEti';

      qryCfgRel := fCriaQuery(nil);
      qryEtique := fCriaQuery(nil);

      pCarregaConfImpr(qryCfgRel, 'frmFatManOrdSer_Eti');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(nil, frxReport, frxDatSet, tpeTipEtq);
      efsEdiFas.pAbreOSVenda(qryEtique, False, String(strNumDoc), String(strCodEmp));

      pSetaClient(qryEtique);
      qryEtique.Open;

      If (Assigned(dtsImpres)) And (objDllEtq.dtsImpres.RecordCount > 0) Then
        frxDatSet.DataSet := dtsImpres
      Else
        frxDatSet.DataSet := qryEtique;

      If efsEdiFas.fLeEtiqueta Then
      Begin
        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := strNomImp;
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If frxReport.PrepareReport Then
        Begin
          If blnImpEti Then
            pPrintReport('frmFatManOrdSer_Eti', tpeTipEtq.GetName(), strNomImp, frxReport)
          Else
            pPreviewReport('frmFatManOrdSer_Eti', tpeTipEtq.GetName(), frxReport);

          Result := True;
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaOSVenda]');
    End;
  End;

  FreeAndNil(efsEdiFas);
  FreeAndNil(qryCfgRel);
  FreeAndNil(qryEtique);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  pLiberaModulos;
end;

function fImprimeEtiquetaGeralAux(prmDllEtq: Pointer; blnChamadaForaDaDll: Boolean): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    frxReport: TfrxReport;
    efsEdiFas: TEditorFast;
    frxDatSet: TfrxDataSet;
    cdsDadEti: TUniClientDataSet;
    strNomImp: String;
    frxMetodos: TFrxMetodos;
    dspDadEti: TUniDataSetProvider;
Begin

  Try
    Result := False;

    objDllEtq := prmDllEtq;

    With objDllEtq Do
    Begin
      If blnChamadaForaDaDll then
      Begin
        pSetaModulos(modRecMod);
        pCriaModulosFast(varRecVar);
      End;

      pCarregaConfImprRel('frmRelEtiqQtdRestante', strNomImp, strTipImp);

      If Not fEmptyStr(strNomFil) Then
        strNomImp := strNomFil;

      frxReport := TfrxReport.Create(Nil);
      If blnUsfrxU Then
         frxDatSet := TfrxUserDataSet.Create(Nil)
      Else
         frxDatSet := TfrxDBDataSet.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';
      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq);

      If efsEdiFas.fLeEtiqueta(fEmptyStr(strLayDoc), strLayDoc) Then
      Begin

        cdsDadEti := TUniClientDataSet.Create(Nil);
        dspDadEti := TUniDataSetProvider.Create(Nil);

        dspDadEti.DataSet := dtsImpres;
        cdsDadEti.SetProvider(dspDadEti);
        cdsDadEti.Open;

        If Not blnUsfrxU Then
          TfrxDBDataSet(frxDatSet).DataSet := cdsDadEti
        Else
        Begin
          frxMetodos := TFrxMetodos.Create;
          frxMetodos.cdsFrxDataSet := tuniclientdataset(cdsDadEti);
          TfrxUserDataSet(frxDatSet).OnCheckEOF := frxMetodos.frxUserDataSetCheckEOF;
          TfrxUserDataSet(frxDatSet).OnFirst := frxMetodos.frxUserDataSetFirst;
          TfrxUserDataSet(frxDatSet).OnNext := frxMetodos.frxUserDataSetNext;
          TfrxUserDataSet(frxDatSet).OnPrior := frxMetodos.frxUserDataSetPrior;
          TfrxUserDataSet(frxDatSet).OnGetValue := frxMetodos.frxUserDataSetGetValue;
          TfrxUserDataSet(frxDatSet).OnNewGetValue := frxMetodos.frxUserDataSetNewGetValue;
        End;

        Application.ProcessMessages;

        If efsEdiFas.fTemParametro('INFADI') Then
          frxReport.Script.Variables['INFADI'] := fInformacaoAdicionalEtiquetaItens;

        If efsEdiFas.fTemParametro('CODCON') Then
          frxReport.Script.Variables['CODCON'] := strCodCon;

        If efsEdiFas.fTemParametro('NOMCON') Then
          frxReport.Script.Variables['NOMCON'] := fRetNomeOperador(strCodCon);

        {*****************************************************}
        {* SE ETIQUETA AVULSA DE UNIDADE RESTANTE E          *}
        {* NÃO FOR INFORMADO O DADOS EM QUESTÃO, NÃO IMPRIME *}
        {**************************************************MA*}

        If (tpeTipEtq = tpeUnidadesRestantesArgoxAvu)  Or
           (tpeTipEtq = tpeUnidadesRestantesAvu) Or
           (tpeTipEtq = tpeUnidadesRestantesArgoxFat)  Or
           (tpeTipEtq = tpeUnidadesRestantesFat) Then

        Begin

          If fEmptyStr(String(strCodEmp)) Then
          Begin
            frxReport.Script.Variables['CODEMP'] := '';
            frxReport.Script.Variables['EMPNOM'] := '';
          End
          Else
          Begin
            If efsEdiFas.fTemParametro('CODEMP') Then
              frxReport.Script.Variables['CODEMP'] := strCodEmp;

            If efsEdiFas.fTemParametro('EMPNOM') Then
              frxReport.Script.Variables['EMPNOM'] := fRetNomeEmpresa(String(strCodEmp));
          End;

          If fEmptyStr(strCodCli) Then
          Begin
            frxReport.Script.Variables['CLICOD'] := '';
            frxReport.Script.Variables['CLINOM'] := '';
          End
          Else
          Begin
            If efsEdiFas.fTemParametro('CLICOD') Then
              frxReport.Script.Variables['CLICOD'] := strCodCli;

            If efsEdiFas.fTemParametro('CLINOM') Then
              frxReport.Script.Variables['CLINOM'] := fRetNomCliente(strCodCli);
          End;

          If fEmptyStr(String(strNumDoc)) Then
          Begin
            frxReport.Script.Variables['NUMDOC'] := '';
          End
          Else
          Begin
            If efsEdiFas.fTemParametro('NUMDOC') Then
              frxReport.Script.Variables['NUMDOC'] := strNumDoc;
          End;

          If fEmptyStr(String(strEspDoc)) Then
          Begin
            frxReport.Script.Variables['ESPDOC'] := '';
          End
          Else
          Begin
            If efsEdiFas.fTemParametro('ESPDOC') Then
              frxReport.Script.Variables['ESPDOC'] := strEspDoc;
          End;

        End;

        frxReport.PrintOptions.Printer    := strNomImp;
        frxReport.PrintOptions.ShowDialog := fEmptyStr(strNomImp);

        If intNumCop > 0 Then
          frxReport.PrintOptions.Copies := intNumCop;

        If frxReport.PrepareReport Then
        Begin
          If fEmptyStr(strNomImp) Or (Not blnImpEti) Then
            pPreviewReport(strNomFrm, tpeTipEtq.GetName(), frxReport)
          Else
            pPrintReport(strNomFrm, tpeTipEtq.GetName(), strNomImp, frxReport);

          Result := True;
        End;
      End

      Else pMensagemOk('O Layout da Etiqueta não está configurado!');

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaGeral]');
    End;
  End;

  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(cdsDadEti);
  FreeAndNil(efsEdiFas);
  If Assigned(frxMetodos) Then
    FreeAndNil(frxMetodos);

  If blnChamadaForaDaDll then
  Begin
    pLiberaModulos;
  End;
End;

procedure pGridDocumentos(prmDllRel: Pointer);
  Var
    objDllRel: TParamDllEtiquetas;
Begin
  Try
    objDllRel := prmDllRel;

    With objDllRel Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      arrProCod := arrPrxCod;

      pCriarForm(TfrmGridDocumentos, frmGridDocumentos);

    End;

    pLiberaModulos;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pGridDocumentos]');
    End;
  End;

End;

procedure pEtiquetasItemCPF(prmDllRel: Pointer);
  Var
    objDllRel: TParamDllEtiquetas;
Begin

  Try
    objDllRel := prmDllRel;

    With objDllRel Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      arrProCod := arrPrxCod;

      pCriarForm(TfrmEtiquetasItemCPF, frmEtiquetasItemCPF);
    End;

    pLiberaModulos;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pEtiquetasItemCPF]');
    End;
  End;

End;

function fImprimeEtiquetasRastreamentoProduto(prmDllEti: Pointer): Boolean; stdcall;
  Var
    objDll: TParamDllEtiquetas;
    qryImpEti,
    qryCfgRel: TUniQuery;
    cdsDados: TZClient;
    strNomFrm,
    strNomImp: String;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataSet;

    {Monta a setença SQL IN() com os numeros do Lote }
    function fRetListaLote: String;
      var recProLotEtiq: TLoteProdutoEtiq;
    Begin
      Result := '';
      {Monta a setença SQL IN() com os numeros do Lote }
      For recProLotEtiq in objDll.ArrLoteProdutoEtiq Do
        Result := Result + QuotedStr(string(ShortString(recProLotEtiq.strAutInc))) + ',';
      {Apaga a ultima virugla para não gerar erro no sql}
      If Result[Length(Result)] = ',' Then
        Delete(Result, Length(Result), Length(Result));
    End;

    function fAjustaCdsDadosPorQuantidadeEtiqueta: Boolean;
      var
        intContador,
        intCampos  : Integer;
        recProLotEtiq : TLoteProdutoEtiq;
    Begin
      Try
        Result := True;
        For recProLotEtiq in objDll.ArrLoteProdutoEtiq Do
        Begin
          If qryImpEti.Locate('SEQLOT', recProLotEtiq.strAutInc, []) Then
          Begin
            For intContador := 1 To recProLotEtiq.intQtdEti Do
            Begin
              cdsDados.Insert;
              For intCampos := 0 To cdsDados.Fields.Count -1 Do
                cdsDados.Fields[intCampos].Value := qryImpEti.Fields[intCampos].Value;
              cdsDados.Post;
            End;
          End;
        End;
      Except
        Result := False;
      End
    End;
Begin
   Try
     objDll    := prmDllEti;
     pSetaModulos(objDll.modRecMod);
     pCriaModulosFast(objDll.varRecVar);
     Try
       qryImpEti := fCriaQuery;
       cdsDados  := TZClient.Create(nil, '');
       qryCfgRel := fCriaQuery;
       //strTipImp := fCfgSis('TIPETI');
       frxReport := TfrxReport.Create(nil);
       frxDatSet := TfrxDBDataSet.Create(nil);
       frxDatSet.Name := 'frxDBImpEti';

       If fEmptyStr(strNomFrm) Then
         strNomFrm := 'frmImpEtiquetas';

       pCarregaConfImpr(qryCfgRel, strNomFrm);

       strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
       If Not fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString) Then
         strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

       efsEdiFas := TEditorFast.Create(nil, frxReport, frxDatSet, objDll.tpeTipEtq);

       //CDS Vazio para ser Replicado pela Quantidade de Etiquetas
       efsEdiFas.pAbreRastreamentoProduto(cdsDados.qryQuery, True, False, '0');
       cdsDados.fAbreClient(True, 'fImprimeEtiquetasRastreamentoProduto');

       efsEdiFas.pAbreRastreamentoProduto(qryImpEti, False, True,'0', fRetListaLote);
       Result := fAjustaCdsDadosPorQuantidadeEtiqueta;
       If Not Result  Then
         Exit;

       If efsEdiFas.fLeEtiqueta Then
       Begin
         If Not fEmptyStr(strNomImp) Then
         Begin
           frxReport.PrintOptions.Printer    := strNomImp;
           frxReport.PrintOptions.ShowDialog := False;
         End;
        frxDatSet.DataSet := cdsDados;
        If frxReport.PrepareReport Then
        Begin
          If fEmptyStr(strNomImp) Then
            pPreviewReport(strNomFrm, objDll.tpeTipEtq.GetName(), frxReport)
          Else
            pPrintReport(strNomFrm, objDll.tpeTipEtq.GetName(), strNomImp, frxReport);

          Result := True;
        End;
      End;

    Finally
      FreeAndNil(qryimpEti);
      FreeAndNil(cdsdados);
      FreeAndNil(efsEdiFas);
      FreeAndNil(frxReport);
      FreeAndNil(frxDatSet);
      pLiberaModulos;
    End;
  Except
    on e: Exception do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetasLoteProduto]');
    End;
  End;
End;

function fImprimeEtiquetasSeparacaoQtdRestante(prmDllEti: Pointer): Boolean;
  var
    objDll: TParamDllEtiquetas;
    qryImpEti,
    qryCfgRel: TUniQuery;
    cdsDados: TZClient;
    strTipImp,
    strNomFrm,
    strNomImp: String;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataSet;
begin
  Result := true;
  objDll    := prmDllEti;
  pSetaModulos(objDll.modRecMod);
  pCriaModulosFast(objDll.varRecVar);
  Try
    Try
      qryImpEti := fCriaQuery;
      cdsDados  := TZClient.Create(nil, '');
      qryCfgRel := fCriaQuery;
      strTipImp := fCfgSis('TIPETI');
      frxReport := TfrxReport.Create(nil);
      frxDatSet := TfrxDBDataSet.Create(nil);
      frxDatSet.Name := 'frxDBImpEti';
      strNomFrm := objDll.strNomFrm;

      If fEmptyStr(strNomFrm) Then
        strNomFrm := 'frmEtiquetadoProdutoSeparado_QtdRestante';

      pCarregaConfImpr(qryCfgRel, strNomFrm);

      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      If Not fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString) Then
        strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(nil, frxReport, frxDatSet, objDll.tpeTipEtq);

      //CDS Vazio para ser Replicado pela Quantidade de Etiquetas
//      efsEdiFas.pAbreEtiquetaDoProdutoSeparado(cdsDados.qryQuery);
      cdsDados.Data := objDll.cdsDadosEtiqueta.Data;

       If efsEdiFas.fLeEtiqueta Then
       Begin
         If Not fEmptyStr(strNomImp) Then
         Begin
           frxReport.PrintOptions.Printer    := strNomImp;
           frxReport.PrintOptions.ShowDialog := False;
         End;
         frxDatSet.DataSet := cdsDados;
         If frxReport.PrepareReport Then
         Begin
           If fEmptyStr(strNomImp) Then
             pPreviewReport(strNomFrm, objDll.tpeTipEtq.GetName(), frxReport)
           Else
             pPrintReport(strNomFrm, objDll.tpeTipEtq.GetName(), strNomImp, frxReport);

           Result := True;
         End;
       End;

    Finally
      FreeAndNil(qryimpEti);
      FreeAndNil(cdsdados);
      FreeAndNil(efsEdiFas);
      FreeAndNil(frxReport);
      FreeAndNil(frxDatSet);
      pLiberaModulos;
    End;
  Except
    on e: Exception do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetasLoteProduto]');
    End;
  End;

End;

function fImprimeEtiquetasLoteProduto(prmDllEti: Pointer): Boolean;
  Var
    objDll: TParamDllEtiquetas;
    qryImpEti,
    qryCfgRel: TUniQuery;
    cdsDados: TZClient;
    strTipImp,
    strNomFrm,
    strNomImp: String;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataSet;

    {Monta a setença SQL IN() com os numeros do Lote }
    function fRetListaLote: String;
      var recProLotEtiq: TLoteProdutoEtiq;
    Begin
      Result := '';
      {Monta a setença SQL IN() com os numeros do Lote }
      For recProLotEtiq in objDll.ArrLoteProdutoEtiq Do
        Result := Result + QuotedStr(string(ShortString(recProLotEtiq.strAutInc))) + ',';
      {Apaga a ultima virugla para não gerar erro no sql}
      If Result[Length(Result)] = ',' Then
        Delete(Result, Length(Result), Length(Result));
    End;

    function fAjustaCdsDadosPorQuantidadeEtiqueta: Boolean;
      var
        intContador,
        intCampos  : Integer;
        recProLotEtiq : TLoteProdutoEtiq;
    Begin
      Try
        Result := True;

        If ((objDll.tpeTipEtq =  tpeMarmoreGranito) Or (objDll.tpeTipEtq =  tpeMarmoreGranitoArgox))And
           (Length(objDll.ArrLoteProdutoEtiq) = 0) Then
        Begin
          qryImpEti.First;
          while not qryImpEti.Eof do
          Begin
            For intContador := 1 To objDll.intQtdEti do
            Begin
              cdsDados.Insert;
              For intCampos := 0 To cdsDados.Fields.Count -1 Do
                cdsDados.Fields[intCampos].Value := qryImpEti.Fields[intCampos].Value;
              cdsDados.Post;
            End;
            qryImpEti.Next
          End
        End
        Else
        Begin
          For recProLotEtiq in objDll.ArrLoteProdutoEtiq Do
          Begin
            If qryImpEti.Locate('AUTINC', recProLotEtiq.strAutInc, []) Then
            Begin
              For intContador := 1 To recProLotEtiq.intQtdEti Do
              Begin
                cdsDados.Insert;
                For intCampos := 0 To cdsDados.Fields.Count -1 Do
                  cdsDados.Fields[intCampos].Value := qryImpEti.Fields[intCampos].Value;
                cdsDados.Post;
              End;
            End;
          End;
        End;
      Except
        Result := False;
      End
    End;
Begin
   Try
     objDll    := prmDllEti;
     pSetaModulos(objDll.modRecMod);
     pCriaModulosFast(objDll.varRecVar);
     Try
       qryImpEti := fCriaQuery;
       cdsDados  := TZClient.Create(nil, '');
       qryCfgRel := fCriaQuery;
       strTipImp := fCfgSis('TIPETI');
       frxReport := TfrxReport.Create(nil);
       frxDatSet := TfrxDBDataSet.Create(nil);
       frxDatSet.Name := 'frxDBImpEti';
       strNomFrm := objDll.strNomFrm;

       If fEmptyStr(strNomFrm) Then
         strNomFrm := 'frmImpEtiquetas';

       pCarregaConfImpr(qryCfgRel, strNomFrm);

       strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
       If Not fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString) Then
         strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

       efsEdiFas := TEditorFast.Create(nil, frxReport, frxDatSet, objDll.tpeTipEtq);

       //CDS Vazio para ser Replicado pela Quantidade de Etiquetas
       If ((objDll.tpeTipEtq =  tpeMarmoreGranito) Or (objDll.tpeTipEtq =  tpeMarmoreGranitoArgox)) Then
         efsEdiFas.pAbreLoteProduto(cdsDados.qryQuery, True, False, '0', '', '', '', '', 1,1,1, True)
       Else
         efsEdiFas.pAbreLoteProduto(cdsDados.qryQuery, True, False, '0');
       cdsDados.fAbreClient(True, 'fImprimeEtiquetasLoteProduto');

       If (objDll.tpeTipEtq =  tpeMarmoreGranito) Or (objDll.tpeTipEtq =  tpeMarmoreGranitoArgox) Then
         efsEdiFas.pAbreLoteProduto(qryImpEti, False, True,'0', '',
                                    string(ShortString(objDll.strCodEmp)), '', '', 1,1,1, True,
                                    objDll.strForceFiltro, objDll.strChaveTemporariaLotMarmore)
       Else
         efsEdiFas.pAbreLoteProduto(qryImpEti, False, True,'0', fRetListaLote, string(ShortString(objDll.strCodEmp)), '', '', 1,1,1, False, '', '', fQuantidadeEmb);
       Result := fAjustaCdsDadosPorQuantidadeEtiqueta;
       If Not Result  Then
         Exit;

       If efsEdiFas.fLeEtiqueta Then
       Begin
         If Not fEmptyStr(strNomImp) Then
         Begin
           frxReport.PrintOptions.Printer    := strNomImp;
           frxReport.PrintOptions.ShowDialog := False;
         End;
         frxDatSet.DataSet := cdsDados;
         If frxReport.PrepareReport Then
         Begin
          If fEmptyStr(strNomImp) Then
            pPreviewReport(strNomFrm, objDll.tpeTipEtq.GetName(), frxReport)
          Else
            pPrintReport(strNomFrm, objDll.tpeTipEtq.GetName(), strNomImp, frxReport);

          Result := True;
         End;
       End;

    Finally
      FreeAndNil(qryimpEti);
      FreeAndNil(cdsdados);
      FreeAndNil(efsEdiFas);
      FreeAndNil(frxReport);
      FreeAndNil(frxDatSet);
      pLiberaModulos;
    End;
  Except
    on e: Exception do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetasLoteProduto]');
    End;
  End;
End;

function fImprimeEtiquetaSequencialSeparacaoWMS(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
    qryRelatorio : TUniQuery;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryRelatorio := fCriaQuery();
      With qryRelatorio, SQL Do
      Begin
        Close;
        Clear;

        Add(' SELECT GROUP_CONCAT(LSE.CODLSE SEPARATOR "  ") AS RESLSE,                    ');
        Add('        (SELECT COUNT(0) FROM EXTGOR  WHERE FGO_SEQSEP = :SEQSEP ) AS QTDPED, ');
        Add('        FGO_SEQSEP AS SEQSEP                                                  ');
        Add(' FROM (                                                                       ');
        Add('     SELECT CONCAT(LOC_CODLSE, " : ", SUM(LDO_QTDITE)) AS CODLSE, FGO_SEQSEP  ');
        Add('     FROM EXTGOR                                                              ');
        Add('       INNER JOIN FATDOR D ON FDO_SEQGER = FGO_SEQFGO                         ');
        Add('       INNER JOIN LOTDOR L ON LDO_SEQFDO = D.AUTOINCREM                       ');
        Add('       INNER JOIN CADLOT C ON LOT_CODITE = FDO_CODITE                         ');
        Add('                          AND LOT_CODEMP = FDO_CODEMP                         ');
        Add('                          AND LOT_NUMLOT = LDO_NUMLOT                         ');
        Add('       INNER JOIN CADLOC A ON LOC_CODLOC = LOT_LOCFIS                         ');
        Add('                          AND LOC_CODEMP = LOT_CODEMP                         ');
        Add('     WHERE FGO_SEQSEP = :SEQSEP                                               ');
        Add('     GROUP BY LOC_CODLSE                                                      ');
        Add('     ) AS LSE                                                                 ');

        ParamByName('SEQSEP').AsString := String(strAutInc);

        Open;

      End;

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      pCarregaConfImpr(qryCfgRel, 'frmFatVendas_SEP');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

      If efsEdiFas.fLeEtiqueta Then
      Begin

        frxDatSet.DataSet := qryRelatorio;

        Application.ProcessMessages;

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If fEmptyStr(strNomImp) Then
          pPreviewReport('frmFatVendas_SEP', tpeTipEtq.GetName(), frxReport)
        Else
        Begin
          frxReport.PrintOptions.ShowDialog := False;

          If frxReport.PrepareReport Then
            pPrintReport('frmFatVendas_SEP', tpeTipEtq.GetName(), strNomImp, frxReport);
        End;
      End;
    End;

    FreeAndNil(qryRelatorio);

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaSequencialSeparacaoWMS]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  pLiberaModulos;

End;

function fImprimeEtiquetaPlanoRecebimento(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
    qryRelatorio : TUniQuery;
    cdsRelatorio : TUniClientDataSet;
    intNoEti   : Integer;
    intNoField : Integer;
    blnSugereLocalizacao,
    blnModCub : Boolean;
    intQtdEtiDef: Integer;
    blnDefCds: Boolean;
    strChaves: String;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      blnSugereLocalizacao := (fCfgSis('TPLREC', varString) = 'L');
      blnModCub := (fCfgSis('MODCUB', varString) = '2');

      qryRelatorio := fCriaQuery();
      With qryRelatorio, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT DISTINCT                                     ');
        Add('        I.AUTOINCREM AS AUTINC,                     ');
        Add('        AIT_CODITE AS CODITE,                       ');
        Add('        ITE_DESITE AS DESITE,                       ');
        Add('        ARC_DTAREC AS DTAREC,                       ');
        Add('        ARC_HRAREC AS HRAREC,                       ');
        Add('        ARC_IDEDIG AS IDEDIG,                       ');
        Add('      C.ADC_NUMDOC AS NUMDOC,                       ');
        Add('      C.ADC_ESPDOC AS ESPDOC,                       ');
        Add('        DEP_CODIGO AS CODDEP,                       ');
        Add('        DEP_DESCRI AS DESDEP,                       ');
        Add('        GRU_CODGRU AS CODGRU,                       ');
        Add('        GRU_DESGRU AS DESGRU,                       ');
        Add('        AIT_CLASSE AS CLASSE,                       ');
        Add('        FOR_CODFOR AS CODFOR,                       ');
        Add('        FOR_NOMFOR AS NOMFOR,                       ');
        Add('        ITE_REFERE AS REFERE,                       ');
        Add('        UNI_SIGUNI AS SIGUNI,                       ');
        Add('        DET_NUMDOC AS NUMDOC,                       ');
        Add('        DET_ESPDOC AS ESPDOC,                       ');
        Add('        (SELECT LOC_CODLOC                          ');
        Add('           FROM MOVDET D                            ');
        Add('         INNER JOIN CADLOT L ON  (D.DET_NUMLOT = L.LOT_NUMLOT) ');
        Add('                             AND (D.DET_CODEMP = L.LOT_CODEMP) ');
        Add('                             AND (D.DET_CODITE = L.LOT_CODITE) ');
        Add('         INNER JOIN CADLOC C ON  (C.LOC_CODLOC = L.LOT_LOCFIS) ');
        Add('                             AND (C.LOC_CODEMP = L.LOT_CODEMP) ');
        Add('         WHERE D.DET_CODITE = DT.DET_CODITE         ');
        Add('           AND D.DET_CODEMP = DT.DET_CODEMP         ');
        Add('           AND D.DET_CLAFIS < 5000                  ');
        Add('         ORDER BY D.DET_DTAENT DESC, D.DET_HORENT DESC LIMIT 1) AS ULTLOC, ');
        Add('        (SELECT COUNT(0) FROM AGEITE WHERE AIT_SEQGER = :SEQGER ) QITENS, ');
        Add('        (SELECT COUNT(0) FROM AGEITE INNER JOIN AGEILO ON AIL_SEQITE = AGEITE.AUTOINCREM WHERE AIT_SEQGER = :SEQGER ) QLOCAL, ');

        If (blnSugereLocalizacao) Then
        Begin
          Add('      1 AS QTDETI,          ');
          Add('      AI.AIL_QTDITE * IFNULL(M.TRI_EMBALA,1) AS QTDITE, ');
          Add('      AI.AIL_QTDVEN AS QTDVEN, ');
          Add('      AI.AIL_LOCFIS AS LOCFIS, ');
          Add('      AI.AIL_DTAVEN AS DTAVEN, ');
        End
        Else
        Begin
          Add('      AIT_QTDETI AS QTDETI, ');
          Add('      0 AS QTDITE,    ');
          Add('      0 AS QTDVEN,    ');
          Add('      "" AS LOCFIS,   ');
          Add('      NULL AS DTAVEN, ');
        End;

        Add('        CONCAT("1", ARC_IDEDIG,                     ');
        Add('                    AIT_CODITE,                     ');
        Add('                    :CODEMP                         ');

        If (blnSugereLocalizacao) And (blnModCub) Then
          Add( ' , AI.AIL_SEQUEN ');

        Add(' ) AS CODBAR,     ');

        Add('     IF( IFNULL(AIT_LOCFIS,"") <> "", AIT_LOCFIS, IG.ITE_LOCFIS) AS ITELOC  ');

        Add(',T.ITE_CODFAB AS CODFAB, ');
        Add(' T.ITE_CODBAR AS BARITE, ');
        Add('fRetLocalizacoesFisicasEtiquetaPlano(IG.ITE_CODEMP, IG.ITE_CODITE, 3) AS LOCSAL ');

        Add(' FROM AGEITE I                                        ');
        Add('   INNER JOIN AGEREC R  ON  R.AUTOINCREM = AIT_SEQGER ');
        Add('   INNER JOIN CADITE T  ON  T.ITE_CODITE = AIT_CODITE ');
        Add('   INNER JOIN ITEGER IG ON IG.ITE_CODITE = AIT_CODITE ');
        Add('                       AND IG.ITE_CODEMP = :CODEMP    ');

        If (blnSugereLocalizacao) And (blnModCub) Then
          Add('   INNER JOIN AGEILO AI ON AI.AIL_SEQITE = I.AUTOINCREM   ')
        Else
          Add('   LEFT  JOIN AGEILO AI ON AI.AIL_SEQITE = I.AUTOINCREM');

        Add('   LEFT  JOIN CADDEP D  ON  D.DEP_CODIGO = ITE_CODDEP ');
        Add('   LEFT  JOIN CADGRU G  ON  G.GRU_CODGRU = ITE_CODGRU ');
        Add('   LEFT  JOIN CADUNI U  ON  U.UNI_CODUNI = ITE_UNICOM ');
        Add('   INNER JOIN AGEDOC C  ON  C.ADC_SEQGER = AIT_SEQGER ');
        Add('   INNER JOIN MOVDET DT ON DET_NUMDOC = ADC_NUMDOC    ');
        Add('                    AND DET_ESPDOC = ADC_ESPDOC       ');
        Add('                    AND DET_SERIE_ = ADC_SERIE_       ');
        Add('                    AND DET_CODFOR = ADC_CODFOR       ');
        Add('                    AND DET_CODITE = AIT_CODITE       ');
        Add('   INNER JOIN MOVTRI M ON M.DET_SEQGER = DT.AUTOINCREM');



        Add('   INNER JOIN CADFOR ON FOR_CODFOR = DET_CODFOR       ');
        Add(' WHERE AIT_SEQGER = :SEQGER                           ');
        Add('   AND ARC_CODEMP = :CODEMP                           ');

        If not fEmptystr(string(strSeqAgeILo)) Then
          Add(' AND AI.AUTOINCREM = :AGEILO ');

        if not femptyStr(strCodIte) then
        begin
          Add(' AND AIT_CODITE = :CODITE ');
          ParamByName('CODITE').AsString := strCodIte;
        end;

        if blnModCub then
        begin 
          Add(' AND ((AIT_MODCUB <> "M") OR (AI.AUTOINCREM IS NOT NULL))');
        end
        Else
        Begin
          If blnSugereLocalizacao Then
            Add(' AND AIL_QTDVEN > 0 ');
        End;

        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('SEQGER').AsString := String(strAutInc);

        If not fEmptystr(string(strSeqAgeILo)) Then
          ParamByName('AGEILO').AsString := String(strSeqAgeILo);

        If blnSugereLocalizacao Then
          Add(' GROUP BY ARC_IDEDIG, IG.ITE_CODITE, AIT_APEPIC, AI.AIL_LOCFIS, AI.AIL_DTAVEN, QTDITE');

        Open;

        cdsRelatorio := fCriaClientDatset(qryRelatorio, True);

        While not Eof Do
        Begin
          blnDefCds := False;
          intQtdEtiDef := FieldByName('QTDETI').AsInteger;
          objDllEtq.cdsPlanoRecebimento.First;

          if (Assigned(objDllEtq.cdsPlanoRecebimento)) And
             (objDllEtq.cdsPlanoRecebimento.Locate('CODITE', qryRelatorio.FieldByname('CODITE').AsString, [])) then
          begin
             blnDefCds := True;
            If (objDllEtq.cdsPlanoRecebimento.FieldByName('QTDETI').AsInteger > 0) Then
               intQtdEtiDef :=  objDllEtq.cdsPlanoRecebimento.FieldByName('QTDETI').AsInteger
          End;

          For intNoEti := 1 To intQtdEtiDef Do
          Begin
            cdsRelatorio.Append;

            For intNoField := 0 To Fields.Count -1 Do
              cdsRelatorio.Fields[intNoField].Value := Fields[intNoField].Value;

            If blnDefCds And (objDllEtq.cdsPlanoRecebimento.FieldByname('QTDITE_POR_ETIQUETA').AsFloat > 0) then
              cdsRelatorio.FieldByname('QTDITE').AsFloat := objDllEtq.cdsPlanoRecebimento.FieldByname('QTDITE_POR_ETIQUETA').AsFloat;
            cdsRelatorio.Post;
          End;
          Next;
        End;
      End;

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      pCarregaConfImpr(qryCfgRel, 'frmPlanoDeRecebimento');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

      If efsEdiFas.fLeEtiqueta Then
      Begin

        frxDatSet.DataSet := cdsRelatorio;

        Application.ProcessMessages;

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If fEmptyStr(strNomImp) Then
          pPreviewReport('frmPlanoDeRecebimento', tpeTipEtq.GetName(), frxReport)
        Else
        Begin
          frxReport.PrintOptions.ShowDialog := False;

          If frxReport.PrepareReport Then
            pPrintReport('frmPlanoDeRecebimento', tpeTipEtq.GetName(), strNomImp, frxReport);
        End;

        If blnAtualizaAgeIteImp And  (Not (blnSugereLocalizacao) And (blnModCub)) then
        Begin
          With qryRelatorio, SQL Do
          Begin
            Close;
            Clear;

            Add(' UPDATE AGEITE SET AIT_IMPETI = "S" ');
            Add(' WHERE AIT_SEQGER = :SEQGER         ');

            ParamByName('SEQGER').AsString := String(strAutInc);

            ExecSQL;
          End;
        End
        Else If blnAtualizaAgeIteImp And ((blnSugereLocalizacao) And (blnModCub)) Then
        Begin
          qryRelatorio.First;
          strChaves := '';
          While not qryRelatorio.EoF do
          Begin
            strChaves := strChaves + IIf(strChaves <> '', ',', '') + '"' + qryRelatorio.FieldByName('AUTINC').AsString + '"';
            qryRelatorio.Next;
          End;

          With qryRelatorio, SQL Do
          Begin
            If Not fEmptyStr(strChaves) Then
            Begin
              Close;
              Clear;

              Add(' UPDATE AGEITE SET AIT_IMPETI = "S" ');
              Add(' WHERE AUTOINCREM IN('+strChaves+') ');
            End;


            ExecSQL;
          End;
        End;

      End;
    End;

    FreeAndNil(qryRelatorio);
    FreeAndNil(cdsRelatorio);
  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaLocalizacao]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  pLiberaModulos;
end;

function fImprimeEtiquetaLocalizacao(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
    cdsDados: TUniClientDataSet;
begin
  Try
    Result := False;

    objDllEtq := prmDllEtq;
    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      pCarregaConfImpr(qryCfgRel, 'frmImpEtiLocalizacao');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      cdsDados := TUniClientDataSet.Create(nil);
      Try

        efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

        If efsEdiFas.fLeEtiqueta Then
        Begin
          pCloneDataSet(cdsDados, TUniClientDataSet(dtsImpres));
          frxDatSet.DataSet := cdsDados;

          Application.ProcessMessages;
          If Not fEmptyStr(strNomImp) Then
          Begin
            frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
            frxReport.PrintOptions.ShowDialog := False;
          End;
          If fEmptyStr(strNomImp) Then
            pPreviewReport('frmImpEtiLocalizacao', tpeTipEtq.GetName(), frxReport)
          Else
          Begin
            frxReport.PrintOptions.ShowDialog := False;
            If frxReport.PrepareReport Then
              pPrintReport('frmImpEtiLocalizacao', tpeTipEtq.GetName(), strNomImp, frxReport);
          End;
        End;
      finally
        FreeAndNil(cdsDados);
      end;
    End;

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaLocalizacao]');
    End;
  End;

  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  pLiberaModulos;
end;


(*
procedure dxInitializeEti;
Begin
  dxInitialize;
End;

procedure dxFinalizeEti;
Begin
  dxFinalize;
End;
*)

function fSVN_RevisionEditorEtiq: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

constructor TFrxMetodos.create;
begin
  intContEti := -1
end;

procedure TFrxMetodos.frxUserDataSetCheckEOF(Sender: TObject; var Eof: Boolean);
Begin
  Eof := cdsFrxDataSet.EoF;
End;

procedure TFrxMetodos.frxUserDataSetFirst(Sender: TObject);
Begin
  cdsFrxDataSet.First;
  intContEti := cdsFrxDataSet.FieldByName('QTDETI').Value;
End;

procedure TFrxMetodos.frxUserDataSetNext(Sender: TObject);
Begin
  Dec(intContEti);
  If intContEti = 0 Then
  Begin
    cdsFrxDataSet.Next;
    intContEti := cdsFrxDataSet.FieldByName('QTDETI').Value;
  End;

End;

procedure TFrxMetodos.frxUserDataSetPrior(Sender: TObject);
Begin
  cdsFrxDataSet.Prior;
End;

procedure TFrxMetodos.frxUserDataSetGetValue(const VarName: string; var Value: Variant);
Begin
  Value := cdsFrxDataSet.FieldByName(VarName).Value;
End;

procedure TFrxMetodos.frxUserDataSetNewGetValue(Sender: TObject; const VarName: string; var Value: Variant);
Begin
{}
End;

function fImprimeEtiquetaUnidadesRestantesAux(prmDllEtq: Pointer): Boolean;
  Var
    objDllEtq: TParamDllEtiquetas;
    frxReport: TfrxReport;
    efsEdiFas: TEditorFast;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;

    cdsDadEti: TUniClientDataSet;
    dspDadEti: TUniDataSetProvider;
    intIndice: integer;
Begin

  Try

    Result := False;
    objDllEtq := prmDllEtq;

    With objDllEtq Do
    Begin

      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      pCarregaConfImprRel('frmRelEtiqQtdRestante', strNomImp, strTipImp);

      If Not fEmptyStr(strNomFil) Then
        strNomImp := strNomFil;

      frxReport := TfrxReport.Create(Nil);
      cdsDadEti := TUniClientDataSet.Create(Nil);
      dspDadEti := TUniDataSetProvider.Create(Nil);

      dspDadEti.DataSet := objDllEtq.dtsImpres;
      cdsDadEti.SetProvider(dspDadEti);
      cdsDadEti.Open;
      cdsDadEti.EmptyDataSet;

      objDllEtq.dtsImpres.First;
      While Not objDllEtq.dtsImpres.Eof Do
      Begin
        cdsDadEti.Append;
        For intIndice := 0 To cdsDadEti.Fields.Count - 1 Do
          cdsDadEti.Fields[intIndice].Value := objDllEtq.dtsImpres.Fields[intIndice].Value;
        cdsDadEti.Post;
        objDllEtq.dtsImpres.Next;
      End;

      Try
        frxDatSet := TfrxDBDataset.Create(Nil);
        Try
          cdsDadEti.PacketRecords :=  objDllEtq.dtsImpres.RecordCount;
          cdsDadEti.Open;
          efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq);
          Try
            frxDatSet.Name := 'frxDBImpEti';

            If efsEdiFas.fLeEtiqueta(fEmptyStr(strLayDoc), strLayDoc) Then
            Begin

              frxDatSet.DataSet := cdsDadEti;
              Application.ProcessMessages;

              If efsEdiFas.fTemParametro('INFADI') Then
                frxReport.Script.Variables['INFADI'] := fInformacaoAdicionalEtiquetaItens;

              If efsEdiFas.fTemParametro('CODCON') Then
                frxReport.Script.Variables['CODCON'] := strCodCon;

              If efsEdiFas.fTemParametro('NOMCON') Then
                frxReport.Script.Variables['NOMCON'] := fRetNomeOperador(strCodCon);

              {*****************************************************}
              {* SE ETIQUETA AVULSA DE UNIDADE RESTANTE E          *}
              {* NÃO FOR INFORMADO O DADOS EM QUESTÃO, NÃO IMPRIME *}
              {**************************************************MA*}

              If (tpeTipEtq = tpeUnidadesRestantesArgoxAvu)  Or
                 (tpeTipEtq = tpeUnidadesRestantesAvu) Or
                 (tpeTipEtq = tpeUnidadesRestantesArgoxFat)  Or
                 (tpeTipEtq = tpeUnidadesRestantesFat) Then

              Begin

                If fEmptyStr(String(strCodEmp)) Then
                Begin
                  frxReport.Script.Variables['CODEMP'] := '';
                  frxReport.Script.Variables['EMPNOM'] := '';
                End
                Else
                Begin
                  If efsEdiFas.fTemParametro('CODEMP') Then
                    frxReport.Script.Variables['CODEMP'] := strCodEmp;

                  If efsEdiFas.fTemParametro('EMPNOM') Then
                    frxReport.Script.Variables['EMPNOM'] := fRetNomeEmpresa(String(strCodEmp));
                End;

                If fEmptyStr(strCodCli) Then
                Begin
                  frxReport.Script.Variables['CLICOD'] := '';
                  frxReport.Script.Variables['CLINOM'] := '';
                End
                Else
                Begin
                  If efsEdiFas.fTemParametro('CLICOD') Then
                    frxReport.Script.Variables['CLICOD'] := strCodCli;

                  If efsEdiFas.fTemParametro('CLINOM') Then
                    frxReport.Script.Variables['CLINOM'] := fRetNomCliente(strCodCli);
                End;

                If fEmptyStr(String(strNumDoc)) Then
                Begin
                  frxReport.Script.Variables['NUMDOC'] := '';
                End
                Else
                Begin
                  If efsEdiFas.fTemParametro('NUMDOC') Then
                    frxReport.Script.Variables['NUMDOC'] := strNumDoc;
                End;

                If fEmptyStr(String(strEspDoc)) Then
                Begin
                  frxReport.Script.Variables['ESPDOC'] := '';
                End
                Else
                Begin
                  If efsEdiFas.fTemParametro('ESPDOC') Then
                    frxReport.Script.Variables['ESPDOC'] := strEspDoc;
                End;

              End;

              frxReport.PrintOptions.Printer    := strNomImp;
              frxReport.PrintOptions.ShowDialog := fEmptyStr(strNomImp);

              If intNumCop > 0 Then
                frxReport.PrintOptions.Copies := intNumCop;

              If frxReport.PrepareReport Then
              Begin
                If fEmptyStr(strNomImp) Or (Not blnImpEti) Then
                  pPreviewReport(strNomFrm, tpeTipEtq.GetName(), frxReport)
                Else
                  pPrintReport(strNomFrm, tpeTipEtq.GetName(), strNomImp, frxReport);

                Result := True;
              End;
            End

            Else pMensagemOk('O Layout da Etiqueta não está configurado!');

          finally
            FreeAndNil(efsEdiFas);
          end;

        finally
          FreeAndNil(frxDatSet);
        end;

      finally
        FreeAndNil(frxReport);
        FreeAndNil(cdsDadEti);
        FreeAndNil(dspDadEti);
      end;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaUnidadesRestantesAux]');
    End;
  End;

  pLiberaModulos;

End;

function fImprimeEtiquetaIDPlanoDeRecebimento(prmDllEtq: Pointer) : Boolean;
 Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    qryIns: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
    cdsDados : TUniClientDataSet;
begin
  Try
    Result := False;
    objDllEtq := prmDllEtq;

    If Not Assigned(objDllEtq.cdsPlanoRecebimento) Then
      Exit(False);

    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      qryIns := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);
      frxDatSet := TfrxDBDataset.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';

      cdsDados := TUniClientDataSet.Create(Nil);
      pCloneDataSet(cdsDados, TUniClientDataSet(cdsPlanoRecebimento));
      frxDatSet.DataSet := cdsDados;

      pCarregaConfImpr(qryCfgRel, 'frmPlanoDeRecebimento');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

      If efsEdiFas.fLeEtiqueta Then
      Begin

        Application.ProcessMessages;

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If fEmptyStr(strNomImp) Then
          pPreviewReport('frmPlanoDeRecebimento', tpeTipEtq.GetName(), frxReport)
        Else
        Begin
          frxReport.PrintOptions.ShowDialog := False;

          If frxReport.PrepareReport Then
            pPrintReport('frmPlanoDeRecebimento', tpeTipEtq.GetName(), strNomImp, frxReport);
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaIDPlanoDeRecebimento]');
    End;
  End;
  FreeAndNil(qryCfgRel);
  FreeAndNil(qryIns);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  pLiberaModulos;

End;

function fQuantidadeEmb: String;
var fltQtdEmb : Double;
begin
  fltQtdEmb := StrToFloatDef(InputBox('Digite a quantidade por Embalagem', 'Quantidade', '1'), -1);
  If fltQtdEmb < 0 Then
  Begin
    pMensagemOk('É preciso digitar uma quantidade de embalagem válida.');
    exit;
  End

  Else
    Result := FloatToStr(fltQtdEmb);
end;

function fImprimeEtiquetaProdutoQtdFracionada(prmDllEtq: Pointer) : Boolean;
 Var
    objDllEtq: TParamDllEtiquetas;
    qryCfgRel: TUniQuery;
    efsEdiFas: TEditorFast;
    frxReport: TfrxReport;
    frxDatSet: TfrxDBDataset;
    strNomImp: String;
    cdsDadEti: TUniClientDataSet;
    dspDadEti: TUniDataSetProvider;
    intIndice: integer;
begin
  Try
    Result := False;
    objDllEtq := prmDllEtq;

    With objDllEtq Do
    Begin
      pSetaModulos(modRecMod);
      pCriaModulosFast(varRecVar);

      qryCfgRel := fCriaQuery;
      frxReport := TfrxReport.Create(Nil);

      cdsDadEti := TUniClientDataSet.Create(Nil);
      dspDadEti := TUniDataSetProvider.Create(Nil);

      dspDadEti.DataSet := dtsImpres;
      cdsDadEti.SetProvider(dspDadEti);
      cdsDadEti.Open;
      cdsDadEti.EmptyDataSet;

      dtsImpres.First;
      While Not dtsImpres.Eof Do
      Begin
        cdsDadEti.Append;
        For intIndice := 0 To cdsDadEti.Fields.Count - 1 Do
        Begin
          If cdsDadEti.Fields[intIndice].ReadOnly Then
            cdsDadEti.Fields[intIndice].ReadOnly := False;

          cdsDadEti.Fields[intIndice].Value := dtsImpres.Fields[intIndice].Value;
        End;
        cdsDadEti.Post;
        dtsImpres.Next;
      End;

      frxDatSet := TfrxDBDataSet.Create(Nil);
      frxDatSet.Name := 'frxDBImpEti';
      frxDatSet.DataSet := cdsDadEti;

      pCarregaConfImpr(qryCfgRel, 'frmEntEnderecamentoProduto');
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      efsEdiFas := TEditorFast.Create(Nil, frxReport, frxDatSet, tpeTipEtq );

      If efsEdiFas.fLeEtiqueta Then
      Begin

        Application.ProcessMessages;

        If Not fEmptyStr(strNomImp) Then
        Begin
          frxReport.PrintOptions.Printer    := AnsiReplaceStr(strNomImp, '\\' + fRetNomeRede + '\', '');
          frxReport.PrintOptions.ShowDialog := False;
        End;

        If fEmptyStr(strNomImp) Then
          pPreviewReport('frmEntEnderecamentoProduto', tpeTipEtq.GetName(), frxReport)
        Else
        Begin
          frxReport.PrintOptions.ShowDialog := False;

          If frxReport.PrepareReport Then
            pPrintReport('frmEntEnderecamentoProduto', tpeTipEtq.GetName(), strNomImp, frxReport);
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
       Result := False;
      pMensagensErro(E.Message, '[untImprimeEtiquetas.fImprimeEtiquetaProdutoQtdFracionada]');
    End;
  End;
  FreeAndNil(qryCfgRel);
  FreeAndNil(frxReport);
  FreeAndNil(frxDatSet);
  FreeAndNil(efsEdiFas);
  FreeAndNil(cdsDadEti);
  FreeAndNil(dspDadEti);
  pLiberaModulos;

End;

procedure pGeraCopiasDeEtiquetas(Var cdsEtique: TUniClientDataSet; objDllEtq: TParamDllEtiquetas);
  Var
    intCont: Integer;
    cdsClone: TUniClientDataSet;
begin
  If (cdsEtique = Nil) Then
    Exit;

  cdsClone := TUniClientDataSet.Create(Nil);

  Try
    cdsClone.Data  := TUniClientDataSet(objDllEtq.dtsImpres).Data;
    cdsEtique.Data := TUniClientDataSet(objDllEtq.dtsImpres).Data;

    For intCont := 1 To objDllEtq.intQtdEti - 1 Do
    Begin
      cdsClone.First;
      While Not cdsClone.Eof Do
      Begin
        pCopiaRegistroDataSet(cdsClone, cdsEtique);
        cdsClone.Next;
      End;
    End;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

procedure pPreenchePREPRA(AcdsDadEti: TUniClientDataSet; AintPreTab, AintParcel: Integer; AstrCndPag, AstrNumPar, AstrValAcr: String; AstrTipoAlter: Integer = 0 );
Var
  qryImpEtiAux: TUniQuery;
begin

  qryImpEtiAux := fCriaQuery;
  AcdsDadEti.DisableControls;

  If (AintPreTab = 0) Then
    AintPreTab := 1;

  try
    AcdsDadEti.First;
    While Not AcdsDadEti.Eof Do
    Begin
      qryImpEtiAux.Close;
      qryImpEtiAux.SQL.Clear;
      qryImpEtiAux.SQL.Add(' SELECT ');
      qryImpEtiAux.SQL.Add(  fGetSQLConsultaItensPrecoValidandoEstrutura('PREITE', IntToStr(AintPreTab), 'PRE_', True) + ' * ( ' + QuotedStr(AstrCndPag) + ' / 100 ) + ' + fGetSQLConsultaItensPrecoValidandoEstrutura('PREITE' , IntToStr(AintPreTab), 'PRE_', True) + '  AS PREPRA,  ');
      qryImpEtiAux.SQL.Add(' CONCAT( "' + QuotedStr(AstrNumPar) + ' X " , CAST(( ' + fGetSQLConsultaItensPrecoValidandoEstrutura('PREITE' , IntToStr(AintPreTab), 'PRE_', True) + ' * ( ' + QuotedStr(AstrCndPag) + ' / 100 ) + ' + fGetSQLConsultaItensPrecoValidandoEstrutura('PREITE' , IntToStr(AintPreTab), 'PRE_', True) + ' ) / ' + QuotedStr(AstrNumPar) + ' AS DECIMAL(15,2))) AS PARPRA ');      qryImpEtiAux.SQL.Add(' FROM  ');
      qryImpEtiAux.SQL.Add('  PREITE ');
      qryImpEtiAux.SQL.Add(' WHERE ');
      qryImpEtiAux.SQL.Add('  PREITE.AUTOINCREM = :AUTINC ');

      qryImpEtiAux.ParamByName('AUTINC').AsString := AcdsDadEti.FieldByName('AUTINC_PREITE').AsString;

      qryImpEtiAux.Open;

      AcdsDadEti.Edit;
      AcdsDadEti.FieldByName('PREPRA').AsString := qryImpEtiAux.FieldByName('PREPRA').AsString;
      AcdsDadEti.FieldByName('PARPRA').AsString := qryImpEtiAux.FieldByName('PARPRA').AsString;
      AcdsDadEti.Post;

      AcdsDadEti.Next;
    End;

  finally
    FreeAndNil(qryImpEtiAux);
    AcdsDadEti.EnableControls
  end;

end;

initialization
  dxInitialize;

finalization
  dxFinalize;

end.

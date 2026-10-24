unit untFuncoesEtiquetas;

interface
{$WARN SYMBOL_PLATFORM OFF}

uses TypesRel, untFuncoesSimples, untModulo, Windows, SysUtils, untFuncoesRelatorios,
  untModuloSPR, untTypesSistema, Variants, untFuncoesRel2, UniClientDataSet;

//  function fSVN_RevisionEditor: String;
  function fImprimeEtiqueta(prmDllRel: TParamDllEtiquetas; strNomFun: String = 'fimprimeetiquetas'): Boolean;
  procedure pEditorEtiqueta(tpeTipEti: TTipoEtiqueta; Var strCodLayDoc: String; srTipImp: String = 'J');
  procedure pGridDocumento;
  procedure pEtiItemCPF;
  procedure pGeraEtiquetaCaixas;
  procedure pGeraEtiquetaMontagemCaixas(cdsDados: TUniClientDataSet; blnPreview: Boolean);

  procedure pGridDocumentos(prmDllRel: Pointer); stdcall; External 'libEditorEtiquetas.dll' delayed;
  procedure pEtiquetasItemCPF(prmDllRel: Pointer); stdcall; External 'libEditorEtiquetas.dll' delayed;
  procedure pImprimeEtiquetaCaixas(prmDllRel: Pointer); stdcall; External 'libEditorEtiquetas.dll' delayed;
  procedure pImprimeEtiquetaMontagemCaixas(prmDllRel: Pointer); stdcall; External 'libEditorEtiquetas.dll' delayed;
  procedure peditoretiquetas(prmDllRel: Pointer); stdcall; External 'libEditorEtiquetas.dll' delayed;
  function fSVN_RevisionEditorEtiq: String; stdcall; External 'libEditorEtiquetas.dll' delayed;
  function fimprimeetiquetas(prmDllRel: Pointer): Boolean; stdcall; External 'libEditorEtiquetas.dll' delayed;
  function fimprimeetiquetaitens(prmDllEtq: Pointer): Boolean; stdcall; External 'libEditorEtiquetas.dll' delayed;
  function fimprimeetiquetaentradamerc(prmDllEtq: Pointer): Boolean; stdcall; External 'libEditorEtiquetas.dll' delayed;
  function fImprimeEtiquetaGeral(prmDllEtq: Pointer): Boolean; stdcall; External 'libEditorEtiquetas.dll' delayed;
  function fImprimeEtiquetasLoteProduto(prmDllEti: Pointer): Boolean; stdcall; External 'libEditorEtiquetas.dll' delayed;
  function fImprimeEtiquetasSeparacaoQtdRestante(prmDllEti: Pointer): Boolean; stdcall; External 'libEditorEtiquetas.dll' delayed;
  function fImprimeEtiquetasRastreamentoProduto(prmDllEti: Pointer): Boolean; stdcall; External 'libEditorEtiquetas.dll' delayed;
  function fImprimeEtiquetaUnidadesRestantesAux(prmDllEtq: Pointer): Boolean; stdcall; External 'libEditorEtiquetas.dll' delayed;

implementation

Procedure MsgErroDllEtiquetas;
Begin
  pMensagensErro('Não foi possível carregar a biblioteca libEditorEtiquetas.' + #13#10 +
                 'Verifique se a Dll existe no diretório do Autcom e tente novamente.' + #13#10 +
                 'Caso o problema persista, entre em contato com o responsável do Sistema AUTCOM.','[fimprimeetiquetas]');
End;

(*
Function fCarregaEditorEtiquetas: Boolean;
  Var
    dxInitializeEti: procedure;
Begin
  Try
    If objEditorEtiquetas = 0 Then
    Begin
      objEditorEtiquetas := LoadLibrary('libEditorEtiquetas.dll');

      If objEditorEtiquetas > 0 Then
      Begin
        dxInitializeEti := GetProcAddress(objEditorEtiquetas, 'dxInitializeEti');
        dxInitializeEti;
      End;
    End;

    Result := objEditorEtiquetas > 0;

    If Not Result Then
      MsgErroDllEtiquetas;

  Except
    MsgErroDllEtiquetas;
    Result := False;
  End;
End;
*)

function fImprimeEtiqueta(prmDllRel: TParamDllEtiquetas; strNomFun: String = 'fimprimeetiquetas'): Boolean;
//  Var
//    prcProc: TFunctionRelatorio;
Begin
  Result  := False;

  Try
//    If fCarregaEditorEtiquetas Then
    Begin

      With prmDllRel Do
      Begin
        pIniVariaveis(varRecVar);
        pIniModulos(modRecMod);
      //  pIniciaLogLeak(intDebugH, 'libEditorEtiquetas');
      End;

     (*
      prcProc := GetProcAddress(objEditorEtiquetas, PChar(strNomFun));

      If Assigned(prcProc)  Then
      Begin
        Result := prcProc(prmDllRel);
      End
      Else
        MsgErroDllFuncaoEtiquetas(strNomFun);
      *)

      If SameText(strNomFun, 'fimprimeetiquetas') Then
        Result := fimprimeetiquetas(prmDllRel)

      Else If SameText(strNomFun, 'fimprimeetiquetaitens') Then
        Result := fimprimeetiquetaitens(prmDllRel)

      Else If SameText(strNomFun, 'fimprimeetiquetaentradamerc') Then
        Result := fimprimeetiquetaentradamerc(prmDllRel)

      Else If SameText(strNomFun, 'fImprimeEtiquetaGeral') Then
        Result := fImprimeEtiquetaGeral(prmDllRel)

      Else If SameText(strNomFun, 'fImprimeEtiquetasLoteProduto') Then
        Result := fImprimeEtiquetasLoteProduto(prmDllRel)
      Else If SameText(strNomFun, 'fImprimeEtiquetasSeparacaoQtdRestante') Then
        Result := fImprimeEtiquetasSeparacaoQtdRestante(prmDllRel)

      Else If SameText(strNomFun, 'fImprimeEtiquetasRastreamentoProduto') Then
        Result := fImprimeEtiquetasRastreamentoProduto(prmDllRel)

      Else If SameText(strNomFun, 'fImprimeEtiquetaUnidadesRestantesAux') Then
        Result := fImprimeEtiquetaUnidadesRestantesAux(prmDllRel)

      Else If SameText(strNomFun, 'pimprimeetiquetamontagemcaixas') Then
      Begin
        pImprimeEtiquetaMontagemCaixas(prmDllRel);
        Result := True;
      End

      Else
        pMensagemOk('Erro interno: Função ' + strNomFun + ' não registrada no sistema!')

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      MsgErroDllEtiquetas;
    End;
  End;
end;

(*
function fSVN_RevisionEditor: String;
  Var
    fSVN_RevisionEditorEtiq: function: String; stdcall;
Begin

  Try
//    If fCarregaEditorEtiquetas Then
    Begin
      fSVN_RevisionEditorEtiq := GetProcAddress(objEditorEtiquetas, 'fSVN_RevisionEditorEtiq');

      If Assigned(fSVN_RevisionEditorEtiq) Then
        Result := fSVN_RevisionEditorEtiq

      Else MsgErroDllFuncaoEtiquetas('fSVN_RevisionEditorEtiq');
    End;

  Except
    On E: Exception Do
      MsgErroDllEtiquetas;
  End;

End;
*)

procedure pGridDocumento;
  Var
    prmDllRel: TParamDllEtiquetas;
//    pGridDocumentos: TProcedureRelatorio;
Begin

  Try
//    If fCarregaEditorEtiquetas Then
    Begin
      prmDllRel := TParamDllEtiquetas.Create;
      With prmDllRel Do
      Begin
        arrPrxCod := arrProCod;
        pIniVariaveis(varRecVar);
        pIniModulos(modRecMod);
      End;

      (*
      pGridDocumentos := GetProcAddress(objEditorEtiquetas, 'pGridDocumentos');

      If Assigned(pGridDocumentos) Then
        pGridDocumentos(prmDllRel)
      Else
        MsgErroDllFuncaoEtiquetas('pGridDocumentos');
      *)


      pGridDocumentos(prmDllRel);
      FreeAndNil(prmDllRel);
    End;

  Except
    On E: Exception Do
    Begin
      MsgErroDllEtiquetas;
    End;
  End;

end;

{*******************************************************************}
{* FUNÇÃO QUE GERA ETIQUETA DE PRODUTOS COM OBRIGATORIEDADE DE CPF *}
{****************************************************************MA*}
procedure pEtiItemCPF;
  Var
    prmDllRel: TParamDllEtiquetas;
//    pEtiquetasItemCPF: TProcedureRelatorio;
Begin
  Try
//    If fCarregaEditorEtiquetas Then
    Begin
      prmDllRel := TParamDllEtiquetas.Create;
      With prmDllRel Do
      Begin
        arrPrxCod := arrProCod;
        pIniVariaveis(varRecVar);
        pIniModulos(modRecMod);
      End;

  //    pEtiquetasItemCPF := GetProcAddress(objEditorEtiquetas, 'pEtiquetasItemCPF');

      pEtiquetasItemCPF(prmDllRel);

      FreeAndNil(prmDllRel);
    End;

  Except
    On E: Exception Do
    Begin
      MsgErroDllEtiquetas;
    End;
  End;

end;

procedure pGeraEtiquetaCaixas;
  Var
    prmDllRel: TParamDllEtiquetas;
Begin
  Try
    prmDllRel := TParamDllEtiquetas.Create;
    With prmDllRel Do
    Begin
      arrPrxCod := arrProCod;
      pIniVariaveis(varRecVar);
      pIniModulos(modRecMod);
    End;
    pImprimeEtiquetaCaixas(prmDllRel);
    FreeAndNil(prmDllRel);
  Except
    On E: Exception Do
    Begin
      MsgErroDllEtiquetas;
    End;
  End;

end;

procedure pGeraEtiquetaMontagemCaixas(cdsDados: TUniClientDataSet; blnPreview: Boolean);
  Var
    prmDllRel: TParamDllEtiquetas;
Begin
  Try
    prmDllRel := TParamDllEtiquetas.Create;
    With prmDllRel Do
    Begin
      cdsDadosEtiqueta := cdsDados;
      blnImpEti := blnPreview;
      arrPrxCod := arrProCod;
      pIniVariaveis(varRecVar);
      pIniModulos(modRecMod);
    End;
    pImprimeEtiquetaMontagemCaixas(prmDllRel);
    FreeAndNil(prmDllRel);
  Except
    On E: Exception Do
    Begin
      MsgErroDllEtiquetas;
    End;
  End;

end;

procedure pEditorEtiqueta(tpeTipEti: TTipoEtiqueta; Var strCodLayDoc: String; srTipImp: String = 'J');
  Var
    prmDllRel: TParamDllEtiquetas;
//    peditoretiquetas: TProcedureRelatorio;
Begin
  Try
//    If fCarregaEditorEtiquetas Then
    Begin
      prmDllRel := TParamDllEtiquetas.Create;
      With prmDllRel Do
      Begin
        {$WARN SYMBOL_PLATFORM OFF}
        intDebugH := DebugHook;
        {$WARN SYMBOL_PLATFORM ON}
        arrPrxCod    := arrProCod;
        tpeTipEtq    := tpeTipEti;
        strTipImp    := srTipImp;
        strLayDoc    := strCodLayDoc;

        pIniVariaveis(varRecVar);
        pIniModulos(modRecMod);
      End;

  //    peditoretiquetas := GetProcAddress(objEditorEtiquetas, 'peditoretiquetas');

      peditoretiquetas(prmDllRel);

      strCodLayDoc := prmDllRel.strLayDoc;

      FreeAndNil(prmDllRel);
    End;

  Except
    On E: Exception Do
    Begin
      MsgErroDllEtiquetas;
    End;
  End;
end;

initialization
end.

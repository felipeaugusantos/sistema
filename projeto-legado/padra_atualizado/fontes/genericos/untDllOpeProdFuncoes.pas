unit untDllOpeProdFuncoes;

interface
{$WARN SYMBOL_PLATFORM OFF}

Uses Classes, Forms, SysUtils, Uni, Windows, untFuncoesSimples, untDllOpeProd,
     untILiberacao, untLiberacao, untFuncoesRel, untTypesSistema, untMovger;


  {****** Operacoes referentes a produtos *******}
  procedure pOpeProdutos(prmDllOpe: Pointer); stdcall; External 'libOpeRefProd.dll' delayed;
  procedure pOpeProdutosCarreg(prmDllOpe: Pointer); stdcall; External 'libOpeRefProd.dll' delayed;
  function fSVN_RevisionOpeRefProd: String; stdcall; External 'libOpeRefProd.dll' delayed;
  function fCallConfirmaEfetivacaoPreco(prmDllOpe: Pointer; dtaDtaPre: TDate): Boolean; stdcall; External 'libOpeRefProd.dll' delayed;

  procedure pOpeProd(frmTipOpeProd: TOpeProd; strCodTab: String = ''; HandleOrigin: HWND = 0; strCodIte: String = '');

  procedure pOpeProdLocFisTransf(Var strCodBar: String);
  procedure pOpeProdParam(frmTipOpeProd: TOpeProd; Var varParametros: TOpeProdParam);
  procedure pIniVariaveis(Var varRecVar: TOpeProdVariaveis);
  procedure pIniModulos(Var modRecMod: TOpeProdModulos);
  function fConfirmaEfetivacaoPreco(dtaDtaPre: TDate): Boolean;

implementation

uses
  untModulo, untFuncIns;


(*
function fSVN_RevisionOpeRef: String;
  Var
    Handle: THandle;
    fSVN_RevisionOpeRefProd: function: String; stdcall;
Begin
  Result := '';
  Handle := 0;

  Try
    Handle := GetModuleHandle('libOpeRefProd.dll');

    If Handle = 0 Then
    Begin
      Handle := LoadLibrary('libOpeRefProd');

      If Handle <> 0 Then
      Begin
        @fSVN_RevisionOpeRefProd := GetProcAddress(Handle,'fSVN_RevisionOpeRefProd');
        If @fSVN_RevisionOpeRefProd <> Nil Then
        Begin
          Result := fSVN_RevisionOpeRefProd;
        End
        Else Raise Exception.Create('Função fSVN_RevisionOpeRefProd não encontrada');

      End
      Else Raise Exception.Create('DLL libOpeRefProd não encontrada');

    End
    Else
    Begin
      @fSVN_RevisionOpeRefProd := GetProcAddress(Handle,'fSVN_RevisionOpeRefProd');
      Result := fSVN_RevisionOpeRefProd;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'DLL libOpeRefProd');
    End;
  End;

  FreeLibrary(Handle);
End;
*)

procedure pOpeProdLocFisTransf(Var strCodBar: String);
  Var
    varParametro : TOpeProdParam;
Begin
  FillChar(varParametro, SizeOf(varParametro), #0);
  varParametro.blnTraBar := True;
  pOpeProdParam(DigCodBarLocFis, varParametro);
  strCodBar := varParametro.strCodBar;
End;

procedure pIniModulos(Var modRecMod: TOpeProdModulos);
Begin
  With modRecMod Do
    Banco := frmModulo.GetCurrentConnection;
End;

procedure pIniVariaveis(Var varRecVar: TOpeProdVariaveis);
Begin
  With varRecVar Do
  Begin
    dtaVSDate := VS_Date;
    strLogUsu := ShortString(strLoginUsuarioLogado);
    strDesUsu := ShortString(strDescriUsuarioLogado);
    strEmpUsu := String(strEmpAcessoUsuarioLogado);
    strEmpEst := String(strEmpEstUsuarioLogado);
    strEmpCod := ShortString(String(VS_strCodEmp));
    objTraceViewer := untFuncoesSimples.VS_objTraceViewer;
    blnModoClassico := blnUsuarioLogadoUtilizaModoClassico;
    utcRegist := utcRegistros;
  End;
End;

Procedure pOpeProdParam(frmTipOpeProd: TOpeProd; Var varParametros: TOpeProdParam);
  Var
    objOpeProd : TparamOpeProd;
Begin
  Try
    objOpeProd := TparamOpeProd.Create;
    With objOpeProd Do
    Begin
      {$WARN SYMBOL_PLATFORM OFF}
      intDebugH := DebugHook;
      {$WARN SYMBOL_PLATFORM ON}
      frmTipOpe := frmTipOpeProd;
            pIniVariaveis(VarRecVar);
      pIniModulos(ModRecMod);
      varParam := varParametros;
      PrcIniciaProcessoDivisaoDeChapa := untFuncoesSimples.PrcIniciaProcessoDivisaoDeChapa;
      PrcSuspenteTimerPrincipal := untFuncoesSimples.PrcSuspenteTimerPrincipal;
      FuncExternaprcRetCfgRelacionadaArquivo := ProcRetCfgRelacionadaArquivo;
      Form :=  untFuncoesSimples.pnlPanelItemPrecoProduto;
      objLibera := TLiberacao.Create;
      objFuncIns := TObjFuncIns.Create;
    End;

    pOpeProdutos(objOpeProd);

    varParametros := objOpeProd.varParam;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'DLL libOpeRefProd');
    End;
  End;

End;

procedure pOpeProd(frmTipOpeProd: TOpeProd; strCodTab: String = ''; HandleOrigin: HWND = 0; strCodIte: String = '');
  Var
    varParametro : TOpeProdParam;
Begin
  FillChar(varParametro, SizeOf(varParametro), #0);
  varParametro.strCodTab := strCodTab;
  varParametro.prcExecutaRelatorio :=  prcExecutaRelatorio;
  varParametro.HandleOrigin := HandleOrigin;
  varParametro.strCodIte := strCodIte;
  varParametro.fGMovGer := fgravaMovGer;
  varParametro.fGMovDet := fgravaMovDet;
  pOpeProdParam(frmTipOpeProd, varParametro);
End;

function fConfirmaEfetivacaoPreco(dtaDtaPre: TDate): Boolean;
  Var
    objOpeProd : TparamOpeProd;
    varParametros : TOpeProdParam;
Begin
  Result := False;
  Try
    objOpeProd := TparamOpeProd.Create;
    FillChar(varParametros, SizeOf(varParametros), #0);
    With objOpeProd Do
    Begin
      {$WARN SYMBOL_PLATFORM OFF}
      intDebugH := DebugHook;
      {$WARN SYMBOL_PLATFORM ON}
      pIniVariaveis(VarRecVar);
      pIniModulos(ModRecMod);
      varParam := varParametros;
      objLibera := TLiberacao.Create;
      objFuncIns := TObjFuncIns.Create;
      PrcIniciaProcessoDivisaoDeChapa := untFuncoesSimples.PrcIniciaProcessoDivisaoDeChapa;
      PrcSuspenteTimerPrincipal := untFuncoesSimples.PrcSuspenteTimerPrincipal;

    End;
    Result := fCallConfirmaEfetivacaoPreco(objOpeProd, dtaDtaPre);
    varParametros := objOpeProd.varParam;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'DLL libOpeRefProd');
    End;
  End;
End;


end.

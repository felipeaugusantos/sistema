unit untDllTransfCodFuncoes;

interface

Uses Classes, Forms, SysUtils, Uni, untDllTransfCod,
     Windows, untFuncoesSimples,untCfgRepositorio, UntFuncaoPortadores;


  function fSVN_RevisionTransfCod: String; stdcall; External 'libTransfCodigo.dll' delayed;
  procedure pTransCodigo(prmDllTra: Pointer); stdcall; External 'libTransfCodigo.dll' delayed;
  procedure pTransCodigoCarreg(prmDllTra: Pointer); stdcall; External 'libTransfCodigo.dll' delayed;

  procedure pTransfCod(frmTipTransf: TTransfCod);

implementation

uses untModulo;

procedure pTransfCod(frmTipTransf: TTransfCod);
  Var
    objTransf : TparamTransfCod;
    LarrCfgs: TArray<String>;
    LstrCfgs: String;
Begin

  if not fConfirmaTransfCodigo then
    exit;

  objTransf := TparamTransfCod.Create;

  try
    Try

      With objTransf Do
      Begin
        {$WARN SYMBOL_PLATFORM OFF}
        intDebugH := DebugHook;
        {$WARN SYMBOL_PLATFORM ON}
        frmTipTra := frmTipTransf;
        pIniVariaveis(VarRecVar);
        FuncExternaprcRetCfgRelacionadaArquivo := ProcRetCfgRelacionadaArquivo;
        pIniModulos(ModRecMod);
      End;

      LarrCfgs := fRetornarCfgsPortador(arrCamposCfg);
      LstrCfgs := fMontarInCfgsPortador(LarrCfgs);

      objTransf.arrCfgsPortadorIn := PChar(LstrCfgs);

      pTransCodigo(objTransf);
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'DLL libTrasfCodigo');
      End;
    End;
  finally
    FreeAndNil(objTransf);
  end;
End;

end.

unit untDominioSistemas;

interface

uses
  Forms,
  Classes,
  SysUtils,
  Uni,
  untDllDominioSistemas,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.SysStyles,
  dxCore,
  untILibDominioSistemasWrapper ;

procedure pShowFormDominio(AprmDllTra: Pointer); stdcall;
procedure pInicializaObjetoLibDominioSistemas(AObjetoLibDominioSistemas: ILibDominioSistemas); StdCall;
procedure dxInitialize; StdCall;
procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;

procedure pChamaForms(AParams: Pointer);

implementation

uses
 DominioSistemas.View.ProcessarDocumentos, untDominioSistemasFuncoes,
 untLibDominioSistemasFuncoes ;

procedure dxInitialize; StdCall;
begin
  dxCore.dxInitialize;
end ;

procedure SetStyleAutcom(AModoClassico: Boolean); StdCall;
Begin
  untLibDominioSistemasFuncoes.VS_AutcomModoClassico := AModoClassico;
  TLibDominioSistemasFuncoes.CarregaEstiloAutcom;
End;

procedure pShowFormDominio(AprmDllTra: Pointer); stdcall;
Var
  objDll : TParamDominio;
Begin
  Try
    objDll := AprmDllTra;
    pChamaForms(objDll);
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[pShowFormDominio]');
    End;
  End;
end ;


procedure pInicializaObjetoLibDominioSistemas(AObjetoLibDominioSistemas: ILibDominioSistemas); StdCall;
begin
  untDominioSistemasFuncoes.VS_FuncoesExternas := AObjetoLibDominioSistemas ;
end ;

procedure pChamaForms(AParams: Pointer);
Var
  LobjDllDominio : TParamDominio;
  LfrmForm: TForm;
Begin
  LfrmForm := nil;
  LobjDllDominio := AParams;
  With LobjDllDominio Do
  Begin
    Case frmTipCad of
      tpdIntegracaoAPI :
                        begin
                          VS_FuncoesExternas.pICriarForm(TfrmDominioSistemasProcessarDocumentos, LfrmForm);
                        end ;
    End;
  End;
end ;

Initialization

Finalization
  dxFinalize;

end.

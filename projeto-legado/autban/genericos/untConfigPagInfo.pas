unit untConfigPagInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, untMemo, Vcl.StdCtrls, Vcl.ExtCtrls, dxScreenTip, cxClasses,
  dxCustomHint, cxHint, Vcl.Buttons, BitBtnLockedIncrem, untPai;

type
 TConfigPagInfo = class
    private
      procedure pInfoMessage;
    public
      class procedure pShowInfo;
    end;

implementation

{ TConfigPagInfo }

procedure TConfigPagInfo.pInfoMessage;
var
  strInformativo: String;
begin
  strInformativo := ' O PLANO DE CONTAS A SER UTILIZADO NA BAIXA DE DUPLICATAS' + sLineBreak
          +' É DE ACORDO COM A CONFIGURAÇÃO [CFG_CTP_AS_].' + sLineBreak + sLineBreak
          +' QUANDO CONFIGURADO "SINTÉTICO", UTILIZA O PLANO DE CONTAS' + sLineBreak
          +' CADASTRO NA RESPECTIVA CARTEIRA DO AUTBAN.' + sLineBreak + sLineBreak
          +' QUANDO CONFIGURADO "ANALITICO", UTILIZA O PLANO DE CONTAS' + sLineBreak
          +' CADASTRADO DENTRO DA DUPLICATA NA MANUTENÇÃO' + sLineBreak
          +' DO CONTAS A PAGAR.' + sLineBreak  + sLineBreak
          +' OBS.: CASO NÃO TENHA PLANO DE CONTAS CADASTRADO NA DUPLICATA' + sLineBreak
          +' E A BAIXA É "ANALITICA", TAMBÉM SERÁ CONSIDERADO ' + sLineBreak
          +' O DA CARTEIRA DO AUTBAN.';

  TfrmMemo.pShowMessage(' INFORMAÇÕES REFERENTE AO PLANO DE CONTAS' + sLineBreak
                        + sLineBreak + strInformativo,11,false,670,350);
end;

class procedure TConfigPagInfo.pShowInfo;
begin
  with Self.Create do
  try
    pInfoMessage;
  finally
    Free;
  end;
end;

end.

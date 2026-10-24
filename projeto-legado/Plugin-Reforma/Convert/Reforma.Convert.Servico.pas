unit Reforma.Convert.Servico;

// Abre a tela do Convert (REFTRI-02). O host ja validou acesso, empresa e servidor; aqui so a tela.

interface

uses
  Reforma.Contrato.Convert;

type
  TConvertServico = class
  public
    class procedure Abrir(const Host: IReformaConvertHost); static;
    // Usuario, 2026-10-07: o Convert so fica disponivel para o operador 998 ou a partir de 26/12/2026.
    class function Liberado(const Operador: string; const Data: TDateTime): Boolean; static;
  end;

implementation

uses
  System.SysUtils,
  Vcl.Forms,
  Reforma.View.Estilo,
  Reforma.View.Convert;

class function TConvertServico.Liberado(const Operador: string; const Data: TDateTime): Boolean;
begin
  Result := (Trim(Operador) = '998') or (Trunc(Data) >= EncodeDate(2026, 12, 26));
end;

class procedure TConvertServico.Abrir(const Host: IReformaConvertHost);
var
  HandleAnterior: THandle;
  Tela: TfrmReformaConvert;
begin
  // O menu ja some fora da regra (fReformaConvertDisponivel); aqui e a mesma trava para quem chegar pela tela.
  if not Liberado(Host.Operador, Host.DataHora) then
  begin
    Host.Mensagem('Ativar Preços Reforma Tributária', 'Disponível a partir de 26/12/2026.');
    Exit;
  end;

  // Estilo antes de criar o form (mesma regra de pReformaInicializar; ja ativo, nao faz nada). Application.Handle da
  // DLL = janela do autcom, para a tela modal ficar sobre ele.
  pAtivarEstilo(Host.EstiloVisual);
  HandleAnterior := Application.Handle;
  Application.Handle := Host.JanelaPrincipal;
  try
    Tela := TfrmReformaConvert.Criar(Host);
    try
      Tela.ShowModal;
    finally
      Tela.Free;
    end;
  finally
    Application.Handle := HandleAnterior;
  end;
end;

end.

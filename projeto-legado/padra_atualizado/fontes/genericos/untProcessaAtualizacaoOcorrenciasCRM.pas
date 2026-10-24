unit untProcessaAtualizacaoOcorrenciasCRM;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, untTypesCRM, untAtualizaOcorrenciasCRM,
  untFuncoesSimples,untGravando,cxProgressBar;

type
  EProcessaOcorrenciaCRM = class(Exception);

  // Model
  TModelDuplicata = record
    Numero: string;
    Especie: string;
    CodigoEmpresa: string;
    CodigoCliente: string;
    Parcela: string;
    CodigoOperador: string;
    DocumentoCliente: string;
    AcaoFatura: TAcaoFatCRM;
    Encerrar: Boolean;
    Reabre: Boolean;
    Excluir: Boolean;
    MensagemFinaliza: string;
    ValorBaixa: Double;
  end;

  // Controller
  TControllerDuplicatasPendentes = class
  private
    FListaDuplicatas: TList<TModelDuplicata>;
    class var FInstancia: TControllerDuplicatasPendentes;
    function GetCount: Integer;
    function ProcessarDuplicatasPendentes(pgbProgresso: TcxProgressBar): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AdicionarDuplicata(ANumero, AEspecie, ACodigoEmpresa, ACodigoCliente,
      AParcela, ACodigoOperador, ADocumentoCliente: string; AAcaoFatura: TAcaoFatCRM;
      AEncerrar: Boolean = False; AReabre: Boolean = False;
      AExcluir: Boolean = False; AMensagemFinaliza: string = '';
      AValorBaixa: Double = 0);

    procedure Processar;
    procedure LimparLista;

    property Count: Integer read GetCount;

    class function GetInstancia: TControllerDuplicatasPendentes;
    class procedure LiberarInstancia;
  end;

implementation

{ TControllerDuplicatasPendentes }

constructor TControllerDuplicatasPendentes.Create;
begin
  inherited Create;
  FListaDuplicatas := TList<TModelDuplicata>.Create;
end;

destructor TControllerDuplicatasPendentes.Destroy;
begin
  FListaDuplicatas.Free;
  inherited Destroy;
end;

procedure TControllerDuplicatasPendentes.AdicionarDuplicata(ANumero, AEspecie,
  ACodigoEmpresa, ACodigoCliente, AParcela, ACodigoOperador, ADocumentoCliente: string;
  AAcaoFatura: TAcaoFatCRM; AEncerrar: Boolean = False; AReabre: Boolean = False;
  AExcluir: Boolean = False; AMensagemFinaliza: string = ''; AValorBaixa: Double = 0);
var
  LDuplicata: TModelDuplicata;
begin
  try
    LDuplicata.Numero := ANumero;
    LDuplicata.Especie := AEspecie;
    LDuplicata.CodigoEmpresa := ACodigoEmpresa;
    LDuplicata.CodigoCliente := ACodigoCliente;
    LDuplicata.Parcela := AParcela;
    LDuplicata.CodigoOperador := ACodigoOperador;
    LDuplicata.DocumentoCliente := ADocumentoCliente;
    LDuplicata.AcaoFatura := AAcaoFatura;
    LDuplicata.Encerrar := AEncerrar;
    LDuplicata.Reabre := AReabre;
    LDuplicata.Excluir := AExcluir;
    LDuplicata.MensagemFinaliza := AMensagemFinaliza;
    LDuplicata.ValorBaixa := AValorBaixa;

    FListaDuplicatas.Add(LDuplicata);
  except
    on E: Exception do
      raise EProcessaOcorrenciaCRM.CreateFmt('Erro ao adicionar duplicata: %s', [E.Message]);
  end;
end;

procedure TControllerDuplicatasPendentes.Processar;
var
  LForm: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando,LForm);
  try
    LForm.fExecutarAcao := ProcessarDuplicatasPendentes;
    LForm.lblGravando.Caption := 'Aguarde... Atualizando CRM.';
    LForm.ShowModal;
  finally
    pFreeAndNil(LForm);
  end;
end;

function TControllerDuplicatasPendentes.ProcessarDuplicatasPendentes(
  pgbProgresso: TcxProgressBar): Boolean;
var
  LDuplicata: TModelDuplicata;
  LErros: TStringList;
begin
  Result := True;

  if FListaDuplicatas.Count = 0 then
    Exit;

  LErros := TStringList.Create;
  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := FListaDuplicatas.Count;

  try
    try
      for LDuplicata in FListaDuplicatas do
      begin
        try
          TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(
           LDuplicata.Numero,
           LDuplicata.Especie,
           LDuplicata.CodigoEmpresa,
           LDuplicata.CodigoCliente,
           LDuplicata.Parcela,
           LDuplicata.CodigoOperador,
           LDuplicata.DocumentoCliente,
           LDuplicata.AcaoFatura,
           LDuplicata.Encerrar,
           LDuplicata.Reabre,
           LDuplicata.Excluir,
           LDuplicata.MensagemFinaliza,
           LDuplicata.ValorBaixa
          );

          pStepStatusGravacao(pgbProgresso);
        except
          on E: Exception do
          begin
            pStepStatusGravacao(pgbProgresso);
            LErros.Add(Format('Duplicata %s: %s', [Concat(LDuplicata.Numero,LDuplicata.Parcela), E.Message]));
          end;
        end;
      end;

      if LErros.Count > 0 then
        pMensagensErro('Ocorreram inconsistências durante a atualização do CRM:' + sLineBreak + LErros.Text,
                       '[TControllerDuplicatasPendentes.ProcessarDuplicatasPendentes]');

    finally
      LimparLista;
    end;
  finally
    LErros.Free;
  end;
end;

procedure TControllerDuplicatasPendentes.LimparLista;
begin
  FListaDuplicatas.Clear;
end;

function TControllerDuplicatasPendentes.GetCount: Integer;
begin
  Result := FListaDuplicatas.Count;
end;

class function TControllerDuplicatasPendentes.GetInstancia: TControllerDuplicatasPendentes;
begin
  if not Assigned(FInstancia) then
    FInstancia := TControllerDuplicatasPendentes.Create;
  Result := FInstancia;
end;

class procedure TControllerDuplicatasPendentes.LiberarInstancia;
begin
  try
    if Assigned(FInstancia) then
    begin
      FInstancia.LimparLista;
      FInstancia.Free;
    end;
    FInstancia := nil;
  except
    on E: Exception do
      raise EProcessaOcorrenciaCRM.CreateFmt('Erro ao liberar instância: %s', [E.Message]);
  end;
end;

end.

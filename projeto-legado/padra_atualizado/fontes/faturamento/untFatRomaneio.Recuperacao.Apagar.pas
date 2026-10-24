unit untFatRomaneio.Recuperacao.Apagar;

interface

uses
  untRomGer, Romaneio.Types;

type
  TRomaneioRecuperacaoApagar = class
  private
    var FIdRestauracao: String;
    FDadosDet: TDadosDet;

    procedure ApagarDet;
    procedure VerificaCapa;

    procedure ApagarInternal(var AIdRestauracao: String; ADadosDet: TDadosDet);
  public
    class procedure Apagar(var AIdRestauracao: String; ADadosDet: TDadosDet);
  end;

implementation

uses
  System.SysUtils, System.Variants, Data.DB, Uni, untFuncoesSimples;

class procedure TRomaneioRecuperacaoApagar.Apagar(var AIdRestauracao: String; ADadosDet: TDadosDet);
var
  LApagar: TRomaneioRecuperacaoApagar;
begin
  LApagar := TRomaneioRecuperacaoApagar.Create;
  try
    LApagar.ApagarInternal(AIdRestauracao, ADadosDet);
  finally
    LApagar.Free;
  end;
End;

procedure TRomaneioRecuperacaoApagar.ApagarDet;
var
  qryRomGer: TUniQuery;
begin
  qryRomGer := fCriaQuery(Nil);
  try
    qryRomGer.SQL.Add('DELETE FROM ROMDET_RES ');
    qryRomGer.SQL.Add('WHERE DET_SEQGER = :SEQGER');
    qryRomGer.SQL.Add('  AND DET_NUMDOC = :NUMDOC');
    qryRomGer.SQL.Add('  AND DET_ESPDOC = :ESPDOC');
    qryRomGer.SQL.Add('  AND DET_CODEMP = :CODEMP');
    qryRomGer.SQL.Add('  AND DET_CODCLI = :CODCLI');
    qryRomGer.SQL.Add('  AND DET_TIP_FC = :TIP_FC');

    qryRomGer.ParamByName('SEQGER').AsString  := FIdRestauracao;
    qryRomGer.ParamByName('NUMDOC').AsString  := FDadosDet.NumeroDocumento;
    qryRomGer.ParamByName('ESPDOC').AsString  := FDadosDet.EspecieDocumento;
    qryRomGer.ParamByName('CODEMP').AsString  := FDadosDet.CodEmpresa;
    qryRomGer.ParamByName('CODCLI').AsString  := FDadosDet.CodCliente;
    qryRomGer.ParamByName('TIP_FC').AsString  := FDadosDet.Tip_FC;

    qryRomGer.ExecSql;
  finally
    FreeAndNil(qryRomGer);
  end;
end;

procedure TRomaneioRecuperacaoApagar.ApagarInternal(var AIdRestauracao: String;
  ADadosDet: TDadosDet);
begin
  FIdRestauracao := AIdRestauracao;
  FDadosDet := ADadosDet;

  ApagarDet;
  VerificaCapa;
end;

procedure TRomaneioRecuperacaoApagar.VerificaCapa;
var
  qryRomGer: TUniQuery;
begin
  qryRomGer := fCriaQuery(Nil);
  try
    qryRomGer.SQL.Add('SELECT DET_CODDET FROM ROMDET_RES ');
    qryRomGer.SQL.Add('WHERE DET_SEQGER = :SEQGER');

    qryRomGer.ParamByName('SEQGER').AsString  := FIdRestauracao;

    qryRomGer.Open;

    if qryRomGer.IsEmpty then
    begin
      qryRomGer.Close;
      qryRomGer.SQL.Clear;
      qryRomGer.SQL.Add('DELETE FROM ROMGER_RES ');
      qryRomGer.SQL.Add('WHERE GER_CODGER = :CODGER');

      qryRomGer.ParamByName('CODGER').AsString  := FIdRestauracao;

      qryRomGer.ExecSql;
    end;
  finally
    FreeAndNil(qryRomGer);
  end;
end;

end.

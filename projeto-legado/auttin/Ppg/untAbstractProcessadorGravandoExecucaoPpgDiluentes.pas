unit untAbstractProcessadorGravandoExecucaoPpgDiluentes;

interface

uses
  untIProcessadorGravandoExecucao, Uni, DB, Classes, SysUtils,
  untIGravando, Variants;

type
  TProcessadorGravandoExecucaoPpgDiluentes = class (TInterfacedObject, IProcessadorGravandoExecucao)
  public
    function GetDataSetOrigem: TDataSet;
    function GetSqlDestino: string;
    procedure GetTabelasVerificaProCod(const stlTabelas: TStrings);
    procedure GravarRegistro(const qryOrigem: TDataSet; const qryDestino: TDataSet);
    function IsRegistroExistente(const qryOrigem: TDataSet; const qryDestino: TDataSet): Boolean;
    procedure LimparTabelas;
    procedure RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando; const qryOrigem: TDataSet;
      const qryDestino: TDataSet);
    function fGetNomeGravacao: string;
  end;

implementation

uses untFuncoesSimples;

{ TProcessadorGravandoExecucaoPpgDiluentes }

function TProcessadorGravandoExecucaoPpgDiluentes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Diluentes';
end;

function TProcessadorGravandoExecucaoPpgDiluentes.GetDataSetOrigem: TDataSet;
//var
//  qryGen: TUniQuery;
begin
  Result := nil;
  try
    Try
      Result := fCriarQuery(' SELECT                                                                    ' +
                            '   ''2K'' AS DIL_LINHA_                                                    ' +
                            '   , ''BC'' AS DIL_SISTEM                                                  ' +
                            '   , ''P850-1492'' AS DIL_CODDIL                                           ' +
                            '   , 0.89 AS DIL_PESESP                                                    ' +
                            '   , 100 AS DIL_MINIMO                                                     ' +
                            '   , 100 AS DIL_MAXIMO                                                     ' +
                            ' UNION  SELECT ''2K'', ''BC3CT'', ''P850-1492'', 0.89,100,100              ' +
                            ' UNION  SELECT ''2K'', ''DG'', ''P850-1492'', 0.89,15,20                   ' +
                            ' UNION  SELECT ''ACS'', ''CRI'', ''C850-3800'', 0.87,100,150               ' +
                            ' UNION  SELECT ''ACS'', ''LAC'', ''C850-3800'', 0.87,100,120               ' +
                            ' UNION  SELECT ''ACS'', ''POL'', ''C850-0600'', 0.89,0,0                   ' +
                            ' UNION  SELECT ''ACS'', ''PU'', ''C850-0600'', 0.89,20,25                  ' +
                            ' UNION  SELECT ''ACS'', ''SIN'', ''C850-1100'', 0.85,20,30                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''280'', ''F371'', 0.89,20,25                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''280'', ''F372'', 0.89,20,25                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''280'', ''F373'', 0.89,20,25                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''290'', ''F371'', 0.89,20,25                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''290'', ''F372'', 0.89,20,25                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''290'', ''F373'', 0.89,20,25                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''350'', ''F371'', 0.89,20,25                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''350'', ''F372'', 0.89,20,25                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''350'', ''F373'', 0.89,20,25                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''360'', ''F371'', 0.89,20,25                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''360'', ''F372'', 0.89,20,25                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''360'', ''F373'', 0.89,20,25                 ' +
                            ' UNION  SELECT ''DELFLEET'', ''BC'', ''F371'', 0.89,25,30                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''BC'', ''F372'', 0.89,25,30                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''BC'', ''F373'', 0.89,25,30                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''BC 3CT'', ''F371'', 0.89,25,30              ' +
                            ' UNION  SELECT ''DELFLEET'', ''BC 3CT'', ''F372'', 0.89,25,30              ' +
                            ' UNION  SELECT ''DELFLEET'', ''BC 3CT'', ''F373'', 0.89,25,30              ' +
                            ' UNION  SELECT ''DELFLEET'', ''DG'', ''F371'', 0.89,20,25                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''DG'', ''F372'', 0.89,20,25                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''DG'', ''F373'', 0.89,20,25                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''EADM'', ''F371'', 0.89,25,30                ' +
                            ' UNION  SELECT ''DELFLEET'', ''EADM'', ''F372'', 0.89,25,30                ' +
                            ' UNION  SELECT ''DELFLEET'', ''EADM'', ''F373'', 0.89,25,30                ' +
                            ' UNION  SELECT ''DELFLEET'', ''EP'', ''F371'', 0.89,20,25                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''EP'', ''F372'', 0.89,20,25                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''EP'', ''F373'', 0.89,20,25                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''ER'', ''F371'', 0.89,20,30                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''ER'', ''F372'', 0.89,20,30                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''ER'', ''F373'', 0.89,20,30                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''ERLC'', ''F371'', 0.89,20,30                ' +
                            ' UNION  SELECT ''DELFLEET'', ''ERLC'', ''F372'', 0.89,20,30                ' +
                            ' UNION  SELECT ''DELFLEET'', ''ERLC'', ''F373'', 0.89,20,30                ' +
                            ' UNION  SELECT ''DELFLEET'', ''NC'', ''F371'', 0.89,100,120                ' +
                            ' UNION  SELECT ''DELFLEET'', ''NC'', ''F372'', 0.89,100,120                ' +
                            ' UNION  SELECT ''DELFLEET'', ''NC'', ''F373'', 0.89,100,120                ' +
                            ' UNION  SELECT ''DELFLEET'', ''NCLC'', ''F371'', 0.89,100,120              ' +
                            ' UNION  SELECT ''DELFLEET'', ''NCLC'', ''F372'', 0.89,100,120              ' +
                            ' UNION  SELECT ''DELFLEET'', ''NCLC'', ''F373'', 0.89,100,120              ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMT'', ''F371'', 0.89,20,25                ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMT'', ''F372'', 0.89,20,25                ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMT'', ''F373'', 0.89,20,25                ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMT40'', ''F371'', 0.89,20,25              ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMT40'', ''F372'', 0.89,20,25              ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMT40'', ''F373'', 0.89,20,25              ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMT60'', ''F371'', 0.89,20,25              ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMT60'', ''F372'', 0.89,20,25              ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMT60'', ''F373'', 0.89,20,25              ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMTLC'', ''F371'', 0.89,20,25              ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMTLC'', ''F372'', 0.89,20,25              ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMTLC'', ''F373'', 0.89,20,25              ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMTLC40'', ''F371'', 0.89,20,25            ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMTLC40'', ''F372'', 0.89,20,25            ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMTLC40'', ''F373'', 0.89,20,25            ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMTLC60'', ''F371'', 0.89,20,25            ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMTLC60'', ''F372'', 0.89,20,25            ' +
                            ' UNION  SELECT ''DELFLEET'', ''PUMTLC60'', ''F373'', 0.89,20,25            ' +
                            ' UNION  SELECT ''DELFLEET'', ''QD'', ''F371'', 0.89,20,25                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''QD'', ''F372'', 0.89,20,25                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''QD'', ''F373'', 0.89,20,25                  ' +
                            ' UNION  SELECT ''DELFLEET'', ''QDLC'', ''F371'', 0.89,20,25                ' +
                            ' UNION  SELECT ''DELFLEET'', ''QDLC'', ''F372'', 0.89,20,25                ' +
                            ' UNION  SELECT ''DELFLEET'', ''QDLC'', ''F373'', 0.89,20,25                ' +
                            ' UNION  SELECT ''DELTRON'', ''BC'', ''D807'', 0.88,100,100                 ' +
                            ' UNION  SELECT ''DELTRON'', ''BC 3CT'', ''D807'', 0.88,100,100             ' +
                            ' UNION  SELECT ''DELTRON'', ''DG'', ''D807'', 0.88,20,25                   ' +
                            ' UNION  SELECT ''DULON'', ''NC'', ''DUL2043'', 0.87,100,120                ' +
                            ' UNION  SELECT ''DULON'', ''POLIEST'', ''DUL2011'', 0.89,0,0               ' +
                            ' UNION  SELECT ''DULON'', ''PU'', ''DUL2011'', 0.89,20,25                  ' +
                            ' UNION  SELECT ''DULON'', ''SINTET'', ''DUL2009'', 0.85,20,30              ' +
                            ' UNION  SELECT ''EHP'', ''3CT'', ''T494'', 1.00,20,30                      ' +
                            ' UNION  SELECT ''EHP'', ''MET'', ''T494'', 1.00,20,25                      ' +
                            ' UNION  SELECT ''EHP'', ''SOLID'', ''T494'', 1.00,10,15                    ' +
                            ' UNION  SELECT ''ZYNAMIX'', ''EPOXI'', ''C850-9702'', 0.89,20,25           ' +
                            ' UNION  SELECT ''ZYNAMIX'', ''EPOXI'', ''C850-9701'', 0.89,20,25           ' +
                            ' UNION  SELECT ''ZYNAMIX'', ''NITROCELULOSE'', ''C850-9702'', 0.89,100,120 ' +
                            ' UNION  SELECT ''ZYNAMIX'', ''NITROCELULOSE'', ''C850-9701'', 0.89,100,120 ' +
                            ' UNION  SELECT ''ZYNAMIX'', ''POLIESTER'', ''C850-9702'', 0.89,0,0         ' +
                            ' UNION  SELECT ''ZYNAMIX'', ''POLIESTER'', ''C850-9701'', 0.89,0,0         ' +
                            ' UNION  SELECT ''ZYNAMIX'', ''PU ACR'', ''C850-9702'', 0.89,20,25          ' +
                            ' UNION  SELECT ''ZYNAMIX'', ''PU ACR'', ''C850-9701'', 0.89,20,25          ' +
                            ' UNION  SELECT ''ZYNAMIX'', ''PU ALQ'', ''C850-9702'', 0.89,20,25          ' +
                            ' UNION  SELECT ''ZYNAMIX'', ''PU ALQ'', ''C850-9701'', 0.89,20,25          ' +
                            ' UNION  SELECT ''ZYNAMIX'', ''SINT'', ''C850-9704'', 0.85,20,30            ' +
                            ' UNION  SELECT ''EHP'', ''MICA'', ''T494'', 1.00,20,25                     ');

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  finally
//    FreeAndNil(qryGen);
  end;
end;

function TProcessadorGravandoExecucaoPpgDiluentes.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM PPG_CADDIL';
end;

procedure TProcessadorGravandoExecucaoPpgDiluentes.GetTabelasVerificaProCod(const stlTabelas: TStrings);
begin
  stlTabelas.Text := 'PPG_CADDIL';
end;

procedure TProcessadorGravandoExecucaoPpgDiluentes.GravarRegistro(const qryOrigem, qryDestino: TDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('DIL_LINHA_').AsString := qryOrigem.FieldByName('DIL_LINHA_').AsString;
  qryDestino.FieldByName('DIL_SISTEM').AsString := qryOrigem.FieldByName('DIL_SISTEM').AsString;
  qryDestino.FieldByName('DIL_CODDIL').AsString := qryOrigem.FieldByName('DIL_CODDIL').AsString;
  qryDestino.FieldByName('DIL_PESESP').AsFloat := qryOrigem.FieldByName('DIL_PESESP').AsFloat;
  qryDestino.FieldByName('DIL_MINIMO').AsFloat := qryOrigem.FieldByName('DIL_MINIMO').AsFloat;
  qryDestino.FieldByName('DIL_MAXIMO').AsFloat := qryOrigem.FieldByName('DIL_MAXIMO').AsFloat;
  qryDestino.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('PPG_CADDIL', VS_strCodEmp);
  qryDestino.FieldByName('DIL_CODEMP').AsString := VS_strCodEmp;
  qryDestino.Post;
end;

function TProcessadorGravandoExecucaoPpgDiluentes.IsRegistroExistente(const qryOrigem, qryDestino: TDataSet): Boolean;
begin
  Result := qryDestino.Locate('DIL_LINHA_;DIL_SISTEM;DIL_CODDIL', VarArrayOf([
    qryOrigem.FieldByName('DIL_LINHA_').AsString,
    qryOrigem.FieldByName('DIL_SISTEM').AsString,
    qryOrigem.FieldByName('DIL_CODDIL').AsString
  ]), []);
end;

procedure TProcessadorGravandoExecucaoPpgDiluentes.LimparTabelas;
begin

end;

procedure TProcessadorGravandoExecucaoPpgDiluentes.RegistrarImpossivelGravarRegistro(const E: Exception; const gravando: IGravando;
  const qryOrigem, qryDestino: TDataSet);
begin
  gravando.Texto := Format('Não foi possivel gravar o diluente [%s - %s - %s], [%s: %s]',
    [qryOrigem.FieldByName('DIL_LINHA_').AsString,
    qryOrigem.FieldByName('DIL_SISTEM').AsString,
    qryOrigem.FieldByName('DIL_CODDIL').AsString,
    E.ClassName,
    E.Message]);
end;

end.

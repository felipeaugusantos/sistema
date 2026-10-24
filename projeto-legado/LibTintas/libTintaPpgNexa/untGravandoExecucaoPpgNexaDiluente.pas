
unit untGravandoExecucaoPpgNexaDiluente;

interface

uses
  untAbstractGravandoExecucaoPpgNexa, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, untTipoCadastro,
  Classes, StrUtils, ComObj, Data.DB;

type
  TGravandoExecucaoPpgNexaDiluente = class(TAbstractGravandoExecucaoPpgNexa)
  private
    function IsRegistroExistente(const qryOrigem: IDataSet; qryDestino: IDataSet): Boolean;
    procedure GravarRegistro(const qryOrigem: IDataSet; qryDestino: IDataSet);
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
    function GetSqlDestino(): string; override;
    function GetSqlOrigem(const strNomeArquivo: string;const stlTabelas: TStrings): string; override;
  end;

implementation

uses
  untIConfTinta, untStrUtils;

{ TGravandoExecucaoPpgNexaDiluente }

procedure TGravandoExecucaoPpgNexaDiluente.Executar(const gravando: IGravando);
var
  qryOrigem : IDataSet;
  qryDestino: IDataSet;
begin
  Try
    Try
      gravando.Texto := 'Verificando path dos arquivos...';

      if not FileExists(AnsiReplaceStr(fGetNomeArquivo, '"', '')) then
      begin
        gravando.Texto := Format('O arquivo [%s] não existe, ou não foi encontrado!', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
        gravando.Cancelar;
      end;

      if gravando.Status <> sgGravando then
      begin
        Exit;
      end;

      gravando.Texto := 'Path validado com sucesso...';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('PPX_CADDIL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      gravando.Texto := 'Carregando dados...';

      qryOrigem := TAutcomTintaFactory.Get.fGetDataSet;
      qryOrigem.Close;
      qryOrigem.SQL  := GetSqlOrigem('', Nil);
      qryOrigem.Open;


      qryDestino := TAutcomTintaFactory.Get.fGetDataSet;
      qryDestino.Close;
      qryDestino.SQL  := 'SELECT * FROM PPX_CADDIL';
      qryDestino.Open;

      if gravando.Status <> sgGravando then
      begin
        Exit;
      end;

      gravando.Texto := 'Dados carregados com sucesso...';

      gravando.Texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(fGetNomeArquivo, '"', '')]);
      gravando.RegistrarProgresso(0, 0, 0);

      qryOrigem.First;

      while (not qryOrigem.Eof) and (gravando.Status = sgGravando) do
      begin
        Try
          Try

            if gravando.Status <> sgGravando then
            begin
              Exit;
            end;

            if not IsRegistroExistente(qryOrigem, qryDestino) then
            begin
              GravarRegistro(qryOrigem, qryDestino);
            end;

          Except
            on E: Exception do
            begin
              gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
            end;
          End;
        Finally
          qryOrigem.Next;
          gravando.RegistrarProgresso(1, qryOrigem.RecNo, qryOrigem.RecordCount);
        End;
      end;

    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;


function TGravandoExecucaoPpgNexaDiluente.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Diluente';
end;

function TGravandoExecucaoPpgNexaDiluente.GetSqlDestino: string;
begin
  Result := 'SELECT * FROM PPX_CADDIL';
end;

function TGravandoExecucaoPpgNexaDiluente.GetSqlOrigem(const strNomeArquivo: string;
  const stlTabelas: TStrings): string;
begin
  Result := ' SELECT                                                                                    ' +
            '   ''DELTRON(LA)'' AS DIL_LINHA_                                                           ' +
            '   , ''BC MS METALICO'' AS DIL_SISTEM                                                      ' +
            '   , ''D807'' AS DIL_CODDIL                                                                ' +
            '   , 0.88 AS DIL_PESESP                                                                    ' +
            '   , 50 AS DIL_MINIMO                                                                      ' +
            '   , 50 AS DIL_MAXIMO                                                                      ' +
            ' UNION  SELECT ''DELTRON(LA)'', ''BC MS METALICO 3CT'', ''D807'', 0.88, 50,50              ' +
            ' UNION  SELECT ''DELTRON(LA)'', ''BC MS SOLIDO'', ''D807'', 0.88, 50,50                    ' +
            ' UNION  SELECT ''DELTRON(LA)'', ''BC MS SOLIDO 3CT'', ''D807'', 0.88, 50,50                ' +
            ' UNION  SELECT ''DELTRON(LA)'', ''DN(LA) BC 3CT METALICO/PEROLIZADO'', ''D807'', 0.88, 100,100 ' +
            ' UNION  SELECT ''DELTRON(LA)'', ''DN(LA) BC 3CT SOLIDO'', ''D807'', 0.88, 100,100          ' +
            ' UNION  SELECT ''DELTRON(LA)'', ''DN(LA) BC METALICO/PEROLIZADO'', ''D807'', 0.88, 100,100 ' +
            ' UNION  SELECT ''DELTRON(LA)'', ''DN(LA) BC SOLIDO'', ''D807'', 0.88, 100,100              ' +
            ' UNION  SELECT ''DELTRON(LA)'', ''DN(LA) DG'', ''D807'', 0.88, 25,25                       ' +
            ' UNION  SELECT ''DELTRON(LA)'', ''DN(LA) DG PB'', ''D807'', 0.88, 25,25                    ' +
            ' UNION  SELECT ''DELTRON(LA)'', ''PERSONALIZADA'', ''D807'', 0.88, 25,25                   ' +
            ' UNION  SELECT ''ENVIROBASE HP'', ''ENVHP MET/MIC'', ''T494'', 1,20,30                     ' +
            ' UNION  SELECT ''ENVIROBASE HP'', ''ENVHP SOLIDO'', ''T494'', 1,10,10                      ' +
            ' UNION  SELECT ''ENVIROBASE HP'', ''ENVHP 3CT'', ''T494'', 1,20,30                         ' +
            ' UNION  SELECT ''ENVIROBASE HP'', ''PERSONALIZADA'', ''T494'', 1,0,100                     ' +
            ' UNION  SELECT ''ACS EVOLUTION (LA)'', ''ACS (LA) EVOLUTION PU'', ''C850-0600'', 0.89,5,15                   ' +
            ' UNION  SELECT ''ACS EVOLUTION (LA)'', ''ACS (LA) EVOLUTION PU COM CHUMBO'', ''C850-0600'', 0.89,5,15        ' +
            ' UNION  SELECT ''ACS EVOLUTION (LA)'', ''ACS (LA) EVOLUTION SIN COM CHUMBO'', ''C850-1100'', 0.85,15,20      ' +
            ' UNION  SELECT ''ACS EVOLUTION (LA)'', ''ACS (LA) EVOLUTION SINTETICO'', ''C850-1100'', 0.85,15,20           ' +
            ' UNION  SELECT ''ACS EVOLUTION (LA)'', ''ACS (LA) EVOLUTION LACA'', ''C850-3800'', 0.87,100,120              ' +
            ' UNION  SELECT ''ACS EVOLUTION (LA)'', ''ACS (LA) EVOLUTION LACA COM CHUMBO'', ''C850-3800'', 0.87,100,120   ' +
            ' UNION  SELECT ''ACS EVOLUTION (LA)'', ''PERSONALIZADA'', ''C850-0600'', 0.89,0,100                          ' +
            ' UNION  SELECT ''ACS EVOLUTION (LA)'', ''PERSONALIZADA'', ''C850-1100'', 0.85,0,100                          ' +
            ' UNION  SELECT ''ACS EVOLUTION (LA)'', ''PERSONALIZADA'', ''C850-3800'', 0.87,0,100                          ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 280'', ''F372'', 0.89,10,15                      ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 280'', ''F373'', 0.89,10,15                      ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 280'', ''F371'', 0.89,10,15                      ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 280LC'', ''F372'', 0.89,10,15                    ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 280LC'', ''F373'', 0.89,10,15                    ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 280LC'', ''F371'', 0.89,10,15                    ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 290'', ''F372'', 0.89,10,15                      ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 290'', ''F373'', 0.89,10,15                      ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 290'', ''F371'', 0.89,10,15                      ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 290LC'', ''F372'', 0.89,10,15                    ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 290LC'', ''F373'', 0.89,10,15                    ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 290LC'', ''F371'', 0.89,10,15                    ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 290PB'', ''F372'', 0.89,10,15                    ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 290PB'', ''F373'', 0.89,10,15                    ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 290PB'', ''F371'', 0.89,10,15                    ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 350'', ''F372'', 0.89,10,15                      ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 350'', ''F373'', 0.89,10,15                      ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 350'', ''F371'', 0.89,10,15                      ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 350PB'', ''F372'', 0.89,10,15                    ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 350PB'', ''F373'', 0.89,10,15                    ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) 350PB'', ''F371'', 0.89,10,15                    ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) ERPB'', ''F372'', 0.89,20,30                     ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) ERPB'', ''F373'', 0.89,20,30                     ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) ERPB'', ''F371'', 0.89,20,30                     ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMT'', ''F372'', 0.89,10,15                     ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMT'', ''F373'', 0.89,10,15                     ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMT'', ''F371'', 0.89,10,15                     ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMT40'', ''F372'', 0.89,10,15                   ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMT40'', ''F373'', 0.89,10,15                   ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMT40'', ''F371'', 0.89,10,15                   ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMT60'', ''F372'', 0.89,10,15                   ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMT60'', ''F373'', 0.89,10,15                   ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMT60'', ''F371'', 0.89,10,15                   ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMTPB'', ''F372'', 0.89,10,15                   ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMTPB'', ''F373'', 0.89,10,15                   ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMTPB'', ''F371'', 0.89,10,15                   ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMTPB40'', ''F372'', 0.89,10,15                 ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMTPB40'', ''F373'', 0.89,10,15                 ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMTPB40'', ''F371'', 0.89,10,15                 ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMTPB60'', ''F372'', 0.89,10,15                 ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMTPB60'', ''F373'', 0.89,10,15                 ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''DT(LA) PUMTPB60'', ''F371'', 0.89,10,15                 ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''PERSONALIZADA'', ''F372'', 0.89,0,100                   ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''PERSONALIZADA'', ''F373'', 0.89,0,100                   ' +
            ' UNION  SELECT ''DELFLEET(LA)'', ''PERSONALIZADA'', ''F371'', 0.89,0,100                   ';
end;


procedure TGravandoExecucaoPpgNexaDiluente.GravarRegistro(const qryOrigem: IDataSet; qryDestino: IDataSet);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PPX_CADDIL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('DIL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('DIL_LINHA_').AsString := AnsiUpperCase(qryOrigem.FieldByName('DIL_LINHA_').AsString);
  qryDestino.FieldByName('DIL_SISTEM').AsString := AnsiUpperCase(qryOrigem.FieldByName('DIL_SISTEM').AsString);
  qryDestino.FieldByName('DIL_CODDIL').AsString := qryOrigem.FieldByName('DIL_CODDIL').AsString;
  qryDestino.FieldByName('DIL_PESESP').AsFloat  := qryOrigem.FieldByName('DIL_PESESP').AsFloat;
  qryDestino.FieldByName('DIL_MINIMO').AsFloat  := qryOrigem.FieldByName('DIL_MINIMO').AsFloat;
  qryDestino.FieldByName('DIL_MAXIMO').AsFloat  := qryOrigem.FieldByName('DIL_MAXIMO').AsFloat;
  qryDestino.Post;
end;

function TGravandoExecucaoPpgNexaDiluente.IsRegistroExistente(const qryOrigem: IDataSet; qryDestino: IDataSet): Boolean;
begin

  Result := qryDestino.Locate('DIL_LINHA_;DIL_SISTEM;DIL_CODDIL', VarArrayOf([
    AnsiUpperCase(qryOrigem.FieldByName('DIL_LINHA_').AsString),
    AnsiUpperCase(qryOrigem.FieldByName('DIL_SISTEM').AsString),
    qryOrigem.FieldByName('DIL_CODDIL').AsString
  ]), []);

end;

end.

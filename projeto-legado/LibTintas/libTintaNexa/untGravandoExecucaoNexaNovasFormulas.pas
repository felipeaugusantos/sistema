{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta NEX *}
{********************************************************************************AC*}
unit untGravandoExecucaoNexaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoNexaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
    function fRetProxCodSeq : Integer;

  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoNexaNovasFormulas }

constructor TGravandoExecucaoNexaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoNexaNovasFormulas.Executar(const gravando: IGravando);
Var
  qryNfm   : IDataSet;
  qryGen   : IDataSet;
  intCont  : Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';

      qryNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryNfm.SQL := 'SELECT * '+
                    '  FROM NEX_CADNFM';


      if strCodNfm <> '' then
        qryNfm.SQL := qryNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('NEX_CADNEX', false);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryGen := TAutcomTintaFactory.Get.fGetDataSet;

      While (not qryNfm.Eof)
        and (gravando.Status = sgGravando) Do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryGen.SQL := ' INSERT INTO NEX_CADNEX(AUTOINCREM '+
                      '                       , NEX_CODSEQ '+
                      '                       , NEX_CODEMP '+
                      '                       , NEX_DESCOR '+
                      '                       , NEX_CODCOR '+
                      '                       , NEX_CODATC '+
                      '                       , NEX_VARIAN '+
                      '                       , NEX_REFERE '+
                      '                       , NEX_MARCA_ '+
                      '                       , NEX_UTILIZ '+
                      '                       , NEX_SISTEM '+
                      '                       , NEX_EFEFIN '+
                      '                       , NEX_ORIGEM '+
                      '                       , NEX_PAISES '+
                      '                       , NEX_VEICUL '+
                      '                       , NEX_MONTAD '+
                      '                       , NEX_A_N_O_ '+
                      '                       , NEX_TIPO__ '+
                      '                       , NEX_ATIVO_ '+
                      '                       , NEX_MD5KEY '+
                      '                       , NEX_DTACAD ';

        For intCont := 1 To 20 Do
        Begin
          qryGen.SQL := qryGen.SQL + ' , NEX_CODB' + TStrUtils.fStrZero(intCont, 2) +
                                     ' , NEX_QTDB' + TStrUtils.fStrZero(intCont, 2) ;
        End;

        qryGen.SQL := qryGen.SQL + ', NEX_ACRMOB) ';

        qryGen.SQL := qryGen.SQL + ' VALUES(:AUTOINCREM '+
                                  '        ,:NEX_CODSEQ '+
                                  '        ,:NEX_CODEMP '+
                                  '        ,:NEX_DESCOR '+
                                  '        ,:NEX_CODCOR '+
                                  '        ,:NEX_CODATC '+
                                  '        ,:NEX_VARIAN '+
                                  '        ,:NEX_REFERE '+
                                  '        ,:NEX_MARCA_ '+
                                  '        ,:NEX_UTILIZ '+
                                  '        ,:NEX_SISTEM '+
                                  '        ,:NEX_EFEFIN '+
                                  '        ,:NEX_ORIGEM '+
                                  '        ,:NEX_PAISES '+
                                  '        ,:NEX_VEICUL '+
                                  '        ,:NEX_MONTAD '+
                                  '        ,:NEX_A_N_O_ '+
                                  '        ,:NEX_TIPO__ '+
                                  '        ,:NEX_ATIVO_ '+
                                  '        ,:NEX_MD5KEY '+
                                  '        ,:NEX_DTACAD ';

        For intCont := 1 To 20 Do
        Begin
          qryGen.SQL := qryGen.SQL + ' ,:NEX_CODB' + TStrUtils.fStrZero(intCont, 2) +
                                     ' ,:NEX_QTDB' + TStrUtils.fStrZero(intCont, 2) ;
        End;

        qryGen.SQL := qryGen.SQL + ' ,:NEX_ACRMOB) ';


        qryGen.ParamByName('NEX_CODSEQ').AsString := TStrUtils.fStrZero(fRetProxCodSeq, 6);
        qryGen.ParamByName('NEX_DESCOR').AsString := qryNfm.FieldByName('NFM_DESCOR').AsString + ' ' + qryNfm.FieldByName('NFM_VARIAN').AsString;

        qryGen.ParamByName('NEX_VEICUL').AsString := qryNfm.FieldByName('NFM_VEICUL').AsString;
        qryGen.ParamByName('NEX_MONTAD').AsString := qryNfm.FieldByName('NFM_MONTAD').AsString;
        qryGen.ParamByName('NEX_TIPO__').AsString := qryNfm.FieldByName('NFM_TIPO__').AsString;

        qryGen.ParamByName('NEX_A_N_O_').AsString := qryNfm.FieldByName('NFM_A_N_O_').AsString;
        qryGen.ParamByName('NEX_CODCOR').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
        qryGen.ParamByName('NEX_CODATC').AsString := qryNfm.FieldByName('NFM_MONTAD').AsString + 'ESP' + qryNfm.FieldByName('NFM_VARIAN').AsString;
        qryGen.ParamByName('NEX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryGen.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('NEX_CADNEX', TAutcomTintaFactory.Get.GetCodEmp);

        qryGen.ParamByName('NEX_MARCA_').AsString := 'NEX';
        qryGen.ParamByName('NEX_SISTEM').AsString := 'PERSONALIZADA';
        qryGen.ParamByName('NEX_ORIGEM').AsString := 'PERSONALIZADA';
        qryGen.ParamByName('NEX_PAISES').AsString := 'BRASIL';
        qryGen.ParamByName('NEX_VARIAN').AsString := qryNfm.FieldByName('NFM_VARIAN').AsString;

        qryGen.ParamByName('NEX_ATIVO_').AsString :=
          TAutcomTintaFactory.Get.IIF(TStrUtils.fEmptyStr(qryNfm.FieldByName('NFM_ATIVO_').AsString),'S',qryNfm.FieldByName('NFM_ATIVO_').AsString);

        qryGen.ParamByName('NEX_EFEFIN').AsString := 'PERSONALIZADA';
        qryGen.ParamByName('NEX_ACRMOB').AsString := qryNfm.FieldByName('NFM_ACRMOB').AsString;
        qryGen.ParamByName('NEX_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDate;

        For intCont := 1 To 20 Do
        Begin
          If TStrUtils.fEmptyStr(qryNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
            Break;

          qryGen.ParamByName('NEX_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryGen.ParamByName('NEX_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryGen.ParamByName('NEX_MD5KEY').AsString :=  GetMD5(qryGen.ParamByName('NEX_DESCOR').AsString +
                                                             qryGen.ParamByName('NEX_VEICUL').AsString +
                                                             qryGen.ParamByName('NEX_TIPO__').AsString +
                                                             qryGen.ParamByName('NEX_A_N_O_').AsString +
                                                             qryGen.ParamByName('NEX_CODCOR').AsString +
                                                             qryGen.ParamByName('NEX_CODATC').AsString +
                                                             qryGen.ParamByName('NEX_VARIAN').AsString +
                                                             qryGen.ParamByName('NEX_MARCA_').AsString +
                                                             qryGen.ParamByName('NEX_UTILIZ').AsString +
                                                             qryGen.ParamByName('NEX_SISTEM').AsString +
                                                             qryGen.ParamByName('NEX_ORIGEM').AsString +
                                                             qryGen.ParamByName('NEX_MONTAD').AsString);

        qryGen.ExecSQL;


        gravando.RegistrarProgresso(0, qryNfm.RecNo, qryNfm.RecordCount);

        qryNfm.Next;
      end;
    Except
      on E: Exception do
      begin
        gravando.Cancelar;
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally

  End;
end;

function TGravandoExecucaoNexaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoNexaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoNexaNovasFormulas.fRetProxCodSeq: Integer;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT (IFNULL(MAX(NEX_CODSEQ), 0) + 1) PROX '+
                '  FROM NEX_CADNEX;';
  qryGen.Open;

  Result := qryGen.FieldByName('PROX').AsInteger;

end;

procedure TGravandoExecucaoNexaNovasFormulas.RemoverNovasFormulas;
var
  qryNEX: IDataSet;
begin
  Try
    Try
      qryNEX := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryNEX.SQL :=
          ' DELETE                        ' +
          ' FROM                          ' +
          '   NEX_CADNEX                  ' +
          ' WHERE NEX_CODCOR IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     NEX_CADNFM)               ';
      end
      else
      begin
        qryNEX.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   NEX_CADNEX                           ' +
          ' WHERE NEX_CODCOR IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     NEX_CADNFM                         ' +
          '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm) + ') ';
      end;

      qryNEX.ExecSQL;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally

  End;
end;

end.

{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta PPX *}
{********************************************************************************AC*}
unit untGravandoExecucaoPpgNexaNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoPpgNexaNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    function fHabilitaOpcao(): Boolean;
    procedure Executar(const gravando: IGravando);
    function fRetProxCodSeq : Integer;

  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoPpgNexaNovasFormulas }

constructor TGravandoExecucaoPpgNexaNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoPpgNexaNovasFormulas.Executar(const gravando: IGravando);
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
                    '  FROM PPX_CADNFM';


      if strCodNfm <> '' then
        qryNfm.SQL := qryNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('PPX_CADPPX', false);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryGen := TAutcomTintaFactory.Get.fGetDataSet;

      While (not qryNfm.Eof)
        and (gravando.Status = sgGravando) Do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryGen.SQL := ' INSERT INTO PPX_CADPPX(AUTOINCREM '+
                      '                       , PPX_CODSEQ '+
                      '                       , PPX_CODEMP '+
                      '                       , PPX_DESCOR '+
                      '                       , PPX_CODCOR '+
                      '                       , PPX_CODATC '+
                      '                       , PPX_VARIAN '+
                      '                       , PPX_REFERE '+
                      '                       , PPX_MARCA_ '+
                      '                       , PPX_UTILIZ '+
                      '                       , PPX_SISTEM '+
                      '                       , PPX_EFEFIN '+
                      '                       , PPX_ORIGEM '+
                      '                       , PPX_PAISES '+
                      '                       , PPX_VEICUL '+
                      '                       , PPX_MONTAD '+
                      '                       , PPX_A_N_O_ '+
                      '                       , PPX_TIPO__ '+
                      '                       , PPX_ATIVO_ '+
                      '                       , PPX_MD5KEY '+
                      '                       , PPX_DTACAD ';

        For intCont := 1 To 20 Do
        Begin
          qryGen.SQL := qryGen.SQL + ' , PPX_CODB' + TStrUtils.fStrZero(intCont, 2) +
                                     ' , PPX_QTDB' + TStrUtils.fStrZero(intCont, 2) ;
        End;

        qryGen.SQL := qryGen.SQL + ', PPX_ACRMOB) ';

        qryGen.SQL := qryGen.SQL + ' VALUES(:AUTOINCREM '+
                                  '        ,:PPX_CODSEQ '+
                                  '        ,:PPX_CODEMP '+
                                  '        ,:PPX_DESCOR '+
                                  '        ,:PPX_CODCOR '+
                                  '        ,:PPX_CODATC '+
                                  '        ,:PPX_VARIAN '+
                                  '        ,:PPX_REFERE '+
                                  '        ,:PPX_MARCA_ '+
                                  '        ,:PPX_UTILIZ '+
                                  '        ,:PPX_SISTEM '+
                                  '        ,:PPX_EFEFIN '+
                                  '        ,:PPX_ORIGEM '+
                                  '        ,:PPX_PAISES '+
                                  '        ,:PPX_VEICUL '+
                                  '        ,:PPX_MONTAD '+
                                  '        ,:PPX_A_N_O_ '+
                                  '        ,:PPX_TIPO__ '+
                                  '        ,:PPX_ATIVO_ '+
                                  '        ,:PPX_MD5KEY '+
                                  '        ,:PPX_DTACAD ';

        For intCont := 1 To 20 Do
        Begin
          qryGen.SQL := qryGen.SQL + ' ,:PPX_CODB' + TStrUtils.fStrZero(intCont, 2) +
                                     ' ,:PPX_QTDB' + TStrUtils.fStrZero(intCont, 2) ;
        End;

        qryGen.SQL := qryGen.SQL + ' ,:PPX_ACRMOB) ';


        qryGen.ParamByName('PPX_CODSEQ').AsString := TStrUtils.fStrZero(fRetProxCodSeq, 6);
        qryGen.ParamByName('PPX_DESCOR').AsString := qryNfm.FieldByName('NFM_DESCOR').AsString + ' ' + qryNfm.FieldByName('NFM_VARIAN').AsString;

        qryGen.ParamByName('PPX_VEICUL').AsString := qryNfm.FieldByName('NFM_VEICUL').AsString;
        qryGen.ParamByName('PPX_MONTAD').AsString := qryNfm.FieldByName('NFM_MONTAD').AsString;
        qryGen.ParamByName('PPX_TIPO__').AsString := qryNfm.FieldByName('NFM_TIPO__').AsString;

        qryGen.ParamByName('PPX_A_N_O_').AsString := qryNfm.FieldByName('NFM_A_N_O_').AsString;
        qryGen.ParamByName('PPX_CODCOR').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
        qryGen.ParamByName('PPX_CODATC').AsString := qryNfm.FieldByName('NFM_MONTAD').AsString + 'ESP' + qryNfm.FieldByName('NFM_VARIAN').AsString;
        qryGen.ParamByName('PPX_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryGen.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PPX_CADPPX', TAutcomTintaFactory.Get.GetCodEmp);

        qryGen.ParamByName('PPX_MARCA_').AsString := 'PPX';
        qryGen.ParamByName('PPX_SISTEM').AsString := 'PERSONALIZADA';
        qryGen.ParamByName('PPX_ORIGEM').AsString := 'PERSONALIZADA';
        qryGen.ParamByName('PPX_PAISES').AsString := 'BRASIL';
        qryGen.ParamByName('PPX_VARIAN').AsString := qryNfm.FieldByName('NFM_VARIAN').AsString;

        qryGen.ParamByName('PPX_ATIVO_').AsString := qryNfm.FieldByName('NFM_ATIVO_').AsString;

        qryGen.ParamByName('PPX_EFEFIN').AsString := 'PERSONALIZADA';
        qryGen.ParamByName('PPX_ACRMOB').AsString := qryNfm.FieldByName('NFM_ACRMOB').AsString;
        qryGen.ParamByName('PPX_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDate;

        For intCont := 1 To 20 Do
        Begin
          If TStrUtils.fEmptyStr(qryNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
            Break;

          qryGen.ParamByName('PPX_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryGen.ParamByName('PPX_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryGen.ParamByName('PPX_MD5KEY').AsString :=  GetMD5(qryGen.ParamByName('PPX_DESCOR').AsString +
                                                             qryGen.ParamByName('PPX_VEICUL').AsString +
                                                             qryGen.ParamByName('PPX_TIPO__').AsString +
                                                             qryGen.ParamByName('PPX_A_N_O_').AsString +
                                                             qryGen.ParamByName('PPX_CODCOR').AsString +
                                                             qryGen.ParamByName('PPX_CODATC').AsString +
                                                             qryGen.ParamByName('PPX_VARIAN').AsString +
                                                             qryGen.ParamByName('PPX_MARCA_').AsString +
                                                             qryGen.ParamByName('PPX_UTILIZ').AsString +
                                                             qryGen.ParamByName('PPX_SISTEM').AsString +
                                                             qryGen.ParamByName('PPX_ORIGEM').AsString +
                                                             qryGen.ParamByName('PPX_MONTAD').AsString);

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

function TGravandoExecucaoPpgNexaNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoPpgNexaNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoPpgNexaNovasFormulas.fRetProxCodSeq: Integer;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT (IFNULL(MAX(PPX_CODSEQ), 0) + 1) PROX '+
                '  FROM PPX_CADPPX;';
  qryGen.Open;

  Result := qryGen.FieldByName('PROX').AsInteger;

end;

procedure TGravandoExecucaoPpgNexaNovasFormulas.RemoverNovasFormulas;
var
  qryPPX: IDataSet;
begin
  Try
    Try
      qryPPX := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryPPX.SQL :=
          ' DELETE                        ' +
          ' FROM                          ' +
          '   PPX_CADPPX                  ' +
          ' WHERE PPX_CODCOR IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     PPX_CADNFM)               ';
      end
      else
      begin
        qryPPX.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   PPX_CADPPX                           ' +
          ' WHERE PPX_CODCOR IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     PPX_CADNFM                         ' +
          '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm) + ') ';
      end;

      qryPPX.ExecSQL;
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

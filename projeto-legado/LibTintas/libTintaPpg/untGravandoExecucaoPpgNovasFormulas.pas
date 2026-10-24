{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Ppg *}
{********************************************************************************AC*}
unit untGravandoExecucaoPpgNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math;

type
  TGravandoExecucaoPpgNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    procedure RemoverNovasFormulas();
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fRetProxCodSeq : Integer;
    function fHabilitaOpcao(): Boolean;

  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoPpgNovasFormulas }

constructor TGravandoExecucaoPpgNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoPpgNovasFormulas.Executar(const gravando: IGravando);
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
                    '  FROM PPG_CADNFM';


      if strCodNfm <> '' then
        qryNfm.SQL := qryNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryNfm.Open;

      If gravando.Status <> sgGravando Then
        Exit;

      RemoverNovasFormulas();
      gravando.Texto := 'Dados carregados com sucesso!';

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('PPG_CADPPG', false);
      gravando.Texto := 'PROCOD verificado com sucesso!';

      qryGen := TAutcomTintaFactory.Get.fGetDataSet;

      While (not qryNfm.Eof)
        and (gravando.Status = sgGravando) Do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryGen.SQL := ' INSERT INTO PPG_CADPPG(AUTOINCREM '+
                      '                       , PPG_CODSEQ '+
                      '                       , PPG_CODEMP '+
                      '                       , PPG_DESCOR '+
                      '                       , PPG_CODCOR '+
                      '                       , PPG_CODATC '+
                      '                       , PPG_VARIAN '+
                      '                       , PPG_REFERE '+
                      '                       , PPG_MARCA_ '+
                      '                       , PPG_UTILIZ '+
                      '                       , PPG_SISTEM '+
                      '                       , PPG_EFEFIN '+
                      '                       , PPG_ORIGEM '+
                      '                       , PPG_PAISES '+
                      '                       , PPG_VEICUL '+
                      '                       , PPG_MONTAD '+
                      '                       , PPG_A_N_O_ '+
                      '                       , PPG_TIPO__ '+
                      '                       , PPG_ATIVO_ '+
                      '                       , PPG_MD5KEY '+
                      '                       , PPG_DTACAD ';

        For intCont := 1 To 20 Do
        Begin
          qryGen.SQL := qryGen.SQL + ' , PPG_CODB' + TStrUtils.fStrZero(intCont, 2) +
                                     ' , PPG_QTDB' + TStrUtils.fStrZero(intCont, 2) ;
        End;

        qryGen.SQL := qryGen.SQL + ', PPG_ACRMOB) ';

        qryGen.SQL := qryGen.SQL + ' VALUES(:AUTOINCREM '+
                                  '        ,:PPG_CODSEQ '+
                                  '        ,:PPG_CODEMP '+
                                  '        ,:PPG_DESCOR '+
                                  '        ,:PPG_CODCOR '+
                                  '        ,:PPG_CODATC '+
                                  '        ,:PPG_VARIAN '+
                                  '        ,:PPG_REFERE '+
                                  '        ,:PPG_MARCA_ '+
                                  '        ,:PPG_UTILIZ '+
                                  '        ,:PPG_SISTEM '+
                                  '        ,:PPG_EFEFIN '+
                                  '        ,:PPG_ORIGEM '+
                                  '        ,:PPG_PAISES '+
                                  '        ,:PPG_VEICUL '+
                                  '        ,:PPG_MONTAD '+
                                  '        ,:PPG_A_N_O_ '+
                                  '        ,:PPG_TIPO__ '+
                                  '        ,:PPG_ATIVO_ '+
                                  '        ,:PPG_MD5KEY '+
                                  '        ,:PPG_DTACAD ';

        For intCont := 1 To 20 Do
        Begin
          qryGen.SQL := qryGen.SQL + ' ,:PPG_CODB' + TStrUtils.fStrZero(intCont, 2) +
                                     ' ,:PPG_QTDB' + TStrUtils.fStrZero(intCont, 2) ;
        End;

        qryGen.SQL := qryGen.SQL + ' ,:PPG_ACRMOB) ';


        qryGen.ParamByName('PPG_CODSEQ').AsString := TStrUtils.fStrZero(fRetProxCodSeq, 6);
        qryGen.ParamByName('PPG_DESCOR').AsString := qryNfm.FieldByName('NFM_DESCOR').AsString + ' ' + qryNfm.FieldByName('NFM_VARIAN').AsString;

        qryGen.ParamByName('PPG_VEICUL').AsString := qryNfm.FieldByName('NFM_VEICUL').AsString;
        qryGen.ParamByName('PPG_MONTAD').AsString := qryNfm.FieldByName('NFM_MONTAD').AsString;
        qryGen.ParamByName('PPG_TIPO__').AsString := qryNfm.FieldByName('NFM_TIPO__').AsString;

        qryGen.ParamByName('PPG_A_N_O_').AsString := qryNfm.FieldByName('NFM_A_N_O_').AsString;
        qryGen.ParamByName('PPG_CODCOR').AsString := qryNfm.FieldByName('NFM_CODNFM').AsString;
        qryGen.ParamByName('PPG_CODATC').AsString := qryNfm.FieldByName('NFM_MONTAD').AsString + 'ESP' + qryNfm.FieldByName('NFM_VARIAN').AsString;
        qryGen.ParamByName('PPG_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryGen.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('PPG_CADPPG', TAutcomTintaFactory.Get.GetCodEmp);

        qryGen.ParamByName('PPG_MARCA_').AsString := 'PPG';
        qryGen.ParamByName('PPG_SISTEM').AsString := 'PERSONALIZADA';
        qryGen.ParamByName('PPG_ORIGEM').AsString := 'PERSONALIZADA';
        qryGen.ParamByName('PPG_PAISES').AsString := 'BRASIL';
        qryGen.ParamByName('PPG_VARIAN').AsString := qryNfm.FieldByName('NFM_VARIAN').AsString;

        qryGen.ParamByName('PPG_ATIVO_').AsString :=
          TAutcomTintaFactory.Get.IIF(TStrUtils.fEmptyStr(qryNfm.FieldByName('NFM_ATIVO_').AsString),'S',qryNfm.FieldByName('NFM_ATIVO_').AsString);

        qryGen.ParamByName('PPG_EFEFIN').AsString := 'PERSONALIZADA';
        qryGen.ParamByName('PPG_ACRMOB').AsString := qryNfm.FieldByName('NFM_ACRMOB').AsString;
        qryGen.ParamByName('PPG_DTACAD').AsDateTime := qryNfm.FieldByName('NFM_DTACAD').AsDate;

        For intCont := 1 To 20 Do
        Begin
          If TStrUtils.fEmptyStr(qryNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString) Then
            Break;

          qryGen.ParamByName('PPG_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString := TrimRight(qryNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intCont, 2)).AsString);
          qryGen.ParamByName('PPG_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat  := qryNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intCont, 2)).AsFloat;
        End;

        qryGen.ParamByName('PPG_MD5KEY').AsString :=  GetMD5(qryGen.ParamByName('PPG_DESCOR').AsString +
                                                             qryGen.ParamByName('PPG_VEICUL').AsString +
                                                             qryGen.ParamByName('PPG_TIPO__').AsString +
                                                             qryGen.ParamByName('PPG_A_N_O_').AsString +
                                                             qryGen.ParamByName('PPG_CODCOR').AsString +
                                                             qryGen.ParamByName('PPG_CODATC').AsString +
                                                             qryGen.ParamByName('PPG_VARIAN').AsString +
                                                             qryGen.ParamByName('PPG_MARCA_').AsString +
                                                             qryGen.ParamByName('PPG_UTILIZ').AsString +
                                                             qryGen.ParamByName('PPG_SISTEM').AsString +
                                                             qryGen.ParamByName('PPG_ORIGEM').AsString +
                                                             qryGen.ParamByName('PPG_MONTAD').AsString);

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

function TGravandoExecucaoPpgNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoPpgNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoPpgNovasFormulas.fRetProxCodSeq: Integer;
Var
  qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT (IFNULL(MAX(PPG_CODSEQ), 0) + 1) PROX '+
                '  FROM PPG_CADPPG;';
  qryGen.Open;

  Result := qryGen.FieldByName('PROX').AsInteger;

end;

procedure TGravandoExecucaoPpgNovasFormulas.RemoverNovasFormulas;
var
  qryPPG: IDataSet;
begin
  Try
    Try
      qryPPG := TAutcomTintaFactory.Get.fGetDataSet;
      if TStrUtils.fEmptyStr(strCodNfm) then
      begin
        qryPPG.SQL :=
          ' DELETE                        ' +
          ' FROM                          ' +
          '   PPG_CADPPG                  ' +
          ' WHERE PPG_CODCOR IN           ' +
          '   (SELECT                     ' +
          '     NFM_CODNFM                ' +
          '   FROM                        ' +
          '     PPG_CADNFM)               ';
      end
      else
      begin
        qryPPG.SQL :=
          ' DELETE                                 ' +
          ' FROM                                   ' +
          '   PPG_CADPPG                           ' +
          ' WHERE PPG_CODCOR IN                    ' +
          '   (SELECT                              ' +
          '     NFM_CODNFM                         ' +
          '   FROM                                 ' +
          '     PPG_CADNFM                         ' +
          '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm) + ') ';
      end;

      qryPPG.ExecSQL;
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

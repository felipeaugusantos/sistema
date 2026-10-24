{**********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta Roberlo *}
{*******************************************************************************PH*}
unit untGravandoExecucaoRoberloNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, Variants, StrUtils;

type
  TGravandoExecucaoRoberloNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoRoberloNovasFormulas }

constructor TGravandoExecucaoRoberloNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm   := strCodNfm;
end;

procedure TGravandoExecucaoRoberloNovasFormulas.Executar(const gravando: IGravando);
Var
  intContador: Integer;
  qryCadRob, qryCadNfm: IDataSet;
  strMd5Key: String;
  fltQtdTotal: Double;
begin
  Try
    Try
      Gravando.Texto := 'Iniciando cadastro de novas fórmulas...';

      qryCadRob := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('ROB_CADROB');
      Gravando.Texto := 'PROCOD verificado com sucesso...';


      qryCadRob.SQL := '  DELETE FROM ROB_CADROB      ';
      qryCadNfm.SQL := '  SELECT * FROM ROB_CADNFM    ';

      Gravando.Texto := 'Deletando novas fórmulas da tabela ROB_CADROB...';
      Gravando.Texto := 'Abrindo cadastro de novas fórmulas...';

      If Not TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryCadNfm.SQL := qryCadNfm.SQL + '  WHERE NFM_CODIGO = ' + QuotedStr(strCodNfm);
        qryCadRob.SQL := qryCadRob.SQL + '  WHERE ROB_CODIGO = ' + QuotedStr(strCodNfm);
      End
      Else
      Begin
        qryCadRob.SQL := qryCadRob.SQL + '  WHERE ROB_CODIGO LIKE "%ESP%"   ';
      End;

      qryCadRob.ExecSQL;
      qryCadNfm.Open;

      Gravando.Texto := 'Processando Novas Fórmulas...';
      qryCadRob.SQL := '  SELECT * FROM ROB_CADROB      ';
      qryCadRob.Open;

      qryCadNfm.First;
      Gravando.RegistrarProgresso(0, 0, 0);

      While Not qryCadNfm.Eof Do
      Begin
        Try
          Try
            qryCadRob.Insert;
            qryCadRob.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ROB_CADROB', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadRob.FieldByName('ROB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadRob.FieldByName('ROB_CODIGO').AsString := qryCadNfm.FieldByName('NFM_CODIGO').AsString;
            qryCadRob.FieldByName('ROB_SERIE_').AsString := qryCadNfm.FieldByName('NFM_SERIE_').AsString;
            qryCadRob.FieldByName('ROB_MARCA_').AsString := qryCadNfm.FieldByName('NFM_MARCA_').AsString;
            qryCadRob.FieldByName('ROB_CODCOR').AsString := qryCadNfm.FieldByName('NFM_CODCOR').AsString;
            qryCadRob.FieldByName('ROB_NOMCOR').AsString := qryCadNfm.FieldByName('NFM_NOMCOR').AsString;
            qryCadRob.FieldByName('ROB_VARIAN').AsString := qryCadNfm.FieldByName('NFM_VARIAN').AsString;
            qryCadRob.FieldByName('ROB_GRUCOR').AsString := qryCadNfm.FieldByName('NFM_GRUCOR').AsString;
            qryCadRob.FieldByName('ROB_CATALO').AsString := qryCadNfm.FieldByName('NFM_CATALO').AsString;
            qryCadRob.FieldByName('ROB_ANOINI').AsString := qryCadNfm.FieldByName('NFM_ANOINI').AsString;
            qryCadRob.FieldByName('ROB_ANOFIN').AsString := qryCadNfm.FieldByName('NFM_ANOFIN').AsString;
            qryCadRob.FieldByName('ROB_CAMADA').AsString := qryCadNfm.FieldByName('NFM_CAMADA').AsString;
            qryCadRob.FieldByName('ROB_MODELO').AsString := '';
            qryCadRob.FieldByName('ROB_REGIAO').AsString := qryCadNfm.FieldByName('NFM_REGIAO').AsString;
            qryCadRob.FieldByName('ROB_ATIVO_').AsString := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;
            qryCadRob.FieldByName('ROB_ACRMOB').AsFloat  := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;

            strMd5Key := '';
            strMd5Key := strMd5Key + qryCadRob.FieldByName('ROB_CODIGO').AsString;
            strMd5Key := strMd5Key + qryCadRob.FieldByName('ROB_SERIE_').AsString;
            strMd5Key := strMd5Key + qryCadRob.FieldByName('ROB_MARCA_').AsString;
            strMd5Key := strMd5Key + qryCadRob.FieldByName('ROB_CODCOR').AsString;
            strMd5Key := strMd5Key + qryCadRob.FieldByName('ROB_NOMCOR').AsString;
            strMd5Key := strMd5Key + qryCadRob.FieldByName('ROB_VARIAN').AsString;
            strMd5Key := strMd5Key + qryCadRob.FieldByName('ROB_GRUCOR').AsString;
            strMd5Key := strMd5Key + qryCadRob.FieldByName('ROB_CATALO').AsString;
            strMd5Key := strMd5Key + qryCadRob.FieldByName('ROB_REGIAO').AsString;
            strMd5Key := strMd5Key + qryCadRob.FieldByName('ROB_MODELO').AsString;
            strMd5Key := strMd5Key + qryCadRob.FieldByName('ROB_ANOINI').AsString;
            strMd5Key := strMd5KEy + qryCadRob.FieldByName('ROB_ANOFIN').AsString;

            qryCadRob.FieldByName('ROB_MD5KEY').AsString := GetMD5(strMd5Key);

            fltQtdTotal := 0;

            //Convertendo as quantidades das novas fórmulas em porcentagem
            For intContador := 1 To 20 Do
              fltQtdTotal := fltQtdTotal + qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat;


            For intContador := 1 To 20 Do
            Begin

              If TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString) Then
                Break;

              qryCadRob.FieldByName('ROB_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_BASE' + TStrUtils.fStrZero(intContador, 2)).AsString);

              qryCadRob.FieldByName('ROB_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat :=
                (qryCadNfm.FieldByName('NFM_QTDB' + TStrUtils.fStrZero(intContador, 2)).AsFloat * 100) / fltQtdTotal;
            End;

            qryCadRob.Post;
          Except
            On E: Exception Do
            Begin
              Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
              Gravando.Cancelar;
            End;
          End;
        Finally
          qryCadNfm.Next;
          Gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Gravando.Cancelar;
      End;
    End;
  Finally

  End;
end;

function TGravandoExecucaoRoberloNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoRoberloNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

end.

{***********************************************************************************}
{* Classe responsável pela geração do cadastro de novas fórmulas da tinta ColorPro *}
{********************************************************************************AC*}
unit untGravandoExecucaoColorProNovasFormulas;

interface

uses
  untIGravandoExecucaoNome, untIGravando, SysUtils, untIDataSet, untAutcomTintaFactory,
  untStrUtils, Math, DateUtils, strUtils;

type
  TGravandoExecucaoColorProNovasFormulas = class(TInterfacedObject, IGravandoExecucaoNome)
  private
    strCodNfm: string;
    Procedure RemoverNovasFormulas();
    function fRetProCodSeq: Integer;
  public
    constructor Create(const strCodNfm: string = '');
    function fGetNomeGravacao: string;
    procedure Executar(const gravando: IGravando);
    function fHabilitaOpcao(): Boolean;
  end;

implementation

uses
  untStatusGravando, untFuncoesGenerica;

{ TGravandoExecucaoColorProNovasFormulas }

constructor TGravandoExecucaoColorProNovasFormulas.Create(
  const strCodNfm: string);
begin
  inherited Create();
  Self.strCodNfm := strCodNfm;
end;

procedure TGravandoExecucaoColorProNovasFormulas.Executar(const gravando: IGravando);
var
  qryCadNfm    : IDataSet;
  qryCadWanPro : IDataSet;
  intCodSeq    : Integer;
  intContador  : Integer;
begin
  Try
    Try
      gravando.Texto := 'Carregando dados...';
      qryCadNfm := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadWanPro := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadNfm.SQL := 'SELECT * FROM WANPRO_CADNFM';

      If strCodNfm <> '' Then
        qryCadNfm.SQL := qryCadNfm.SQL + ' WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);

      qryCadNfm.Open;

      RemoverNovasFormulas();

      If gravando.Status <> sgGravando Then
        Exit;

      gravando.Texto := 'Dados carregados com sucesso!';



      intCodSeq := fRetProCodSeq;

      while (not qryCadNfm.Eof) and (gravando.Status = sgGravando) do
      begin
        If gravando.Status <> sgGravando Then
          Exit;

        qryCadWanPro.SQL := TAutcomTintaFactory.Get.GetInsert('WANPRO_CADWAN');

        qryCadWanPro.ParamByName('WAN_CODSEQ').AsString  := TStrUtils.fStrZero(intCodSeq,6);
        qryCadWanPro.ParamByName('WAN_LINHA_').AsString  := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
        qryCadWanPro.ParamByName('WAN_NOMLIN').AsString  := qryCadNfm.FieldByName('NFM_NOMLIN').AsString;
        qryCadWanPro.ParamByName('WAN_CODAKZ').AsString  := qryCadNfm.FieldByName('NFM_CODNFM').AsString;
        qryCadWanPro.ParamByName('WAN_DESCRI').AsString  := qryCadNfm.FieldByName('NFM_DESCRI').AsString;
        qryCadWanPro.ParamByName('WAN_MONTAD').AsString  := qryCadNfm.FieldByName('NFM_MONTAD').AsString;
        qryCadWanPro.ParamByName('WAN_DTACAD').AsDateTime := qryCadNfm.FieldByName('NFM_DTACAD').AsDate;
        qryCadWanPro.ParamByName('WAN_ANOINI').AsString  := IntToStr(YearOf(qryCadNfm.FieldByName('NFM_DTACAD').AsDate));
        qryCadWanPro.ParamByName('WAN_ANOFIN').AsString  := IntToStr(YearOf(qryCadNfm.FieldByName('NFM_DTACAD').AsDate));
        qryCadWanPro.ParamByName('WAN_ALTERN').AsString  := qryCadNfm.FieldByName('NFM_ALTERN').AsString;
        qryCadWanPro.ParamByName('WAN_CODEMP').AsString  := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadWanPro.ParamByName('AUTOINCREM').AsString  := TAutcomTintaFactory.Get.fRetAutoIncrem('WANPRO_CADWAN', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadWanPro.ParamByName('WAN_CAMADA').AsInteger := qryCadNfm.FieldByName('WAN_CAMADA').AsInteger;
        qryCadWanPro.ParamByName('WAN_ACRMOB').AsFloat   := qryCadNfm.FieldByName('NFM_ACRMOB').AsFloat;
        qryCadWanPro.ParamByName('WAN_CATALI').AsString  := qryCadNfm.FieldByName('NFM_CATALI').AsString;
        qryCadWanPro.ParamByName('WAN_ATIVO_').AsString  := qryCadNfm.FieldByName('NFM_ATIVO_').AsString;

        qryCadWanPro.ParamByName('WAN_MD5KEY').AsString  := GetMD5(qryCadWanPro.ParamByName('WAN_LINHA_').AsString +
                                                                   qryCadWanPro.ParamByName('WAN_CODAKZ').AsString +
                                                                   qryCadWanPro.ParamByName('WAN_ALTERN').AsString +
                                                                   qryCadWanPro.ParamByName('WAN_MONTAD').AsString +
                                                                   qryCadWanPro.ParamByName('WAN_CAMADA').AsString +
                                                                   qryCadWanPro.ParamByName('WAN_DESCRI').AsString);

        For intContador := 1 To 20 Do
        Begin
          If (TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString)) Then
            Break;

          qryCadWanPro.ParamByName('WAN_LINC' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
          qryCadWanPro.ParamByName('WAN_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString := TrimRight(qryCadNfm.FieldByName('NFM_CODB' + TStrUtils.fStrZero(intContador, 2)).AsString);
          qryCadWanPro.ParamByName('WAN_QCON' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDC' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

          If qryCadWanPro.ParamByName('WAN_LINHA_').AsString = '72' Then
            qryCadWanPro.ParamByName('WAN_QD92' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat
          Else
            qryCadWanPro.ParamByName('WAN_QD21' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDD' + TStrUtils.fStrZero(intContador, 2)).AsFloat;

          qryCadWanPro.ParamByName('WAN_QD41' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QD41' + TStrUtils.fStrZero(intContador, 2)).AsFloat;
        End;

        If (Not TStrUtils.fEmptyStr(qryCadNfm.FieldByName('NFM_CODDIL').AsString)) Then
        Begin
          qryCadWanPro.ParamByName('WAN_LINC' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadNfm.FieldByName('NFM_LINHA_').AsString;
          qryCadWanPro.ParamByName('WAN_CODC' + TStrUtils.fStrZero(intContador, 2)).AsString := qryCadNfm.FieldByName('NFM_CODDIL').AsString;
          qryCadWanPro.ParamByName('WAN_QCON' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := 0.0;

          If qryCadWanPro.ParamByName('WAN_LINHA_').AsString = '72' Then
            qryCadWanPro.ParamByName('WAN_QD92' + TStrUtils.fStrZero(intContador, 2)).AsFloat := qryCadNfm.FieldByName('NFM_QTDDIL').AsFloat
          Else
            qryCadWanPro.ParamByName('WAN_QD21' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDDIL').AsFloat;

          qryCadWanPro.ParamByName('WAN_QD41' + TStrUtils.fStrZero(intContador, 2)).AsFloat  := qryCadNfm.FieldByName('NFM_QTDDI4').AsFloat;
        End;

        qryCadWanPro.ExecSQL;

        gravando.RegistrarProgresso(0, qryCadNfm.RecNo, qryCadNfm.RecordCount);

        Inc(intCodSeq);

        qryCadNfm.Next;
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

function TGravandoExecucaoColorProNovasFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Novas Fórmulas';
end;

function TGravandoExecucaoColorProNovasFormulas.fHabilitaOpcao: Boolean;
begin
  Result := True;
end;

function TGravandoExecucaoColorProNovasFormulas.fRetProCodSeq: Integer;
  Var
    qryGen: IDataSet;
begin
  qryGen := TAutcomTintaFactory.Get.fGetDataSet;
  qryGen.SQL := 'SELECT IFNULL(MAX(WAN_CODSEQ),0) + 1 PROX FROM WANPRO_CADWAN;';
  qryGen.Open;

  Result := qryGen.FieldByName('PROX').AsInteger;
end;

procedure TGravandoExecucaoColorProNovasFormulas.RemoverNovasFormulas;
Var
  qryGen: IDataSet;
begin
  Try
    Try
      qryGen := TAutcomTintaFactory.Get.fGetDataSet;
      If TStrUtils.fEmptyStr(strCodNfm) Then
      Begin
        qryGen.SQL :=
          ' DELETE WANPRO_CADWAN                   ' +
          ' FROM                                   ' +
          '   WANPRO_CADWAN JOIN WANPRO_CADNFM ON WANPRO_CADNFM.NFM_CODNFM = WANPRO_CADWAN.WAN_CODAKZ ';
      End
      Else
      Begin
        qryGen.SQL :=
          ' DELETE WANPRO_CADWAN                   ' +
          ' FROM                                   ' +
          '   WANPRO_CADWAN JOIN WANPRO_CADNFM ON WANPRO_CADNFM.NFM_CODNFM = WANPRO_CADWAN.WAN_CODAKZ ' +
          '   WHERE NFM_CODNFM = ' + QuotedStr(strCodNfm);
      End;

      qryGen.ExecSQL;
    Except
      On E: Exception Do
        Raise;
    End;
  Finally
  End;
end;

end.


{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Recoa *}
{***************************************************************************PH*}
unit untGravandoExecucaoRecoaColorantes;

interface

uses
  untAbstractGravandoExecucaoRecoa, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils;
type
  TGravandoExecucaoRecoaColorantes = class(TAbstractGravandoExecucaoRecoa)
  private
    qryAdoColorantes: TADOQuery;
    function fRetQuantidadeEmb(strUnidade:String):Double;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoRecoaCores }

procedure TGravandoExecucaoRecoaColorantes.Executar(const gravando: IGravando);
var
  qryCadEmb, qryCadCol: IDataSet;
  fltQuantidadeEmb:Double;
  intCont: Integer;
const
  ArrayUnidade: Array[0..2] Of String = ('LT', 'GL', 'LA');
begin
  Try
    Try
      Gravando.Texto := 'Carregando Dados do Cadastro de Embalagens...';

      qryCadEmb := TAutcomTintaFactory.Get.fGetDataSet;

      Gravando.Texto:= 'Deletando o Cadastro de Embalagens...';
      qryCadEmb.SQL := '    DELETE FROM REC_CADEMB    ';
      qryCadEmb.ExecSQL;
      Gravando.Texto := 'Cadastro de Embalagens Deletado...';

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REC_CADEMB');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Abrindo Cadastro de Embalagens...';
      qryCadEmb.SQL.Empty;
      qryCadEmb.SQL := '    SELECT * FROM REC_CADEMB    ';
      qryCadEmb.Open;
      Gravando.Texto := 'Processando Dados...';

      //Embalagens
      Try
        Begin
          For intCont := 0 To 2 Do
          Begin
            qryCadEmb.Insert;
            qryCadEmb.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REC_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
            qryCadEmb.FieldByName('EMB_CODEMB').AsString := TAutcomTintaFactory.Get.GetCodEmp;
            qryCadEmb.FieldByName('EMB_CODEMB').AsString := (TStrUtils.fStrZero(intCont, 2));
            qryCadEmb.FieldByName('EMB_UNIDAD').AsString := ArrayUnidade[intCont];
            fltQuantidadeEmb := fRetQuantidadeEmb(ArrayUnidade[intCont]);
            qryCadEmb.FieldByName('EMB_QTDEMB').AsFloat := fltQuantidadeEmb;
            qryCadEmb.Post;
          End;
          Gravando.Texto := 'Embalagens foi gravado com sucesso...';
        End;
      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      End;

    //Colorantes
      Try
        If Not FileExists(GetPath) Then
        Begin
          gravando.texto := Format('O arquivo %s não existe', [AnsiReplaceStr(GetPath, '"', '')]);
          gravando.Cancelar;
        End;

        If (gravando.Status <> sgGravando) Then
          Exit;

        Gravando.Texto := 'Carregando Dados do Cadastro de Colorante...';

        qryAdoColorantes := TADOQuery.Create(Nil);
        qryAdoColorantes.Connection := fConexaoRecoa;

        qryAdoColorantes.SQL.Clear;
        qryAdoColorantes.SQL.Add('    SELECT   ');
        qryAdoColorantes.SQL.Add('       NOME        ');
        qryAdoColorantes.SQL.Add('    FROM CORANTES    ');
        qryAdoColorantes.SQL.Add('      ORDER BY NUMERO    ');
        qryAdoColorantes.Open;

        qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;
        Gravando.Texto := ' Deletando Cadastro de Colorantes...';
        qryCadCol.SQL := '    DELETE FROM REC_CADCOL    ';
        qryCadCol.ExecSQL;
        Gravando.Texto := ' Cadastro de Colorantes Deletado...';

        Gravando.Texto := 'Verifcando PROCOD...';
        TAutcomTintaFactory.Get.fInsereProCod('REC_CADCOL');
        Gravando.Texto := 'PROCOD verificado com sucesso...';

        Gravando.Texto := 'Abrindo Cadastro de Colorantes...';


        qryCadCol.SQL := '    SELECT * FROM REC_CADCOL    ';
        qryCadCol.Open;

        If (gravando.Status <> sgGravando) Then
          Exit;

        gravando.texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
        gravando.RegistrarProgresso(0, 0, 0);

        While Not qryAdoColorantes.Eof Do
        Begin
          If (gravando.Status <> sgGravando) Then
            Break;

          qryCadCol.Insert;
          qryCadCol.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REC_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
          qryCadCol.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
          qryCadCol.FieldByName('COL_CODCOL').AsString := qryAdoColorantes.FieldByName('NOME').AsString;
          qryCadCol.FieldByName('COL_EMBALA').AsFloat  := 810;
          qryCadCol.Post;
          qryAdoColorantes.Next;
        End;
        Gravando.RegistrarProgresso(0, qryAdoColorantes.RecNo, qryAdoColorantes.RecordCount);
      Except
        On E: Exception Do
        Begin
          gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        End;
      End;

    Except
      On  E: Exception Do
      Begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;

    End;
  Finally
    Gravando.Texto := 'Cadastro de Colorantes/Embalagens gerado com sucesso...';
  End;
end;

function TGravandoExecucaoRecoaColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes/Embalagens';
end;



function TGravandoExecucaoRecoaColorantes.fRetQuantidadeEmb(
  strUnidade: String): Double;
begin
  Result := 0;
  If strUnidade = 'LT' Then
    Result := 810
  Else If strUnidade = 'GL' Then
    Result := 3240
  Else If strUnidade = 'LA' Then
    Result := 16200;
end;

end.


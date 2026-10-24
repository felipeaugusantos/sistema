{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta AdvanceStr *}
{***************************************************************************PH*}
unit untGravandoExecucaoAdvanceStrColorantes;

interface

uses
  untAbstractGravandoExecucaoAdvanceStr, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni, DBFUniProvider;

type
  TGravandoExecucaoAdvanceStrColorantes = class(TAbstractGravandoExecucaoAdvanceStr)
  Private
    procedure IsDeletarRegistros();
  Protected
    function GetSqlDestino(): string; override;
    function fGetPath(intContador: Integer; intDiretorio: Integer): String; override;
    function IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean; override;
    procedure GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery); override;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;


{ TGravandoExecucaoAdvanceStrCores }


procedure TGravandoExecucaoAdvanceStrColorantes.Executar(const gravando: IGravando);
var
  qryColorantes: TUniQuery;
  qryCadCol: IDataSet;
  strSQL: String;
begin
  Try
    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.Texto := 'Carregando Dados do Cadastro de Colorantes...';
    qryColorantes := TUniQuery.Create(Nil);
    qryColorantes.Connection := fConexaoPostgreSQL;

    strSQL := ' SELECT DISTINCT                  ' +
              '  fc.id_componente AS IDCOL,      ' +
              '  co.codigo as CODCOL,            ' +
              '  co.descricao as DESCCOL,        ' +
              '  co.volume_embalagem_ml AS EMB,  ' +
              '  co.peso_especifico as PESESP    ' +
              '  FROM formula_composicao AS fc   ' +
              '  INNER JOIN componente AS co ON  ' +
              '  co.id = fc.id_componente        ' +
              '  ORDER BY co.codigo;             ';

    qryColorantes.Close;
    qryColorantes.SQL.Clear;
    qryColorantes.SQL.Add(strSQL);
    qryColorantes.Open;

    If qryColorantes.IsEmpty Then
    Begin
      Gravando.Texto := 'O cadastro de Colorantes esta vazio! Verificar.';
      Exit;
    End;

    Gravando.Texto := 'Deletando Cadastro de Colorantes...';
    IsDeletarRegistros();
    Gravando.Texto := 'Cadastro de Colorantes deletado...';

    Gravando.Texto := 'Verificando PROCOD...';
    TAutcomTintaFactory.Get.fInsereProCod('ADS_CADCOL');
    Gravando.Texto := 'PROCOD verificado com sucesso...';

    Gravando.Texto := 'Abrindo Cadastro de Colorantes...';
    qryCadCol := GetDataSetDestino();

    If (Gravando.Status <> sgGravando) Then
      Exit;

    Gravando.RegistrarProgresso(0, 0, 0);
    qryColorantes.First;

    Try
      While Not qryColorantes.Eof Do
      Begin
        If (Gravando.Status <> sgGravando) Then
          Break;


        If Not IsRegistroExistente(qryCadCol, qryColorantes) Then
          GravarRegistro(qryCadCol, qryColorantes);

        qryColorantes.Next;
        Gravando.RegistrarProgresso(0, qryColorantes.RecNo, qryColorantes.RecordCount);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Cancelar;
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      End;
    End;
  Finally
    If Assigned(qryColorantes) Then
      FreeAndNil(qryColorantes);
  End;
end;

function TGravandoExecucaoAdvanceStrColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

function TGravandoExecucaoAdvanceStrColorantes.fGetPath(intContador,
  intDiretorio: Integer): String;
begin
  Result := Conf.fGet('PATADS');
end;

function TGravandoExecucaoAdvanceStrColorantes.GetSqlDestino: string;
begin
  Result := ' SELECT * FROM ADS_CADCOL';
end;

procedure TGravandoExecucaoAdvanceStrColorantes.GravarRegistro(const qryDestino: IDataSet; qryOrigem: TUniQuery);
begin
  qryDestino.Insert;
  qryDestino.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('ADS_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
  qryDestino.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDestino.FieldByName('COL_IDCOLO').AsString := qryOrigem.FieldByName('IDCOL').AsString;
  qryDestino.FieldByName('COL_CODCOL').AsString := qryOrigem.FieldByName('CODCOL').AsString;
  qryDestino.FieldByName('COL_DESCRI').AsString := qryOrigem.FieldByName('DESCCOL').AsString;
  qryDestino.FieldByName('COL_EMBALA').AsFloat  := qryOrigem.FieldByName('EMB').AsFloat;
  qryDestino.FieldByName('COL_PESESP').AsFloat  := qryOrigem.FieldByName('PESESP').AsFloat;
  qryDestino.Post;
end;

procedure TGravandoExecucaoAdvanceStrColorantes.IsDeletarRegistros;
Var
  qryDelet: IDataSet;
begin
  qryDelet := TAutcomTintaFactory.Get.fGetDataSet;
  qryDelet.SQL := 'DELETE FROM ADS_CADCOL        ';
  qryDelet.ExecSQL;
end;

function TGravandoExecucaoAdvanceStrColorantes.IsRegistroExistente(const qryDestino: IDataSet; qryOrigem: TUniQuery): Boolean;
begin
  Result := qryDestino.Locate('COL_CODCOL', qryOrigem.FieldByName('CODCOL').AsString, []);
end;

end.


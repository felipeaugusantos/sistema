{**************************************************************************}
{* Classe responsável pela geração do cadastro de Linhass da tinta MazaIndustrial *}
{***********************************************************************AC*}
unit untGravandoExecucaoMazaIndustrialLinhas;

interface

uses
  untAbstractGravandoExecucaoMazaIndustrial, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils;

type
  TGravandoExecucaoMazaIndustrialLinhas = class(TAbstractGravandoExecucaoMazaIndustrial)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory, Uni;

{ TGravandoExecucaoMazaIndustrialLinhas }

procedure TGravandoExecucaoMazaIndustrialLinhas.Executar(const gravando: IGravando);
var
  qryCadLin: IDataSet;
  qryLinhas: TUniQuery;
  strSQL: String;
begin
  If (Gravando.Status <> sgGravando) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + '  SELECT           ';
  strSQL := strSQL + '   *               ';
  strSQL := strSQL + '  FROM produto            ';
  strSQL := strSQL + '  WHERE tipo = ''INDUSTRIAL''       ';

  Gravando.Texto := 'Carregando dados do Cadastro de Linhas...';
  qryLinhas := TUniQuery.Create(Nil);
  qryLinhas.Connection := fConexaoPostgreSQL;
  qryLinhas.Close;
  qryLinhas.SQL.Clear;
  qryLinhas.SQL.Add(strSQL);
  qryLinhas.Open;
  qryLinhas.First;

  Gravando.Texto := 'Deletando Cadastro de Linhas...';
  qryCadLin := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadLin.SQL := '  DELETE FROM MZD_CADLIN   ';
  qryCadLin.ExecSQL;
  qryCadLin.SQL.Empty;
  Gravando.Texto := 'Cadastro de Linhas deletado...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('MZD_CADLIN');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Abrindo Cadastro de Linhas...';
  qryCadLin.SQL := '   SELECT * FROM MZD_CADLIN   ';
  qryCadLin.Open;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    While Not qryLinhas.Eof Do
    Begin
      If Not qryCadLin.Locate('LIN_CODIGO', qryLinhas.FieldByName('codigo_produto').AsString, []) Then
      Begin
        qryCadLin.Insert;
        qryCadLin.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MZD_CADLIN', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadLin.FieldByName('LIN_CODIGO').AsString := qryLinhas.FieldByName('codigo_produto').AsString;
        qryCadLin.FieldByName('LIN_DESCRI').AsString := qryLinhas.FieldByName('descricao').AsString;
        qryCadLin.FieldByName('LIN_VOLUME').AsFloat := 900;
        qryCadLin.Post;
      End;

      qryLinhas.Next;
      Gravando.RegistrarProgresso(0, qryLinhas.RecNo, qryLinhas.RecordCount);
    End;
  Finally
    FreeAndNil(qryLinhas);
  End;

End;

function TGravandoExecucaoMazaIndustrialLinhas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Linhas';
end;


end.

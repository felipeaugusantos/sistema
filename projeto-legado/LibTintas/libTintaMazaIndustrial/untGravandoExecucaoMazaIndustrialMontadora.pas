{**************************************************************************}
{* Classe responsável pela geração do cadastro de Montadoras da tinta MazaIndustrial *}
{***********************************************************************AC*}
unit untGravandoExecucaoMazaIndustrialMontadora;

interface

uses
  untAbstractGravandoExecucaoMazaIndustrial, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, DB, Classes, StrUtils, Uni;

type
  TGravandoExecucaoMazaIndustrialMontadora = class(TAbstractGravandoExecucaoMazaIndustrial)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

uses
  untStrUtils, untIDefinicaoTxt, untGenericDefinicaoTxt, untDefinicaoTxtCharacterSet,
  untIDefinicaoTxtCampo, untGenericDefinicaoTxtCampo, untDefinicaoTxtCampoTipo, untADOTxtFactory;

{ TGravandoExecucaoMazaIndustrialMontadora }

procedure TGravandoExecucaoMazaIndustrialMontadora.Executar(const gravando: IGravando);
var
  qryCadMon: IDataSet;
  qryMontadoras: TUniQuery;
  strSQL: String;
begin
  If (Gravando.Status <> sgGravando) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + '  SELECT           ';
  strSQL := strSQL + '   fp.descricao AS DESMON,        ';
  strSQL := strSQL + '   fp.tag_codigo as CODMON        ';
  strSQL := strSQL + '  FROM formula                    ';
  strSQL := strSQL + '  INNER JOIN fabricante_padraocor as fp ON    ';
  strSQL := strSQL + '    fp.id = formula.id_fabricante_padraocor   ';
  strSQL := strSQL + '  INNER JOIN produto as pro ON                ';
  strSQL := strSQL + '    pro.id = formula.id_produto       ';
  strSQL := strSQL + '  WHERE pro.tipo = ''INDUSTRIAL''       ';

  Gravando.Texto := 'Carregando dados do Cadastro de Montadoras...';
  qryMontadoras := TUniQuery.Create(Nil);
  qryMontadoras.Connection := fConexaoPostgreSQL;
  qryMontadoras.Close;
  qryMontadoras.SQL.Clear;
  qryMontadoras.SQL.Add(strSQL);
  qryMontadoras.Open;
  qryMontadoras.First;

  Gravando.Texto := 'Deletando Cadastro de Montadoras...';
  qryCadMon := TAutcomTintaFactory.Get.fGetDataSet;
  qryCadMon.SQL := '  DELETE FROM MZD_CADMON   ';
  qryCadMon.ExecSQL;
  qryCadMon.SQL.Empty;
  Gravando.Texto := 'Cadastro de Montadoras deletado...';

  Gravando.Texto := 'Verificando PROCOD...';
  TAutcomTintaFactory.Get.fInsereProCod('MZD_CADMON');
  Gravando.Texto := 'PROCOD verificado com sucesso...';

  Gravando.Texto := 'Abrindo Cadastro de Montadoras...';
  qryCadMon.SQL := '   SELECT * FROM MZD_CADMON  ';
  qryCadMon.Open;

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    While Not qryMontadoras.Eof Do
    Begin
      If Not qryCadMon.Locate('MON_CODMON', qryMontadoras.FieldByName('CODMON').AsString, []) Then
      Begin
        qryCadMon.Insert;
        qryCadMon.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('MZD_CADMON', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadMon.FieldByName('MON_CODMON').AsString := qryMontadoras.FieldByName('CODMON').AsString;
        qryCadMon.FieldByName('MON_DESCRI').AsString := qryMontadoras.FieldByName('DESMON').AsString;
        qryCadMon.Post;
      End;
      qryMontadoras.Next;
      Gravando.RegistrarProgresso(0, qryMontadoras.RecNo, qryMontadoras.RecordCount);
    End;
  Finally
    FreeAndNil(qryMontadoras);
  End;
End;

function TGravandoExecucaoMazaIndustrialMontadora.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Montadora';
end;


end.

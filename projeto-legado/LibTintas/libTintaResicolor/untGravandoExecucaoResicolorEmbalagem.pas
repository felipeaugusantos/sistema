{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta Resicolor *}
{***************************************************************************PH*}
unit untGravandoExecucaoResicolorEmbalagem;

interface

uses
  untAbstractGravandoExecucaoResicolor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils, Uni, DBFUniProvider;
type
  TGravandoExecucaoResicolorEmbalagem = class(TAbstractGravandoExecucaoResicolor)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoResicolorCores }

procedure TGravandoExecucaoResicolorEmbalagem.Executar(const gravando: IGravando);
Var
  tblCans  : TUniQuery;
  DataCans : TUniConnection;
  intCont  : Integer;
begin
 Try
   Try
     Gravando.Texto := 'Verificando path do arquivo...';

     If Not fValidaPath Then
     Begin
       Gravando.Texto := Format('O arquivo %s não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
       Exit;
     End;

     Gravando.Texto := 'Path verificado com sucesso...';

     If (Gravando.Status <> sgGravando) Then
       Exit;

     Gravando.Texto := 'Carregando dados do Cadastro de Embalagem...';

     DataCans := TUniConnection.Create(Nil);
     DataCans.ProviderName := 'DBF';
     DataCans.LoginPrompt := False;
     DataCans.Database := GetPath;

     If (Not DataCans.Connected) Then
      DataCans.Connected := True;

     tblCans := TUniQuery.Create(Nil);
     tblCans.Connection := DataCans;

     tblCans.Close;
     tblCans.SQL.Clear;
     tblCans.SQL.Add('    SELECT * FROM \CANS.DBF   ');
     tblCans.Open;
     tblCans.First;

     Gravando.Texto := 'Limpando Cadastro de Embalagem inconsistente...';
     qryRSI_CADEMB.Close;
     qryRSI_CADEMB.SQL.Empty;
     qryRSI_CADEMB.SQL := '   DELETE FROM RSI_CADEMB    ';
     qryRSI_CADEMB.ExecSQL;
     qryRSI_CADEMB.SQL.Empty;
     Gravando.Texto := 'Cadastro de Embalagem deletado...';

     If (Gravando.Status <> sgGravando) Then
       Exit;

     qryRSI_CADEMB.SQL := '   SELECT * FROM RSI_CADEMB WHERE FALSE    ';
     qryRSI_CADEMB.Open;

     Gravando.Texto := 'Verificando PROCOD...';
     TAutcomTintaFactory.Get.fInsereProCod('RSI_CADEMB');
     Gravando.Texto := 'PROCOD verificado com sucesso...';

     Gravando.Texto := 'Processando Cadastro de Embalagem...';

     For intCont := 1 To tblCans.RecordCount Do
     Begin

       If (Gravando.Status <> sgGravando) Then
         Break;

       qryRSI_CADEMB.Insert;
       qryRSI_CADEMB.FieldByName('EMB_CODEMB').AsString := TStrUtils.fStrZero(Trim(tblCans.FieldByName('ID').AsString), 2);
       qryRSI_CADEMB.FieldByName('EMB_QTDEMB').AsFloat  := tblCans.FieldByName('NOM_Q').AsFloat;
       qryRSI_CADEMB.FieldByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
       qryRSI_CADEMB.FieldByName('EMB_UNIDAD').AsString := fRetUnidade(tblCans.FieldByName('NOM_Q').AsFloat);
       qryRSI_CADEMB.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('RSI_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
       qryRSI_CADEMB.Post;
       tblCans.Next;
     End;

   Except
     On E: Exception Do
     Begin
       Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
       Exit;
     End;
   End;
 Finally
  Gravando.Texto := 'Cadastro de Embalagem processado com sucesso...';
 End;
end;

function TGravandoExecucaoResicolorEmbalagem.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Embalagem';
end;

end.


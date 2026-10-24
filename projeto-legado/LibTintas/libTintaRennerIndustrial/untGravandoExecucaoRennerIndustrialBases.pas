{**********************************************************************************}
{* Classe responsável pela geração do cadastro de bases da tinta RennerIndustrial *}
{*******************************************************************************AC*}
unit untGravandoExecucaoRennerIndustrialBases;

interface

uses
  untAbstractGravandoExecucaoRennerIndustrial, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, Variants, untStatusGravando, ComObj, Dialogs,
  StrUtils;

type
  TGravandoExecucaoRennerIndustrialBases = class(TAbstractGravandoExecucaoRennerIndustrial)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoRennerIndustrialBases }

procedure TGravandoExecucaoRennerIndustrialBases.Executar(const gravando: IGravando);
Var
  qryAdoBases: TADOQuery;
  qryCadBas: IDataSet;
Const
  strUnidade = 'GL';
begin
  Try
    Try

      Gravando.Texto := 'Validando path do arquivo...';

      If Not fValidaPath Then
      Begin
        Gravando.Texto := Format('O Path %s não existe!', [AnsiReplaceStr(GetPath, '"', '')]);
        Exit;
      End;

      Gravando.Texto := 'Path validado com sucesso...';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := 'Carregando dados do Cadastro de Bases...';

      qryAdoBases := TADOQuery.Create(Nil);
      qryAdoBases.Connection := fGetDataRenner(GetPath);


      qryAdoBases.SQL.Add('       SELECT        ');
      qryAdoBases.SQL.Add('         *           ');
      qryAdoBases.SQL.Add('       FROM          ');
      qryAdoBases.SQL.Add('         Bases       ');
      qryAdoBases.SQL.Add('       ORDER BY 1     ');
      qryAdoBases.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REN_CADBAS');
      gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := 'Deletando Cadastro de Bases...';
      qryCadBas := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadBas.SQL := '    DELETE FROM REN_CADBAS    ';
      qryCadBas.ExecSQL;
      qryCadBas.SQL.Empty;

      Gravando.Texto := Format('Processando arquivos [%s]', [AnsiReplaceStr(GetPath, '"','')]);
      Gravando.RegistrarProgresso(0, 0, 0);


      qryCadBas.SQL := '    INSERT INTO REN_CADBAS      ' ;
      qryCadBas.SQL := qryCadBas.SQL + '    (AUTOINCREM,    ';
      qryCadBas.SQL := qryCadBas.SQL + '     BAS_BASE__,    ';
      qryCadBas.SQL := qryCadBas.SQL + '     BAS_DESCRI,    ';
      qryCadBas.SQL := qryCadBas.SQL + '     BAS_UNIDAD,    ';
      qryCadBas.SQL := qryCadBas.SQL + '     BAS_CODEMP,    ';
      qryCadBas.SQL := qryCadBas.SQL + '     BAS_COMPOB,    ';
      qryCadBas.SQL := qryCadBas.SQL + '     BAS_PRECUS,    ';
      qryCadBas.SQL := qryCadBas.SQL + '     BAS_PREVEN,    ';
      qryCadBas.SQL := qryCadBas.SQL + '     BAS_MARGEM)    ';
      qryCadBas.SQL := qryCadBas.SQL + '  VALUES            ';
      qryCadBas.SQL := qryCadBas.SQL + '   (:AUTOINCREM,    ';
      qryCadBas.SQL := qryCadBas.SQL + '    :BAS_BASE__,    ';
      qryCadBas.SQL := qryCadBas.SQL + '    :BAS_DESCRI,    ';
      qryCadBas.SQL := qryCadBas.SQL + '    :BAS_UNIDAD,    ';
      qryCadBas.SQL := qryCadBas.SQL + '    :BAS_CODEMP,    ';
      qryCadBas.SQL := qryCadBas.SQL + '    :BAS_COMPOB,    ';
      qryCadBas.SQL := qryCadBas.SQL + '    :BAS_PRECUS,    ';
      qryCadBas.SQL := qryCadBas.SQL + '    :BAS_PREVEN,    ';
      qryCadBas.SQL := qryCadBas.SQL + '    :BAS_MARGEM)    ';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      While Not qryAdoBases.Eof Do
      Begin

        If (Gravando.Status <> sgGravando) Then
          Break;

        qryCadBas.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REN_CADBAS',  TAutcomTintaFactory.Get.GetCodEmp);
        qryCadBas.ParamByName('BAS_BASE__').AsString := qryAdoBases.FieldByName('Código da Base').AsString;
        qryCadBas.ParamByName('BAS_DESCRI').AsString := AnsiUpperCase(qryAdoBases.FieldByName('Descrição').AsString);
        qryCadBas.ParamByName('BAS_COMPOB').AsString := qryAdoBases.FieldByName('Componente B').AsString;
        qryCadBas.ParamByName('BAS_UNIDAD').AsString := strUnidade;
        qryCadBas.ParamByName('BAS_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadBas.ParamByName('BAS_PRECUS').AsFloat  := 0.00;
        qryCadBas.ParamByName('BAS_PREVEN').AsFloat  := 0.00;
        qryCadBas.ParamByName('BAS_MARGEM').AsFloat  := 0.00;

        qryCadBas.ExecSQL;
        qryAdoBases.Next;
        gravando.RegistrarProgresso(0, qryAdoBases.RecNo, qryAdoBases.RecordCount);
      End;

    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;

    End;
  Finally
    Gravando.Texto := Format('Arquivo processado! [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
  End;
end;

function TGravandoExecucaoRennerIndustrialBases.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Bases';
end;

end.

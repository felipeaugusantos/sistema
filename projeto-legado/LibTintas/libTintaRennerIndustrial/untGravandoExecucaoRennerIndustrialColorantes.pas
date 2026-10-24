{******************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta RennerIndustrial *}
{***************************************************************************PH*}
unit untGravandoExecucaoRennerIndustrialColorantes;

interface

uses
  untAbstractGravandoExecucaoRennerIndustrial, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, ADODB, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils, Variants;
type
  TGravandoExecucaoRennerIndustrialColorantes = class(TAbstractGravandoExecucaoRennerIndustrial)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoRennerIndustrialCores }

procedure TGravandoExecucaoRennerIndustrialColorantes.Executar(const gravando: IGravando);
Var
  qryAdoCol: TADOQuery;
  qryCadCol: IDataSet;
  qryCadEmb: IDataSet;
Const
  fltQtdGl = 3600;
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

      Gravando.Texto := 'Carregando dados do Cadastro de Colorante...';

      qryAdoCol := TADOQuery.Create(Nil);
      qryAdoCol.Connection := fGetDataRenner(GetPath);
      qryAdoCol.SQL.Add('           SELECT             ');
      qryAdoCol.SQL.Add('             *                ');
      qryAdoCol.SQL.Add('           FROM               ');
      qryAdoCol.SQL.Add('             Pigmentos        ');
      qryAdoCol.SQL.Add('           ORDER BY 1           ');
      qryAdoCol.Open;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REN_CADCOL');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      qryCadCol := TAutcomTintaFactory.Get.fGetDataSet;

      Gravando.Texto := 'Deletando Cadastro de Colorantes...';
      qryCadCol.SQL := '    DELETE FROM REN_CADCOL';
      qryCadCol.ExecSQL;
      qryCadCol.SQL.Empty;


      qryCadCol.SQL := '    INSERT INTO REN_CADCOL      ';
      qryCadCol.SQL := qryCadCol.SQL + '        (AUTOINCREM,        ';
      qryCadCol.SQL := qryCadCol.SQL + '         COL_CODCOL,        ';
      qryCadCol.SQL := qryCadCol.SQL + '         COL_DESCRI,        ';
      qryCadCol.SQL := qryCadCol.SQL + '         COL_CODEMP,        ';
      qryCadCol.SQL := qryCadCol.SQL + '         COL_EMBALA)        ';
      qryCadCol.SQL := qryCadCol.SQL + '    VALUES                  ';
      qryCadCol.SQL := qryCadCol.SQL + '       (:AUTOINCREM,        ';
      qryCadCol.SQL := qryCadCol.SQL + '        :COL_CODCOL,        ';
      qryCadCol.SQL := qryCadCol.SQL + '        :COL_DESCRI,        ';
      qryCadCol.SQL := qryCadCol.SQL + '        :COL_CODEMP,        ';
      qryCadCol.SQL := qryCadCol.SQL + '        :COL_EMBALA);       ';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      Gravando.Texto := Format('Processando arquivo [%s]', [AnsiReplaceStr(GetPath, '"', '')]);
      Gravando.RegistrarProgresso(0, 0, 0);

      While Not qryAdoCol.Eof Do
      Begin
        qryCadCol.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REN_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
        qryCadCol.ParamByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
        qryCadCol.ParamByName('COL_CODCOL').AsString := qryAdoCol.FieldByName('Código do Pigmento').AsString;
        qryCadCol.ParamByName('COL_DESCRI').AsString := qryAdoCol.FieldByName('Descrição').AsString;
        qryCadCol.ParamByName('COL_EMBALA').AsFloat  := 1000;

        qryCadCol.ExecSQL;
        qryAdoCol.Next;
        Gravando.RegistrarProgresso(0, qryAdoCol.RecNo, qryAdoCol.RecordCount);
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

  Gravando.RegistrarProgresso(0, 0, 0);

  If (Gravando.Status <> sgGravando) Then
    Exit;

  Try
    Try
      Gravando.Texto := 'Carregando dados do Cadastro de Embalagem...';

      qryCadEmb := TAutcomTintaFactory.Get.fGetDataSet;
      qryCadEmb.SQL := '    DELETE FROM REN_CADEMB    ';
      qryCadEmb.ExecSQL;
      qryCadEmb.SQL.Empty;

      Gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('REN_CADEMB');
      Gravando.Texto := 'PROCOD verificado com sucesso...';

      Gravando.Texto := Format('Processando Cadastro de %s...', ['Embalagem']);
      Gravando.RegistrarProgresso(0, 0, 0);

      qryCadEmb.SQL := '    INSERT INTO REN_CADEMB    ';
      qryCadEmb.SQL := qryCadEmb.SQL + '   (AUTOINCREM,             ';
      qryCadEmb.SQL := qryCadEmb.SQL + '    EMB_CODEMP,             ';
      qryCadEmb.SQL := qryCadEmb.SQL + '    EMB_CODEMB,             ';
      qryCadEmb.SQL := qryCadEmb.SQL + '    EMB_QTDEMB,             ';
      qryCadEmb.SQL := qryCadEmb.SQL + '    EMB_UNIDAD)             ';
      qryCadEmb.SQL := qryCadEmb.SQL + '  VALUES                    ';
      qryCadEmb.SQL := qryCadEmb.SQL + '    (:AUTOINCREM,             ';
      qryCadEmb.SQL := qryCadEmb.SQL + '     :EMB_CODEMP,             ';
      qryCadEmb.SQL := qryCadEmb.SQL + '     :EMB_CODEMB,             ';
      qryCadEmb.SQL := qryCadEmb.SQL + '     :EMB_QTDEMB,             ';
      qryCadEmb.SQL := qryCadEmb.SQL + '     :EMB_UNIDAD);            ';

      If (Gravando.Status <> sgGravando) Then
        Exit;

      qryCadEmb.ParamByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('REN_CADEMB', TAutcomTintaFactory.Get.GetCodEmp);
      qryCadEmb.ParamByName('EMB_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryCadEmb.ParamByName('EMB_CODEMB').AsString := '1';
      qryCadEmb.ParamByName('EMB_QTDEMB').AsFloat  := fltQtdGl;
      qryCadEmb.ParamByName('EMB_UNIDAD').AsString := strUnidade;
      qryCadEmb.ExecSQL;

      Gravando.RegistrarProgresso(0, 1, 1);

    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;

    End;
  Finally
    Gravando.Texto := Format('Cadastro de %s processado com sucesso!', ['Embalagem']);
  End;


end;

function TGravandoExecucaoRennerIndustrialColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes/Embalagens';
end;


end.


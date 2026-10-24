unit untFrameNegativacaoUF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, Data.DB, Grids, DBGrids,
  Uni, UniClientDataSet, untFuncoes, untFuncoesSimples,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox;

type
  TfrmNegativacaoUF = class(TFrame)
    grpDiasNegativacaoUF: TcxGroupBox;
    pnlGridDiasUF: TPanel;
    grdDiasUF: TDBGrid;
    pnlBotoesGrid: TPanel;
    btnAddUF: TBitBtnLocked;
    btnRemoveUF: TBitBtnLocked;
    btnEditUF: TBitBtnLocked;

    procedure btnAddUFClick(Sender: TObject);
    procedure btnEditUFClick(Sender: TObject);
    procedure btnRemoveUFClick(Sender: TObject);
    procedure grdDiasUFColExit(Sender: TObject);
    procedure grdDiasUFKeyPress(Sender: TObject; var Key: Char);

  private
    FEditavel: Boolean;
    FChaveCarteiraCompleta: String;
    FCodigoBanco: String;
    FCodigoEmpresa: String;

    dsDiasUF: TDataSource;
    cdsDiasUF: TUniClientDataSet;

    procedure pHabilitarControles(Value: Boolean);
    procedure pCarregarDados;
    procedure pGravarLog(stlCfgAnt, stlCfgAtu: TStringList);
    function fGetNomeUF(const AUF: String): String;
    function fUfValida(const AUF: String): Boolean;
    function fRetStrCfg(stlCfg: TStringList): String;
    function IncluirUf(const AUF: String; ADias: Integer): Boolean;
    procedure CarregarConfiguracaoAnterior(const AListaConfiguracoes: TStringList);
    procedure MigrarConfiguracoesAntigas;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExisteNegativacaoConfigurada : Boolean;
    procedure CarregarPorCarteira(AChave, ACodBco, ACodEmp: String);
    function Validar: Boolean;
    function Salvar: Boolean;
    property Editavel: Boolean read FEditavel write pHabilitarControles;
  end;

implementation

{$R *.dfm}

{ TfrmNegativacaoUF }

constructor TfrmNegativacaoUF.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  cdsDiasUF := TUniClientDataSet.Create(Self);
  cdsDiasUF.FieldDefs.Add('NEG_CHAVE_', ftString, 70);
  cdsDiasUF.FieldDefs.Add('NEG_CODBCO', ftString, 3);
  cdsDiasUF.FieldDefs.Add('NEG_CODEMP', ftString, 3);
  cdsDiasUF.FieldDefs.Add('NEG_NOM_UF', ftString, 100);
  cdsDiasUF.FieldDefs.Add('NEG_COD_UF', ftString, 2);
  cdsDiasUF.FieldDefs.Add('NEG_DIA_UF', ftInteger);
  cdsDiasUF.CreateDataSet;

  dsDiasUF := TDataSource.Create(Self);
  dsDiasUF.DataSet := cdsDiasUF;

  grdDiasUF.DataSource := dsDiasUF;
end;

destructor TfrmNegativacaoUF.Destroy;
begin

  inherited;
end;

function TfrmNegativacaoUF.fGetNomeUF(const AUF: String): String;
begin
  if AUF = 'AC' then Result := 'Acre'
  else if AUF = 'AL' then Result := 'Alagoas'
  else if AUF = 'AP' then Result := 'Amapá'
  else if AUF = 'AM' then Result := 'Amazonas'
  else if AUF = 'BA' then Result := 'Bahia'
  else if AUF = 'CE' then Result := 'Ceará'
  else if AUF = 'DF' then Result := 'Distrito Federal'
  else if AUF = 'ES' then Result := 'Espírito Santo'
  else if AUF = 'GO' then Result := 'Goiás'
  else if AUF = 'MA' then Result := 'Maranhão'
  else if AUF = 'MT' then Result := 'Mato Grosso'
  else if AUF = 'MS' then Result := 'Mato Grosso do Sul'
  else if AUF = 'MG' then Result := 'Minas Gerais'
  else if AUF = 'PA' then Result := 'Pará'
  else if AUF = 'PB' then Result := 'Paraíba'
  else if AUF = 'PR' then Result := 'Paraná'
  else if AUF = 'PE' then Result := 'Pernambuco'
  else if AUF = 'PI' then Result := 'Piauí'
  else if AUF = 'RJ' then Result := 'Rio de Janeiro'
  else if AUF = 'RN' then Result := 'Rio Grande do Norte'
  else if AUF = 'RS' then Result := 'Rio Grande do Sul'
  else if AUF = 'RO' then Result := 'Rondônia'
  else if AUF = 'RR' then Result := 'Roraima'
  else if AUF = 'SC' then Result := 'Santa Catarina'
  else if AUF = 'SP' then Result := 'São Paulo'
  else if AUF = 'SE' then Result := 'Sergipe'
  else if AUF = 'TO' then Result := 'Tocantins'
  else Result := '';
end;

function TfrmNegativacaoUF.fUfValida(const AUF: String): Boolean;
begin
  Result := fGetNomeUF(AUF) <> '';
end;

procedure TfrmNegativacaoUF.grdDiasUFColExit(Sender: TObject);
var
  strUF: String;
begin
  if grdDiasUF.SelectedIndex = 0 then
  begin
    if cdsDiasUF.State in [dsInsert, dsEdit] then
    begin
      strUF := Trim(cdsDiasUF.FieldByName('NEG_COD_UF').AsString);

      if strUF <> '' then
      begin
        strUF := UpperCase(strUF);
        cdsDiasUF.FieldByName('NEG_COD_UF').AsString := strUF;

        if not fUfValida(strUF) then
        begin
          fMensagem('ATENÇÃO!', 'UF inválida! Digite uma UF válida (ex: SP, RJ, MG)', ['&OK']);
          cdsDiasUF.FieldByName('NEG_COD_UF').Clear;
          cdsDiasUF.FieldByName('NEG_NOM_UF').Clear;
          grdDiasUF.SetFocus;
          Exit;
        end
        else
        begin
          cdsDiasUF.FieldByName('NEG_NOM_UF').AsString := fGetNomeUF(strUF);
        end;
      end;
    end;
  end;
end;

procedure TfrmNegativacaoUF.grdDiasUFKeyPress(Sender: TObject; var Key: Char);
begin
  if grdDiasUF.SelectedIndex = 0 then
  begin
    if CharInSet(Key, ['a'..'z']) then
      Key := UpCase(Key);
  end;
end;

procedure TfrmNegativacaoUF.btnAddUFClick(Sender: TObject);
begin
  if not FEditavel then
    Exit;

  cdsDiasUF.Append;
  cdsDiasUF.FieldByName('NEG_CHAVE_').AsString := FChaveCarteiraCompleta;
  cdsDiasUF.FieldByName('NEG_CODBCO').AsString := FCodigoBanco;
  cdsDiasUF.FieldByName('NEG_CODEMP').AsString := FCodigoEmpresa;
  cdsDiasUF.FieldByName('NEG_DIA_UF').AsInteger := 0;
  cdsDiasUF.FieldByName('NEG_COD_UF').AsString := '';
  cdsDiasUF.FieldByName('NEG_NOM_UF').AsString := '';

  grdDiasUF.SetFocus;
  grdDiasUF.SelectedIndex := 0;
end;

procedure TfrmNegativacaoUF.btnEditUFClick(Sender: TObject);
begin
  if not FEditavel then
    Exit;

  if cdsDiasUF.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Não há registro selecionado para editar!', ['&OK']);
    Exit;
  end;

  cdsDiasUF.Edit;
  grdDiasUF.SetFocus;
  grdDiasUF.SelectedIndex := 0;
end;

function TfrmNegativacaoUF.fRetStrCfg(stlCfg: TStringList): String;
var
  intCont: Integer;
begin
  Result := '';
  for intCont := 0 to stlCfg.Count - 1 do
    Result := Result + stlCfg.Strings[intCont] + #13+#10;
end;

procedure TfrmNegativacaoUF.btnRemoveUFClick(Sender: TObject);
begin
  if not FEditavel then
    Exit;

  if cdsDiasUF.IsEmpty then
  begin
    fMensagem('ATENÇÃO!', 'Não há registro selecionado para remover!', ['&OK']);
    Exit;
  end;

  if fMensagem('ATENÇÃO!', 'Confirma a remoção da UF ' +
              cdsDiasUF.FieldByName('NEG_COD_UF').AsString + '?', ['&Sim', '&Não']) = 1 then
  begin
    cdsDiasUF.Delete;
  end;
end;

procedure TfrmNegativacaoUF.CarregarPorCarteira(AChave, ACodBco, ACodEmp: String);
begin
  FChaveCarteiraCompleta := AChave;
  FCodigoBanco := ACodBco;
  FCodigoEmpresa := ACodEmp;
  pCarregarDados;
end;

procedure TfrmNegativacaoUF.pCarregarDados;
var
  LQuery: TUniQuery;
begin
  LQuery := Nil;
  MigrarConfiguracoesAntigas;

  cdsDiasUF.DisableControls;
  try
    cdsDiasUF.EmptyDataSet;

    LQuery := fCriaQuery(Self);
    try
      LQuery.SQL.Text :='SELECT                         '+
                        '  NEG_CHAVE_,                  '+
                        '  NEG_CODBCO,                  '+
                        '  NEG_CODEMP,                  '+
                        '  NEG_NOM_UF,                  '+
                        '  NEG_COD_UF,                  '+
                        '  NEG_DIA_UF                   '+
                        'FROM                           '+
                        '  DIANEG                       '+
                        'WHERE NEG_CHAVE_ = :NEG_CHAVE_ '+
                        'ORDER BY NEG_COD_UF            ';

      LQuery.ParamByName('NEG_CHAVE_').AsString := FChaveCarteiraCompleta;
      LQuery.Open;

      while not LQuery.Eof do
      begin
        cdsDiasUF.Append;

        cdsDiasUF.FieldByName('NEG_CHAVE_').AsString := LQuery.FieldByName('NEG_CHAVE_').AsString;
        cdsDiasUF.FieldByName('NEG_CODBCO').AsString := LQuery.FieldByName('NEG_CODBCO').AsString;
        cdsDiasUF.FieldByName('NEG_CODEMP').AsString := LQuery.FieldByName('NEG_CODEMP').AsString;
        cdsDiasUF.FieldByName('NEG_NOM_UF').AsString := LQuery.FieldByName('NEG_NOM_UF').AsString;
        cdsDiasUF.FieldByName('NEG_COD_UF').AsString := LQuery.FieldByName('NEG_COD_UF').AsString;
        cdsDiasUF.FieldByName('NEG_DIA_UF').AsInteger := LQuery.FieldByName('NEG_DIA_UF').AsInteger;

        cdsDiasUF.Post;
        LQuery.Next;
      end;

    except
      on E: Exception do
      begin
        raise;
      end;
    end;

  finally
    if Assigned(LQuery) then
      FreeAndNil(LQuery);
    cdsDiasUF.First;
    cdsDiasUF.EnableControls;
  end;
end;

procedure TfrmNegativacaoUF.pHabilitarControles(Value: Boolean);
begin
  FEditavel := Value;
  btnAddUF.Enabled := Value;
  btnEditUF.Enabled := Value;
  btnRemoveUF.Enabled := Value;
  grpDiasNegativacaoUF.Enabled := Value;
  grdDiasUF.Enabled := Value;
  grdDiasUF.ReadOnly := not Value;
  grdDiasUF.Options := grdDiasUF.Options + [dgEditing];
  if not Value then
    grdDiasUF.Options := grdDiasUF.Options - [dgEditing];

  grdDiasUF.Columns[1].ReadOnly := True;
end;


function TfrmNegativacaoUF.Validar: Boolean;
var
  LUF: string;
  LDias: Integer;
  LUFsExistentes: TStringList;
begin
  Result := True;

  if cdsDiasUF.IsEmpty then
    Exit;

  LUFsExistentes := TStringList.Create;
  try
    cdsDiasUF.DisableControls;
    try
      cdsDiasUF.First;

      while not cdsDiasUF.Eof do
      begin
        LUF := UpperCase(Trim(cdsDiasUF.FieldByName('NEG_COD_UF').AsString));
        LDias := cdsDiasUF.FieldByName('NEG_DIA_UF').AsInteger;

        // 1. UF em branco
        if LUF = '' then
        begin
          fMensagem('ATENÇÃO!', 'Existe registro com UF em branco!', ['&OK']);
          Result := False;
          Exit;
        end;

        // 2. UF inválida
        if not fUfValida(LUF) then
        begin
          fMensagem('ATENÇÃO!', 'UF ' + LUF + ' inválida!', ['&OK']);
          Result := False;
          Exit;
        end;

        // 3. UF duplicada
        if LUFsExistentes.IndexOf(LUF) >= 0 then
        begin
          fMensagem('ATENÇÃO!', 'UF ' + LUF + ' duplicada na lista!', ['&OK']);
          Result := False;
          Exit;
        end;

        // 4. Validação específica de dias por UF
        if (LUF = 'SP') then
        begin
          if not (LDias in [0, 21..99]) then
          begin
            fMensagem('ATENÇÃO!',
              'Preencha o campo "Dias para Negativação (UF: São Paulo)" com valor entre 21 e 99, ' +
              'ou 0 (zero) para não negativar clientes dessa UF.', ['&Ok']);
            Result := False;
            Exit;
          end;
        end
        else if (LUF = 'MS') then
        begin
          if not (LDias in [0, 46..99]) then
          begin
            fMensagem('ATENÇÃO!',
              'Preencha o campo "Dias para Negativação (UF: Mato Grosso do Sul)" com valor entre 46 e 99, ' +
              'ou 0 (zero) para não negativar clientes dessa UF.', ['&Ok']);
            Result := False;
            Exit;
          end;
        end
        else if (LUF = 'PR') then
        begin
          if not (LDias in [0, 31..99]) then
          begin
            fMensagem('ATENÇÃO!',
              'Preencha o campo "Dias para Negativação (UF: Paraná)" com valor entre 31 e 99, ' +
              'ou 0 (zero) para não negativar clientes dessa UF.', ['&Ok']);
            Result := False;
            Exit;
          end;
        end
        else if (LUF = 'RS') then
        begin
          if not (LDias in [0, 11..99]) then
          begin
            fMensagem('ATENÇÃO!',
              'Preencha o campo "Dias para Negativação (UF: Rio Grande do Sul)" com valor entre 11 e 99, ' +
              'ou 0 (zero) para não negativar clientes dessa UF.', ['&Ok']);
            Result := False;
            Exit;
          end;
        end
        else
        begin
          // Demais UFs
          if not (LDias in [0, 1..99]) then
          begin
            fMensagem('ATENÇÃO!',
              'Preencha o campo "Dias para Negativação (UF: ' + LUF + ')" com valor entre 1 e 99, ' +
              'ou 0 (zero) para não negativar clientes dessa UF.', ['&Ok']);
            Result := False;
            Exit;
          end;
        end;

        // Adiciona à lista para controle de duplicidade
        LUFsExistentes.Add(LUF);

        cdsDiasUF.Next;
      end;

    finally
      cdsDiasUF.EnableControls;
    end;

  finally
    LUFsExistentes.Free;
  end;
end;

function TfrmNegativacaoUF.IncluirUf(const AUF: String; ADias: Integer): Boolean;
var
  LQuery: TUniQuery;
begin
  Result := False;
  LQuery := nil;

  Try
    try
      LQuery := fCriaQuery(Self);

      LQuery.SQL.Text :=
        'INSERT INTO DIANEG ' +
        '(NEG_CHAVE_, NEG_CODBCO, NEG_CODEMP, NEG_NOM_UF, NEG_COD_UF, NEG_DIA_UF) ' +
        'VALUES (:NEG_CHAVE_, :NEG_CODBCO, :NEG_CODEMP, :NEG_NOM_UF, :NEG_COD_UF, :NEG_DIA_UF)';

      LQuery.ParamByName('NEG_CHAVE_').AsString := FChaveCarteiraCompleta;
      LQuery.ParamByName('NEG_CODBCO').AsString := FCodigoBanco;
      LQuery.ParamByName('NEG_CODEMP').AsString := FCodigoEmpresa;
      LQuery.ParamByName('NEG_NOM_UF').AsString := fGetNomeUF(AUF);
      LQuery.ParamByName('NEG_COD_UF').AsString := UpperCase(Trim(AUF));
      LQuery.ParamByName('NEG_DIA_UF').AsInteger := ADias;

      LQuery.ExecSQL;
      Result := True;
    except
      on E: Exception do
      begin
        raise ;
      end;
    end;

  finally
    if Assigned(LQuery) then
      FreeAndNil(LQuery);
  end;
end;

function TfrmNegativacaoUF.ExisteNegativacaoConfigurada: Boolean;
begin
  Result := False;

  if not Assigned(cdsDiasUF) then
    Exit;

  if cdsDiasUF.IsEmpty then
    Exit;

  cdsDiasUF.DisableControls;
  try
    cdsDiasUF.First;
    while not cdsDiasUF.Eof do
    begin
      // Verifica se o campo de dias da UF está preenchido com valor > 0
      if cdsDiasUF.FieldByName('NEG_DIA_UF').AsInteger > 0 then
      begin
        Result := True;
        Break;
      end;
      cdsDiasUF.Next;
    end;
  finally
    cdsDiasUF.EnableControls;
  end;
end;

procedure TfrmNegativacaoUF.MigrarConfiguracoesAntigas;
var
  LDiasMS: Integer;
  LDiasSP: Integer;
  LChaveSemEmpresa: String;
begin
  LChaveSemEmpresa := Copy(FChaveCarteiraCompleta, 1, LastDelimiter('-', FChaveCarteiraCompleta) -1);

  if fGetBancoConfig(0, LChaveSemEmpresa, 'MIGROU_DIANEG_UF', '') = 'SIM' then
    Exit;

  LDiasMS := StrToIntDef(fGetBancoConfig(0, LChaveSemEmpresa, 'DIANEGAMS', '0'), 0);
  LDiasSP := StrToIntDef(fGetBancoConfig(0, LChaveSemEmpresa, 'DIANEGASP', '0'), 0);

  fStartTransaction;
  Try
    // Migrar MS
    if LDiasMS > 0 then
      IncluirUf('MS',LDiasMS);

    // Migrar SP
    if LDiasSP > 0 then
      IncluirUf('SP',LDiasSP);

    If fCommit Then
      fGetBancoConfig(1, LChaveSemEmpresa, 'MIGROU_DIANEG_UF', 'SIM');
  Except
    fRollBack;
    Raise;
  End;

end;

procedure TfrmNegativacaoUF.pGravarLog(stlCfgAnt, stlCfgAtu: TStringList);
begin
  pGravaLogAtb(FCodigoBanco, fRetNomBanco(FCodigoBanco), FChaveCarteiraCompleta, strLoginUsuarioLogado, FCodigoEmpresa,
    fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), 'Dias de negativação por estado');
end;

function TfrmNegativacaoUF.Salvar: Boolean;
var
  LListaCfgAnteriores: TStringList;
  LListaCfgAtuais: TStringList;
begin
  Result := True;

  if not FEditavel then
    Exit;

  if not Validar then
  begin
    Result := False;
    Exit;
  end;

  LListaCfgAnteriores := TStringList.Create;
  LListaCfgAtuais := TStringList.Create;

  try
    CarregarConfiguracaoAnterior(LListaCfgAnteriores);

    fStartTransaction;
    Try

      fExecutaSQL(Format('DELETE FROM DIANEG WHERE NEG_CHAVE_ = %s', [QuotedStr(FChaveCarteiraCompleta)]));

      cdsDiasUF.DisableControls;
      cdsDiasUF.First;

      while not cdsDiasUF.Eof do
      begin

        if not IncluirUf(cdsDiasUF.FieldByName('NEG_COD_UF').AsString,
                         cdsDiasUF.FieldByName('NEG_DIA_UF').AsInteger) Then
        Begin
          fRollBack;
          Result := False;
          Exit;
        end;

        LListaCfgAtuais.Add(Format('UF: %s - %s - Dias: %d',
          [cdsDiasUF.FieldByName('NEG_COD_UF').AsString,
           cdsDiasUF.FieldByName('NEG_NOM_UF').AsString,
           cdsDiasUF.FieldByName('NEG_DIA_UF').AsInteger]));

        cdsDiasUF.Next;
      end;

      pGravarLog(LListaCfgAnteriores, LListaCfgAtuais);
      fCommit;
    Except
      fRollBack;
      Raise;
    End;

    pCarregarDados;
  finally
    cdsDiasUF.EnableControls;
    LListaCfgAtuais.Free;
    LListaCfgAnteriores.Free;
  end;
end;

procedure TfrmNegativacaoUF.CarregarConfiguracaoAnterior(const AListaConfiguracoes: TStringList);
var
  LQuery: TUniQuery;
begin
  Try
    AListaConfiguracoes.Clear;

    LQuery := nil;
    try
      LQuery := fCriaQuery(Self);

      LQuery.SQL.Text :=
        'SELECT NEG_COD_UF, NEG_NOM_UF, NEG_DIA_UF ' +
        'FROM DIANEG ' +
        'WHERE NEG_CHAVE_ = :NEG_CHAVE_ ' +
        'ORDER BY NEG_COD_UF';

      LQuery.ParamByName('NEG_CHAVE_').AsString := FChaveCarteiraCompleta;
      LQuery.Open;

      while not LQuery.Eof do
      begin
        AListaConfiguracoes.Add(Format('UF: %s - %s - Dias: %d',
          [LQuery.FieldByName('NEG_COD_UF').AsString,
           LQuery.FieldByName('NEG_NOM_UF').AsString,
           LQuery.FieldByName('NEG_DIA_UF').AsInteger]));

        LQuery.Next;
      end;

    except
      on E: Exception do
      begin
        raise;
      end;
    end;

  finally
    if Assigned(LQuery) then
      FreeAndNil(LQuery);
  end;
end;

end.

unit untPedidosRotasRegiao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem, Uni,
  ExtCtrls, Grids, DBGrids, DB, DBClient, Provider, DBCtrls, frxClass,
  frxExportCSVTestabilidade, DBGridCitel, UniClientDataSet, UniDataSetProvider;

type
  TfrmPedidosRotasRegiao = class(TfrmPai)
    pnlGeral          : TPanel;
    pnlRota           : TPanel;
    pnlPedidos        : TPanel;
    grbRota           : TGroupBox;
    Label1            : TLabel;
    Label2            : TLabel;
    dbgRotas          : TDBGridCitel;
    Label3            : TLabel;
    dspConsulta       : TUniDataSetProvider;
    cdsConsulta       : TUniClientDataSet;
    dtsConsulta       : TDataSource;
    lblSeqRota        : TLabel;
    lblRegiao         : TLabel;
    lblDataEntrega    : TLabel;
    Label6            : TLabel;
    lblVeiPadrao      : TLabel;
    btnAlteraVeiculo  : TBitBtnLocked;
    ckbLiberaSeparacao: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    lblPesTot: TLabel;
    lblValTot: TLabel;
    lblVlrMin         : TLabel;
    btnCalculaCustoRota: TBitBtnLocked;
    pnlLegenda: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAlteraVeiculoClick(Sender: TObject);
    procedure ckbLiberaSeparacaoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCalculaCustoRotaClick(Sender: TObject);
    procedure pCarregaCidadesRota(var strLocations : TStrings);

  private
    { Private declarations }
    qryConsulta : TUniQuery;

    procedure pPreencheCamposRota;
    procedure pPreencheCamposEndereco;
    procedure pInserirPedido;
    procedure pDeletarPedido;

    function fRetSQLEspDoc(strEspDoc: String): String;
    function fRetSQL: String;
    function fPesoTotal: Double;
    function fValorTotal: Double;
  public
    { Public declarations }
    strCodRot: String;
    function fAbreConsulta(blnLike: Boolean): Boolean;
  end;


implementation

uses untFuncoesSimples, untCadVeiculoEntregaRegiao, untValidacoesRotasRegiao,
  QualP.Classe.Controle, untEnderecoEntrega, untCustosFreteQualP,
  untIncluiPedidoRotasRegiao;

{$R *.dfm}

{ TfrmPedidosRotasRegiao }

procedure TfrmPedidosRotasRegiao.btnCalculaCustoRotaClick(Sender: TObject);
var
  frmCustosFreteQualP : TfrmCustosFreteQualP;
  LControleQualP      : TControleQualP;
  stlLocations        : TStrings;
  strKey              : String;
begin
  inherited;

  if not btnCalculaCustoRota.Visible then
    Exit;

  stlLocations   := TStringList.Create;
  LControleQualP := TControleQualP.Create;
  pCriarFormularios(TfrmCustosFreteQualP, frmCustosFreteQualP);
  try
    Try
      LControleQualP.fSetCodRot(lblSeqRota.Caption);
      LControleQualP.SetPlacaVeiculo(cdsConsulta.FieldByName('REV_PLAVEI').AsString);
      LControleQualP.Peso := StrToFloatDef(lblPesTot.Caption, 0);
      LControleQualP.blnUsaFatVendas := False;
      LControleQualP.OptimizedRoute  := True;

      pCarregaCidadesRota(stlLocations);
      LControleQualP.strLocations := stlLocations;

      LControleQualP.pPrepararCalculo;

      For strKey In LControleQualP.CustosPorCidade.Keys Do
      Begin
        frmCustosFreteQualP.cdsConsulta.Append;
        frmCustosFreteQualP.cdsConsulta.FieldByName('CIDADE').AsString           := strKey;
        frmCustosFreteQualP.cdsConsulta.FieldByName('VALOR_COMBUSTIVEL').AsFloat := LControleQualP.CustosPorCidade[strKey].Combustivel;
        frmCustosFreteQualP.cdsConsulta.FieldByName('VALOR_PEDAGIO').AsFloat     := LControleQualP.CustosPorCidade[strKey].Pedagio;
        frmCustosFreteQualP.cdsConsulta.FieldByName('TOTAL').AsFloat             := LControleQualP.CustosPorCidade[strKey].Combustivel
                                                                                  + LControleQualP.CustosPorCidade[strKey].Pedagio;
        frmCustosFreteQualP.cdsConsulta.Post;
      End;

      LControleQualP.pCalcular;

      frmCustosFreteQualP.pCarregaTotais(LControleQualP.CustoPedagio, LControleQualP.CustoCombustivel, LControleQualP.ValorAcrescimoVeiculo);

      frmCustosFreteQualP.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmPedidosRotasRegiao.btnCalculaCustoRotaClick]');
        Exit;
      End;
    End;
  finally
    pFreeAndNil(frmCustosFreteQualP);
    FreeAndNil(LControleQualP);
    FreeAndNil(stlLocations);
  end;
end;

procedure TfrmPedidosRotasRegiao.btnAlteraVeiculoClick(Sender: TObject);
var
  blnConfirma: Boolean;
begin
  inherited;

  Try
    pCriarFormularios(TfrmCadVeiculoEntregaRegiao,frmCadVeiculoEntregaRegiao);
    frmCadVeiculoEntregaRegiao.strCodRot := strCodRot;
    frmCadVeiculoEntregaRegiao.ShowModal;
    blnConfirma := frmCadVeiculoEntregaRegiao.blnConfirma;
  Finally
    pFreeAndNil(frmCadVeiculoEntregaRegiao);
  End;

  If blnConfirma Then
    fAbreConsulta(False);
end;

procedure TfrmPedidosRotasRegiao.ckbLiberaSeparacaoClick(Sender: TObject);
var
  objRotReg : TRotReg;
begin
  inherited;

  objRotReg := nil;
  Try
    objRotReg := TRotReg.Create(Self);
    objRotReg.strCodRot := strCodRot;

    If objRotReg.fLiberaImpSeparacao(ckbLiberaSeparacao.Checked) Then
      fAbreConsulta(False);
  Finally
    objRotReg.Free;
  End;
end;

function TfrmPedidosRotasRegiao.fAbreConsulta(blnLike: Boolean): Boolean;
Begin
  Try
    With qryConsulta, Sql Do
    Begin
      Close;
      cdsConsulta.Close;
      Clear;

      Add(fRetSQL);

      ParamByName('CODROT').AsString := strCodRot;

      Open;

      pSetaClient(qryConsulta);

      cdsConsulta.Open;



      TFloatField(cdsConsulta.FieldByName('FGO_PESBRU')).DisplayFormat := '#,##0.00';
      TFloatField(cdsConsulta.FieldByName('FGO_VLRCON')).DisplayFormat := '#,##0.00';

      pPreencheCamposRota;
      pPreencheCamposEndereco;

      Result := True;
    End;

  Except
    Result := False;
  End;
end;

procedure TfrmPedidosRotasRegiao.pDeletarPedido;
const
  LSQL = 'UPDATE EXTGOR SET FGO_CODROT = NULL WHERE FGO_SEQFGO = :SEQFGO';
var
  LQry: TUniQuery;
begin
  if (not fVerificaAcessoSistema('RRGEPD')) then
  begin
    fMensagem('', 'Operador sem Direito de Acesso!' , ['&Ok']);
    Exit;
  end;

  if fMensagem('', 'Deseja excluir o pedido "' + cdsConsulta.FieldByName('PEDIDO').AsString + '" da entrega?', ['&Sim', '&Não']) = 2 then
    Exit;

  LQry := fCriaQuery;

  try
    fStartTransaction;
    
    try
      LQry.SQL.Text := LSQL;
      LQry.ParamByName('SEQFGO').AsString := cdsConsulta.FieldByName('SEQFGO').AsString;
      LQry.ExecSQL;

      fCommit;
    except
      on E: Exception do
      begin
        fRollback;
        pMensagensErro(E.Message, '[pDeletarPedido]');
      end;
    end;                 
        
    fAbreConsulta(False);
  finally
    FreeAndNil(LQry);
  end;
end;

procedure TfrmPedidosRotasRegiao.pInserirPedido;
var
  frmIncluiPedidoRotasRegiao: TfrmIncluiPedidoRotasRegiao;
begin
  if (not fVerificaAcessoSistema('RRGIPD')) then
  begin
    fMensagem('', 'Operador sem Direito de Acesso!' , ['&Ok']);
    Exit;
  end;

  pCriarFormularios(TfrmIncluiPedidoRotasRegiao, frmIncluiPedidoRotasRegiao);

  try
    frmIncluiPedidoRotasRegiao.strCodRot := strCodRot;
    frmIncluiPedidoRotasRegiao.ShowModal();

    if frmIncluiPedidoRotasRegiao.ModalResult = mrOk then
      fAbreConsulta(False);
  finally
    pFreeAndNil(frmIncluiPedidoRotasRegiao);
  end;
end;

procedure TfrmPedidosRotasRegiao.FormCreate(Sender: TObject);
begin
  inherited;
  strCodRot           := '';
  qryConsulta         := fCriaQuery;
  dspConsulta.DataSet := qryConsulta;

end;

procedure TfrmPedidosRotasRegiao.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F2: BtnAlteraVeiculo.Click;
    VK_F3: btnCalculaCustoRota.Click;
    VK_INSERT: pInserirPedido;
    VK_DELETE: pDeletarPedido;
  End;
end;

procedure TfrmPedidosRotasRegiao.FormShow(Sender: TObject);
begin
  inherited;

  pPreencheCamposRota;
  btnCalculaCustoRota.Visible := fCfgSis('QLPUSA', varBoolean);
  ckbLiberaSeparacao.Checked := IIF(fCfgSis('SUGSEP', varInteger) = 1, True, False);
end;

function TfrmPedidosRotasRegiao.fPesoTotal: Double;
begin
  Result := 0;

  With cdsConsulta Do
  Begin
    Try
      First;
      DisableControls;

      While Not Eof Do
      Begin
        Result := Result + FieldByName('FGO_PESBRU').AsFloat;
        Next;
      End;
    Finally
      EnableControls;
      First;
    End;
  End;
end;

procedure TfrmPedidosRotasRegiao.pCarregaCidadesRota(var strLocations : TStrings);
begin
  cdsConsulta.DisableControls;
  cdsConsulta.First;

  while not cdsConsulta.EOF do
  begin
    strLocations.Add(cdsConsulta.FieldByName('ETC_CEPENT').AsString);
    cdsConsulta.Next;
  end;
  cdsConsulta.First;
  cdsConsulta.EnableControls;
end;

function TfrmPedidosRotasRegiao.fRetSQLEspDoc(strEspDoc: String): String;
begin
  Result := ' SELECT ENT_CODIGO,                                                      '+
             '         ENT_CODREG,                                                     '+
             '         REG_DESREG,                                                     '+
             '         CONCAT(ENT_CODREG," - ",REG_DESREG) AS REGIAO,                  '+
             '         ENT_DTAENT,                                                     '+
             '         FGO_CODCLI,                                                     '+
             '         CLI_NOMCLI,                                                     '+
             '         FGO_NUMDOC,                                                     '+
             '         FGO_ESPDOC,                                                     '+
             '         FGO_CODEMP,                                                     '+
             '         CONCAT(FGO_NUMDOC,"-",FGO_ESPDOC,"-",FGO_CODEMP) AS PEDIDO,     '+
             '         FDO_TIPFAT,                                                     '+
             '         FDO_NUMFAT,                                                     '+
             '         FDO_EMPFAT,                                                     '+
             '         CONCAT(FDO_NUMFAT,"-",FDO_TIPFAT,"-",FDO_EMPFAT) AS DOCFAT,     '+
             '         IFNULL(SUM(FATDOR.FDO_VLRCON),0)  AS FGO_VLRCON,                '+
             '         IFNULL(SUM(EXTDOR.FDO_PESBRU),0) AS FGO_PESBRU,                 '+
             '         FGO_CODVEN,                                                     '+
             '         OPE_NOMOPE,                                                     '+
             '         ROT_HOREMI,                                                     '+
             '         ROT_VLRMIN,                                                     '+
             '         IFNULL(REV_PLAVEI, "") AS REV_PLAVEI,                           '+
             '         ENT_LIBSEP,                                                     '+
             '         ETC_CEPENT,                                                     '+
             '         FATDOR.AUTOINCREM AS AUTINC,                                    '+
             '         CAST("" AS CHAR(60)) AS CIDEST,                                 '+
             '         FATGOR.AUTOINCREM AS SEQFGO                                     '+
             '   FROM ENTREG                                                           '+
             '   INNER JOIN ROTREG ON ROT_CODREG = ENT_CODREG                          '+
             '   INNER JOIN CADREG ON REG_CODREG = ENT_CODREG                          '+
             '   INNER JOIN EXTGOR ON FGO_CODROT = ENT_CODIGO                          '+
             '   INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO                   '+
             '   INNER JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER            '+
             '   INNER JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO            '+
             '   INNER JOIN AUXGOR ON FATDOR.FDO_SEQGER = AUXGOR.AUX_SEQGER            '+
             '   INNER JOIN ENTCLI ON ENTCLI.AUTOINCREM = AUXGOR.AUX_ENTGER            '+
             '   INNER JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI                          '+
             '   INNER JOIN CADOPE ON OPE_CODOPE = FGO_CODVEN                          '+
             '   LEFT  JOIN ROTREV ON REV_CODIGO = ENT_ROTVEI                          '+
             '   WHERE ENT_CODIGO = :CODROT                                             '+
             '     AND ((IFNULL(FGO_MOTBAI, "") = "") OR ((IFNULL(FGO_MOTBAI, "") <> "") AND (IFNULL(FDO_NUMFAT, "") <> "")))         '+
             '     AND FGO_ESPDOC = "'+strEspDoc+'" '+
             '     AND IFNULL(FDO_TIPFAT, "") <> "PD" '+
             '   GROUP BY ENT_CODIGO, ENT_CODREG, REG_DESREG, CONCAT(ENT_CODREG," - ",REG_DESREG), ENT_DTAENT,                       '+
             '         FGO_CODCLI, CLI_NOMCLI, FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP, CONCAT(FGO_NUMDOC,"-",FGO_ESPDOC,"-",FGO_CODEMP),  '+
             '         FDO_TIPFAT, FDO_NUMFAT, FDO_EMPFAT, CONCAT(FDO_NUMFAT,"-",FDO_TIPFAT,"-",FDO_EMPFAT),                          '+
             '         FGO_CODVEN, OPE_NOMOPE, ROT_HOREMI, ROT_VLRMIN,  IFNULL(REV_PLAVEI, ""), ENT_LIBSEP                            ';
end;

function TfrmPedidosRotasRegiao.fRetSQL: String;
begin
  Result := fRetSQLEspDoc('OR') +
            ' UNION ALL '+
            fRetSQLEspDoc('PD');
end;

function TfrmPedidosRotasRegiao.fValorTotal: Double;
begin
  Result := 0;

  With cdsConsulta Do
  Begin
    Try
      First;
      DisableControls;

      While Not Eof Do
      Begin
        Result := Result + FieldByName('FGO_VLRCON').AsFloat;
        Next;
      End;
    Finally
      EnableControls;
      First;
    End;
  End;
end;

procedure TfrmPedidosRotasRegiao.pPreencheCamposEndereco;
var intRecNo : Integer;
begin
  intRecNo := cdsConsulta.RecNo;
  Try
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While (Not cdsConsulta.Eof) Do
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('CIDEST').AsString := fRetornaCidadeUFFatDor(cdsConsulta.FieldByName('AUTINC').AsString);
      cdsConsulta.Post;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.RecNo := intRecNo;
    cdsConsulta.EnableControls;
  End;
end;

procedure TfrmPedidosRotasRegiao.pPreencheCamposRota;
var
  fltValorTotal : Double;
begin
  With cdsConsulta Do
  Begin
    lblSeqRota.Caption     := FieldByName('ENT_CODIGO').AsString;
    lblRegiao.Caption      := FieldByName('REGIAO').AsString;
    lblDataEntrega.Caption := DateToStr(FieldByName('ENT_DTAENT').AsDateTime);

    If Not fEmptyStr(FieldByName('REV_PLAVEI').AsString) Then
      lblVeiPadrao.Caption := FieldByName('REV_PLAVEI').AsString + ' - ' +
                              fRetornaDescricaoVeic(FieldByName('REV_PLAVEI').AsString)
    Else
      lblVeiPadrao.Caption := 'Nenhum veículo informado';

    fltValorTotal     := fValorTotal;
    lblPesTot.Caption := FormatFloat('###,##0.00', fPesoTotal);
    lblValTot.Caption := FormatFloat('###,##0.00', fltValorTotal);
    lblVlrMin.Caption := FormatFloat('###,##0.00', FieldByName('ROT_VLRMIN').AsFloat);

    ckbLiberaSeparacao.Checked := (FieldByName('ENT_LIBSEP').AsString = 'S');
  End;
end;


end.

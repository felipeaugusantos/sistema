unit untFatLoteRapido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, UniClientDataSet,
  cxCurrencyEdit, untTypesSistema;

type
  TfrmFatLoteRapido = class(TfrmPaiConfirma)
    grdLotesTv: TcxGridDBTableViewCitel;
    grdLotesLv: TcxGridLevel;
    grdLotes: TcxGridCitel;
    dsLotes: TDataSource;
    grdLotesTvLOT_CODBAR: TcxGridDBColumn;
    grdLotesTvSALDOS: TcxGridDBColumn;
    grdLotesTvQTDE: TcxGridDBColumn;
    grdLotesTvSALPED: TcxGridDBColumn;
    grdLotesTvENTPRE: TcxGridDBColumn;
    grdLotesTvENTAGU: TcxGridDBColumn;
    grdLotesTvSALDIS: TcxGridDBColumn;
    procedure FormDestroy(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FCodProduto: String;
    FCodEmpresa: String;
    FCdsLotes: TUniClientDataSet;
    FfIncluirItem: TfIncluiItem;
    procedure AdicionarItens;
    procedure InformaSaldos(ACodIte, ACodEmp: string);
    function ContinuarIncluindo(AQryLote: TDataSet; AQtdIncluida: Double): Boolean;
    function ValidaQtde(): Boolean;
    procedure BeforePostLotes(DataSet: TDataSet);
  public
    { Public declarations }
    procedure Show(const ACodProduto, ACodEmpresa: String; const AfIncluirItem: TfIncluiItem);
  end;

implementation

{$R *.dfm}

uses
  Uni, untFuncoesSimples, untTFatReservaSaldo, untTFatEntregaFutura, untIFatEntregaFutura,
  untIFatReservaSaldo;

{ TfrmFatLoteRapido }

procedure TfrmFatLoteRapido.AdicionarItens;
var
  LQryLote: TUniQuery;
  LQtd: Double;
  LQtdIncluida: Double;
begin
  FCdsLotes.Filtered := False;
  FCdsLotes.Filter := 'QTDE > 0';
  FCdsLotes.FIltered := True;

  LQryLote := fCriaQuery;
  try
    while not FCdsLotes.Eof do
    begin
      LQryLote.Close;
      LQryLote.SQL.Clear;
      LQryLote.SQL.Add('SELECT LOT_NUMLOT, LOT_SALDOS');
      LQryLote.SQL.Add('FROM CADLOT');
      LQryLote.SQL.Add('WHERE');
      LQryLote.SQL.Add('  LOT_CODITE = :CODITE AND');

      If fEmptyStr(FCdsLotes.FieldByName('LOT_CODBAR').AsString) Then
        LQryLote.SQL.Add('  LOT_NUMLOT = :CODLOT AND')
      Else
        LQryLote.SQL.Add('  LOT_CODBAR = :CODLOT AND');

      LQryLote.SQL.Add('  LOT_SALDOS > 0');
      LQryLote.SQL.Add('ORDER BY LOT_CODITE,');
      LQryLote.SQL.Add('  LOT_CODEMP,');
      LQryLote.SQL.Add('  LOT_NUMLOT');

      LQryLote.ParamByName('CODITE').AsString := FCodProduto;
      LQryLote.ParamByName('CODLOT').AsString := FCdsLotes.FieldByName('LOT_CODLOT').AsString;
      LQryLote.Open;

      LQtdIncluida := 0;

      while ContinuarIncluindo(LQryLote, LQtdIncluida)  do
      begin
        If fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis Then
        Begin
          if (FCdsLotes.FieldByName('QTDE').AsFloat - LQtdIncluida) > FCdsLotes.FieldByName('SALDOS').AsFloat then
            LQtd := FCdsLotes.FieldByName('SALDOS').AsFloat
          else
            LQtd := FCdsLotes.FieldByName('QTDE').AsFloat - LQtdIncluida;
        End
        Else
        Begin
          if (FCdsLotes.FieldByName('QTDE').AsFloat - LQtdIncluida) > LQryLote.FieldByName('LOT_SALDOS').AsFloat then
            LQtd := LQryLote.FieldByName('LOT_SALDOS').AsFloat
          else
            LQtd := FCdsLotes.FieldByName('QTDE').AsFloat - LQtdIncluida;
        End;

        FfIncluirItem(
          FCodProduto,
          LQryLote.FieldByName('LOT_NUMLOT').AsString,
          LQtd,
          0,
          '',
          '',
          '',
          0,
          '',
          False,
          FCodEmpresa);

        LQtdIncluida := LQtdIncluida + LQtd;
        LQryLote.Next;
      end;

      FCdsLotes.Next;
    end;
  finally
    FreeAndNil(LQryLote);
  end;
end;

procedure TfrmFatLoteRapido.BeforePostLotes(DataSet: TDataSet);
begin
  if not ValidaQtde then
  begin
    fMensagem('','Qtd. Venda não pode ser maior que o saldo!',['&OK']);
    Abort;
  end;
end;

procedure TfrmFatLoteRapido.btnConfirmaClick(Sender: TObject);
begin
//  inherited;
  if not ValidaQtde then
  begin
    fMensagem('','Qtd. Venda não pode ser maior que o saldo!',['&OK']);
    Exit;
  end;

  ModalResult := MrOk;
end;

function TfrmFatLoteRapido.ContinuarIncluindo(AQryLote: TDataSet; AQtdIncluida: Double): Boolean;
begin
  Result := True;
  if AQryLote.Eof then
    Exit(False);

  if AQtdIncluida >= FCdsLotes.FieldByName('QTDE').AsFloat then
    Exit(False);
end;

procedure TfrmFatLoteRapido.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FCdsLotes) then
    FreeAndNil(FCdsLotes);
end;

procedure TfrmFatLoteRapido.InformaSaldos(ACodIte, ACodEmp: string);
var
  LCdsSaldos: TUniQuery;
  LEntPre,
  LEntFal,
  LEntAgu,
  LEstFis,
  LSalPed,
  LSalEnd,
  LSalOrd,
  LSalGar,
  LSalExt,
  LBaiFut,
  LSalDis: Double;
begin
  FCdsLotes.DisableControls;
  LCdsSaldos := fCriaQuery;

  try
    FCdsLotes.First;

    while not FCdsLotes.Eof do
    begin
      FCdsLotes.Edit;

      LCdsSaldos.Close;
      LCdsSaldos.SQL.Clear;
      LCdsSaldos.SQL.Add('SELECT LOT_NUMLOT, LOT_SALDOS');
      LCdsSaldos.SQL.Add('FROM CADLOT');
      LCdsSaldos.SQL.Add('WHERE LOT_CODITE = :CODITE');
      LCdsSaldos.SQL.Add('AND LOT_CODEMP = :CODEMP');

      If fEmptyStr(FCdsLotes.FieldByName('LOT_CODBAR').AsString) Then
        LCdsSaldos.SQL.Add('AND LOT_NUMLOT = :CODLOT')
      Else
        LCdsSaldos.SQL.Add('AND LOT_CODBAR = :CODLOT');

      LCdsSaldos.SQL.Add('AND LOT_NUMLOT <> "A DEFINIR"');
      LCdsSaldos.SQL.Add('AND LOT_NUMLOT <> "GARANTIA"');
      LCdsSaldos.SQL.Add('AND LOT_SALDOS <> 0');

      LCdsSaldos.ParamByName('CODITE').AsString := ACodIte;
      LCdsSaldos.ParamByName('CODEMP').AsString := ACodEmp;
      LCdsSaldos.ParamByName('CODLOT').AsString := FCdsLotes.FieldByName('LOT_CODLOT').AsString;
      LCdsSaldos.Open;
      LCdsSaldos.First;

      LEntPre := 0;
      LEntFal := 0;
      LEntAgu := 0;
      LEstFis := 0;
      LSalPed := 0;
      LSalEnd := 0;
      LSalOrd := 0;
      LSalGar := 0;
      LSalExt := 0;
      LBaiFut := 0;
      LSalDis := 0;

      while not LCdsSaldos.Eof do
      begin
        LEntPre := LEntPre + TEntregaFutura.New(
                               TParamEF.New()
                                 .CodIte(ACodIte)
                                 .CodEmp(ACodEmp)
                                 .Lote(LCdsSaldos.FieldByName('LOT_NUMLOT').AsString)
                                 .Faturamento(True)
                                 .TipoTE(tteNenhuma)
                                 .TipoEF(tefPrevisao)
                               ).Total();

        LEntFal := LEntFal + TEntregaFutura.New(
                               TParamEF.New()
                                 .CodIte(ACodIte)
                                 .CodEmp(ACodEmp)
                                 .Lote(LCdsSaldos.FieldByName('LOT_NUMLOT').AsString)
                                 .Faturamento(True)
                                 .TipoTE(tteNenhuma)
                                 .TipoEF(tefFaltaDeProduto)
                               ).Total();

        LEntAgu := LEntAgu + TEntregaFutura.New(
                               TParamEF.New()
                                 .CodIte(ACodIte)
                                 .CodEmp(ACodEmp)
                                 .Lote(LCdsSaldos.FieldByName('LOT_NUMLOT').AsString)
                                 .Faturamento(True)
                                 .TipoTE(tteNenhuma)
                                 .TipoEF(tefAguardandoCliente)
                               ).Total();

        LEstFis := LEstFis + LCdsSaldos.FieldByName('LOT_SALDOS').AsFloat + LEntPre + LEntFal + LEntAgu;

        LSalPed := LSalPed + TSaldoReservado.New(
                               TReservaParametros.New()
                                 .EmpresaItem(ACodEmp)
                                 .CodigoItem(ACodIte)
                                 .CodEmpresa(ACodEmp)
                                 .NumeroLote(LCdsSaldos.FieldByName('LOT_NUMLOT').AsString)
                                 .TipoReserva(trsPedidoVenda)
                                 .DesconsideraPedidosEnderecamento(True)
                               ).fGetQuantidade();

        LSalEnd := LSalEnd + TSaldoReservado.New(
                               TReservaParametros.New()
                                 .EmpresaItem(ACodEmp)
                                 .CodigoItem(ACodIte)
                                 .CodEmpresa(ACodEmp)
                                 .NumeroLote(LCdsSaldos.FieldByName('LOT_NUMLOT').AsString)
                                 .TipoReserva(trsEnderecamento)
                               ).fGetQuantidade();

        if fCfgSis('ORDPRO', varBoolean) then
          LSalOrd := LSalOrd + TSaldoReservado.New(
                                 TReservaParametros.New()
                                   .EmpresaItem(ACodEmp)
                                   .CodigoItem(ACodIte)
                                   .CodEmpresa(ACodEmp)
                                   .NumeroLote(LCdsSaldos.FieldByName('LOT_NUMLOT').AsString)
                                   .TipoReserva(trsOrdemProducao)
                                 ).fGetQuantidade();

        LSalGar := LSalGar + TSaldoReservado.New(
                               TReservaParametros.New()
                                 .EmpresaItem(ACodEmp)
                                 .CodigoItem(ACodIte)
                                 .CodEmpresa(ACodEmp)
                                 .NumeroLote(LCdsSaldos.FieldByName('LOT_NUMLOT').AsString)
                                 .TipoReserva(trsGarantia)
                               ).fGetQuantidade();

        LSalExt := LSalExt + TSaldoReservado.New(
                               TReservaParametros.New()
                                 .EmpresaItem(ACodEmp)
                                 .CodigoItem(ACodIte)
                                 .CodEmpresa(ACodEmp)
                                 .NumeroLote(LCdsSaldos.FieldByName('LOT_NUMLOT').AsString)
                                 .TipoReserva(trsExterno)
                               ).fGetQuantidade();

        If (LSalExt < 0) Then
          LSalExt := 0;

        LBaiFut := LBaiFut + TSaldoReservado.New(
                               TReservaParametros.New()
                                 .EmpresaItem(ACodEmp)
                                 .CodigoItem(ACodIte)
                                 .CodEmpresa(ACodEmp)
                                 .NumeroLote(LCdsSaldos.FieldByName('LOT_NUMLOT').AsString)
                                 .TipoReserva(trsPedidoBaixaEntregaFuturaReservSaldo)
                               ).fGetQuantidade();

        LSalDis := LSalDis + fCalculaSaldoDisponivel(fCfgSis('CALSAL', varInteger), LEstFis, LSalGar, LSalPed, LSalEnd, LSalOrd, LEntPre, LEntFal, LEntAgu, LSalExt, LBaiFut);

        LCdsSaldos.Next;
      end;

      FCdsLotes.FieldByName('SALDOS').AsFloat := LEstFis;
      FCdsLotes.FieldByName('SALPED').AsFloat := LSalPed;
      FCdsLotes.FieldByName('ENTPRE').AsFloat := LEntPre;
      FCdsLotes.FieldByName('ENTAGU').AsFloat := LEntAgu;
      FCdsLotes.FieldByName('SALDIS').AsFloat := LSalDis;
      FCdsLotes.Post;

      FCdsLotes.Next;
    end;

    grdLotesTvSALPED.Visible := True;
    grdLotesTvENTPRE.Visible := True;
    grdLotesTvENTAGU.Visible := True;
    grdLotesTvSALDIS.Visible := True;
  finally
    FCdsLotes.First;
    FCdsLotes.EnableControls;
    FreeAndNil(LCdsSaldos);
  end;
end;

procedure TfrmFatLoteRapido.Show(const ACodProduto, ACodEmpresa: String; const AfIncluirItem: TfIncluiItem);
var
  LQryLotes: TUniQuery;
begin
  FCodProduto := ACodProduto;
  FCodEmpresa := ACodEmpresa;

  LQryLotes := fCriaQuery;
  try
    LQryLotes.SQL.Add('SELECT IF(IFNULL(LOT_CODBAR,"") <> "", LOT_CODBAR, LOT_NUMLOT) AS LOT_CODLOT, ');
    LQryLotes.SQL.Add('       LOT_CODBAR, 0.0 as SALPED, 0.0 as ENTPRE, 0.0 as ENTAGU, 0.0 as SALDIS, 0.0 as QTDE');

    If fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis Then
    Begin
      LQryLotes.SQL.Add(', 0.0 as SALDOS');
    End
    Else
    Begin
      LQryLotes.SQL.Add(',SUM( LOT_SALDOS ) as SALDOS');
    End;

    LQryLotes.SQL.Add('FROM CADLOT');
    LQryLotes.SQL.Add('WHERE');
    LQryLotes.SQL.Add('  LOT_CODITE = :CODITE      AND');
    LQryLotes.SQL.Add('  LOT_CODEMP = :CODEMP      AND');
    LQryLotes.SQL.Add('  LOT_NUMLOT <> "A DEFINIR" AND');
    LQryLotes.SQL.Add('  LOT_NUMLOT <> "GARANTIA"  AND');
    LQryLotes.SQL.Add('  LOT_SALDOS <> 0');
    LQryLotes.SQL.Add('GROUP BY LOT_CODITE, LOT_CODEMP, IF(IFNULL(LOT_CODBAR,"") <> "", LOT_CODBAR, LOT_NUMLOT)');

    LQryLotes.ParamByName('CODITE').AsString := ACodProduto;
    LQryLotes.ParamByName('CODEMP').AsString := ACodEmpresa;
    LQryLotes.Open;

    FCdsLotes := fCriaClientDatset(LQryLotes);
    FCdsLotes.BeforePost := BeforePostLotes;
    dsLotes.DataSet := FCdsLotes;

    If fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis Then
      InformaSaldos(ACodProduto, ACodEmpresa);

    FfIncluirItem := AfIncluirItem;

    if Self.ShowModal = MrOk Then
    begin
      AdicionarItens;
    end;
  finally
    FreeAndNil(LQryLotes);
  end;
end;

function TfrmFatLoteRapido.ValidaQtde: Boolean;
begin
  Result := True;
  if not (FCdsLotes.State in dsEditModes) then
    Exit;

  If fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis Then
  Begin
    if (FCdsLotes.FieldByName('QTDE').AsFloat > FCdsLotes.FieldByName('SALDIS').AsFloat) then
      Exit(False);
  End
  Else
  Begin
    if (FCdsLotes.FieldByName('QTDE').AsFloat > FCdsLotes.FieldByName('SALDOS').AsFloat) then
      Exit(False);
  End;
end;

end.

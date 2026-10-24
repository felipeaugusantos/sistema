unit LalaMove.View.Consulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, untPai, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, cxCheckGroup,
  cxCheckBox, untFuncFat, Uni, cxProgressBar, LalaMove.Errors, UniClientDataSet,
  cxContainer, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar;

type
  TfrmLalaMoveConsulta = class(TfrmPai)
    pnlBackground: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitel1: TcxGridCitel;
    cxGridCitel1DBTableViewCitel1FRIENDLY_SERVICEKEY: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1LENGTH: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1WIDTH: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1HEIGHT: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1LOAD1: TcxGridDBColumn;
    Panel3: TPanel;
    cxGridCitel2DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel2Level1: TcxGridLevel;
    cxGridCitel2: TcxGridCitel;
    dtsServices: TDataSource;
    dtsRequests: TDataSource;
    cxGridCitel2DBTableViewCitel1FRIENDLY_REQUESTNAME: TcxGridDBColumn;
    cxGridCitel2DBTableViewCitel1MARCADO: TcxGridDBColumn;
    Label1: TLabel;
    edtCordOrigem: TEdit;
    btnEfetuarCotacao: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    cxGridCitel1DBTableViewCitel1VALOR_COTACAO: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1ID_COTACAO: TcxGridDBColumn;
    edtEnderecoCompletoOrigem: TEdit;
    Label2: TLabel;
    edtCordDest: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    edtEnderecoCompletoDestino: TEdit;
    btnAtualizarServicosCidades: TBitBtnLocked;
    cxGridCitel1DBTableViewCitel1CITYNAME: TcxGridDBColumn;
    Label5: TLabel;
    cxGridCitel1DBTableViewCitel1SCHEDULEAT: TcxGridDBColumn;
    edtDtHrAgendamento: TcxDateEdit;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtsServicesDataChange(Sender: TObject; Field: TField);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnEfetuarCotacaoClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnAtualizarServicosCidadesClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private type
    TEndereco = record
      Endereco : String;
      Bairro : String;
      Cidade : String;
      Estado : String;
      Cep : String;
      Latitude : String;
      Longitude : String;
    End;
  private
    { Private declarations }
    qryServices : TUniQuery;
    qryRequests : TUniQuery;
    blnFecharForm : Boolean;
    blnValidouGeo : Boolean;
    cdsOpcionaisCotados : TUniClientDataSet;
    procedure CarregarServicos;
    procedure CarregarOpcionais(const AServiceID : Int64; const AquotationId : string);
    function ValidarCoordenadas: Boolean;
    function ConsultaLalaMoveWS: Boolean;
    procedure CoordenadasDestino(out ALatitude : String; out ALongitude : String; out AEnderecoCompleto : String);
    procedure CoordenadasOrigem(out ALatitude : String; out ALongitude : String; out AEnderecoCompleto : String);
    procedure ErrorMessage(const AMessage: string; const AErrors: TLalamoveErrorResponse);
    procedure PreencherInformacoesDaTela;
    procedure getItemInfo(var AQuantity : String; var AWeight : String);
    procedure GravarOpcionaisCotados(const AquotationId : string; const ASpecialRequests : TArray<string>);
    procedure LimparServicosECidades;
    function ValidouAgendamento : Boolean;
    procedure ProcessarGeoLocalizacao(const AEndereco : TEndereco);
    function GetEnderecoCliente : TEndereco;
    procedure AtualizarGeolocalizacao(const strLatitude, strLongitude : String);
    procedure ValidarGeolocalizacao;
  public
    { Public declarations }
    fatVenda : TFatVenda;
    blnConfirmou : Boolean;
    fltValorDoFrete : Double;
  end;

implementation

uses untFuncoesSimples, LalaMove.Quotation, LalaMove.ApiClient, System.StrUtils,
  LalaMove.Cities, System.DateUtils, untGoogleGeocoding, untGeocode;

{$R *.dfm}

procedure TfrmLalaMoveConsulta.btnAtualizarServicosCidadesClick(
  Sender: TObject);
begin
  inherited;
  If (Not btnAtualizarServicosCidades.Visible) Then
    Exit;
  If (fMensagem('ATENÇÃO!', 'Se prosseguir com essa operação TODOS os dados de serviços e cidades serão excluidos e inseridos novamente conforme API LALAMOVE, deseja prosseguir?', ['&Sim', '&Não']) = 2) Then
    Exit;
  LimparServicosECidades;
  CarregarServicos;
  cdsOpcionaisCotados.EmptyDataSet;
end;

procedure TfrmLalaMoveConsulta.btnConfirmarClick(Sender: TObject);
begin
  If (qryServices.IsEmpty) Then
  Begin
    pMensagemOk('Nenhum item selecionado');
    Exit;
  End;

  If (fEmptyStr(qryServices.FieldByName('ID_COTACAO').AsString)) Then
  Begin
    pMensagemOk('Veículo sem ID de Cotação!');
    Exit;
  End;

  If (qryServices.FieldByName('VALOR_COTACAO').AsFloat <= 0) Then
  Begin
    pMensagemOk('Veículo sem valor de cotação!');
    Exit;
  End;

  fatVenda.strQuotationIDLalaMove := qryServices.FieldByName('ID_COTACAO').AsString;
  fltValorDoFrete := qryServices.FieldByName('VALOR_COTACAO').AsFloat;
  fatVenda.strQlpPlaVei := EmptyStr;
  fatVenda.fltQlpDist := 0;
  fatVenda.fltQlpVlrCmb := 0;
  fatVenda.fltQlpVlrPed := 0;
  fatvenda.strFreTipApi := 'LALAMOVE';
  fatvenda.blnFreFatRecalculado := True;

  blnConfirmou := True;
  Close;
end;

procedure TfrmLalaMoveConsulta.btnEfetuarCotacaoClick(Sender: TObject);
begin
  If (qryServices.IsEmpty) Then
  Begin
    pMensagemOk('Nenhum item selecionado');
    Exit;
  End;

  If (Not ValidarCoordenadas) Then
    Exit;

  If (Not ValidouAgendamento) Then
    Exit;

  If Not fExecutarModal(function(pgbProgresso: TcxProgressBar): Boolean
                         begin
                           Result := ConsultaLalaMoveWS;
                         end, 'Aguarde, executando cotação LalaMove...', '') Then
  Begin
    Exit;
  End;
end;

procedure TfrmLalaMoveConsulta.CarregarOpcionais(const AServiceID: Int64; const AquotationId : string);
begin
  qryRequests.Close;
  qryRequests.SQL.Clear;
  qryRequests.SQL.Add('SELECT 0 AS MARCADO, REQUESTNAME, IF(IFNULL(FRIENDLY_REQUESTNAME,"")="", REQUESTNAME, FRIENDLY_REQUESTNAME) AS FRIENDLY_REQUESTNAME FROM LALAMOVE_SPECIALREQUESTS WHERE CITYSERVICEID = :SERVICEID');
  qryRequests.ParamByName('SERVICEID').AsLargeInt := AServiceID;
  qryRequests.Open;
  dtsRequests.DataSet := qryRequests;
  If (qryRequests.IsEmpty) Then
    Exit;
  If (fEmptyStr(AquotationId)) Then
    Exit;
  Try
    cdsOpcionaisCotados.Filter := 'ID_COTACAO = ' + QuotedStr(AquotationId);
    cdsOpcionaisCotados.Filtered := True;
    qryRequests.First;
    While Not qryRequests.Eof Do
    Begin
      If Not cdsOpcionaisCotados.FindKey([qryRequests.FieldByName('REQUESTNAME').AsString]) Then
      Begin
        qryRequests.Next;
        Continue;
      End;
      qryRequests.Edit;
      qryRequests.FieldByName('MARCADO').AsInteger := 1;
      qryRequests.Post;
      qryRequests.Next;
    End;
  Finally
    cdsOpcionaisCotados.Filtered := False;
    cdsOpcionaisCotados.Filter := '';
  End;
end;

procedure TfrmLalaMoveConsulta.CarregarServicos;
begin
  qryServices.Close;
  qryServices.SQL.Clear;
  qryServices.SQL.Add(' SELECT IF(IFNULL(FRIENDLY_SERVICEKEY,"")="", SERVICEKEY, FRIENDLY_SERVICEKEY) AS FRIENDLY_SERVICEKEY, ');
  qryServices.SQL.Add('        SERVICEKEY, ');
  qryServices.SQL.Add('        CONCAT(LENGTHVALUE, " ", LENGTHUNIT) AS LENGTH, ');
  qryServices.SQL.Add('        CONCAT(WIDTHVALUE, " ", WIDTHUNIT) AS WIDTH, ');
  qryServices.SQL.Add('        CONCAT(HEIGHTVALUE, " ", HEIGHTUNIT) AS HEIGHT, ');
  qryServices.SQL.Add('        CONCAT(LOADVALUE, " ", LOADUNIT) AS LOAD1, ');
  qryServices.SQL.Add('        AUTOINCREM, ');
  qryServices.SQL.Add('        0.00 AS VALOR_COTACAO, ');
  qryServices.SQL.Add('        CAST("" AS CHAR(20)) AS ID_COTACAO, ');
  qryServices.SQL.Add('        CITYNAME, ');
  qryServices.SQL.Add('        CAST(NULL AS DATETIME) AS SCHEDULEAT ');
  qryServices.SQL.Add('   FROM LALAMOVE_CITYSERVICE ');
  qryServices.SQL.Add('  WHERE VISIBLE = 1 ');
  qryServices.SQL.Add('  ORDER BY CITYNAME, 1 ');
  qryServices.Open;
  TFloatField(qryServices.FieldByName('VALOR_COTACAO')).DisplayFormat := '###,##0.00';
  dtsServices.DataSet := qryServices;
end;

procedure TfrmLalaMoveConsulta.dtsServicesDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  CarregarOpcionais(qryServices.FieldByName('AUTOINCREM').AsLargeInt, qryServices.FieldByName('ID_COTACAO').AsString);
end;

procedure TfrmLalaMoveConsulta.FormActivate(Sender: TObject);
begin
  inherited;
  ValidarGeolocalizacao;
end;

procedure TfrmLalaMoveConsulta.FormCreate(Sender: TObject);
begin
  inherited;
  blnValidouGeo := False;
  qryServices := fCriaQuery();
  qryServices.CachedUpdates := True;
  qryServices.Options.SetFieldsReadOnly := False;
  qryRequests := fCriaQuery();
  qryRequests.CachedUpdates := True;
  qryRequests.Options.SetFieldsReadOnly := False;
  cdsOpcionaisCotados := TUniClientDataSet.Create(nil);
  cdsOpcionaisCotados.FieldDefs.Add('ID_COTACAO', ftString,  30, False);
  cdsOpcionaisCotados.FieldDefs.Add('REQUESTNAME', ftString,  100, False);
  cdsOpcionaisCotados.CreateDataSet;
  cdsOpcionaisCotados.IndexFieldNames := 'REQUESTNAME';
  fatVenda := Nil;
  blnConfirmou := False;
  blnFecharForm := False;
  fltValorDoFrete := 0;
  edtDtHrAgendamento.Properties.DisplayFormat := 'dd/MM/yyyy HH:mm:ss';
  edtDtHrAgendamento.Properties.EditFormat := 'dd/MM/yyyy HH:mm:ss';
  edtDtHrAgendamento.Date := fNow() + 0.5;
  CarregarServicos;
end;

procedure TfrmLalaMoveConsulta.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryServices);
  FreeAndNil(qryRequests);
  FreeAndNil(cdsOpcionaisCotados);
end;

procedure TfrmLalaMoveConsulta.FormPaint(Sender: TObject);
begin
  inherited;
  If (blnFecharForm) Then
    Close;
end;

procedure TfrmLalaMoveConsulta.FormShow(Sender: TObject);
begin
  inherited;
  btnAtualizarServicosCidades.Visible := fEhAdministrador(strLoginUsuarioLogado);
  PreencherInformacoesDaTela;
  If (Not fEmptyStr(fatVenda.strQuotationIDLalaMove)) Then
  Begin
    If (fMensagem('', 'Deseja ignorar a última cotação realizada? "' + fatVenda.strQuotationIDLalaMove + '"', ['&Sim', '&Não']) = 1) Then
      fatVenda.strQuotationIDLalaMove := ''
    Else
      blnFecharForm := True;
  End;
end;

procedure TfrmLalaMoveConsulta.getItemInfo(var AQuantity : String; var AWeight : String);
  Var
    LCount : Integer;
    LPeso : Double;
    LQuantity : Integer;
begin
  LQuantity := 0;
  LPeso := 0;
  For LCount := 0 to Length(fatVenda.arrMatItens) -1 Do
  Begin
    If fatVenda.arrMatItens[LCount].strEntRet = 'R' Then
      Continue;
    LQuantity := LQuantity + fFloatToInt(fatVenda.arrMatItens[LCount].fltQtdIte);
    LPeso := LPeso + (fFloatToInt(fatVenda.arrMatItens[LCount].fltQtdIte) * fCampoTabela('ITE_PESOIT', 'CADITE', ['ITE_CODITE'], [fatVenda.arrMatItens[LCount].strCodIte]));
  End;
  AWeight := FloatToStrF(LPeso, ffNumber, 15, 4) + ' kg';
  AQuantity := LQuantity.ToString;
end;

function TfrmLalaMoveConsulta.ValidarCoordenadas : Boolean;
  Var
    LLatitude : string;
    LLongitude : string;
    LLatLon : string;
begin
  Result := True;
  If Not fEmptyStr(fatVenda.strAutEnt) Then
  Begin
    LLatLon := fCampoTabela('ETC_LATLON', 'ENTCLI', ['AUTOINCREM'], [fatVenda.strAutEnt]);
    If fEmptyStr(LLatLon) Then
    Begin
      pMensagemOK('As coordenadas do endereço de entrega do cliente não estão preenchidas!');
      Result := False;
      Exit;
    End
    Else
    Begin
      pExtrairCoordenadas(LLatLon, LLatitude, LLongitude);
      If (fEmptyStr(LLatitude)) or (fEmptyStr(LLongitude)) Then
      Begin
        pMensagemOK('As coordenadas do endereço de entrega do cliente não estão preenchidas corretamente!');
        Result := False;
        Exit;
      End;
    End;
  End
  Else
  Begin
    If (fEmptyStr(fCampoTabela('CLI_LATITU', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli]))) Or
       (fEmptyStr(fCampoTabela('CLI_LONGIT', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli]))) Then
    Begin
      pMensagemOK('As coordenadas do endereço do cliente não estão preenchidas!');
      Result := False;
      Exit;
    End;
  End;
  LLatLon := fCfgSis('LATLON', varString);
  If (fEmptyStr(LLatLon)) Then
  Begin
    pMensagemOK('As coordenadas do endereço do centro de distribuição não estão preenchidas "CFG_LATLON"!');
    Result := False;
    Exit;
  End
  Else
  Begin
    pExtrairCoordenadas(LLatLon, LLatitude, LLongitude);
    If (fEmptyStr(LLatitude)) or (fEmptyStr(LLongitude)) Then
    Begin
      pMensagemOK('As coordenadas do endereço do centro de distribuição não estão preenchidas corretamente "CFG_LATLON"!');
      Result := False;
      Exit;
    End;
  End;
end;

function TfrmLalaMoveConsulta.ValidouAgendamento: Boolean;
  Var
    dtaMinDate : TDateTime;
    dtaMaxDate : TDateTime;
begin
  Result := True;
  dtaMinDate := IncMinute(fNow(), 30);
  dtaMaxDate := IncDay(fNow(), 30);
  If (edtDtHrAgendamento.Date <= dtaMinDate) Then
  Begin
    pMensagemOK('A data de agendamento deve ter o valor mínimo de 30 minutos!');
    Result := False;
  End;
  If (edtDtHrAgendamento.Date > dtaMaxDate) Then
  Begin
    pMensagemOK('A data de agendamento deve ter o valor máximo de 30 dias!');
    Result := False;
  End;
end;

function TfrmLalaMoveConsulta.ConsultaLalaMoveWS: Boolean;
  Var
    LGetQuotation : TLalaMoveGetQuotation;
    LLalaMoveQuotation : TLalaMoveQuotation;
    LItem : TLalaMoveItem;
    LLatitude : String;
    LLongitude : String;
    LEnderecoCompleto : String;
    LLalaMoveApiClient : TLalaMoveApiClient;
    LSpecialRequests : TArray<string>;
    LStops : TArray<TLalaMoveStop>;
    LNewQuotationCreated : TLalaMoveGetQuotationCreated;
    LQuantity : string;
    LWeight : String;
begin
  LLalaMoveApiClient := TLalaMoveApiClient.Create;
  LGetQuotation := TLalaMoveGetQuotation.Create;
  LItem := TLalaMoveItem.Create;
  Try
    Try
      getItemInfo(LQuantity, LWeight);

      LItem.quantity := LQuantity;
      LItem.weight := LWeight;

      LLalaMoveQuotation := TLalaMoveQuotation.Create;
      Try
        LGetQuotation.data := LLalaMoveQuotation;
        LGetQuotation.data.serviceType := qryServices.FieldByName('SERVICEKEY').AsString;

        If (Not qryRequests.IsEmpty) Then
        Begin
          SetLength(LSpecialRequests, 0);
          qryRequests.First;
          While Not qryRequests.Eof Do
          Begin
            If (qryRequests.FieldByName('MARCADO').AsInteger = 0) Then
            Begin
              qryRequests.Next;
              Continue;
            End;
            SetLength(LSpecialRequests, Length(LSpecialRequests) + 1);
            LSpecialRequests[Length(LSpecialRequests) - 1] := qryRequests.FieldByName('REQUESTNAME').AsString;
            qryRequests.Next;
          End;
          LGetQuotation.data.specialRequests := LSpecialRequests;
        End;

        LGetQuotation.data.language := 'pt_BR';
        SetLength(LStops, 2);
        CoordenadasOrigem(LLatitude, LLongitude, LEnderecoCompleto);
        LStops[0] := TLalaMoveStop.Create;
        LStops[0].coordinates := TLalaMoveCoordinate.Create;
        LStops[0].coordinates.lat := Trim(LLatitude);
        LStops[0].coordinates.lng := Trim(LLongitude);
        LStops[0].address := LEnderecoCompleto;

        CoordenadasDestino(LLatitude, LLongitude, LEnderecoCompleto);
        LStops[1] := TLalaMoveStop.Create;
        LStops[1].coordinates := TLalaMoveCoordinate.Create;
        LStops[1].coordinates.lat := Trim(LLatitude);
        LStops[1].coordinates.lng := Trim(LLongitude);
        LStops[1].address := LEnderecoCompleto;

        LGetQuotation.data.stops := LStops;
        LGetQuotation.data.item := LItem;
        LGetQuotation.data.isRouteOptimized := True;
        LGetQuotation.data.scheduleAt := FormatDateTime('yyyy-mm-dd"T"hh:nn:ss"Z"', TTimeZone.Local.ToUniversalTime(edtDtHrAgendamento.Date));

        LNewQuotationCreated := LLalaMoveApiClient.getQuotation(LGetQuotation);

        Result := Not fEmptyStr(LNewQuotationCreated.data.quotationId);

        If (Result) Then
        Begin
          btnConfirmar.Enabled := True;
          qryServices.Edit;
          qryServices.FieldByName('VALOR_COTACAO').AsFloat := fStrToFloat(AnsiReplaceStr(LNewQuotationCreated.data.priceBreakdown.total, '.', ','));
          qryServices.FieldByName('ID_COTACAO').AsString := LNewQuotationCreated.data.quotationId;
          qryServices.FieldByName('SCHEDULEAT').AsDateTime := edtDtHrAgendamento.Date;
          qryServices.Post;
          GravarOpcionaisCotados(LNewQuotationCreated.data.quotationId, LSpecialRequests);
          CarregarOpcionais(qryServices.FieldByName('AUTOINCREM').AsLargeInt, LNewQuotationCreated.data.quotationId);
        End
        Else
          pMensagemOk('Não conseguiu obter o ID da Cotação!');
      Finally
        FreeAndNil(LLalaMoveQuotation);
      End;
    Finally
      FreeAndNil(LStops[0]);
      FreeAndNil(LStops[1]);
      FreeAndNil(LGetQuotation);
      FreeAndNil(LItem);
      FreeAndNil(LLalaMoveApiClient);
    End;
  Except
    On E: ExceptionLalaMovApiClientError Do
    Begin
      Result := False;
      ErrorMessage(E.Message, E.Errors);
    End;
  End;
end;

procedure TfrmLalaMoveConsulta.ErrorMessage(const AMessage: string; const AErrors: TLalamoveErrorResponse);
  Var
    LCount : Integer;
    LMessage : String;
begin
  If (Length(AErrors.errors) = 0) Then
    pMensagemOK(AMessage)
  Else
  Begin
    LMessage := '';
    For LCount := 0 To Length(AErrors.errors) -1 Do
    Begin
      If (Not fEmptyStr(AErrors.errors[LCount].message)) Then
      Begin
        If AErrors.errors[LCount].message.Contains('Date cannot be a past date or more than 30 days in advance') Then
          LMessage := LMessage + 'A data não pode ser uma data passada nem ter mais de 30 dias de antecedência.' + sLineBreak
        Else
          LMessage := LMessage + 'Id: ' + AErrors.errors[LCount].id + sLineBreak + 'Message: ' + AErrors.errors[LCount].message + sLineBreak;
      End;
    End;
    If fEmptyStr(LMessage) Then
      pMensagemOK(AMessage)
    Else
      pMensagemOK(LMessage);
  End;
end;

procedure TfrmLalaMoveConsulta.CoordenadasDestino(out ALatitude : String; out ALongitude : String; out AEnderecoCompleto : String);
  Var
    LLatLon : String;
begin
  LLatLon := fCampoTabela('ETC_LATLON', 'ENTCLI', ['AUTOINCREM'], [fatVenda.strAutEnt]);
  If Not fEmptyStr(LLatLon) Then
  Begin
    pExtrairCoordenadas(LLatLon, ALatitude, ALongitude);
    AEnderecoCompleto := fCampoTabela('ETC_ENDENT', 'ENTCLI', ['AUTOINCREM'], [fatVenda.strAutEnt]) + ' ' + fCampoTabela('ETC_BAIENT', 'ENTCLI', ['AUTOINCREM'], [fatVenda.strAutEnt]);
  End
  Else
  Begin
    ALatitude := fCampoTabela('CLI_LATITU', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli]);
    ALongitude := fCampoTabela('CLI_LONGIT', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli]);
    AEnderecoCompleto := fCampoTabela('IF(IFNULL(CLI_ENDNUM, "") = "", CLI_ENDERE, CONCAT(CLI_ENDERE, ", ", IFNULL(CLI_ENDNUM,""), IF(IFNULL(CLI_ENDCOM, "") = "", "", CONCAT("  ", CLI_ENDCOM))))', 'CADCLI', ['CLI_CODCLI'], [fatVenda.strCodCli]);
  End;
end;

procedure TfrmLalaMoveConsulta.CoordenadasOrigem(out ALatitude : String; out ALongitude : String; out AEnderecoCompleto : String);
begin
  pExtrairCoordenadas(fCfgSis('LATLON', varString), ALatitude, ALongitude);
  AEnderecoCompleto := fCampoTabela('IF(IFNULL(EMP_ENDNUM, "") = "", EMP_ENDERE, CONCAT(EMP_ENDERE, ", ", IFNULL(EMP_ENDNUM,""), IF(IFNULL(EMP_ENDCMP, "") = "", "", CONCAT("  ", EMP_ENDCMP))))', 'CADEMP', ['EMP_CODEMP'], [VS_strCodEmp]);
end;

procedure TfrmLalaMoveConsulta.PreencherInformacoesDaTela;
  Var
    LLatitude : String;
    LLongitude : String;
    LEnderecoCompleto : String;
begin
  CoordenadasOrigem(LLatitude, LLongitude, LEnderecoCompleto);
  edtCordOrigem.Text := LLatitude + ', ' + LLongitude;
  edtEnderecoCompletoOrigem.Text := LEnderecoCompleto;
  CoordenadasDestino(LLatitude, LLongitude, LEnderecoCompleto);
  edtCordDest.Text := LLatitude + ', ' + LLongitude;
  edtEnderecoCompletoDestino.Text := LEnderecoCompleto;
end;

procedure TfrmLalaMoveConsulta.GravarOpcionaisCotados(const AquotationId : string; const ASpecialRequests : TArray<string>);
  Var
    LCount : Integer;
begin
  Try
    cdsOpcionaisCotados.Filter := 'ID_COTACAO = ' + QuotedStr(AquotationId);
    cdsOpcionaisCotados.Filtered := True;
    While Not cdsOpcionaisCotados.Eof Do
      cdsOpcionaisCotados.Delete;
    If (Length(ASpecialRequests) = 0) Then
      Exit;
    For LCount := 0 To Length(ASpecialRequests)-1 Do
    Begin
      cdsOpcionaisCotados.Append;
      cdsOpcionaisCotados.FieldByName('ID_COTACAO').AsString := AquotationId;
      cdsOpcionaisCotados.FieldByName('REQUESTNAME').AsString := ASpecialRequests[LCount];
      cdsOpcionaisCotados.Post;
    End;
  Finally
    cdsOpcionaisCotados.Filtered := False;
    cdsOpcionaisCotados.Filter := '';
  End;
end;

procedure TfrmLalaMoveConsulta.LimparServicosECidades;
  Var
    objLalaMoveApiClient : TLalaMoveApiClient;
    objLalaMoveCities : TLalaMoveCities;
    objLalaMoveCity : TLalaMoveCity;
    objLalaMoveService : TLalaMoveService;
    objLalaMoveSpecialRequest : TLalaMoveSpecialRequest;
    qryServicos : TUniquery;
    qryRequests : TUniquery;
begin
  objLalaMoveApiClient := TLalaMoveApiClient.Create;
  qryServicos := fCriaQuery();
  qryRequests := fCriaQuery();
  Try
    fStartTransaction;
    Try
      qryServicos.SQL.Text := 'DELETE FROM LALAMOVE_CITYSERVICE';
      qryServicos.ExecSQL;

      qryServicos.SQL.Text := 'SELECT * FROM LALAMOVE_CITYSERVICE WHERE FALSE';
      qryServicos.Open;

      qryRequests.SQL.Text := 'DELETE FROM LALAMOVE_SPECIALREQUESTS';
      qryRequests.ExecSQL;

      qryRequests.SQL.Text := 'SELECT * FROM LALAMOVE_SPECIALREQUESTS WHERE FALSE';
      qryRequests.Open;

      objLalaMoveCities := objLalaMoveApiClient.getCities;
      If (Length(objLalaMoveCities.data) > 0) Then
      Begin
        For objLalaMoveCity in objLalaMoveCities.data Do
        Begin
          For objLalaMoveService In objLalaMoveCity.services Do
          Begin
            qryServicos.Append;
            qryServicos.FieldByName('LOCODE').AsString := objLalaMoveCity.locode;
            qryServicos.FieldByName('CITYNAME').AsString := objLalaMoveCity.name;
            qryServicos.FieldByName('SERVICEKEY').AsString := objLalaMoveService.key;
            qryServicos.FieldByName('LENGTHVALUE').AsString := objLalaMoveService.dimensions.length.value;
            qryServicos.FieldByName('LENGTHUNIT').AsString := objLalaMoveService.dimensions.length.&unit;
            qryServicos.FieldByName('WIDTHVALUE').AsString := objLalaMoveService.dimensions.width.value;
            qryServicos.FieldByName('WIDTHUNIT').AsString := objLalaMoveService.dimensions.width.&unit;
            qryServicos.FieldByName('HEIGHTVALUE').AsString := objLalaMoveService.dimensions.height.value;
            qryServicos.FieldByName('HEIGHTUNIT').AsString := objLalaMoveService.dimensions.height.&unit;
            qryServicos.FieldByName('LOADVALUE').AsString := objLalaMoveService.load.value;
            qryServicos.FieldByName('LOADUNIT').AsString := objLalaMoveService.load.&unit;
            qryServicos.Post;

            For objLalaMoveSpecialRequest In objLalaMoveService.specialRequests Do
            Begin
              qryRequests.Append;
              qryRequests.FieldByName('CITYSERVICEID').AsLargeInt := qryServicos.FieldByName('AUTOINCREM').AsLargeInt;
              qryRequests.FieldByName('REQUESTNAME').AsString := objLalaMoveSpecialRequest.name;
              qryRequests.FieldByName('DESCRIPTION').AsString := objLalaMoveSpecialRequest.description;
              qryRequests.FieldByName('PARENTTYPE').AsString := objLalaMoveSpecialRequest.parent_type;
              qryRequests.Post;
            End;
          End;
        End;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Raise;
      End;
    End;
  Finally
    FreeAndNil(objLalaMoveApiClient);
    FreeAndNil(qryServicos);
    FreeAndNil(qryRequests);
  End;
end;

procedure TfrmLalaMoveConsulta.ProcessarGeoLocalizacao(const AEndereco : TEndereco);
  Var
    LEndGeoCode : IEnderecoGeocode;
    LPegouLatLong : Boolean;
    LEndereco : TEndereco;
begin
  If fEmptyStr(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_KEYMDP'])) Then
    Exit;
  LEndereco := AEndereco;
  LPegouLatLong := fExecutarModal(
    function(pgbProgresso: TcxProgressBar): Boolean
    begin
      Try
        LEndGeoCode := TGoogleGeocoding.fProcessaGeocode(LEndereco.Endereco, LEndereco.Bairro, LEndereco.Cidade, LEndereco.Estado, LEndereco.Cep, True);
        Result := (Assigned(LEndGeoCode)) And (LEndGeoCode.fGetLatitude <> 0) and (LEndGeoCode.fGetLongitude <> 0);
      Except
        On E: EGoogleGeocodingError Do
        Begin
          Result := False;
          pMensagemOK(E.Message);
        End;
        On E: Exception Do
        Begin
          Result := False;
          pGravarErro(True, E.Message, E.StackTrace);
          pMensagemOK('Não foi possível verificar a geolocalização do endereço. Tente novamente.');
        End;
      End;
    end, 'Aguarde, verificando geolocalização do endereço...', ''
  );
  If (LPegouLatLong) Then
  Begin
    edtCordDest.Text := AnsiReplaceStr(LEndGeoCode.fGetLatitude.ToString, ',', '.') + ', ' + AnsiReplaceStr(LEndGeoCode.fGetLongitude.ToString, ',', '.');
    edtEnderecoCompletoDestino.Text := LEndGeoCode.fGetEndereco;
    AtualizarGeolocalizacao(LEndGeoCode.fGetLatitude.ToString, LEndGeoCode.fGetLongitude.ToString);
  End;
end;

function TfrmLalaMoveConsulta.GetEnderecoCliente: TEndereco;
  Var
    LQuery : TUniQuery;
    LLatitude : String;
    LLongitude : String;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.Close;
    LQuery.SQL.Clear;
    Result := Default(TEndereco);
    If fEmptyStr(fatVenda.strAutEnt) Then
    Begin
      LQuery.SQL.Add(' SELECT CLI_ENDERE, CLI_ENDNUM, CLI_BAIRRO, ');
      LQuery.SQL.Add('        CLI_C_E_P_, CID_NOMCID, CID_ESTADO, ');
      LQuery.SQL.Add('        CLI_LATITU, CLI_LONGIT ');
      LQuery.SQL.Add('   FROM CADCLI ');
      LQuery.SQL.Add('   JOIN CADCID ON CID_CODCID = CLI_CODCID ');
      LQuery.SQL.Add('  WHERE CLI_CODCLI = :CODCLI');
      LQuery.ParamByName('CODCLI').AsString := fatVenda.strCodCli;
      LQuery.Open;
      If LQuery.IsEmpty Then
        Exit;
      Result.Endereco := LQuery.FieldByName('CLI_ENDERE').AsString + IIF(fEmptyStr(LQuery.FieldByName('CLI_ENDNUM').AsString), '', ', ' + LQuery.FieldByName('CLI_ENDNUM').AsString);
      Result.Bairro := LQuery.FieldByName('CLI_BAIRRO').AsString;
      Result.Cidade := LQuery.FieldByName('CID_NOMCID').AsString;
      Result.Estado := LQuery.FieldByName('CID_ESTADO').AsString;
      Result.Cep := LQuery.FieldByName('CLI_C_E_P_').AsString;
      Result.Latitude := LQuery.FieldByName('CLI_LATITU').AsString;
      Result.Longitude := LQuery.FieldByName('CLI_LONGIT').AsString;
    End
    Else
    Begin
      LQuery.SQL.Add(' SELECT ETC_ENDERE, ETC_ENDNUM, ETC_BAIENT, ');
      LQuery.SQL.Add('        ETC_CEPENT, CID_NOMCID, CID_ESTADO, ');
      LQuery.SQL.Add('        ETC_LATLON ');
      LQuery.SQL.Add('   FROM ENTCLI ');
      LQuery.SQL.Add('   JOIN CADCID ON CID_CODCID = ETC_CIDENT ');
      LQuery.SQL.Add('  WHERE ENTCLI.AUTOINCREM = :AUTINC');
      LQuery.ParamByName('AUTINC').AsString := fatVenda.strAutEnt;
      LQuery.Open;
      If LQuery.IsEmpty Then
        Exit;
      Result.Endereco := LQuery.FieldByName('ETC_ENDERE').AsString + IIF(fEmptyStr(LQuery.FieldByName('ETC_ENDNUM').AsString), '', ', ' + LQuery.FieldByName('ETC_ENDNUM').AsString);
      Result.Bairro := LQuery.FieldByName('ETC_BAIENT').AsString;
      Result.Cidade := LQuery.FieldByName('CID_NOMCID').AsString;
      Result.Estado := LQuery.FieldByName('CID_ESTADO').AsString;
      Result.Cep := LQuery.FieldByName('ETC_CEPENT').AsString;
      if not fEmptyStr(LQuery.FieldByName('ETC_LATLON').AsString) Then
      begin
        pExtrairCoordenadas(LQuery.FieldByName('ETC_LATLON').AsString,  LLatitude, LLongitude);
        Result.Latitude := LLatitude;
        Result.Longitude := LLongitude;
      end;
    End;
  Finally
    FreeANdNil(LQuery);
  End;
end;

procedure TfrmLalaMoveConsulta.AtualizarGeolocalizacao(const strLatitude, strLongitude : String);
  Var
    LQuery : TUniQuery;
begin
  LQuery := fCriaQuery;
  Try
    LQuery.Close;
    LQuery.SQL.Clear;
    If fEmptyStr(fatVenda.strAutEnt) Then
    Begin
      LQuery.SQL.Add(' UPDATE CADCLI ');
      LQuery.SQL.Add('    SET CLI_LATITU = :LATITU, ');
      LQuery.SQL.Add('        CLI_LONGIT = :LONGIT ');
      LQuery.SQL.Add('  WHERE CLI_CODCLI = :CODCLI ');
      LQuery.ParamByName('CODCLI').AsString := fatVenda.strCodCli;
      LQuery.ParamByName('LATITU').AsString := AnsiReplaceStr(strLatitude, ',', '.');
      LQuery.ParamByName('LONGIT').AsString := AnsiReplaceStr(strLongitude, ',', '.');
      LQuery.ExecSQL;
    End
    Else
    Begin
      LQuery.SQL.Add(' UPDATE ENTCLI ');
      LQuery.SQL.Add('    SET ETC_LATLON = :LATLON ');
      LQuery.SQL.Add('  WHERE AUTOINCREM = :AUTINC ');
      LQuery.ParamByName('AUTINC').AsString := fatVenda.strAutEnt;
      LQuery.ParamByName('LATLON').AsString := AnsiReplaceStr(strLatitude, ',', '.') + ', ' + AnsiReplaceStr(strLongitude, ',', '.');
      LQuery.ExecSQL;
    End;
  Finally
    FreeANdNil(LQuery);
  End;
end;

procedure TfrmLalaMoveConsulta.ValidarGeolocalizacao;
  Var
    LEndereco : TEndereco;
begin
  If blnFecharForm Then
    Exit;
  If blnValidouGeo Then
    Exit;
  blnValidouGeo := True;
  LEndereco := GetEnderecoCliente;
  if fEmptyStr(LEndereco.Latitude) or fEmptyStr(LEndereco.Longitude) Then
    ProcessarGeoLocalizacao(LEndereco);
end;

end.

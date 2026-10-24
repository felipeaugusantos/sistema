unit untAlteraFreteEspelho;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untDadosFechamentoVendaTransportadoraFrame,
  ComboBoxFocus, Vcl.Mask, MaskEditFocus, EditFocus, Uni, UniClientDataSet, UniDataSetProvider,
  StrUtils;

type
  TfrmAlteraFreteEspelho = class(TfrmPai)
    btnConfirmaDados: TBitBtnLocked;
    pnlTransportadora: TPanel;
    lblValorDoFrete: TLabel;
    edtValFre: TEditFocus;
    edtEspTra: TEditFocus;
    lblEspecie: TLabel;
    lblQuantidade: TLabel;
    edtQtdTra: TEditFocus;
    lblTransportadora: TLabel;
    edtCodTra: TEditFocus;
    lblPlacaVeiculo: TLabel;
    mskPlaFat: TMaskEditFocus;
    edtNomTra: TEditFocus;
    lblNumeracao: TLabel;
    edtNumera: TEditFocus;
    edtMarTra: TEditFocus;
    lblMarca: TLabel;
    lblFretePorConta: TLabel;
    cmbTipFre: TComboBoxFocus;
    edtPesBru: TEditFocus;
    lblPesoBruto: TLabel;
    edtPesLiq: TEditFocus;
    lblPesoLiquido: TLabel;
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdTraKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    qryEspelho : TUniQuery;

    procedure pCarregaCadTra;
  public
    strAutIncEspelho : String;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, untPesqAux,
  untConstantes, untTipoFreteAtc;

procedure TfrmAlteraFreteEspelho.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If (not fVerificaCampos) Then
    Exit;

  Try
    fStartTransaction();

    qryEspelho.Edit;
    qryEspelho.FieldByName('GER_TOTFRE').AsFloat   := StrToFloat(edtValFre.Text);
    qryEspelho.FieldByName('GER_ESPECI').AsString  := edtEspTra.Text;
    qryEspelho.FieldByName('GER_VOLUME').AsInteger := StrToInt(edtQtdTra.Text);
    qryEspelho.FieldByName('GER_CODTRA').AsString  := edtCodTra.Text;
    qryEspelho.FieldByName('GER_NUMERA').AsString  := edtNumera.Text;
    qryEspelho.FieldByName('GER_MARCA_').AsString  := edtMarTra.Text;
    qryEspelho.FieldByName('GER_PESBRU').AsFloat   := StrToFloat(edtPesBru.Text);
    qryEspelho.FieldByName('GER_PESLIQ').AsFloat   := StrToFloat(edtPesLiq.Text);
    qryEspelho.FieldByName('GER_TIPFRE').AsString  := fTipoFrete(cmbTipFre.Text);

    If (fEmptyStr(mskPlaFat.Text)) Then
      qryEspelho.FieldByName('GER_PLAFAT').Clear
    Else
      qryEspelho.FieldByName('GER_PLAFAT').AsString  := mskPlaFat.Text;

    qryEspelho.Post;

    fCommit();
    ModalResult := mrOk;
  Except
    On E:Exception Do
    Begin
      fRollBack();
      pMensagensErro(E.Message, '');
    End;
  End;
end;

procedure TfrmAlteraFreteEspelho.edtCodTraKeyPress(Sender: TObject; var Key: Char);
Var
  arrTransp  : TConsultasArray;
begin
  inherited;

  If fPesqTransportadora(conTraCompleta, Self, edtCodTra, edtNomTra, Nil, Key, arrTransp, True, '', 'S') Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteraFreteEspelho.pCarregaCadTra;
Var
  qryConTra : TUniQuery;
begin
  If (Not fEmptyStr(mskPlaFat.Text)) Then
    Exit;

  qryConTra := fCriaQuery(Self);

  Try
    pPesquisaCadTra(qryConTra, qryConTra, edtCodTra.Text, 'S');

    edtNomTra.Text := qryConTra.FieldByName('TRA_NOMTRA').AsString;

    If (Not fEmptyStr(edtCodTra.Text)) Then
      mskPlaFat.Text := AnsiReplaceStr(qryConTra.FieldByName('TRA_NUMPLA').AsString, '-', '');
  Finally
    FreeAndNil(qryConTra);
  End;
end;

procedure TfrmAlteraFreteEspelho.edtQtdTraKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If CharInSet(Key, [',', '.']) Then
    Key := #0;
end;

procedure TfrmAlteraFreteEspelho.FormCreate(Sender: TObject);
Var
  intTipFre: Integer;
begin
  inherited;
  cmbTipFre.Clear;
  For intTipFre In TiposFrete Do
    cmbTipFre.Items.Add(fDescricaoFrete(IntToStr(intTipFre)));
end;

procedure TfrmAlteraFreteEspelho.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(qryEspelho);
end;

procedure TfrmAlteraFreteEspelho.FormShow(Sender: TObject);
begin
  inherited;
  qryEspelho := fCriaQuery(Self);

  qryEspelho.SQL.Add('SELECT                                                 ');
  qryEspelho.SQL.Add('  EG.AUTOINCREM,                                       ');
  qryEspelho.SQL.Add('  EG.GER_CODTRA,                                       ');
  qryEspelho.SQL.Add('  EG.GER_ESPECI,                                       ');
  qryEspelho.SQL.Add('  EG.GER_MARCA_,                                       ');
  qryEspelho.SQL.Add('  EG.GER_NUMERA,                                       ');
  qryEspelho.SQL.Add('  EG.GER_PESBRU,                                       ');
  qryEspelho.SQL.Add('  EG.GER_PESLIQ,                                       ');
  qryEspelho.SQL.Add('  EG.GER_VOLUME,                                       ');
  qryEspelho.SQL.Add('  EG.GER_TIPFRE,                                       ');
  qryEspelho.SQL.Add('  EG.GER_TOTFRE,                                       ');
  qryEspelho.SQL.Add('  EG.GER_PLAFAT,                                       ');
  qryEspelho.SQL.Add('  CT.TRA_NOMTRA                                        ');
  qryEspelho.SQL.Add('FROM ESPGER EG                                         ');
  qryEspelho.SQL.Add('LEFT JOIN CADTRA CT ON (EG.GER_CODTRA = CT.TRA_CODTRA) ');
  qryEspelho.SQL.Add('WHERE                                                  ');
  qryEspelho.SQL.Add('  EG.AUTOINCREM=:AUTINC                                ');

  qryEspelho.ParamByName('AUTINC').AsString := strAutIncEspelho;
  qryEspelho.Open;

  If (not qryEspelho.IsEmpty) Then
  Begin
    edtValFre.Text      := FormatFloat('0.00', qryEspelho.FieldByName('GER_TOTFRE').AsFloat);
    edtEspTra.Text      := qryEspelho.FieldByName('GER_ESPECI').AsString;
    edtQtdTra.Text      := IntToStr(qryEspelho.FieldByName('GER_VOLUME').AsInteger);
    edtCodTra.Text      := qryEspelho.FieldByName('GER_CODTRA').AsString;
    edtNomTra.Text      := qryEspelho.FieldByName('TRA_NOMTRA').AsString;
    edtNumera.Text      := qryEspelho.FieldByName('GER_NUMERA').AsString;
    edtMarTra.Text      := qryEspelho.FieldByName('GER_MARCA_').AsString;
    edtPesBru.Text      := FormatFloat('0.00', qryEspelho.FieldByName('GER_PESBRU').AsFloat);
    edtPesLiq.Text      := FormatFloat('0.00', qryEspelho.FieldByName('GER_PESLIQ').AsFloat);
    mskPlaFat.Text      := qryEspelho.FieldByName('GER_PLAFAT').AsString;

    cmbTipFre.ItemIndex := cmbTipFre.Items.IndexOf(fDescricaoFrete(qryEspelho.FieldByName('GER_TIPFRE').AsString));
  End
  Else
    fMensagem('ATENÇÃO!', 'Espelho não foi encontrado!', ['&Ok']);
end;

function TfrmAlteraFreteEspelho.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := inherited fValidaCampos(Sender, blnBuscaPorChave);

  If (Result) Then
  Begin
    If (Sender = edtCodTra) Then
    Begin
      If (fEmptyStr(edtCodTra.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Transportadora deve ser preenchido!', ['&O k']);
        Result := False;
      End
      else
      if not fRetTransportadoraAtiva(edtCodTra.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Transportadora está inativada!', ['&Ok']);
        Result := False;
      end
      Else
      Begin
        pCarregaCadTra;
        If fEmptyStr(edtNomTra.Text) Then
          Result := False;
      End;
    End
    Else If (Sender = mskPlaFat) Then
    Begin
      If (Not fEmptyStr(mskPlaFat.Text)) Then
      Begin
        If Not fValidaPlaca(mskPlaFat.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A placa informada não é válida!', ['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        If (Not fEmptyStr(edtCodTra.Text)) and (fCfgSis('PLAOBR', varBoolean)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A placa da transportadora deve ser preenchida!', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = cmbTipFre) Then
    Begin
      If (Not fFreteValido(fTipoFrete(cmbTipFre.Text))) Or
         (Not fPermiteFreteProprio(fTipoFrete(cmbTipFre.Text))) Then
      Begin
        Result := False;
      End
      Else
      Begin
        If (fTipoFrete(cmbTipFre.Text) = '9') And (fStrToFloat(edtValFre.Text) > 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe um Tipo de Frete válido:' +#13+
                                'Emitente(CIF), Destinatário(FOB) ou Terceiros', ['&O k']);
          Result := False;
        End;
      End;
    End;
  End;

  If (not Result) Then
    pSetFocus(Sender);
end;

end.

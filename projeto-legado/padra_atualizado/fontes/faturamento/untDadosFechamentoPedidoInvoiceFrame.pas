unit untDadosFechamentoPedidoInvoiceFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus,
  QColorLabel, Vcl.ExtCtrls, untFuncFat, Uni;

type
  TfraDadosFechamentoPedidoInvoiceFrame = class(TFrame)
    pnlFundo: TPanel;
    pnlInvoice: TGroupBox;
    lblIncoterms: TLabel;
    lblPortoDestino: TLabel;
    lblPortoEmbarque: TLabel;
    lblAeroporto: TLabel;
    lblTarifa: TLabel;
    lblSeguro: TLabel;
    lblFrete: TLabel;
    lblWorks: TLabel;
    lblNotify: TLabel;
    lblContainer: TLabel;
    lblPacking: TLabel;
    dbePeEmp_S_N_: TColorLabel;
    edtCodTer: TEditFocus;
    edtDesTer: TEditFocus;
    edtPorDes: TEditFocus;
    edtDesPor: TEditFocus;
    edtPorEmb: TEditFocus;
    edtDesEmb: TEditFocus;
    edtAeropo: TEditFocus;
    edtDesAer: TEditFocus;
    edtTarifa: TEditFocus;
    edtSeguro: TEditFocus;
    edtFrete: TEditFocus;
    edtCodWor: TEditFocus;
    edtNomWor: TEditFocus;
    edtNotify: TEditFocus;
    edtTipCont: TEditFocus;
    edtPackin: TEditFocus;
    procedure edtCodTerKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorDesKeyPress(Sender: TObject; var Key: Char);
    procedure edtPorEmbKeyPress(Sender: TObject; var Key: Char);
    procedure edtAeropoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodWorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    blnIniciandoTela: Boolean;

    procedure pOnShow;
    procedure pAplicaIncoterms;
    procedure pAtualizaTela;
    procedure pLimpaTela(blnLimpaIncoterms: Boolean);
  public
    { Public declarations }
    objVenda: TFatVenda;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;

    procedure OnFormShow;

    function fConfirmaDados: Boolean;
  end;

implementation

uses untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfraDadosFechamentoPedidoInvoiceFrame.OnFormShow;
begin
  blnIniciandoTela := True;
  Try
    pOnShow;
  Finally
    blnIniciandoTela := False;
  End;
end;

procedure TfraDadosFechamentoPedidoInvoiceFrame.pOnShow;
begin
  pLimpaTela(True);
  edtCodTer.Text := objVenda.strInvoiceIncTer;
  edtPorDes.Text := objVenda.strInvoicePorDes;
  edtPorEmb.Text := objVenda.strInvoicePorEmb;
  edtAeropo.Text := objVenda.strInvoiceAeropo;
  edtTarifa.Text := FormatFloat('#,##0.00', objVenda.fltInvoiceTarifa);
  edtSeguro.Text := FormatFloat('#,##0.00', objVenda.fltInvoiceSeguro);
  edtFrete.Text  := FormatFloat('#,##0.00', objVenda.fltInvoiceFrete_);
  edtNotify.Text := objVenda.strInvoiceNotify;
  edtCodWor.Text := objVenda.strInvoiceEWorks;
  edtTipCont.Text:= objVenda.strInvoiceContai;
  edtPackin.Text := objVenda.strInvoicePackin;
  pAtualizaTela;
  pAplicaIncoterms;
end;

procedure TfraDadosFechamentoPedidoInvoiceFrame.edtAeropoKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  If fPesqAeroportos(GetParentForm(self) as TForm, edtAeropo, nil, nil, Key, arrSel) then
    fValidaCampos(edtAeropo,  False);
end;

procedure TfraDadosFechamentoPedidoInvoiceFrame.edtCodTerKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  If fPesqIncoterms(GetParentForm(self) as TForm, edtCodTer, nil, nil, Key, arrSel) then
  Begin
    fValidaCampos(edtCodTer,  False);
  End;
end;

procedure TfraDadosFechamentoPedidoInvoiceFrame.edtCodWorKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  If fPesqCidade(GetParentForm(self) as TForm, edtCodWor, edtNomWor, nil, Nil, Key, arrSel) Then
    fValidaCampos(edtCodWor, False);
end;

procedure TfraDadosFechamentoPedidoInvoiceFrame.edtPorDesKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  If fPesqPortos(GetParentForm(self) as TForm, edtPorDes, nil, nil, Key, arrSel) then
    fValidaCampos(edtPorDes,  False);
end;

procedure TfraDadosFechamentoPedidoInvoiceFrame.edtPorEmbKeyPress(
  Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  If fPesqPortos(GetParentForm(self) as TForm, edtPorEmb, nil, nil, Key, arrSel) then
    fValidaCampos(edtPorEmb,  False);
end;

function TfraDadosFechamentoPedidoInvoiceFrame.fConfirmaDados: Boolean;
begin

  objVenda.strInvoiceIncTer := edtCodTer.Text;
  objVenda.strInvoicePorDes := edtPorDes.Text;
  objVenda.strInvoicePorEmb := edtPorEmb.Text;
  objVenda.strInvoiceAeropo := edtAeropo.Text;
  objVenda.fltInvoiceTarifa := fStrToFloat(edtTarifa.Text);
  objVenda.fltInvoiceSeguro := fStrToFloat(edtSeguro.Text);
  objVenda.fltInvoiceFrete_ := fStrToFloat(edtFrete.Text);
  objVenda.strInvoiceNotify := edtNotify.Text;
  objVenda.strInvoiceEWorks := edtCodWor.Text;
  objVenda.strInvoiceContai := edtTipCont.Text;
  objVenda.strInvoicePackin := edtPackin.Text;

  Result := True;
end;

procedure TfraDadosFechamentoPedidoInvoiceFrame.pAplicaIncoterms;
var
  qryAux: TUniQuery;
begin

  edtCodTer.Enabled := True;
  edtPorDes.Enabled := True;
  edtPorEmb.Enabled := True;
  edtAeropo.Enabled := True;
  edtTarifa.Enabled := True;
  edtSeguro.Enabled := True;
  edtFrete.Enabled  := True;
  edtNotify.Enabled := True;
  edtCodWor.Enabled := True;
  edtTipCont.Enabled := True;
  edtPackin.Enabled := True;

  qryAux := fCriaQuery;

  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT * FROM CADICT');
    qryAux.SQL.Add('WHERE ICT_CODICT = :CODICT');
    qryAux.ParamByName('CODICT').AsString := edtCodTer.Text;
    qryAux.Open;

    If not qryAux.IsEmpty Then
    Begin
      edtPorDes.Enabled := (qryAux.FieldByName('ICT_TPTERM').AsString = 'M');
      edtPorEmb.Enabled := (qryAux.FieldByName('ICT_TPTERM').AsString = 'M');
      edtAeropo.Enabled := (qryAux.FieldByName('ICT_TPTERM').AsString = 'A');
      edtTarifa.Enabled := (qryAux.FieldByName('ICT_TARIFA').AsString = 'S');
      edtSeguro.Enabled := (qryAux.FieldByName('ICT_SEGURO').AsString = 'S');
      edtFrete.Enabled  := (qryAux.FieldByName('ICT_FRETE_').AsString = 'S');
    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfraDadosFechamentoPedidoInvoiceFrame.pLimpaTela(blnLimpaIncoterms:Boolean);
begin
  If blnLimpaIncoterms Then
  Begin
    edtCodTer.Clear;
    edtDesTer.Clear;
  End;

  edtPorDes.Clear;
  edtDesPor.Clear;
  edtPorEmb.Clear;
  edtDesEmb.Clear;
  edtAeropo.Clear;
  edtDesAer.Clear;
  edtTarifa.Text := '0.00';
  edtSeguro.Text := '0.00';
  edtFrete.Text  := '0.00';
  edtNotify.Clear;
  edtCodWor.Clear;
  edtNomWor.Clear;
  edtTipCont.Clear;
  edtPackin.Text := 'S';
end;

procedure TfraDadosFechamentoPedidoInvoiceFrame.pAtualizaTela;
begin
  edtDesTer.Text := fRetDescricaoIncoterms(edtCodTer.Text);
  edtDesPor.Text := fRetDescricaoPorto(edtPorDes.Text);
  edtDesEmb.Text := fRetDescricaoPorto(edtPorEmb.Text);
  edtDesAer.Text := fRetDescricaoAeroporto(edtAeropo.Text);
  edtNomWor.Text := fRetNomCidade(edtCodWor.Text, 0);
  edtNomWor.Text := edtNomWor.Text + '-'+ fRetNomCidade(edtCodWor.Text, 1);
end;

function TfraDadosFechamentoPedidoInvoiceFrame.fValidaCampos(Sender: TWinControl;  blnBuscaPorChave: Boolean): Boolean;
Var
  strDescricaoIncoterms: String;
  blnModificouIncoterms: Boolean;
begin
  Result := True;

  If Result Then
  Begin
    If (Sender = edtCodTer) Then
    Begin
      if fEmptyStr(edtCodTer.Text) Then
      Begin
        fMensagem('', 'O campo "Incoterms" deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        strDescricaoIncoterms := fRetDescricaoIncoterms(edtCodTer.Text);
        blnModificouIncoterms := not (edtDesTer.Text = strDescricaoIncoterms);

        edtDesTer.Text := strDescricaoIncoterms;

        if fEmptyStr(edtDesTer.Text) Then
        Begin
          fMensagem('', 'Incoterms não cadastrado!', ['&OK']);
          Result := False;
        End
        Else
        Begin
          If blnModificouIncoterms Then
          Begin
            pLimpaTela(False);
            pAtualizaTela;
            pAplicaIncoterms;
          End;
        End;
      End;
    End

    Else If (Sender = edtPorDes) And (edtPorDes.Enabled) Then
    Begin
      if fEmptyStr(edtPorDes.Text) Then
      Begin
        fMensagem('', 'O campo "Porto de destino" deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtDesPor.Text := fRetDescricaoPorto(edtPorDes.Text);

        if fEmptyStr(edtDesPor.Text) Then
        Begin
          fMensagem('', 'Porto de destino não cadastrado!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtPorEmb) And (edtPorEmb.Enabled) Then
    Begin
      if fEmptyStr(edtPorEmb.Text) Then
      Begin
        fMensagem('', 'O campo "Porto de embarque" deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtDesEmb.Text := fRetDescricaoPorto(edtPorEmb.Text);

        if fEmptyStr(edtDesEmb.Text) Then
        Begin
          fMensagem('', 'Porto de embarque não cadastrado!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtAeropo) And (edtAeropo.Enabled) Then
    Begin
      if fEmptyStr(edtAeropo.Text) Then
      Begin
        fMensagem('', 'O campo "Aeroporto" deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtDesAer.Text := fRetDescricaoAeroporto(edtAeropo.Text);

        if fEmptyStr(edtDesAer.Text) Then
        Begin
          fMensagem('', 'Aeroporto não cadastrado!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtTarifa) And (edtTarifa.Enabled) Then
    Begin
      If fStrtoFloat(edtTarifa.Text) <= 0.0 Then
      Begin
        fMensagem('', 'Informe a tarifa do porto de embarque!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtSeguro) And (edtSeguro.Enabled) Then
    Begin
      If fStrtoFloat(edtSeguro.Text) <= 0.0 Then
      Begin
        fMensagem('', 'Informe o seguro marítimo internacional!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtFrete) And (edtFrete.Enabled) Then
    Begin
      If fStrtoFloat(edtFrete.Text) <= 0.0 Then
      Begin
        fMensagem('', 'Informe o frete do oceano!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodWor) Then
    Begin
      if fEmptyStr(edtCodWor.Text) Then
      Begin
        fMensagem('', 'O campo "Ex-Works" deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        edtNomWor.Text := fRetNomCidade(edtCodWor.Text, 0);
        edtNomWor.Text := edtNomWor.Text + ' - '+ fRetNomCidade(edtCodWor.Text, 1);

        if fEmptyStr(fTiraCaracEspeciaisPonto(edtNomWor.Text)) Then
        Begin
          fMensagem('', 'Cidade não cadastrada!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtPackin) Then
    Begin
      If (fEmptyStr(edtPackin.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "Packing" deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else If (Pos(edtPackin.Text,'S_N_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "Packing" deve ser (S)im ou (N)ão!', ['&OK']);
        Result := False;
      End;
    End

  End;

  If not Result Then
    pSetFocus(Sender);

end;

end.

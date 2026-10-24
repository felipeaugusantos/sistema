{*****************************}
{* qryConTra -> CADTRA       *}
{* qryConReg -> CADREG       *}
{**************************JB*}

unit untFatRomTransMot;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, Uni,
  AppEvnts, Mask, MaskEditFocus, DB, BitBtnLockedIncrem, UniClientDataSet,
  frxClass, frxExportCSVTestabilidade, MemoFocus, TaEntregue.Romaneios.Classes;

type
  TfrmFatRomTransMot = class(TfrmPai)
    btnConfirma: TBitBtnLocked;
    pnlCentral: TPanel;
    lblTransp: TLabel;
    edtCodTra: TEditFocus;
    edtNomTra: TEditFocus;
    lblMotorista: TLabel;
    edtCodMot: TEditFocus;
    edtNomMot: TEditFocus;
    lblRegiao: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    btnRoteiro: TBitBtnLocked;
    mskPlaVei: TMaskEditFocus;
    Label1: TLabel;
    edtDesVei: TEditFocus;
    edtVlrFrete: TEditFocus;
    lbl1: TLabel;
    edtVlrAdiant: TEditFocus;
    edtVlrSaldo: TEditFocus;
    lbl3: TLabel;
    lbl4: TLabel;
    edtPercFrete: TEditFocus;
    lbl2: TLabel;
    lbl5: TLabel;
    edtCodAj1: TEditFocus;
    edtNomAj1: TEditFocus;
    lbl6: TLabel;
    edtCodAj2: TEditFocus;
    edtNomAj2: TEditFocus;
    lblAjudante3: TLabel;
    lblAjudante4: TLabel;
    edtCodAj3: TEditFocus;
    edtNomAj3: TEditFocus;
    edtCodAj4: TEditFocus;
    edtNomAj4: TEditFocus;
    lblObs: TLabel;
    mmoObsFec: TMemoFocus;
    procedure edtCodTraKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure btnRoteiroClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAj1KeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAj2KeyPress(Sender: TObject; var Key: Char);
    procedure mskPlaVeiKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodTraKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodMotKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodAj1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodAj2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodRegKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodAj3KeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAj4KeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAj3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodAj4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    qryConReg: TUniQuery;
    qryConTra: TUniQuery;

    procedure pCarregaCadTra;
    function fCarregaCadMot: Boolean;
    function fVerificarDoc(blnApenasDocNov: Boolean = True): Boolean;
    procedure pCarregaAjudantes;
    procedure pCarregaVeic;
    function fRoteirizacaoCompleta: Boolean;
    procedure pLiberaDocsAppTaEntregue;
    function fValidaRomaneioEmAberto: Boolean;
  protected
    qryCadReg: TUniQuery;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strNomeTabela : String;
    strCodRom     : String;
    fltTotDoc     : Double;
    cdsTmpDoc,
    cdsRomRet,
    cdsOutDig     : TUniClientDataSet;
    strIntFus     : String;
    strDefCon     : String;

    procedure pCalculaSaldoFrete;
    procedure pCarregaCadReg;
  end;


implementation

uses untfuncoesSimples, untTypesSistema, untPesqAux, untFatRomRoteiro, untRomGer,
  untConsultas, untFuncIns;

{$R *.dfm}

procedure TfrmFatRomTransMot.edtCodTraKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTransp: TConsultasArray;

begin
  inherited;
  {************************************}
  {* NOVA CONSULTA DE TRANSPORTADORAS *}
  {*********************************RV*}
  If fPesqTransportadora(conTraSimples, Self, edtCodTra, edtNomTra, Nil, Key, arrTransp) Then
  Begin
    If fValidaCampos(edtCodTra, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatRomTransMot.edtCodTraKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  strCodTmp: String;
begin
  inherited;
  If Key = VK_Insert Then
  begin
    strCodTmp := untFuncIns.fChamaCadTra(Key, fStrZero(edtCodTra.Text, 5));

    If (Not fEmptyStr(strCodTmp)) Then
    Begin
      edtCodTra.Text := strCodTmp;
      edtNomTra.Text := fRetNomTransportadora(edtCodTra.Text);
    End;
  end;
end;

procedure TfrmFatRomTransMot.FormCreate(Sender: TObject);
var
  strSQL: String;
begin
  inherited;
  strSQL    := 'SELECT * FROM CADREG';
  qryCadReg := fCriarQuery(strSQL, Self);

  qryConTra := fCriarQuery('SELECT * FROM CADTRA WHERE FALSE', Self);
  qryConReg := qryCadReg;

  strIntFus := 'N';
end;

procedure TfrmFatRomTransMot.edtCodMotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMot: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE MOTORISTAS *}
  {****************************RV*}
  If fPesqMotorista(Self, edtCodMot, edtNomMot, Nil, Key, arrMot, True, True) Then
  Begin
    If fValidaCampos(edtCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomTransMot.edtCodMotKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  strCodTmp: String;
begin
  inherited;
  If Key = VK_Insert Then
  begin
    strCodTmp := untFuncIns.fChamaCadMot(Key, fStrZero(edtCodMot.Text, 5));

    If (Not fEmptyStr(strCodTmp)) Then
    Begin
      edtCodMot.Text := strCodTmp;
      edtNomMot.Text := fRetNomeMotorista(strCodTmp);
    End;
  end;
end;

function TfrmFatRomTransMot.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodTra) And (fCfgSis('TIPROM') = '1') Then
  Begin

    If (fEmptyStr(edtCodTra.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código da Transportadora deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaCadTra;
      If qryConTra.FieldByName('TRA_CODTRA').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Transportadora não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End;

  End
  Else If (Sender = edtCodMot) Then
  Begin

    If (fEmptyStr(edtCodMot.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Código do Motorista deve ser preenchido!', ['&OK']);
      Result := False;
    End
    Else
    Begin
      If (Not fCarregaCadMot) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Motorista está inativo!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        If fEmptyStr(edtNomMot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Motorista não está cadastrado!', ['&OK']);
          Result := False;
        End
        Else If Not (fValidaRomaneioEmAberto) Then
          Result := False;
      End;
    End;

  End
  Else If (Sender = edtCodReg) And (fCfgSis('TIPROM') = '1') Then
  Begin

    If Not (fEmptyStr(edtCodReg.Text)) Then
    Begin
      pCarregaCadReg;
      If qryConReg.FieldByName('REG_CODREG').IsNull Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa Região não está cadastrada!', ['&Ok']);
        Result := False;
      End;
    End
    Else
      edtDesReg.Text := EmptyStr;

  End
  Else If Sender = mskPlaVei Then
  Begin

    If fVeiculoInativo(fTiraCaracEspeciais(mskPlaVei.Text)) Then
    Begin
      edtDesVei.Text := '';
      fMensagem('','Este veículo está inativo.',['&O k']);
      Result := False;
    End
    Else
    Begin
      mskPlaVei.Text := fTiraCaracEspeciais(mskPlaVei.Text);
      edtDesVei.Text := fRetornaDescricaoVeic(fTiraCaracEspeciais(mskPlaVei.Text));

      If Not fEmptyStr(fTiraCaracEspeciais(mskPlaVei.Text)) Then
      Begin
        If fEmptyStr(edtDesVei.Text) Then
        Begin
          Result := False;
          fMensagem('','Nenhum veículo cadastrado com esta placa!',['&Ok']);
        End
      End
      Else If fCfgSis('OPVGRM', varBoolean) Then
      Begin
        Result := False;
        fMensagem('','Necessário preencher o número do veículo!',['&Ok']);
      End;
    End;

  End
  Else If Sender = edtCodAj1 Then
  Begin

    edtNomAj1.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'],[edtCodAj1.Text], False);

    If Not fEmptyStr(edtCodAj1.Text) Then
    Begin
      If fEmptyStr(edtNomAj1.Text) Then
      Begin
        Result := False;
        fMensagem('','Nenhum ajudante cadastrado com esta código!',['&Ok']);
      End
    End;

  End
  Else If Sender = edtCodAj2 Then
  Begin

    edtNomAj2.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'],[edtCodAj2.Text], False);

    If Not fEmptyStr(edtCodAj2.Text) Then
    Begin
      If fEmptyStr(edtNomAj2.Text) Then
      Begin
        Result := False;
        fMensagem('','Nenhum ajudante cadastrado com esta código!',['&Ok']);
      End
    End;

  End
  Else If Sender = edtCodAj3 Then
  Begin
    edtNomAj3.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'], [edtCodAj3.Text], False);

    If (Not fEmptyStr(edtCodAj3.Text)) And (fEmptyStr(edtNomAj3.Text)) Then
    Begin
      Result := False;
      fMensagem('', 'Nenhum ajudante cadastrado com este código!', ['&Ok']);
    End;
  End
  Else If Sender = edtCodAj4 Then
  Begin
    edtNomAj4.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'], [edtCodAj4.Text], False);

    If (Not fEmptyStr(edtCodAj4.Text)) And (fEmptyStr(edtNomAj4.Text)) Then
    Begin
      Result := False;
      fMensagem('', 'Nenhum ajudante cadastrado com este código!', ['&Ok']);
    End;
  End
  Else If (Sender = edtVlrFrete) Or (Sender = edtVlrAdiant) Then
  Begin

    If Not fEmptyStr(edtVlrFrete.Text) Then
      pCalculaSaldoFrete;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmFatRomTransMot.fVerificarDoc(blnApenasDocNov: Boolean = True): Boolean;
var
  intRecNo: Integer;
begin
  intRecNo := 0;
  try
    intRecNo := cdsTmpDoc.RecNo;
    cdsTmpDoc.DisableControls;

    Result := False;
    cdsTmpDoc.First;
    While Not cdsTmpDoc.Eof Do
    Begin
      if blnApenasDocNov then
      begin
        if fEmptyStr(cdsTmpDoc.FieldByName('GER_NROROM').AsString) then
        begin
          Result := True;
        end
        else
        begin
          Result := False;
          Exit;
        end;
      end
      else
      begin
        if not(fEmptyStr(cdsTmpDoc.FieldByName('GER_NROROM').AsString)) then
        begin
          Result := True;
        end
        else
        begin
          Result := False;
          Exit;
        end;
      end;
      cdsTmpDoc.Next;
    End;

  finally
    cdsTmpDoc.RecNo := intRecNo;
    cdsTmpDoc.EnableControls;
  end;
end;

procedure TfrmFatRomTransMot.pCarregaCadTra;
begin
  pPesquisaCadTra(qryConTra, qryConTra, edtCodTra.Text);
  With qryConTra Do
  Begin
    edtNomTra.Text := FieldByName('TRA_NOMTRA').AsString;
  End;
end;

procedure TfrmFatRomTransMot.pCarregaVeic;
begin
  edtDesVei.Text := fRetornaDescricaoVeic(fTiraCaracEspeciais(mskPlaVei.Text));
end;

procedure TfrmFatRomTransMot.pCalculaSaldoFrete;
  Var
    fltFrete: Double;
    fltAdian: Double;
    fltSaldo: Double;
    fltPerc : Double;
begin
  fltPerc  := 0;
  fltFrete := fStrToFloat(edtVlrFrete.Text);
  fltAdian := fStrToFloat(edtVlrAdiant.Text);
  fltSaldo := fltFrete - fltAdian;
  If (fltFrete > 0) and (fltTotDoc > 0) Then
    fltPerc  := (fltFrete / fltTotDoc) * 100;


  edtVlrSaldo.Text  := FloatToStrF(fltSaldo, ffFixed, 12, 2);
  edtPercFrete.Text := FloatToStrF(fltPerc, ffFixed, 12, 4);
end;

function TfrmFatRomTransMot.fCarregaCadMot: Boolean;
begin
  If Not fEmptyStr(edtCodMot.Text) Then
  Begin
    if (fRetStatusMotorista(edtCodMot.Text) = 'I') Then
    Begin
      edtNomMot.Clear;
      Result := False;
      Exit;
    End
    Else
      edtNomMot.Text := fRetNomeMotorista(edtCodMot.Text);
  End
  Else
    edtNomMot.Clear;

  Result := True;
end;

procedure TfrmFatRomTransMot.pCarregaAjudantes;
begin
  edtNomAj1.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'], [edtCodAj1.Text], False);
  edtNomAj2.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'], [edtCodAj2.Text], False);
  edtNomAj3.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'], [edtCodAj3.Text], False);
  edtNomAj4.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'], [edtCodAj4.Text], False);
end;

procedure TfrmFatRomTransMot.pCarregaCadReg;
begin
  pPesquisaCadReg(qryCadReg, qryConReg, edtCodReg.Text);
  With qryConReg Do
  Begin
    edtDesReg.Text := FieldByName('REG_DESREG').AsString;
  End;
end;

function TfrmFatRomTransMot.fRoteirizacaoCompleta: Boolean;
var
  blnExisteDocLiberado,
  blnExisteDocNaoLiberado: Boolean;
  intOpc: Integer;
begin
  Result := True;

  if cdsTmpDoc.IsEmpty then
    Exit;

  if not fCfgSis('MATDIS', varBoolean) then
    Exit;

  blnExisteDocLiberado := False;
  blnExisteDocNaoLiberado := False;

  cdsTmpDoc.DisableControls;

  cdsTmpDoc.First;
  while not cdsTmpDoc.Eof do
  begin
    if not blnExisteDocLiberado then
      blnExisteDocLiberado := (cdsTmpDoc.FieldByName('GER_LIBAPP').AsString = 'S');

    if not blnExisteDocNaoLiberado then
      blnExisteDocNaoLiberado := (cdsTmpDoc.FieldByName('GER_LIBAPP').AsString <> 'S') ;

    if blnExisteDocLiberado and blnExisteDocNaoLiberado then
    begin
      Result := False;
      Break;
    end;

    cdsTmpDoc.Next;
  end;

  cdsTmpDoc.EnableControls;

  if not Result then
  begin
    intOpc :=  fMensagem('ATENÇÃO!', 'Existem documentos liberados e não liberados para carregamento no app Tá Entregue.'+#13#10+
                                     'O que você pretende fazer?', ['Parar a gravação e recalcular a Rota',
                                     'Continuar a gravação e liberar documentos'],
                                     1,      // intFocoBotao: Integer = 1;
                                     True,   // blnSaiComEsc: Boolean = False;
                                     1,      // intEstFon: Integer = 1;
                                     330,    // intWidBut: Integer = 0;
                                     False,  // blnAutosize: Boolean = False;
                                     0,      // intSomarTop: Integer=0;
                                     False,  // blnObrigaEsc: Boolean = False;
                                     False,  // blnOcultPainelBtn: Boolean = False;
                                     True,   // blnBtnSemImg : Boolean = False;
                                     0,      // intHeightOpc: Integer = 0;
                                     700);   // intFormWidth : Integer = 0) = 1

    case intOpc of
      0: Result := False;
      1: Result := False;
      2: begin
           pLiberaDocsAppTaEntregue;
           Result := True;
         end;
    end;

  end;
end;

procedure TfrmFatRomTransMot.pLiberaDocsAppTaEntregue;
begin
  cdsTmpDoc.DisableControls;

  cdsTmpDoc.First;
  while not cdsTmpDoc.Eof do
  begin
    if cdsTmpDoc.FieldByName('GER_LIBAPP').AsString <> 'S' then
    begin
      cdsTmpDoc.Edit;
      cdsTmpDoc.FieldByName('GER_LIBAPP').AsString := 'S';
      cdsTmpDoc.Post;
    end;

    cdsTmpDoc.Next;
  end;

  cdsTmpDoc.EnableControls;
end;

procedure TfrmFatRomTransMot.btnConfirmaClick(Sender: TObject);
var
  blnConfirma: Boolean;
begin
  inherited;
  ModalResult := mrNone;

  blnConfirma := True;

  If Assigned(cdsTmpDoc) Then
  Begin
    cdsTmpDoc.Filtered := False;
    cdsTmpDoc.Filter   := 'GER_ORDIMP > 0';
    cdsTmpDoc.Filtered := True;
  End;

  If Not (fVerificaCampos) Then
     blnConfirma := False;

  If Assigned(cdsTmpDoc) Then
  Begin
    if (blnConfirma) and (not fRoteirizacaoCompleta) then
    begin
      blnConfirma := False;
      btnRoteiro.Click;
    end;
  End;

  if blnConfirma then
  begin
    Close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmFatRomTransMot.FormShow(Sender: TObject);
begin
  inherited;
  fCarregaCadMot;
  pCarregaVeic;
  pCarregaAjudantes;
  pCalculaSaldoFrete;

  If fCfgSis('TIPROM') = '1' Then
  Begin
    pCarregaCadTra;
    pCarregaCadReg;
    pSetFocus(edtCodTra);
  End
  Else
  Begin
    lblTransp.Visible := False;
    edtCodTra.Visible := False;
    edtNomTra.Visible := False;
    lblRegiao.Visible := False;
    edtCodReg.Visible := False;
    edtDesReg.Visible := False;
    pSetFocus(edtCodMot);
  End;

  btnRoteiro.Visible := (strIntFus = 'N') And Assigned(cdsTmpDoc);
end;

procedure TfrmFatRomTransMot.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrRegiao : TConsultasArray;

begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE REGIOES *}
  {*************************DP*}
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatRomTransMot.edtCodRegKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  strCodTmp: String;
begin
  inherited;
  If Key = VK_Insert Then
  begin
    strCodTmp := untFuncIns.fChamaCadReg(Key, fStrZero(edtCodReg.Text, 5));

    If (Not fEmptyStr(strCodTmp)) Then
    Begin
      edtCodReg.Text := strCodTmp;
      pCarregaCadReg;
    End;
  end;
end;

procedure TfrmFatRomTransMot.btnRoteiroClick(Sender: TObject);
Var
  intContador : Integer;
  strIndice   : String;
  blnTemDocNov: Boolean;
  blnTemDocAnt: Boolean;
  blnAtuOrdImp: Boolean;
begin
  inherited;
  With cdsTmpDoc Do
  Begin
    Filtered := False;
    Filter   := 'GER_ORDIMP > 0';
    Filtered := True;
  End;

  strIndice := cdsTmpDoc.IndexFieldNames;
  If fEmptyStr(cdsTmpDoc.FieldByName('GER_ORDIMP').AsString) or fCfgSis('ROTREG', varBoolean) Then
  Begin

    intContador  := 1;
    blnAtuOrdImp := False;
    if fCfgSis('ROTREG', varBoolean) then
    begin
      blnAtuOrdImp := False;
      blnTemDocNov := fVerificarDoc;
      blnTemDocAnt := fVerificarDoc(False);
      if blnTemDocNov and not(blnTemDocAnt) then
      begin
        cdsTmpDoc.IndexFieldNames := 'GER_SEQUEN';
        cdsTmpDoc.First;
        blnAtuOrdImp := True;
      end
      else
        if not(blnTemDocNov) and not(blnTemDocAnt) then
        begin
          If (fMensagem('AVISO!', 'Foram incluído novos documentos no romaneio.'+#13#10+' Deseja reordenar pela sequência de cidades?', ['&Sim', '&Não'], 1) = 1) Then
          begin
           cdsTmpDoc.IndexFieldNames := 'GER_SEQUEN';
           cdsTmpDoc.First;
           blnAtuOrdImp := True;
          end;
        end;
    end;

    if blnAtuOrdImp or fEmptyStr(cdsTmpDoc.FieldByName('GER_ORDIMP').AsString) then
    begin

      While Not cdsTmpDoc.Eof Do
      Begin
        cdsTmpDoc.Edit;

        if fCfgSis('ROTREG', varBoolean) then
          cdsTmpDoc.FieldByName('GER_ORDIMP').AsString := IntToStr(IntContador)
        else
          cdsTmpDoc.FieldByName('ORDIMP').AsString := IntToStr(IntContador);

        cdsTmpDoc.Post;
        cdsTmpDoc.Next;
        inc(intContador);
      End;

    end;
  End;

  if (Assigned(cdsTmpDoc.FindField('GER_TRANSP'))) then
  begin
    cdsTmpDoc.First;
    While Not cdsTmpDoc.Eof Do
    Begin
      if fEmptyStr(edtCodTra.Text) then
      begin
        cdsTmpDoc.Edit;
        cdsTmpDoc.FieldByName('GER_TRANSP').AsString := '';
        cdsTmpDoc.Post;
      end
      else
      begin
        cdsTmpDoc.Edit;
        cdsTmpDoc.FieldByName('GER_TRANSP').AsString := fCampoTabela('TRA_NOMTRA', 'CADTRA', ['TRA_CODTRA'], [edtCodTra.Text], False);
        cdsTmpDoc.Post;
      end;
      cdsTmpDoc.Next;
    End;
  end;

  cdsTmpDoc.IndexFieldNames := 'GER_ORDIMP';

  Try
    pCriarFormularios(TfrmFatRomRoteiro, frmFatRomRoteiro);
    if fCfgSis('MATDIS', varBoolean) then
    begin
      frmFatRomRoteiro.strCodMot := edtCodMot.Text;
      frmFatRomRoteiro.WindowState := wsMaximized;
    end;
    frmFatRomRoteiro.cdsTmpDoc := cdsTmpDoc;
    frmFatRomRoteiro.cdsRomRet := cdsRomRet;
    frmFatRomRoteiro.cdsOutDig := cdsOutDig;
    frmFatRomRoteiro.TaEntregue:= TTaEntregue.Create();
    frmFatRomRoteiro.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmFatRomTransMot.btnRoteiroClick]');
    End;
  End;

  strDefCon := frmFatRomRoteiro.strDefCon;

  pFreeAndNil(frmFatRomRoteiro);
  cdsTmpDoc.IndexFieldNames := strIndice;
end;

procedure TfrmFatRomTransMot.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_ESCAPE) Then
    btnSair.Click
  Else
  If (Key = VK_F9) And (btnRoteiro.Visible) Then
    btnRoteiro.Click;
end;

procedure TfrmFatRomTransMot.btnSairClick(Sender: TObject);
begin
  inherited;

  If btnRoteiro.Visible Then
  Begin
    cdsTmpDoc.Filtered := False;
    cdsTmpDoc.Filter   := '';
  End;
end;

procedure TfrmFatRomTransMot.mskPlaVeiKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrVeic: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE VEÍCULOS   *}
  {****************************RV*}
  If fPesqVeiculos(Self, mskPlaVei, edtDesVei, Nil, Key, arrVeic, True, True,  ' VEI_STATUS = "A" ') Then
  Begin
    If fValidaCampos(mskPlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatRomTransMot.mskPlaVeiKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  strCodTmp: String;
begin
  inherited;
  If Key = VK_Insert Then
  begin
    strCodTmp := untFuncIns.fChamaCadVei(Key, mskPlaVei.Text);

    If (Not fEmptyStr(strCodTmp)) Then
    Begin
      mskPlaVei.Text := fTiraCaracEspeciais(strCodTmp);
      edtDesVei.Text := fRetornaDescricaoVeic(fTiraCaracEspeciais(strCodTmp));
    End;
  end;
end;

procedure TfrmFatRomTransMot.edtCodAj1KeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqAjudantes(Self, edtCodAj1, edtNomAj1, nil, nil, Key, arrSel, True, True) Then
  Begin
    If fValidaCampos(edtCodAj1, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatRomTransMot.edtCodAj1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  strCodTmp: String;
begin
  inherited;
  If Key = VK_Insert Then
  begin
    strCodTmp := untFuncIns.fChamaCadAju(Key, fStrZero(edtCodAj1.Text, 5));

    If (Not fEmptyStr(strCodTmp)) Then
    Begin
      edtCodAj1.Text := strCodTmp;
      edtNomAj1.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'],[edtCodAj1.Text], False);
    End;
  end;
end;

procedure TfrmFatRomTransMot.edtCodAj2KeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqAjudantes(Self, edtCodAj2, edtNomAj2, nil, nil, Key, arrSel, True, True) Then
  Begin
    If fValidaCampos(edtCodAj2, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmFatRomTransMot.edtCodAj2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  strCodTmp: String;
begin
  inherited;
  If Key = VK_Insert Then
  begin
    strCodTmp := untFuncIns.fChamaCadAju(Key, fStrZero(edtCodAj2.Text, 5));

    If (Not fEmptyStr(strCodTmp)) Then
    Begin
      edtCodAj2.Text := strCodTmp;
      edtNomAj2.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'],[edtCodAj2.Text], False);
    End;
  end;
end;

procedure TfrmFatRomTransMot.edtCodAj3KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqAjudantes(Self, edtCodAj3, edtNomAj3, nil, nil, Key, arrSel, True, True) Then
  Begin
    If fValidaCampos(edtCodAj3, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomTransMot.edtCodAj3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  Var
    strCodTmp: String;
begin
  inherited;

  If Key = VK_Insert Then
  begin
    strCodTmp := untFuncIns.fChamaCadAju(Key, fStrZero(edtCodAj3.Text, 5));

    If (Not fEmptyStr(strCodTmp)) Then
    Begin
      edtCodAj3.Text := strCodTmp;
      edtNomAj3.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'],[edtCodAj3.Text], False);
    End;
  end;
end;

procedure TfrmFatRomTransMot.edtCodAj4KeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqAjudantes(Self, edtCodAj4, edtNomAj4, nil, nil, Key, arrSel, True, True) Then
  Begin
    If fValidaCampos(edtCodAj4, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomTransMot.edtCodAj4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  Var
    strCodTmp: String;
begin
  inherited;

  If Key = VK_Insert Then
  begin
    strCodTmp := untFuncIns.fChamaCadAju(Key, fStrZero(edtCodAj4.Text, 5));

    If (Not fEmptyStr(strCodTmp)) Then
    Begin
      edtCodAj4.Text := strCodTmp;
      edtNomAj4.Text := fCampoTabela('AJU_NOMAJU', 'CADAJU', ['AJU_CODAJU'],[edtCodAj4.Text], False);
    End;
  end;
end;

function TfrmFatRomTransMot.fValidaRomaneioEmAberto: Boolean;
  Var
    strNumRomAberto: String;
begin
  Result := False;

  If Not (fCfgSis('ROMABE', varBoolean)) Then
  begin
    Result := True;
    Exit;
  end;

  strNumRomAberto := fRetornaRomaneioEmAberto(edtCodMot.Text);

  If Not (fEmptyStr(strNumRomAberto)) Then
  begin
    fMensagem('ATENÇÃO!', 'Existe romaneio em aberto para o motorista '+
      edtCodMot.Text +' - '+ edtNomMot.Text +', favor baixar o romaneio Nº '+
      strNumRomAberto +' para prosseguir com a nova inclusão!', ['&Ok']);
    Exit;
  end;

  Result := True;
end;

end.


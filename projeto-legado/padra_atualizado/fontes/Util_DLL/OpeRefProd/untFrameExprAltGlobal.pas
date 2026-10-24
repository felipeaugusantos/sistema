unit untFrameExprAltGlobal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  MaskEditFocus, EditFocus, ComboBoxFocus, Vcl.ExtCtrls, untFuncoesSimples, BitBtnLockedIncrem,
  Vcl.Buttons;

type
  TPrcOnRemover = procedure(AIntTag: Integer) of object;
  TPrcExpandir = procedure of object;
  TEventoCampoSelecionado = procedure (AStrCampo: String; ATagFrame: Integer; var ABlnPodeSelecionar: Boolean) of object;
  TfrmExprAltGlobal = class(TFrame)
    pnlExpressao: TPanel;
    btnRemoverFrame: TBitBtnLocked;
    cmbCampos: TComboBoxFocus;
    cmbOperad: TComboBoxFocus;
    edtValDig: TEditFocus;
    edtValDigOutro: TEditFocus;
    mskDtaExpIni: TMaskEditFocus;
    mskDtaExpFin: TMaskEditFocus;
    shpDireita: TShape;
    shpRodape: TShape;
    shpEsquerda: TShape;
    shpTopo: TShape;
    lblNumExpr: TLabel;
    procedure btnRemoverFrameClick(Sender: TObject);
    procedure cmbCamposChange(Sender: TObject);
    procedure cmbOperadChange(Sender: TObject);
    procedure cmbCamposExit(Sender: TObject);
    procedure cmbOperadExit(Sender: TObject);
    procedure edtValDigExit(Sender: TObject);
    procedure edtValDigOutroExit(Sender: TObject);
    procedure mskDtaExpIniExit(Sender: TObject);
    procedure mskDtaExpFinExit(Sender: TObject);
  private
    FPrcOnRemover: TPrcOnRemover;
    FArrCamposExp: Array Of TCampoExp;
    FEdtDiasMovimentacao: TEdit;
    FBlnCarregandoCadInt: Boolean;
    FArrCamposGlobal: TArrCampoGlobal;
    FBlnAltPorFator: Boolean;
    FOnCampoSelecionado: TEventoCampoSelecionado;
    FStrUltimoCampoSelecionado: String;
    FStrUltimoCampoDescSelecionado: String;
    FPrcExpandir: TPrcExpandir;
    FStlCamposUtilizados: TStringList;
    function fSoma(var intVal: Integer; intSoma: Integer = 1): Integer;

  public
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
    procedure pCarregaComboExpressao;
    procedure pAjustaCamposExpressao(strNomCam: String = '');
    procedure pPreencheComboOperadores;
    function fGetCampoSelecionado: String;
    function fRetornaNomeCampoExpressao(strDesCam: String): String;


    property OnRemover: TPrcOnRemover read FPrcOnRemover write FPrcOnRemover;
    property OnCampoSelecionado: TEventoCampoSelecionado read FOnCampoSelecionado write FOnCampoSelecionado;

    property edtDiasMovimentacao: TEdit write FEdtDiasMovimentacao;
    property blnCarregandoCadInt: Boolean read FBlnCarregandoCadInt write FBlnCarregandoCadInt;
    property arrCamposGlobal: TArrCampoGlobal read FArrCamposGlobal write FArrCamposGlobal;
    property blnAltPorFator: Boolean read FBlnAltPorFator write FBlnAltPorFator;
    property prcExpandir: TPrcExpandir read FPrcExpandir write FPrcExpandir;
    property stlCamposUtilizados: TStringList read FStlCamposUtilizados write FStlCamposUtilizados;
  end;

implementation

{$R *.dfm}

procedure TfrmExprAltGlobal.btnRemoverFrameClick(Sender: TObject);
begin
  If Assigned(FPrcOnRemover) Then
    FPrcOnRemover(TBitBtnLocked(Sender).Tag);
end;

function TfrmExprAltGlobal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  {***********************************}
  {* VALIDA O OPERADOR DA EXPRESSÃO  *}
  {********************************PZ*}
  If (Sender = cmbOperad) And (Pos('SEM_REAJUSTE_CUSTO', fRetornaNomeCampoExpressao(cmbCampos.Text)) = 0) Then
  Begin
    If cmbOperad.Visible Then
    Begin
      If (Not fEmptyStr(cmbCampos.Text)) And (fEmptyStr(cmbOperad.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','O operador da expressão deve ser informado!', ['&O k']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtValDigOutro) And (edtValDigOutro.Visible) Then
  Begin
    If (Not fEmptyStr(edtValDigOutro.Text)) Then
    Begin
      If fStrToFloat(edtValDig.Text) > fStrToFloat(edtValDigOutro.Text) Then
      Begin
        fMensagem('ATENÇÃO!','Valor Inicial deve ser menor ou igual ao Valor Final!', ['&O k']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = mskDtaExpIni) And ((Pos('SEM_REAJUSTE_CUSTO', fRetornaNomeCampoExpressao(cmbCampos.Text)) > 0) Or
                                         (Pos('ITE_DTAUVE', fRetornaNomeCampoExpressao(cmbCampos.Text)) > 0)) Then
  Begin
    If fEmptyDate(mskDtaExpIni.Text) Then
    Begin
      pMensagemOk('Necessário informar a Data Inicial da Expressão!');
      Result := False;
    End
    Else
    Begin
      If StrToDateDef(mskDtaExpIni.Text, 0) <= 0 Then
      Begin
        pMensagemOk('Data Inicial da Expressão Inválida!');
        Result := False;
      End;
    End;
  End
  Else
  If (Sender = mskDtaExpFin) And ((Pos('SEM_REAJUSTE_CUSTO', fRetornaNomeCampoExpressao(cmbCampos.Text)) > 0) Or
                                  (Pos('ITE_DTAUVE', fRetornaNomeCampoExpressao(cmbCampos.Text)) > 0)) Then
  Begin
    If fEmptyDate(mskDtaExpFin.Text) Then
    Begin
      pMensagemOk('Necessário informar a Data Final da Expressão!');
      Result := False;
    End
    Else
    Begin
      If StrToDateDef(mskDtaExpFin.Text, 0) <= 0 Then
      Begin
        pMensagemOk('Data Final da Expressão Inválida!');
        Result := False;
      End;
    End;

    If Result Then
    Begin
      If StrToDateDef(mskDtaExpFin.Text, 0) < StrToDateDef(mskDtaExpIni.Text, 0) Then
      Begin
        pMensagemOk('A Data Final da Expressão deve ser Maior ou Igual a Data Inicial da Expressão!');
        Result := False;
      End;
    End;
  End;

  If Not Result Then
  Begin
    If btnRemoverFrame.Tag > 1 Then
      If Assigned(FPrcExpandir) Then
        FPrcExpandir;
    pSetFocus(Sender);
  End;
end;


procedure TfrmExprAltGlobal.mskDtaExpFinExit(Sender: TObject);
begin
  fValidaCampos(mskDtaExpFin, True);
end;

procedure TfrmExprAltGlobal.mskDtaExpIniExit(Sender: TObject);
begin
  fValidaCampos(mskDtaExpIni, True);
end;

procedure TfrmExprAltGlobal.cmbCamposChange(Sender: TObject);
var
  strCampoExp: String;
  blnPodeSelecionar: Boolean;
begin
  inherited;
  strCampoExp := fRetornaNomeCampoExpressao(cmbCampos.Text);

  if Assigned(FOnCampoSelecionado) then
  begin
    blnPodeSelecionar := True;
    FOnCampoSelecionado(strCampoExp, Self.BtnRemoverFrame.Tag, blnPodeSelecionar);

    if not blnPodeSelecionar then
    begin
      // Restaura o valor anterior do combo
      // Você precisa armazenar o valor anterior em uma variável
      Try
        cmbCampos.OnChange := Nil;
        cmbCampos.ItemIndex := cmbCampos.Items.IndexOf(FStrUltimoCampoDescSelecionado);
      Finally
        cmbCampos.OnChange := cmbCamposChange
      End;
      Exit;
    end;
  end;
  FStrUltimoCampoSelecionado := strCampoExp;
  FStrUltimoCampoDescSelecionado := cmbCampos.Text;

  pAjustaCamposExpressao(strCampoExp);
end;

procedure TfrmExprAltGlobal.cmbCamposExit(Sender: TObject);
begin
  fValidaCampos(cmbCampos, True);
end;

procedure TfrmExprAltGlobal.cmbOperadChange(Sender: TObject);
begin
  inherited;

  If cmbOperad.Text <> 'Entre' Then
  Begin
    edtValDigOutro.Visible:= False;
    edtValDigOutro.Enabled:= False;
    edtValDigOutro.Text   := '0.00';

    edtValDig.Visible    := True;
    edtValDig.Enabled    := True;
    edtValDig.Text       := '0.00';
  End
  Else
  Begin
    edtValDigOutro.Visible:= True;
    edtValDigOutro.Enabled:= True;
    edtValDigOutro.Text   := '0.00';

    edtValDig.Visible    := True;
    edtValDig.Enabled    := True;
    edtValDig.Text       := '0.00';
  End;
end;

procedure TfrmExprAltGlobal.cmbOperadExit(Sender: TObject);
begin
  fValidaCampos(cmbOperad, True);
end;

procedure TfrmExprAltGlobal.edtValDigExit(Sender: TObject);
begin
  fValidaCampos(edtValDig, True);
end;

procedure TfrmExprAltGlobal.edtValDigOutroExit(Sender: TObject);
begin
  fValidaCampos(edtValDigOutro, True);
end;

function TfrmExprAltGlobal.fGetCampoSelecionado: String;
begin
  Result := fRetornaNomeCampoExpressao(cmbCampos.Text);
end;

function TfrmExprAltGlobal.fRetornaNomeCampoExpressao(strDesCam: String): String;
Var
  intPosArr: Integer;
begin
  If fEmptyStr(strDesCam) Then
  Begin
    Result := '';
    Exit;
  End;

  For intPosArr := 0 To Length(FArrCamposExp) - 1 Do
  Begin
    If (FArrCamposExp[intPosArr].strDesCam = strDesCam) Then
    Begin
      Result := FArrCamposExp[intPosArr].strNomCam;
      Break;
    End;
  End;
end;

procedure TfrmExprAltGlobal.pAjustaCamposExpressao(strNomCam: String = '');
begin
  FEdtDiasMovimentacao.Enabled := (Not (Pos('ITE_DTAUVE', FStlCamposUtilizados.CommaText) > 0));
  If fEmptyStr(strNomCam) Then
  Begin
    cmbCampos.ItemIndex  := -1;

    cmbOperad.Visible    := True;
    cmbOperad.Enabled    := False;
    cmbOperad.ItemIndex  := -1;

    edtValDig.Visible    := True;
    edtValDig.Enabled    := False;
    edtValDig.Text       := '0.00';

    edtValDigOutro.Visible:= True;
    edtValDigOutro.Enabled:= False;
    edtValDigOutro.Text   := '0.00';

    mskDtaExpIni.Clear;
    mskDtaExpIni.Enabled := False;
    mskDtaExpIni.Visible := False;
    mskDtaExpFin.Clear;
    mskDtaExpFin.Enabled := False;
    mskDtaExpFin.Visible := False;
  End
  Else
  Begin
    If (Pos('SEM_REAJUSTE_CUSTO', FStlCamposUtilizados.CommaText) > 0) Or (Pos('ITE_DTAUVE', FStlCamposUtilizados.CommaText) > 0) Then
    Begin
      mskDtaExpIni.Visible := True;
      mskDtaExpIni.Enabled := True;
      If Not FBlnCarregandoCadInt Then
        mskDtaExpIni.Clear;
      mskDtaExpIni.Left    := 396;

      mskDtaExpFin.Visible := True;
      mskDtaExpFin.Enabled := True;
      If Not FBlnCarregandoCadInt Then
        mskDtaExpFin.Clear;
      mskDtaExpFin.Left    := 468;

      cmbOperad.ItemIndex  := -1;
      cmbOperad.Enabled    := False;
      cmbOperad.Visible    := False;

      edtValDig.Text       := '0.00';
      edtValDig.Enabled    := False;
      edtValDig.Visible    := False;

      edtValDigOutro.Visible:= False;
      edtValDigOutro.Enabled:= False;
      edtValDigOutro.Text   := '0.00';

      If Not FedtDiasMovimentacao.Enabled Then
        FedtDiasMovimentacao.Clear;

    End
    Else
    Begin
      cmbOperad.Visible    := True;
      cmbOperad.Enabled    := True;
      cmbOperad.ItemIndex  := -1;

      edtValDig.Visible    := True;
      edtValDig.Enabled    := True;
      edtValDig.Text       := '0.00';

      edtValDigOutro.Visible:= True;
      edtValDigOutro.Enabled:= True;
      edtValDigOutro.Text   := '0.00';

      mskDtaExpIni.Clear;
      mskDtaExpIni.Enabled := False;
      mskDtaExpIni.Visible := False;

      mskDtaExpFin.Clear;
      mskDtaExpFin.Enabled := False;
      mskDtaExpFin.Visible := False;
    End;
  End;

  If FBlnCarregandoCadInt Then
    FBlnCarregandoCadInt := False;
end;

procedure TfrmExprAltGlobal.pCarregaComboExpressao;
Var
  intPosGlo: Integer;
  intPosExp: Integer;
begin
  intPosExp := 0;

  For intPosGlo := 0 To Length(FArrCamposGlobal) - 1 Do
  Begin
    If (Pos('NUMERIC', FArrCamposGlobal[intPosGlo].strTipCam) > 0) Then
    Begin
      SetLength(FArrCamposExp, fSoma(intPosExp));
      FArrCamposExp[(intPosExp - 1)].strNomCam := arrCamposGlobal[intPosGlo].strNomCam;
      FArrCamposExp[(intPosExp - 1)].strDesCam := arrCamposGlobal[intPosGlo].strDesCam;

    End
    Else
    If (Pos('DECIMAL', FArrCamposGlobal[intPosGlo].strTipCam) > 0) Then
    Begin
      SetLength(FArrCamposExp, fSoma(intPosExp));
      FArrCamposExp[(intPosExp - 1)].strNomCam := arrCamposGlobal[intPosGlo].strNomCam;
      FArrCamposExp[(intPosExp - 1)].strDesCam := arrCamposGlobal[intPosGlo].strDesCam;

    End;
  End;

  //inclusão do campo ITE_SALDOS apenas no filtro do combo expressão.
  SetLength(FArrCamposExp, fSoma(intPosExp));
  FArrCamposExp[(intPosExp - 1)].strNomCam := 'ITE_SALDOS';
  FArrCamposExp[(intPosExp - 1)].strDesCam := 'Saldo';

  If FBlnAltPorFator Then
  Begin
    //inclusão do campo SEM_REAJUSTE_CUSTO apenas no filtro do combo expressão.
    SetLength(FArrCamposExp, fSoma(intPosExp));
    FArrCamposExp[(intPosExp - 1)].strNomCam := 'SEM_REAJUSTE_CUSTO';
    FArrCamposExp[(intPosExp - 1)].strDesCam := 'Sem Reajustes de Custo';
  End;

  //inclusão do campo ITE_DTAUVE apenas no filtro do combo expressão.
  SetLength(FArrCamposExp, fSoma(intPosExp));
  FArrCamposExp[(intPosExp - 1)].strNomCam := 'ITE_DTAUVE';
  FArrCamposExp[(intPosExp - 1)].strDesCam := 'Data da última venda';

  cmbCampos.Clear;

  For intPosExp := 0 To Length(FArrCamposExp) - 1 Do
  Begin
    cmbCampos.Items.Add(FArrCamposExp[intPosExp].strDesCam);
  End;

  cmbCampos.ItemIndex := -1;

end;

procedure TfrmExprAltGlobal.pPreencheComboOperadores;
begin
  cmbOperad.Items.Clear;
  cmbOperad.Items.Add('>');
  cmbOperad.Items.Add('>=');
  cmbOperad.Items.Add('<');
  cmbOperad.Items.Add('<=');
  cmbOperad.Items.Add('=');
  cmbOperad.Items.Add('<>');
  cmbOperad.Items.Add('Entre');
end;

function TfrmExprAltGlobal.fSoma(Var intVal : Integer; intSoma : Integer = 1) : Integer;
Begin
  intVal := intVal + intSoma;
  Result := intVal + 1;
End;

end.

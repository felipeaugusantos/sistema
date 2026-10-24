unit untDigCodBarBoleto;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Mask, MaskEditFocus, EditFocus, untfuncoesSimples,
  ComCtrls, Buttons, ExtCtrls, StrUtils, Menus, AppEvnts, untFuncoesGenerica, untConstantes,
  Uni, BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  Math, Vcl.DBCtrls, DBEditFocus, untBancos, untFuncoes;

type
  TfrmDigCodBarBoleto = class(TfrmPaiSimples)
    pnlBotoesBaixa: TPanel;
    pnlFundo: TPanel;
    pnlDuplics: TPanel;
    btnSairDig: TBitBtnLocked;
    btnSalvar: TBitBtnLocked;
    pnlValPad: TPanel;
    pnl13: TPanel;
    Label3: TLabel;
    edtSeq13: TEditFocus;
    edtDtaVen13: TMaskEditFocus;
    edtVal13: TEditFocus;
    edtCodBar13: TEditFocus;
    edtLinDig13: TEditFocus;
    pnl14: TPanel;
    Label16: TLabel;
    edtDtaVen14: TMaskEditFocus;
    edtSeq14: TEditFocus;
    edtVal14: TEditFocus;
    edtCodBar14: TEditFocus;
    edtLinDig14: TEditFocus;
    pnl15: TPanel;
    Label17: TLabel;
    edtSeq15: TEditFocus;
    edtDtaVen15: TMaskEditFocus;
    edtVal15: TEditFocus;
    edtCodBar15: TEditFocus;
    edtLinDig15: TEditFocus;
    pnl17: TPanel;
    Label19: TLabel;
    edtSeq17: TEditFocus;
    edtDtaVen17: TMaskEditFocus;
    edtVal17: TEditFocus;
    edtCodBar17: TEditFocus;
    edtLinDig17: TEditFocus;
    pnl16: TPanel;
    Label18: TLabel;
    edtSeq16: TEditFocus;
    edtDtaVen16: TMaskEditFocus;
    edtVal16: TEditFocus;
    edtCodBar16: TEditFocus;
    edtLinDig16: TEditFocus;
    pnl18: TPanel;
    Label20: TLabel;
    edtSeq18: TEditFocus;
    edtDtaVen18: TMaskEditFocus;
    edtVal18: TEditFocus;
    edtCodBar18: TEditFocus;
    edtLinDig18: TEditFocus;
    pnl20: TPanel;
    Label22: TLabel;
    edtSeq20: TEditFocus;
    edtDtaVen20: TMaskEditFocus;
    edtVal20: TEditFocus;
    edtCodBar20: TEditFocus;
    edtLinDig20: TEditFocus;
    pnl19: TPanel;
    Label21: TLabel;
    edtSeq19: TEditFocus;
    edtDtaVen19: TMaskEditFocus;
    edtVal19: TEditFocus;
    edtCodBar19: TEditFocus;
    edtLinDig19: TEditFocus;
    pnl22: TPanel;
    Label24: TLabel;
    edtSeq22: TEditFocus;
    edtDtaVen22: TMaskEditFocus;
    edtVal22: TEditFocus;
    edtCodBar22: TEditFocus;
    edtLinDig22: TEditFocus;
    pnl21: TPanel;
    Label23: TLabel;
    edtSeq21: TEditFocus;
    edtDtaVen21: TMaskEditFocus;
    edtVal21: TEditFocus;
    edtCodBar21: TEditFocus;
    edtLinDig21: TEditFocus;
    pnl24: TPanel;
    Label27: TLabel;
    edtSeq24: TEditFocus;
    edtDtaVen24: TMaskEditFocus;
    edtVal24: TEditFocus;
    edtCodBar24: TEditFocus;
    edtLinDig24: TEditFocus;
    pnl23: TPanel;
    Label25: TLabel;
    edtSeq23: TEditFocus;
    edtDtaVen23: TMaskEditFocus;
    edtVal23: TEditFocus;
    edtCodBar23: TEditFocus;
    edtLinDig23: TEditFocus;
    pnl1: TPanel;
    Label4: TLabel;
    edtSeq1: TEditFocus;
    edtDtaVen1: TMaskEditFocus;
    edtVal1: TEditFocus;
    edtCodBar1: TEditFocus;
    edtLinDig1: TEditFocus;
    pnl2: TPanel;
    Label5: TLabel;
    edtDtaVen2: TMaskEditFocus;
    edtSeq2: TEditFocus;
    edtVal2: TEditFocus;
    edtCodBar2: TEditFocus;
    edtLinDig2: TEditFocus;
    pnl3: TPanel;
    Label6: TLabel;
    edtSeq3: TEditFocus;
    edtDtaVen3: TMaskEditFocus;
    edtVal3: TEditFocus;
    edtCodBar3: TEditFocus;
    edtLinDig3: TEditFocus;
    pnl5: TPanel;
    Label8: TLabel;
    edtSeq5: TEditFocus;
    edtDtaVen5: TMaskEditFocus;
    edtVal5: TEditFocus;
    edtCodBar5: TEditFocus;
    edtLinDig5: TEditFocus;
    pnl4: TPanel;
    Label7: TLabel;
    edtSeq4: TEditFocus;
    edtDtaVen4: TMaskEditFocus;
    edtVal4: TEditFocus;
    edtCodBar4: TEditFocus;
    edtLinDig4: TEditFocus;
    pnl6: TPanel;
    Label9: TLabel;
    edtSeq6: TEditFocus;
    edtDtaVen6: TMaskEditFocus;
    edtVal6: TEditFocus;
    edtCodBar6: TEditFocus;
    edtLinDig6: TEditFocus;
    pnl8: TPanel;
    Label11: TLabel;
    edtSeq8: TEditFocus;
    edtDtaVen8: TMaskEditFocus;
    edtVal8: TEditFocus;
    edtCodBar8: TEditFocus;
    edtLinDig8: TEditFocus;
    pnl7: TPanel;
    Label10: TLabel;
    edtSeq7: TEditFocus;
    edtDtaVen7: TMaskEditFocus;
    edtVal7: TEditFocus;
    edtCodBar7: TEditFocus;
    edtLinDig7: TEditFocus;
    pnl10: TPanel;
    Label13: TLabel;
    edtSeq10: TEditFocus;
    edtDtaVen10: TMaskEditFocus;
    edtVal10: TEditFocus;
    edtCodBar10: TEditFocus;
    edtLinDig10: TEditFocus;
    pnl9: TPanel;
    Label12: TLabel;
    edtSeq9: TEditFocus;
    edtDtaVen9: TMaskEditFocus;
    edtVal9: TEditFocus;
    edtCodBar9: TEditFocus;
    edtLinDig9: TEditFocus;
    pnl12: TPanel;
    Label15: TLabel;
    edtSeq12: TEditFocus;
    edtDtaVen12: TMaskEditFocus;
    edtVal12: TEditFocus;
    edtCodBar12: TEditFocus;
    edtLinDig12: TEditFocus;
    pnl11: TPanel;
    Label14: TLabel;
    edtSeq11: TEditFocus;
    edtDtaVen11: TMaskEditFocus;
    edtVal11: TEditFocus;
    edtCodBar11: TEditFocus;
    edtLinDig11: TEditFocus;
    pnlHeader: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    chkCodBar: TCheckBox;
    chkLinDig: TCheckBox;
    procedure btnSalvarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkCodBarClick(Sender: TObject);
    procedure chkLinDigClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure pCarregaDados;
    procedure pSalvaDados;
    function  fVerificaValoresPreechidos : Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    intQtdPar : Integer;
    curTotalPed: Currency;
    blnEditavel : Boolean;
    blnHabEditDup: Boolean;
    blnHabEditValor: Boolean;
    blnConfirma: Boolean;
    blnPergConf: Boolean;
    strCndPag: String;
    dtaDtaBas: TDateTime;
    blnDupsRedondas: Boolean;
    blnFaturamento: Boolean;
    blnAgrupVeio: Boolean;
    strEspDoc: String;
    strCodCli: String;
    blnPerRep: Boolean;
    fltValRec: Double;
    arrLinDigCodbar: TarrLinDigCodbar;
    arrDuplicata: TarrDuplicataPointer;
    class function fValidaCodBar      (edtCodBar, edtLinDig: TEditFocus; fltbase: Double; strDtaVen: String) : Boolean; overload;
    class function fValidaLinDig      (edtCodBar, edtLinDig: TEditFocus; fltbase: Double; strDtaVen: String) : Boolean; overload;
    class function fValidaDadosBoleto (edtCodBar, edtLinDig: TEditFocus; fltbase: Double; strDtaVen: String) : Boolean; overload;
    class function fVerificaExisteDup (edtCodBar, edtLinDig: TEditFocus) : Boolean; overload;

    class function fRetCodBarLinDig              (strLinDig: String): String;

    class function fValidaCodBar      (strCodBar, strLinDig: String; fltbase: Double; strDtaVen: String) : Boolean; overload;
    class function fValidaLinDig      (strCodBar, strLinDig: String; fltbase: Double; strDtaVen: String) : Boolean; overload;
    class function fValidaDadosBoleto (strCodBar, strLinDig: String; fltbase: Double; strDtaVen: String) : Boolean; overload;
    class function fVerificaExisteDup (strCodBar, strLinDig: String) : Boolean; overload;

end;

var
  frmDigCodBarBoleto: TfrmDigCodBarBoleto;

implementation

uses untPai, Data.DB;

{$R *.dfm}

procedure TfrmDigCodBarBoleto.pCarregaDados;
var i: Integer;
Begin
  intQtdPar := 0;

  For i := 0 To 23 Do
  Begin
    If ArrDuplicata[i].strSequen <> '' Then
    begin
      TEditFocus(FindComponent('edtSeq' + IntToStr(i + 1))).Text := ArrDuplicata[i].strSequen;
      TMaskEditFocus(FindComponent('edtDtaVen' + IntToStr(i + 1))).Text := ArrDuplicata[i].dtaDtaVen;
      TEditFocus(FindComponent('edtVal' + IntToStr(i + 1))).Text := CurrToStrF(ArrDuplicata[i].curValor,ffNumber,2);
      TEditFocus(FindComponent('edtCodBar' + IntToStr(i + 1))).Text := arrLinDigCodbar[i].strCodBar;
      TEditFocus(FindComponent('edtLinDig' + IntToStr(i + 1))).Text := arrLinDigCodbar[i].strLinDig;
      Inc(intQtdPar);
    End
    Else
      TPanel(FindComponent('pnl' + IntToStr(i + 1))).Visible := False;
  End;

  {106 = height sem parcelas}

  frmDigCodBarBoleto.Height := 106 + (25 * (intQtdPar + 1));
  pnlDuplics.Height := intQtdPar*25;
End;

procedure TfrmDigCodBarBoleto.pSalvaDados;
var i: Integer;
Begin
  For i := 0 To 23 Do
  begin
    arrLinDigCodbar[i].strCodBar := '';
    arrLinDigCodbar[i].strLinDig := '';
    If ArrDuplicata[i].strSequen <> '' Then
    Begin
      arrLinDigCodbar[i].strCodBar := TEditFocus(FindComponent('edtCodBar' + IntToStr(i + 1))).Text;
      arrLinDigCodbar[i].strLinDig := TEditFocus(FindComponent('edtLinDig' + IntToStr(i + 1))).Text;
    End
  End

End;

procedure TfrmDigCodBarBoleto.btnSalvarClick(Sender: TObject);
var
  blnVerificaCampos : Boolean;
Begin
  inherited;
  blnVerificaCampos := fVerificaCampos;

  If Not blnVerificaCampos then
    Exit;

  If Not fVerificaValoresPreechidos Then
  Begin
    fMensagem('ATENÇÃO!', 'A linha digitável e/ou o código de barras devem ser preenchido(s)!', ['&O k']);
    Exit;
  End
  Else
  Begin
    If (fMensagem('','Confirma Dados? ',['&Sim', '&Não']) = 1)  Then
    Begin
      pSalvaDados;
      blnConfirma := True;
      Close;
    End;
  End;
End;

procedure TfrmDigCodBarBoleto.chkCodBarClick(Sender: TObject);
var i: Integer;
Begin

  inherited;
  If chkCodBar.Checked Then
  Begin
    chkLinDig.Checked     := False;
    For i := 1 To 24 Do
    begin
      TEditFocus(FindComponent('edtLinDig' + IntToStr(i))).Enabled := False;
      If TPanel(FindComponent('pnl' + IntToStr(i))).Visible  Then
         TEditFocus(FindComponent('edtCodBar' + IntToStr(i))).Enabled := True;
    End
  End
  Else
  Begin
    For i := 1 To 24 Do
    begin
      TEditFocus(FindComponent('edtCodBar' + IntToStr(i))).Enabled := False;
      TEditFocus(FindComponent('edtCodBar' + IntToStr(i))).Clear;
      If Not chkLinDig.Checked Then
        TEditFocus(FindComponent('edtLinDig' + IntToStr(i))).Clear
    End;
  End;
End;

procedure TfrmDigCodBarBoleto.chkLinDigClick(Sender: TObject);
  var i: Integer;
Begin
  inherited;
  If chkLinDig.Checked Then
  Begin
    chkCodBar.Checked     := False;

    For i := 1 To 24 Do
    begin
      TEditFocus(FindComponent('edtCodBar' + IntToStr(i))).Enabled := False;
      If TPanel(FindComponent('pnl' + IntToStr(i))).Visible  Then
         TEditFocus(FindComponent('edtLinDig' + IntToStr(i))).Enabled := True;
    End
  End
  Else
  Begin
    For i := 1 To 24 Do
    begin
      TEditFocus(FindComponent('edtLinDig' + IntToStr(i))).Enabled := False;
      TEditFocus(FindComponent('edtLinDig' + IntToStr(i))).Clear;
      If Not chkCodBar.Checked Then
        TEditFocus(FindComponent('edtCodBar' + IntToStr(i))).Clear
    End;
  End;
End;

procedure TfrmDigCodBarBoleto.FormCreate(Sender: TObject);
begin
  inherited;
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
    Self.Position := poScreenCenter;
end;

procedure TfrmDigCodBarBoleto.FormShow(Sender: TObject);
Begin
  inherited;
  pCarregaDados;
End;

class function TfrmDigCodBarBoleto.fRetCodBarLinDig(strLinDig: String): String;
Begin
  Result := Copy(strLinDig, 01, 04) + Copy(strLinDig, 33, 15) + Copy(strLinDig, 05, 05) +
            Copy(strLinDig, 11, 08) + Copy(strLinDig, 19, 02) + Copy(strLinDig, 22, 10);
End;

function TfrmDigCodBarBoleto.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
Begin
	Result := True;

	If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
	Begin
    { VALIDAÇÃO CÓDIGO DE BARRAS }
    If (Sender = edtCodBar1) and Not fEmptyStr(edtCodBar1.Text) Then
      Result := fValidaCodBar(edtCodBar1,edtLinDig1,ArrDuplicata[0].curValor,ArrDuplicata[0].dtaDtaVen);
    If (Sender = edtCodBar2) and Not fEmptyStr(edtCodBar2.Text) Then
      Result := fValidaCodBar(edtCodBar2,edtLinDig2,ArrDuplicata[1].curValor,ArrDuplicata[1].dtaDtaVen);
    If (Sender = edtCodBar3) and Not fEmptyStr(edtCodBar3.Text) Then
      Result := fValidaCodBar(edtCodBar3,edtLinDig3,ArrDuplicata[2].curValor,ArrDuplicata[2].dtaDtaVen);
    If (Sender = edtCodBar4) and Not fEmptyStr(edtCodBar4.Text) Then
      Result := fValidaCodBar(edtCodBar4,edtLinDig4,ArrDuplicata[3].curValor,ArrDuplicata[3].dtaDtaVen);
    If (Sender = edtCodBar5) and Not fEmptyStr(edtCodBar5.Text) Then
      Result := fValidaCodBar(edtCodBar5,edtLinDig5,ArrDuplicata[4].curValor,ArrDuplicata[4].dtaDtaVen);
    If (Sender = edtCodBar6) and Not fEmptyStr(edtCodBar6.Text) Then
      Result := fValidaCodBar(edtCodBar6,edtLinDig6,ArrDuplicata[5].curValor,ArrDuplicata[5].dtaDtaVen);
    If (Sender = edtCodBar7) and Not fEmptyStr(edtCodBar7.Text) Then
      Result := fValidaCodBar(edtCodBar7,edtLinDig7,ArrDuplicata[6].curValor,ArrDuplicata[6].dtaDtaVen);
    If (Sender = edtCodBar8) and Not fEmptyStr(edtCodBar8.Text) Then
      Result := fValidaCodBar(edtCodBar8,edtLinDig8,ArrDuplicata[7].curValor,ArrDuplicata[7].dtaDtaVen);
    If (Sender = edtCodBar9) and Not fEmptyStr(edtCodBar9.Text) Then
      Result := fValidaCodBar(edtCodBar9,edtLinDig9,ArrDuplicata[8].curValor,ArrDuplicata[8].dtaDtaVen);
    If (Sender = edtCodBar10) and Not fEmptyStr(edtCodBar10.Text) Then
      Result := fValidaCodBar(edtCodBar10,edtLinDig10,ArrDuplicata[9].curValor,ArrDuplicata[9].dtaDtaVen);
    If (Sender = edtCodBar11) and Not fEmptyStr(edtCodBar11.Text) Then
      Result := fValidaCodBar(edtCodBar11,edtLinDig11,ArrDuplicata[10].curValor,ArrDuplicata[10].dtaDtaVen);
    If (Sender = edtCodBar12) and Not fEmptyStr(edtCodBar12.Text) Then
      Result := fValidaCodBar(edtCodBar12,edtLinDig12,ArrDuplicata[11].curValor,ArrDuplicata[11].dtaDtaVen);
    If (Sender = edtCodBar13) and Not fEmptyStr(edtCodBar13.Text) Then
      Result := fValidaCodBar(edtCodBar13,edtLinDig13,ArrDuplicata[12].curValor,ArrDuplicata[12].dtaDtaVen);
    If (Sender = edtCodBar14) and Not fEmptyStr(edtCodBar14.Text) Then
      Result := fValidaCodBar(edtCodBar14,edtLinDig14,ArrDuplicata[13].curValor,ArrDuplicata[13].dtaDtaVen);
    If (Sender = edtCodBar15) and Not fEmptyStr(edtCodBar15.Text) Then
      Result := fValidaCodBar(edtCodBar15,edtLinDig15,ArrDuplicata[14].curValor,ArrDuplicata[14].dtaDtaVen);
    If (Sender = edtCodBar16) and Not fEmptyStr(edtCodBar16.Text) Then
      Result := fValidaCodBar(edtCodBar16,edtLinDig16,ArrDuplicata[15].curValor,ArrDuplicata[15].dtaDtaVen);
    If (Sender = edtCodBar17) and Not fEmptyStr(edtCodBar17.Text) Then
      Result := fValidaCodBar(edtCodBar17,edtLinDig17,ArrDuplicata[16].curValor,ArrDuplicata[16].dtaDtaVen);
    If (Sender = edtCodBar18) and Not fEmptyStr(edtCodBar18.Text) Then
      Result := fValidaCodBar(edtCodBar18,edtLinDig18,ArrDuplicata[17].curValor,ArrDuplicata[17].dtaDtaVen);
    If (Sender = edtCodBar19) and Not fEmptyStr(edtCodBar19.Text) Then
      Result := fValidaCodBar(edtCodBar19,edtLinDig19,ArrDuplicata[18].curValor,ArrDuplicata[18].dtaDtaVen);
    If (Sender = edtCodBar20) and Not fEmptyStr(edtCodBar20.Text) Then
      Result := fValidaCodBar(edtCodBar20,edtLinDig20,ArrDuplicata[19].curValor,ArrDuplicata[19].dtaDtaVen);
    If (Sender = edtCodBar21) and Not fEmptyStr(edtCodBar21.Text) Then
      Result := fValidaCodBar(edtCodBar21,edtLinDig21,ArrDuplicata[20].curValor,ArrDuplicata[20].dtaDtaVen);
    If (Sender = edtCodBar22) and Not fEmptyStr(edtCodBar22.Text) Then
      Result := fValidaCodBar(edtCodBar22,edtLinDig22,ArrDuplicata[21].curValor,ArrDuplicata[21].dtaDtaVen);
    If (Sender = edtCodBar23) and Not fEmptyStr(edtCodBar23.Text) Then
      Result := fValidaCodBar(edtCodBar23,edtLinDig23,ArrDuplicata[22].curValor,ArrDuplicata[22].dtaDtaVen);
    If (Sender = edtCodBar24) and Not fEmptyStr(edtCodBar24.Text) Then
      Result := fValidaCodBar(edtCodBar24,edtLinDig24,ArrDuplicata[23].curValor,ArrDuplicata[23].dtaDtaVen);



    { VALIDAÇÃO CÓDIGO LINHA DIGITÁVEL }
    If (Sender = edtLinDig1) and Not fEmptyStr(edtLinDig1.Text) Then
      Result := fValidaLinDig(edtCodBar1,edtLinDig1,ArrDuplicata[0].curValor,ArrDuplicata[0].dtaDtaVen);
    If (Sender = edtLinDig2) and Not fEmptyStr(edtLinDig2.Text) Then
      Result := fValidaLinDig(edtCodBar2,edtLinDig2,ArrDuplicata[1].curValor,ArrDuplicata[1].dtaDtaVen);
    If (Sender = edtLinDig3) and Not fEmptyStr(edtLinDig3.Text) Then
      Result := fValidaLinDig(edtCodBar3,edtLinDig3,ArrDuplicata[2].curValor,ArrDuplicata[2].dtaDtaVen);
    If (Sender = edtLinDig4) and Not fEmptyStr(edtLinDig4.Text) Then
      Result := fValidaLinDig(edtCodBar4,edtLinDig4,ArrDuplicata[3].curValor,ArrDuplicata[3].dtaDtaVen);
    If (Sender = edtLinDig5) and Not fEmptyStr(edtLinDig5.Text) Then
      Result := fValidaLinDig(edtCodBar5,edtLinDig5,ArrDuplicata[4].curValor,ArrDuplicata[4].dtaDtaVen);
    If (Sender = edtLinDig6) and Not fEmptyStr(edtLinDig6.Text) Then
      Result := fValidaLinDig(edtCodBar6,edtLinDig6,ArrDuplicata[5].curValor,ArrDuplicata[5].dtaDtaVen);
    If (Sender = edtLinDig7) and Not fEmptyStr(edtLinDig7.Text) Then
      Result := fValidaLinDig(edtCodBar7,edtLinDig7,ArrDuplicata[6].curValor,ArrDuplicata[6].dtaDtaVen);
    If (Sender = edtLinDig8) and Not fEmptyStr(edtLinDig8.Text) Then
      Result := fValidaLinDig(edtCodBar8,edtLinDig8,ArrDuplicata[7].curValor,ArrDuplicata[7].dtaDtaVen);
    If (Sender = edtLinDig9) and Not fEmptyStr(edtLinDig9.Text) Then
      Result := fValidaLinDig(edtCodBar9,edtLinDig9,ArrDuplicata[8].curValor,ArrDuplicata[8].dtaDtaVen);
    If (Sender = edtLinDig10) and Not fEmptyStr(edtLinDig10.Text) Then
      Result := fValidaLinDig(edtCodBar10,edtLinDig10,ArrDuplicata[9].curValor,ArrDuplicata[9].dtaDtaVen);
    If (Sender = edtLinDig11) and Not fEmptyStr(edtLinDig11.Text) Then
      Result := fValidaLinDig(edtCodBar11,edtLinDig11,ArrDuplicata[10].curValor,ArrDuplicata[10].dtaDtaVen);
    If (Sender = edtLinDig12) and Not fEmptyStr(edtLinDig12.Text) Then
      Result := fValidaLinDig(edtCodBar12,edtLinDig12,ArrDuplicata[11].curValor,ArrDuplicata[11].dtaDtaVen);

    If (Sender = edtLinDig13) and Not fEmptyStr(edtLinDig13.Text) Then
      Result := fValidaLinDig(edtCodBar13,edtLinDig13,ArrDuplicata[12].curValor,ArrDuplicata[12].dtaDtaVen);
    If (Sender = edtLinDig14) and Not fEmptyStr(edtLinDig14.Text) Then
      Result := fValidaLinDig(edtCodBar14,edtLinDig14,ArrDuplicata[13].curValor,ArrDuplicata[13].dtaDtaVen);
    If (Sender = edtLinDig15) and Not fEmptyStr(edtLinDig15.Text) Then
      Result := fValidaLinDig(edtCodBar15,edtLinDig15,ArrDuplicata[14].curValor,ArrDuplicata[14].dtaDtaVen);
    If (Sender = edtLinDig16) and Not fEmptyStr(edtLinDig16.Text) Then
      Result := fValidaLinDig(edtCodBar16,edtLinDig16,ArrDuplicata[15].curValor,ArrDuplicata[15].dtaDtaVen);
    If (Sender = edtLinDig17) and Not fEmptyStr(edtLinDig17.Text) Then
      Result := fValidaLinDig(edtCodBar17,edtLinDig17,ArrDuplicata[16].curValor,ArrDuplicata[16].dtaDtaVen);
    If (Sender = edtLinDig18) and Not fEmptyStr(edtLinDig18.Text) Then
      Result := fValidaLinDig(edtCodBar18,edtLinDig18,ArrDuplicata[17].curValor,ArrDuplicata[17].dtaDtaVen);
    If (Sender = edtLinDig19) and Not fEmptyStr(edtLinDig19.Text) Then
      Result := fValidaLinDig(edtCodBar19,edtLinDig19,ArrDuplicata[18].curValor,ArrDuplicata[18].dtaDtaVen);
    If (Sender = edtLinDig20) and Not fEmptyStr(edtLinDig20.Text) Then
      Result := fValidaLinDig(edtCodBar20,edtLinDig20,ArrDuplicata[19].curValor,ArrDuplicata[19].dtaDtaVen);
    If (Sender = edtLinDig21) and Not fEmptyStr(edtLinDig21.Text) Then
      Result := fValidaLinDig(edtCodBar21,edtLinDig21,ArrDuplicata[20].curValor,ArrDuplicata[20].dtaDtaVen);
    If (Sender = edtLinDig22) and Not fEmptyStr(edtLinDig22.Text) Then
      Result := fValidaLinDig(edtCodBar22,edtLinDig22,ArrDuplicata[21].curValor,ArrDuplicata[21].dtaDtaVen);
    If (Sender = edtLinDig23) and Not fEmptyStr(edtLinDig23.Text) Then
      Result := fValidaLinDig(edtCodBar23,edtLinDig23,ArrDuplicata[22].curValor,ArrDuplicata[22].dtaDtaVen);
    If (Sender = edtLinDig24) and Not fEmptyStr(edtLinDig24.Text) Then
      Result := fValidaLinDig(edtCodBar24,edtLinDig24,ArrDuplicata[23].curValor,ArrDuplicata[23].dtaDtaVen);
  End;

	If (Not Result) Then
    pSetFocus(Sender);

End;

class function TfrmDigCodBarBoleto.fValidaCodBar(edtCodBar, edtLinDig: TEditFocus; fltbase: Double; strDtaVen: String): Boolean;
var
  intCodPag: Integer;
Begin
  {***********************************************}
  {* VALIDA O CÓDIGO DE BARRAS COM 44 CARACTERES *}
  {********************************************JU*}
  Result := True;
  If Not fEmptyStr(edtCodBar.Text) Then
  Begin
    If Copy(edtCodBar.Text, 1, 1) <> '8' then
    Begin
      If Length(edtCodBar.Text) <> 44 Then
      Begin
        fMensagem('ATENÇÃO!', 'Leitura incorreta, o código de barras deve ter 44 dígitos!' + #13#10 +
                              'Caso o erro persista, desmaque a opção Leitor de código de barras e seleciona a opção Informar linha digitável manualmente!', ['&O k']);
        Result := False;
      End;
      If (fltbase <> 0) And (Not fValidaDadosBoleto(edtCodBar,edtLinDig,fltbase,strDtaVen)) And (Result) Then
      Begin
        fMensagem('ATENÇÃO!', 'A linha digitável e/ou código de barras não correspondem aos dados da Duplicata. Verifique!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      If fValidaCodigoBarrasCobranca(edtCodBar.Text) then
      Begin
        intCodPag :=  StrToInt(Copy(fRetSomenteNumeros(edtCodBar.Text), 2, 1));
        If (intCodPag=5) Then
          edtLinDig.Text := fRetornaReprNumericaCobrancaMod11(edtCodBar.Text)
        Else
          edtLinDig.Text := fRetornaReprNumericaCobranca(edtCodBar.Text);
      End
    End;
    If Result then
      Result := fVerificaExisteDup(edtCodBar,edtLinDig);
  End
  Else
  Begin
    {**************************************}
    {* VERIFICA SE E OBRIGATORIO INFORMAR *}
    {* O CODIGO DE BARRAS                 *}
    {***********************************FS*}
    If (edtCodBar.Enabled) Then
    Begin
        fMensagem('ATENÇÃO!', 'O código de barras deve ser preenchido!', ['&O k']);
        Result := False;
    End;
  End;
End;

class function TfrmDigCodBarBoleto.fValidaCodBar(strCodBar, strLinDig: String; fltbase: Double; strDtaVen: String): Boolean;
begin
  {***********************************************}
  {* VALIDA O CÓDIGO DE BARRAS COM 44 CARACTERES *}
  {********************************************JU*}
  Result := True;
  If Not fEmptyStr(strCodBar) Then
  Begin
    If Copy(strCodBar, 1, 1) <> '8' then
    Begin
      If Length(strCodBar) <> 44 Then
      Begin
        fMensagem('ATENÇÃO!', 'Leitura incorreta, o código de barras deve ter 44 dígitos!' + #13#10 +
                              'Caso o erro persista, desmaque a opção Leitor de código de barras e seleciona a opção Informar linha digitável manualmente!', ['&O k']);
        Result := False;
      End;
      If (fltbase <> 0) And (Not fValidaDadosBoleto(strCodBar,strLinDig,fltbase,strDtaVen)) And (Result) Then
      Begin
        fMensagem('ATENÇÃO!', 'A linha digitável e/ou código de barras não correspondem aos dados da Duplicata. Verifique!', ['&O k']);
        Result := False;
      End;
    End;
    If fValidaCodigoBarrasCobranca(strCodBar) and Result then
      Result := fVerificaExisteDup(strCodBar,strLinDig);
  End

end;

class function TfrmDigCodBarBoleto.fValidaLinDig(edtCodBar, edtLinDig: TEditFocus; fltbase: Double; strDtaVen: String) : Boolean;
Begin
 {***********************************************}
 {* VALIDA O LINHA DIGITÁVEL COM 47 CARACTERES  *}
 {********************************************JU*}
  Result := True;
  If Not fEmptyStr(edtLindig.Text) Then
  Begin
    If Copy(edtLinDig.Text, 1, 1) <> '8' then
    Begin
      If Length(edtLinDig.Text) <> 47 Then
      Begin
        fMensagem('ATENÇÃO!', 'Valor informado incorretamente, a linha digitável deve ter 47 dígitos!', ['&O k']);
        Result := False;
      End
      Else
      If not fValidaLinhaDigitavel(edtLinDig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A linha digitável informada está incorreta!', ['&O k']);
        Result := False;
      End
      Else
        edtCodBar.Text := fRetCodBarLinDig(edtLinDig.Text);

      If (fltbase <> 0) And (Not fValidaDadosBoleto(edtCodBar,edtLinDig,fltbase,strDtaVen)) And (Result) Then
      Begin
        fMensagem('ATENÇÃO!', 'A linha digitável e/ou código de barras não correspondem aos dados da Duplicata. Verifique!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      If Length(edtLinDig.Text) <> 48 Then
      Begin
        fMensagem('ATENÇÃO!', 'Valor informado incorretamente, a linha digitável deve ter 48 dígitos!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        If fValidaRepresentacaoNumericaCobranca(edtLinDig.Text) then
        Begin
          edtCodBar.Text := fRetornaCodigoBarrasCobranca(edtLinDig.Text);
        End;
      End;
    End;
    If Result then
      Result := fVerificaExisteDup(edtCodBar,edtLinDig);
  End
  Else
  Begin
    {**************************************}
    {* VERIFICA SE E OBRIGATORIO INFORMAR *}
    {* A LINHA DIGITAVEL                  *}
    {***********************************FS*}
    If (edtLinDig.Enabled) Then
    Begin
        fMensagem('ATENÇÃO!', 'A linha digitável deve ser preenchida!', ['&O k']);
        Result := False;
    End;
  End;
End;

class function TfrmDigCodBarBoleto.fValidaLinDig(strCodBar, strLinDig: String; fltbase: Double; strDtaVen: String): Boolean;
begin
 {***********************************************}
 {* VALIDA O LINHA DIGITÁVEL COM 47 CARACTERES  *}
 {********************************************JU*}
  Result := True;
  If Not fEmptyStr(strLinDig) Then
  Begin
    If Copy(strLinDig, 1, 1) <> '8' then
    Begin
      If Length(strLinDig) <> 47 Then
      Begin
        fMensagem('ATENÇÃO!', 'Valor informado incorretamente, a linha digitável deve ter 47 dígitos!', ['&O k']);
        Result := False;
      End
      Else
      If not fValidaLinhaDigitavel(strLinDig) Then
      Begin
        fMensagem('ATENÇÃO!', 'A linha digitável informada está incorreta!', ['&O k']);
        Result := False;
      End;
      If (fltbase <> 0) And (Not fValidaDadosBoleto(strCodBar,strLinDig,fltbase,strDtaVen)) And (Result) Then
      Begin
        fMensagem('ATENÇÃO!', 'A linha digitável e/ou código de barras não correspondem aos dados da Duplicata. Verifique!', ['&O k']);
        Result := False;
      End;
    End
    Else
    Begin
      If Length(strLinDig) <> 48 Then
      Begin
        fMensagem('ATENÇÃO!', 'Valor informado incorretamente, a linha digitável deve ter 48 dígitos!', ['&O k']);
        Result := False;
      End
      Else
      Result := fValidaRepresentacaoNumericaCobranca(strLinDig);
    End;
    If Result then
      Result := fVerificaExisteDup(strCodBar,strLinDig);
  End;
end;

class function TfrmDigCodBarBoleto.fVerificaExisteDup(edtCodBar, edtLinDig: TEditFocus): Boolean;
var
  stlVerifica  : TStringList;
begin
  {*************************************}
  {* VERIFICA SE A LINHA DIGITÁVEL /   *}
  {* CÓD BARRAS JÁ ESTA CADASTRADO     *}
  {**********************************AJ*}
  Result := True;
  stlVerifica := fVerificaLinDigCtaPag(True, edtLinDig.Text, edtCodBar.Text);
  If stlVerifica.Count > 0 Then
  Begin
    pMensagemOK('Já existe uma duplicata com o código de barras e/ou linha digitável informado(s). Verifique!' +
                   #13 + 'Duplicata: ' + stlVerifica[0] + '-' + stlVerifica[2] + '-' + stlVerifica[7]);
    FreeAndNil(stlVerifica);
    Result := False;
  End;
end;

class function TfrmDigCodBarBoleto.fVerificaExisteDup(strCodBar, strLinDig: String): Boolean;
var
  stlVerifica  : TStringList;
begin
  {*************************************}
  {* VERIFICA SE A LINHA DIGITÁVEL /   *}
  {* CÓD BARRAS JÁ ESTA CADASTRADO     *}
  {**********************************AJ*}
  Result := True;
  stlVerifica := fVerificaLinDigCtaPag(True, strLinDig, strCodBar);
  If stlVerifica.Count > 0 Then
  Begin
    pMensagemOK('Já existe uma duplicata com o código de barras e/ou linha digitável informado(s). Verifique!' +
                   #13 + 'Duplicata: ' + stlVerifica[0] + '-' + stlVerifica[2] + '-' + stlVerifica[7]);
    FreeAndNil(stlVerifica);
    Result := False;
  End;
end;

function TfrmDigCodBarBoleto.fVerificaValoresPreechidos: Boolean;
begin
  Result := True;
  If pnl1.Visible And fEmptyStr(edtCodBar1.Text) And fEmptyStr(edtLinDig1.Text) Then
    Result := False;
  If pnl2.Visible And fEmptyStr(edtCodBar2.Text) And fEmptyStr(edtLinDig2.Text) Then
    Result := False;
  If pnl3.Visible And fEmptyStr(edtCodBar3.Text) And fEmptyStr(edtLinDig3.Text) Then
    Result := False;
  If pnl4.Visible And fEmptyStr(edtCodBar4.Text) And fEmptyStr(edtLinDig4.Text) Then
    Result := False;
  If pnl5.Visible And fEmptyStr(edtCodBar5.Text) And fEmptyStr(edtLinDig5.Text) Then
    Result := False;
  If pnl6.Visible And fEmptyStr(edtCodBar6.Text) And fEmptyStr(edtLinDig6.Text) Then
    Result := False;
  If pnl7.Visible And fEmptyStr(edtCodBar7.Text) And fEmptyStr(edtLinDig7.Text) Then
    Result := False;
  If pnl8.Visible And fEmptyStr(edtCodBar8.Text) And fEmptyStr(edtLinDig8.Text) Then
    Result := False;
  If pnl9.Visible And fEmptyStr(edtCodBar9.Text) And fEmptyStr(edtLinDig9.Text) Then
    Result := False;
  If pnl10.Visible And fEmptyStr(edtCodBar10.Text) And fEmptyStr(edtLinDig10.Text) Then
    Result := False;
  If pnl11.Visible And fEmptyStr(edtCodBar11.Text) And fEmptyStr(edtLinDig11.Text) Then
    Result := False;
  If pnl12.Visible And fEmptyStr(edtCodBar12.Text) And fEmptyStr(edtLinDig12.Text) Then
    Result := False;

  If pnl13.Visible And fEmptyStr(edtCodBar13.Text) And fEmptyStr(edtLinDig13.Text) Then
    Result := False;
  If pnl14.Visible And fEmptyStr(edtCodBar14.Text) And fEmptyStr(edtLinDig14.Text) Then
    Result := False;
  If pnl15.Visible And fEmptyStr(edtCodBar15.Text) And fEmptyStr(edtLinDig15.Text) Then
    Result := False;
  If pnl16.Visible And fEmptyStr(edtCodBar16.Text) And fEmptyStr(edtLinDig16.Text) Then
    Result := False;
  If pnl17.Visible And fEmptyStr(edtCodBar17.Text) And fEmptyStr(edtLinDig17.Text) Then
    Result := False;
  If pnl18.Visible And fEmptyStr(edtCodBar18.Text) And fEmptyStr(edtLinDig18.Text) Then
    Result := False;
  If pnl19.Visible And fEmptyStr(edtCodBar19.Text) And fEmptyStr(edtLinDig19.Text) Then
    Result := False;
  If pnl20.Visible And fEmptyStr(edtCodBar20.Text) And fEmptyStr(edtLinDig20.Text) Then
    Result := False;
  If pnl21.Visible And fEmptyStr(edtCodBar21.Text) And fEmptyStr(edtLinDig21.Text) Then
    Result := False;
  If pnl22.Visible And fEmptyStr(edtCodBar22.Text) And fEmptyStr(edtLinDig22.Text) Then
    Result := False;
  If pnl23.Visible And fEmptyStr(edtCodBar23.Text) And fEmptyStr(edtLinDig23.Text) Then
    Result := False;
  If pnl24.Visible And fEmptyStr(edtCodBar24.Text) And fEmptyStr(edtLinDig24.Text) Then
    Result := False;



end;

class function TfrmDigCodBarBoleto.fValidaDadosBoleto(edtCodBar, edtLinDig: TEditFocus; fltbase: Double; strDtaVen: String): Boolean;
Var strFatorVen: String;
    fltValDup  : Double;
Begin
  Result := True;

  strFatorVen := CalcularFatorVencimento(StrToDateTime(strDtaVen));

  If (Not fEmptyStr(edtLinDig.Text)) Then
  Begin
    fltValDup := StrtoFloat(Copy(edtLinDig.Text, 38, 10)) / 100;
    If (fltValDup <> 0) And (strFatorVen <> '0000') Then
    Begin
      If Copy(edtLinDig.Text, 34, 4) <> strFatorVen Then
        Result := False
      Else
      If fltValDup <> fltbase Then
        Result := False;
    End;
  End;

  If (Not fEmptyStr(edtCodBar.Text)) And (Result) Then
  Begin
    fltValDup := StrtoFloat(Copy(edtCodBar.Text, 10, 10)) / 100;
    If (fltValDup <> 0) And (strFatorVen <> '0000') Then
    Begin
      If Copy(edtCodBar.Text, 6, 4) <> strFatorVen Then
        Result := False
      Else
      If fltValDup <> fltbase Then
        Result := False;
    End;
  End;
End;

class function TfrmDigCodBarBoleto.fValidaDadosBoleto(strCodBar, strLinDig: String; fltbase: Double; strDtaVen: String): Boolean;
Var strFatorVen: String;
    fltValDup  : Double;
Begin
  Result := True;
  strFatorVen := CalcularFatorVencimento(StrToDateTime(strDtaVen));

  If (Not fEmptyStr(strLinDig)) Then
  Begin
    fltValDup := StrtoFloat(Copy(strLinDig, 38, 10)) / 100;
    If (fltValDup <> 0) And (strFatorVen <> '0000') Then
    Begin
      If Copy(strLinDig, 34, 4) <> strFatorVen Then
        Result := False
      Else
      If fltValDup <> fltbase Then
        Result := False;
    End;
  End;

  If (Not fEmptyStr(strCodBar)) And (Result) Then
  Begin
    fltValDup := StrtoFloat(Copy(strCodBar, 10, 10)) / 100;
    If (fltValDup <> 0) And (strFatorVen <> '0000') Then
    Begin
      If Copy(strCodBar, 6, 4) <> strFatorVen Then
        Result := False
      Else
      If fltValDup <> fltbase Then
        Result := False;
    End;
  End;
end;

procedure TfrmDigCodBarBoleto.btnSairClick(Sender: TObject);
Begin
  Close;
End;

End.

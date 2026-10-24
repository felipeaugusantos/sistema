unit untConfiguracoesPPG;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DirectoryEditFocus, EditFocus, StrUtils, AppEvnts, Uni,
  FilenameEditFocus, ComCtrls, Grids, ValEdit, untConfConsulta, untIConfTinta,
  untIConsultaTinta,  untIConfEmb, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit;

type
  TfrmConfiguracoesPPG = class(TfrmPai)
    pnlCentral: TPanel;
    Label6: TLabel;
    lbPatTxt: TLabel;
    edtDesProPpg: TEditFocus;
    edtProPpg: TEditFocus;
    chkUsaPpg: TCheckBox;
    pnlCabecalho: TPanel;
    Label9: TLabel;
    Label20: TLabel;
    Label11: TLabel;
    edtTraPpg: TEditFocus;
    edtFatPpg: TEditFocus;
    Label10: TLabel;
    Label7: TLabel;
    edtGalPpg: TEditFocus;
    edtEmbPpg: TEditFocus;
    Label12: TLabel;
    Label15: TLabel;
    edtPpgVcd: TEditFocus;
    edtPpgVvd: TEditFocus;
    lbPatTxtDin: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    edtPpgLdu: TEditFocus;
    edtDesPpgLdu: TEditFocus;
    edtPpgLdf: TEditFocus;
    edtDesPpgLdf: TEditFocus;
    edtPpgLdt: TEditFocus;
    edtDesPpgLdt: TEditFocus;
    edtPpgLom: TEditFocus;
    edtDesPpgLom: TEditFocus;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtPpgGdu: TEditFocus;
    edtDesPpgGdu: TEditFocus;
    edtPpgGdf: TEditFocus;
    edtDesPpgGdf: TEditFocus;
    edtPpgGdt: TEditFocus;
    edtDesPpgGdt: TEditFocus;
    edtPpgGom: TEditFocus;
    edtDesPpgGom: TEditFocus;
    chkUsaFor: TCheckBox;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label14: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    edtPpgLAdu: TEditFocus;
    edtDesPpgLAdu: TEditFocus;
    edtPpgLAdf: TEditFocus;
    edtDesPpgLAdf: TEditFocus;
    edtPpgLAdt: TEditFocus;
    edtDesPpgLAdt: TEditFocus;
    edtPpgLAom: TEditFocus;
    edtDesPpgLAom: TEditFocus;
    edtProCod: TEditFocus;
    GroupBox4: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    edtPpgTdu: TEditFocus;
    edtDesPpgTdu: TEditFocus;
    edtPpgTdf: TEditFocus;
    edtDesPpgTdf: TEditFocus;
    edtPpgTdt: TEditFocus;
    edtDesPpgTdt: TEditFocus;
    edtPpgTom: TEditFocus;
    edtDesPpgTom: TEditFocus;
    tbsConfCampos: TTabSheet;
    chkNovFor: TCheckBox;
    tbsEmbPM: TTabSheet;
    tbsEmbPMNexa: TTabSheet;
    GroupBox5: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    edtPpgPMLdu: TEditFocus;
    edtDesPpgPMLdu: TEditFocus;
    edtPpgPMLdf: TEditFocus;
    edtDesPpgPMLdf: TEditFocus;
    edtPpgPMLdt: TEditFocus;
    edtDesPpgPMLdt: TEditFocus;
    edtPpgPMLeb: TEditFocus;
    edtDesPpgPMLeb: TEditFocus;
    GroupBox6: TGroupBox;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    edtPpgPMGdu: TEditFocus;
    edtDesPpgPMGdu: TEditFocus;
    edtPpgPMGdf: TEditFocus;
    edtDesPpgPMGdf: TEditFocus;
    edtPpgPMGdt: TEditFocus;
    edtDesPpgPMGdt: TEditFocus;
    edtPpgPMGeb: TEditFocus;
    edtDesPpgPMGeb: TEditFocus;
    GroupBox7: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    edtPpgPMLAdu: TEditFocus;
    edtDesPpgPMLAdu: TEditFocus;
    edtPpgPMLAdf: TEditFocus;
    edtDesPpgPMLAdf: TEditFocus;
    edtPpgPMLAdt: TEditFocus;
    edtDesPpgPMLAdt: TEditFocus;
    edtPpgPMLAeb: TEditFocus;
    edtDesPpgPMLAeb: TEditFocus;
    GroupBox8: TGroupBox;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    edtPpgPMTdu: TEditFocus;
    edtDesPpgPMTdu: TEditFocus;
    edtPpgPMTdf: TEditFocus;
    edtDesPpgPMTdf: TEditFocus;
    edtPpgPMTdt: TEditFocus;
    edtDesPpgPMTdt: TEditFocus;
    edtPpgPMTeb: TEditFocus;
    edtDesPpgPMTeb: TEditFocus;
    GroupBox9: TGroupBox;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label59: TLabel;
    edtPpgPML2k: TEditFocus;
    edtDesPpgPML2k: TEditFocus;
    edtPpgPMLAc: TEditFocus;
    edtDesPpgPMLAc: TEditFocus;
    edtPpgPMLIn: TEditFocus;
    edtDesPpgPMLIn: TEditFocus;
    edtPpgPMLSg: TEditFocus;
    edtDesPpgPMLSg: TEditFocus;
    edtPpgPMLZy: TEditFocus;
    edtDesPpgPMLZy: TEditFocus;
    GroupBox10: TGroupBox;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label60: TLabel;
    edtPpgPMG2k: TEditFocus;
    edtDesPpgPMG2k: TEditFocus;
    edtPpgPMGAc: TEditFocus;
    edtDesPpgPMGAc: TEditFocus;
    edtPpgPMGIn: TEditFocus;
    edtDesPpgPMGIn: TEditFocus;
    edtPpgPMGSg: TEditFocus;
    edtDesPpgPMGSg: TEditFocus;
    edtPpgPMGZy: TEditFocus;
    edtDesPpgPMGZy: TEditFocus;
    GroupBox11: TGroupBox;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label61: TLabel;
    edtPpgPMLA2k: TEditFocus;
    edtDesPpgPMLA2k: TEditFocus;
    edtPpgPMLAAc: TEditFocus;
    edtDesPpgPMLAAc: TEditFocus;
    edtPpgPMLAIn: TEditFocus;
    edtDesPpgPMLAIn: TEditFocus;
    edtPpgPMLASg: TEditFocus;
    edtDesPpgPMLASg: TEditFocus;
    edtPpgPMLAZy: TEditFocus;
    edtDesPpgPMLAZy: TEditFocus;
    GroupBox12: TGroupBox;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label62: TLabel;
    edtPpgPMT2k: TEditFocus;
    edtDesPpgPMT2k: TEditFocus;
    edtPpgPMTAc: TEditFocus;
    edtDesPpgPMTAc: TEditFocus;
    edtPpgPMTin: TEditFocus;
    edtDesPpgPMTin: TEditFocus;
    edtPpgPMTSg: TEditFocus;
    edtDesPpgPMTSg: TEditFocus;
    edtPpgPMTZy: TEditFocus;
    edtDesPpgPMTZy: TEditFocus;
    lblLazCop: TLabel;
    edtPpgCopEb: TEditFocus;
    edtDesPpgCopEb: TEditFocus;
    SpeedButton20: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SpeedButton22: TSpeedButton;
    SpeedButton23: TSpeedButton;
    SpeedButton24: TSpeedButton;
    SpeedButton25: TSpeedButton;
    SpeedButton26: TSpeedButton;
    SpeedButton27: TSpeedButton;
    SpeedButton28: TSpeedButton;
    SpeedButton29: TSpeedButton;
    SpeedButton30: TSpeedButton;
    SpeedButton31: TSpeedButton;
    SpeedButton32: TSpeedButton;
    SpeedButton33: TSpeedButton;
    SpeedButton34: TSpeedButton;
    SpeedButton35: TSpeedButton;
    SpeedButton36: TSpeedButton;
    btnPreVis: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    rgVersaoArquivo: TRadioGroup;
    chkAcuAbs: TCheckBox;
    Label58: TLabel;
    edtDesOpe: TEditFocus;
    Label63: TLabel;
    edtApreve: TEditFocus;
    edtPatPpgDin: TFilenameEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnGravarConfClick(Sender: TObject);
    procedure edtPpgGduKeyPress(Sender: TObject; var Key: Char);
    procedure edtProPpgKeyPress(Sender: TObject; var Key: Char);
    procedure edtPpgLAduKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure chkNovForClick(Sender: TObject);
    procedure edtPpgPMLduKeyPress(Sender: TObject; var Key: Char);
    procedure edtPpgPMLAduKeyPress(Sender: TObject; var Key: Char);
    procedure edtPpgCopKeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton20Click(Sender: TObject);
    procedure SpeedButton21Click(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure SpeedButton23Click(Sender: TObject);
    procedure SpeedButton24Click(Sender: TObject);
    procedure SpeedButton25Click(Sender: TObject);
    procedure SpeedButton26Click(Sender: TObject);
    procedure SpeedButton27Click(Sender: TObject);
    procedure SpeedButton28Click(Sender: TObject);
    procedure SpeedButton29Click(Sender: TObject);
    procedure SpeedButton30Click(Sender: TObject);
    procedure SpeedButton31Click(Sender: TObject);
    procedure SpeedButton32Click(Sender: TObject);
    procedure SpeedButton33Click(Sender: TObject);
    procedure SpeedButton34Click(Sender: TObject);
    procedure SpeedButton35Click(Sender: TObject);
    procedure SpeedButton36Click(Sender: TObject);
    procedure btnPreVisClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
  private
    { Private declarations }

    qryCadIte: TUniQuery;
    frmConfConsultaPPG: TfrmConfConsulta;
    tinta: IConsultaTinta;
    conf: IConfTinta;
    confEmb: IConfEmb;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pRetornaDescricaoItem(edtCodIte: TEdit);
    procedure pRetornaDescricaoItem2(edtCodIte: TEdit);
    procedure pRetornaDescricaoItem3(edtCodIte: TEdit);
    procedure pRetornaDescricaoItem4(edtCodIte: TEdit);
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
    procedure EscondeTabEmbPM;
    procedure EscondeTabEmb;
    procedure pCriaCadEmbTinta(strCodCfg, strIdePro, strEmbala, strLinha: String);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesPPG: TfrmConfiguracoesPPG;

implementation

uses untFuncoes,
  untFuncTinta, untFuncoesSimples, untCadEmbTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoesPPG }

function TfrmConfiguracoesPPG.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    edtDesIte: TEdit;
begin

  Result := True;

  If (Sender = edtProPpg) Then
  Begin
    If (fEmptyStr(edtProPpg.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtProPpg);
      If (fEmptyStr(edtDesProPpg.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtTraPpg) Then
  Begin
    If (fEmptyStr(edtTraPpg.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A trava para valor de venda deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else If Length(edtTraPpg.Text) <> 3 Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
      Result := False;
    End
    Else If Pos(edtTraPpg.Text, 'VEN_CUS_') <= 0 Then
    Begin
      fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtFatPpg) Then
  Begin
    If (fEmptyStr(edtFatPpg.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O fator para trava deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtFatPpg.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtPpgVvd) Then
  Begin
    If (fEmptyStr(edtPpgVvd.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor de venda litro diluente deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtPpgVvd.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor de venda litro diluente deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtPpgVcd) Then
  Begin
    If (fEmptyStr(edtPpgVcd.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor de custo litro diluente deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtPpgVcd.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Valor de custo litro diluente deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtEmbPpg) Then
  Begin
    If (fEmptyStr(edtEmbPpg.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço de Embalagem deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat(edtEmbPpg.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço de Embalagem deve ser maior ou igual a Zero!', ['&O k']);
      Result := False;
    End;
  End

  Else If (Sender = edtGalPpg) Then
  Begin
    If (fEmptyStr(edtGalPpg.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço do Galão deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else If (fStrToFloat(edtGalPpg.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O preço do Galão deve ser maior ou igual a Zero!', ['&O k']);
      Result := False;
    End;
  End
  else If (Sender = edtPatPpgDin) Then
  Begin

    If (not fEmptyStr(edtPatPpgDin.Text)) Then
    Begin
      edtPatPpgDin.Text := AnsiDequotedStr(edtPatPpgDin.Text, '"');

      if not DirectoryExists(ExtractFileDir(edtPatPpgDin.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'O Diretório informado não foi encontrado!', ['&Ok']);
        Result := False;
      end;

      if not FileExists(edtPatPpgDin.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O  Arquivo " '+  ExtractFileName(edtPatPpgDin.Text)  +'" não foi encontrado no diretório informado!', ['&Ok']);
        Result := False;
      end;

    End;

  End
  Else If ((Sender = edtPpgGdu) Or
          (Sender = edtPpgGdf) Or
          (Sender = edtPpgGdt) Or
          (Sender = edtPpgGom) Or
          (Sender = edtPpgLdu) Or
          (Sender = edtPpgLdf) Or
          (Sender = edtPpgLdt) Or
          (Sender = edtPpgLom) Or
          (Sender = edtPpgTdu) Or
          (Sender = edtPpgTdf) Or
          (Sender = edtPpgTdt) Or
          (Sender = edtPpgTom)) and (not chkNovFor.Checked) Then
  Begin

    If (fEmptyStr(TEdit(Sender).Text)) Then
    Begin
    End
    Else
    Begin
      pRetornaDescricaoItem(TEdit(Sender));
      //edtDesIte := TEdit(fComponentByName(pnlCentral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
      edtDesIte := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 6)));
      If (fEmptyStr(edtDesIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If ((Sender = edtPpgLAdu) Or
          (Sender = edtPpgLAdf) Or
          (Sender = edtPpgLAdt) Or
          (Sender = edtPpgLAom)) and (not chkNovFor.Checked) Then
  Begin

    If (fEmptyStr(TEdit(Sender).Text)) Then
    Begin

    End
    Else
    Begin
      pRetornaDescricaoItem2(TEdit(Sender));
      //edtDesIte := TEdit(fComponentByName(pnlCentral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
      edtDesIte := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 7)));
      If (fEmptyStr(edtDesIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End
  
  Else If ( ( (Sender = edtPpgPMGdu) Or
              (Sender = edtPpgPMGdf) Or
              (Sender = edtPpgPMGdt) Or
              (Sender = edtPpgPMGeb) Or
              (Sender = edtPpgPMLdu) Or
              (Sender = edtPpgPMLdf) Or
              (Sender = edtPpgPMLdt) Or
              (Sender = edtPpgPMLeb) Or
              (Sender = edtPpgPMTdu) Or
              (Sender = edtPpgPMTdf) Or
              (Sender = edtPpgPMTdt) Or
              (Sender = edtPpgPMTeb)  Or
              (Sender = edtPpgCopEb)) And ( chkNovFor.Checked ) ) Then
  Begin

    If (fEmptyStr(TEdit(Sender).Text)) Then
    Begin
    End
    Else
    Begin
      pRetornaDescricaoItem3(TEdit(Sender));
      edtDesIte := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 8)));
      If (fEmptyStr(edtDesIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End
  Else If ( ( (Sender = edtPpgPMLAdu) Or
              (Sender = edtPpgPMLAdf) Or
              (Sender = edtPpgPMLAdt) Or
              (Sender = edtPpgPMLAeb) ) And (chkNovFor.Checked) ) Then
  Begin

    If (fEmptyStr(TEdit(Sender).Text)) Then
    Begin
    End
    Else
    Begin
      pRetornaDescricaoItem4(TEdit(Sender));
      //edtDesIte := TEdit(fComponentByName(pnlCentral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
      edtDesIte := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 9)));
      If (fEmptyStr(edtDesIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End
  Else If ( ( (Sender = edtPpgPMG2k) Or
              (Sender = edtPpgPMGAc) Or
              (Sender = edtPpgPMGIn) Or
              (Sender = edtPpgPMGSg) Or
              (Sender = edtPpgPMGZy) Or
              (Sender = edtPpgPML2k) Or
              (Sender = edtPpgPMLAc) Or
              (Sender = edtPpgPMLIn) Or
              (Sender = edtPpgPMLSg) Or
              (Sender = edtPpgPMLZy) Or
              (Sender = edtPpgPMT2k) Or
              (Sender = edtPpgPMTAc) Or
              (Sender = edtPpgPMTin) Or
              (Sender = edtPpgPMTSg) Or
              (Sender = edtPpgPMTZy) ) And ( chkNovFor.Checked ) ) Then

  Begin

    If (fEmptyStr(TEdit(Sender).Text)) Then
    Begin
    End
    Else
    Begin
      pRetornaDescricaoItem3(TEdit(Sender));
      //edtDesIte := TEdit(fComponentByName(pnlCentral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
      edtDesIte := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 8)));
      If (fEmptyStr(edtDesIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End
  Else If ( ( (Sender = edtPpgPMLA2k) Or
              (Sender = edtPpgPMLAAc) Or
              (Sender = edtPpgPMLAIn) Or
              (Sender = edtPpgPMLASg) Or
              (Sender = edtPpgPMLAZy) ) And (chkNovFor.Checked) ) Then
  Begin

    If (fEmptyStr(TEdit(Sender).Text)) Then
    Begin
    End
    Else
    Begin
      pRetornaDescricaoItem4(TEdit(Sender));
      //edtDesIte := TEdit(fComponentByName(pnlCentral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
      edtDesIte := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 9)));
      If (fEmptyStr(edtDesIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtDesOpe) Then
  Begin

    If fEmptyStr(edtDesOpe.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtDesOpe.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = edtApreve) Then
  Begin

    If fEmptyStr(edtApreve.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(edtApreve.Text) < 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;

  End;

  if not Result then
    pSetFocus(Sender);
end;



procedure TfrmConfiguracoesPPG.PageControl1Change(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (PageControl1.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesPPG.pCarregaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA PPG                    *}
  {**************************************MV*}

  chkUsaPpg.Checked := conf.fGetBoolean('USATIN');
  edtProPpg.Text := conf.fGet('PROPPG');
  edtTraPpg.Text := conf.fGet('TRAPPG');
  edtFatPpg.Text := conf.fGet('FATPPG');
  edtEmbPpg.Text := conf.fGet('EMBPPG');
  edtGalPpg.Text := conf.fGet('GALPPG');
  edtDesOpe.Text := conf.fGet('DESOPE');
  edtApreve.Text := conf.fGet('APREVE');


  edtPpgGdu.Text := conf.fGet('PPGGDU');
  edtPpgGdf.Text := conf.fGet('PPGGDF');
  edtPpgGdt.Text := conf.fGet('PPGGDT');
  edtPpgGom.Text := conf.fGet('PPGGOM');

  edtPpgLdu.Text := conf.fGet('PPGLDU');
  edtPpgLdf.Text := conf.fGet('PPGLDF');
  edtPpgLdt.Text := conf.fGet('PPGLDT');
  edtPpgLom.Text := conf.fGet('PPGLOM');

  edtPpgLAdu.Text := conf.fGet('PPGLADU');
  edtPpgLAdf.Text := conf.fGet('PPGLADF');
  edtPpgLAdt.Text := conf.fGet('PPGLADT');
  edtPpgLAom.Text := conf.fGet('PPGLAOM');

  edtPpgTdu.Text := conf.fGet('PPGTDU');
  edtPpgTdf.Text := conf.fGet('PPGTDF');
  edtPpgTdt.Text := conf.fGet('PPGTDT');
  edtPpgTom.Text := conf.fGet('PPGTOM');

  //As embalagens agora serão gravadas em tabela a parte
  edtPpgPMGdu.Text  := confEmb.fGet('PPGPMGDU');
  edtPpgPMGdf.Text  := confEmb.fGet('PPGPMGDF');
  edtPpgPMGdt.Text  := confEmb.fGet('PPGPMGDT');
  edtPpgPMGeb.Text  := confEmb.fGet('PPGPMGEB');

  edtPpgPMLdu.Text  := confEmb.fGet('PPGPMLDU');
  edtPpgPMLdf.Text  := confEmb.fGet('PPGPMLDF');
  edtPpgPMLdt.Text  := confEmb.fGet('PPGPMLDT');
  edtPpgPMLeb.Text  := confEmb.fGet('PPGPMLEB');

  edtPpgPMLAdu.Text := confEmb.fGet('PPGPMLADU');
  edtPpgPMLAdf.Text := confEmb.fGet('PPGPMLADF');
  edtPpgPMLAdt.Text := confEmb.fGet('PPGPMLADT');
  edtPpgPMLAeb.Text := confEmb.fGet('PPGPMLAEB');

  edtPpgPMTdu.Text  := confEmb.fGet('PPGPMTDU');
  edtPpgPMTdf.Text  := confEmb.fGet('PPGPMTDF');
  edtPpgPMTdt.Text  := confEmb.fGet('PPGPMTDT');
  edtPpgPMTeb.Text  := confEmb.fGet('PPGPMTEB');  

  //As embalagens agora serão gravadas em tabela a parte
  edtPpgPMG2k.Text := confEmb.fGet('PPGPMG2K');
  edtPpgPMGAc.Text := confEmb.fGet('PPGPMGAC');
  edtPpgPMGIn.Text := confEmb.fGet('PPGPMGIN');
  edtPpgPMGSg.Text := confEmb.fGet('PPGPMGSG');
  edtPpgPMGZy.Text := confEmb.fGet('PPGPMGZY');

  edtPpgPML2k.Text := confEmb.fGet('PPGPML2K');
  edtPpgPMLAc.Text := confEmb.fGet('PPGPMLAC');
  edtPpgPMLIn.Text := confEmb.fGet('PPGPMLIN');
  edtPpgPMLSg.Text := confEmb.fGet('PPGPMLSG');
  edtPpgPMLZy.Text := confEmb.fGet('PPGPMLZY');

  edtPpgPMLA2k.Text := confEmb.fGet('PPGPMLA2K');
  edtPpgPMLAAc.Text := confEmb.fGet('PPGPMLAAC');
  edtPpgPMLAIn.Text := confEmb.fGet('PPGPMLAIN');
  edtPpgPMLASg.Text := confEmb.fGet('PPGPMLASG');
  edtPpgPMLAZy.Text := confEmb.fGet('PPGPMLAZY');

  edtPpgPMT2k.Text := confEmb.fGet('PPGPMT2K');
  edtPpgPMTAc.Text := confEmb.fGet('PPGPMTAC');
  edtPpgPMTin.Text := confEmb.fGet('PPGPMTIN');
  edtPpgPMTSg.Text := confEmb.fGet('PPGPMTSG');
  edtPpgPMTZy.Text := confEmb.fGet('PPGPMTZY');
  //


  edtPpgVvd.Text := conf.fGet('PATVVD');
  edtPpgVcd.Text := conf.fGet('PATVCD');
  edtPatPpgDin.Text := conf.fGet('PATPPG');

  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');

  edtProCod.Text := conf.fGet('PROCOD');

{  edtPpgCop.Text := conf.fGet('PPGCOP');}
  edtPpgCopEb.Text := confEmb.fGet('PPGCOP');

  chkNovFor.Checked := conf.fGetBoolean('NOVFOR'); //(fArqIniTinta(0, 'PPG', 'NOVFOR', '') = 'S');
  chkAcuAbs.Checked := conf.fGetInteger('ACUABS') = 1;
  
  {*******************************************}
  {* GRUPOS DOS ITENS                        *}
  {****************************************MV*}
  pRetornaDescricaoItem(edtPpgGdu);
  pRetornaDescricaoItem(edtPpgGdf);
  pRetornaDescricaoItem(edtPpgGdt);
  pRetornaDescricaoItem(edtPpgGom);

  pRetornaDescricaoItem(edtPpgLdu);
  pRetornaDescricaoItem(edtPpgLdf);
  pRetornaDescricaoItem(edtPpgLdt);
  pRetornaDescricaoItem(edtPpgLom);
  pRetornaDescricaoItem(edtProPpg);

  pRetornaDescricaoItem2(edtPpgLAdu);
  pRetornaDescricaoItem2(edtPpgLAdf);
  pRetornaDescricaoItem2(edtPpgLAdt);
  pRetornaDescricaoItem2(edtPpgLAom);

  pRetornaDescricaoItem(edtPpgTdu);
  pRetornaDescricaoItem(edtPpgTdf);
  pRetornaDescricaoItem(edtPpgTdt);
  pRetornaDescricaoItem(edtPpgTom);

  //PAINT MANAGER - PPG
  pRetornaDescricaoItem3(edtPpgPMGdu);
  pRetornaDescricaoItem3(edtPpgPMGdf);
  pRetornaDescricaoItem3(edtPpgPMGdt);
  pRetornaDescricaoItem3(edtPpgPMGeb);

  pRetornaDescricaoItem3(edtPpgPMLdu);
  pRetornaDescricaoItem3(edtPpgPMLdf);
  pRetornaDescricaoItem3(edtPpgPMLdt);
  pRetornaDescricaoItem3(edtPpgPMLeb);

  pRetornaDescricaoItem4(edtPpgPMLAdu);
  pRetornaDescricaoItem4(edtPpgPMLAdf);
  pRetornaDescricaoItem4(edtPpgPMLAdt);
  pRetornaDescricaoItem4(edtPpgPMLAeb);

  pRetornaDescricaoItem3(edtPpgPMTdu);
  pRetornaDescricaoItem3(edtPpgPMTdf);
  pRetornaDescricaoItem3(edtPpgPMTdt);
  pRetornaDescricaoItem3(edtPpgPMTeb);
  //

  //PAINT MANAGER - NEXA
  pRetornaDescricaoItem3(edtPpgPMG2k);
  pRetornaDescricaoItem3(edtPpgPMGAc);
  pRetornaDescricaoItem3(edtPpgPMGIn);
  pRetornaDescricaoItem3(edtPpgPMGSg);
  pRetornaDescricaoItem3(edtPpgPMGZy);

  pRetornaDescricaoItem3(edtPpgPML2k);
  pRetornaDescricaoItem3(edtPpgPMLAc);
  pRetornaDescricaoItem3(edtPpgPMLIn);
  pRetornaDescricaoItem3(edtPpgPMLSg);
  pRetornaDescricaoItem3(edtPpgPMLZy);

  pRetornaDescricaoItem4(edtPpgPMLA2k);
  pRetornaDescricaoItem4(edtPpgPMLAAc);
  pRetornaDescricaoItem4(edtPpgPMLAIn);
  pRetornaDescricaoItem4(edtPpgPMLASg);
  pRetornaDescricaoItem4(edtPpgPMLAZy);

  pRetornaDescricaoItem3(edtPpgPMT2k);
  pRetornaDescricaoItem3(edtPpgPMTAc);
  pRetornaDescricaoItem3(edtPpgPMTin);
  pRetornaDescricaoItem3(edtPpgPMTSg);
  pRetornaDescricaoItem3(edtPpgPMTZy);
  pRetornaDescricaoItem3(edtPpgCopEb);

  rgVersaoArquivo.ItemIndex := conf.fGetInteger('VERARQ') - 1;

end;

procedure TfrmConfiguracoesPPG.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  if fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesPPG.pGravaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA PPG                    *}
  {**************************************MV*}

  conf.pSetBoolean('USATIN', chkUsaPpg.Checked);
  conf.pSet('PROPPG', edtProPpg.Text);
  conf.pSet('TRAPPG', edtTraPpg.Text);
  conf.pSet('FATPPG', edtFatPpg.Text);
  conf.pSet('EMBPPG', edtEmbPpg.Text);
  conf.pSet('GALPPG', edtGalPpg.Text);
  conf.pSet('PATPPG', edtPatPpgDin.Text);
  conf.pSet('PPGGDU', edtPpgGdu.Text);
  conf.pSet('PPGGDF', edtPpgGdf.Text);
  conf.pSet('PPGGDT', edtPpgGdt.Text);
  conf.pSet('PPGGOM', edtPpgGom.Text);
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  conf.pSet('PPGLDU', edtPpgLdu.Text);
  conf.pSet('PPGLDF', edtPpgLdf.Text);
  conf.pSet('PPGLDT', edtPpgLdt.Text);
  conf.pSet('PPGLOM', edtPpgLom.Text);

  conf.pSet('PPGLADU', edtPpgLAdu.Text);
  conf.pSet('PPGLADF', edtPpgLAdf.Text);
  conf.pSet('PPGLADT', edtPpgLAdt.Text);
  conf.pSet('PPGLAOM', edtPpgLAom.Text);

  conf.pSet('PPGTDU', edtPpgTdu.Text);
  conf.pSet('PPGTDF', edtPpgTdf.Text);
  conf.pSet('PPGTDT', edtPpgTdt.Text);
  conf.pSet('PPGTOM', edtPpgTom.Text);

  conf.pSet('PATVVD', edtPpgVvd.Text);
  conf.pSet('PATVCD', edtPpgVcd.Text);

//  conf.fGet('VERARQ', (rgVersaoArquivo.ItemIndex + 1));




  {*******************************************}
  {* GRUPOS DOS ITENS                        *}
  {****************************************AC*}

  conf.pSet('G_PPGGDU', fRetornaGrupoItem(edtPpgGdu.Text));
  conf.pSet('G_PPGGDF', fRetornaGrupoItem(edtPpgGdf.Text));
  conf.pSet('G_PPGGDT', fRetornaGrupoItem(edtPpgGdt.Text));
  conf.pSet('G_PPGGOM', fRetornaGrupoItem(edtPpgGom.Text));
  conf.pSet('G_PPGLDU', fRetornaGrupoItem(edtPpgLdu.Text));
  conf.pSet('G_PPGLDF', fRetornaGrupoItem(edtPpgLdf.Text));
  conf.pSet('G_PPGLDT', fRetornaGrupoItem(edtPpgLdt.Text));
  conf.pSet('G_PPGLOM', fRetornaGrupoItem(edtPpgLom.Text));

  //PAINT MANAGER - PPG
  conf.pSet('G_PPGPMGDU', fRetornaGrupoItem(edtPpgPMGdu.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMGDU', fRetornaGrupoItem(edtPpgPMGdu.Text));
  conf.pSet('G_PPGPMGDF', fRetornaGrupoItem(edtPpgPMGdf.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMGDF', fRetornaGrupoItem(edtPpgPMGdf.Text));
  conf.pSet('G_PPGPMGDT', fRetornaGrupoItem(edtPpgPMGdt.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMGDT', fRetornaGrupoItem(edtPpgPMGdt.Text));
  conf.pSet('G_PPGPMGEB', fRetornaGrupoItem(edtPpgPMGeb.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMGEB', fRetornaGrupoItem(edtPpgPMGeb.Text));
  conf.pSet('G_PPGPMLDU', fRetornaGrupoItem(edtPpgPMLdu.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMLDU', fRetornaGrupoItem(edtPpgPMLdu.Text));
  conf.pSet('G_PPGPMLDF', fRetornaGrupoItem(edtPpgPMLdf.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMLDF', fRetornaGrupoItem(edtPpgPMLdf.Text));
  conf.pSet('G_PPGPMLDT', fRetornaGrupoItem(edtPpgPMLdt.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMLDT', fRetornaGrupoItem(edtPpgPMLdt.Text));
  conf.pSet('G_PPGPMLEB', fRetornaGrupoItem(edtPpgPMLeb.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMLEB', fRetornaGrupoItem(edtPpgPMLeb.Text));
  //

  //PAINT MANAGER - NEXA
  conf.pSet('G_PPGPMG2K', fRetornaGrupoItem(edtPpgPMG2k.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMG2K', fRetornaGrupoItem(edtPpgPMG2k.Text));
  conf.pSet('G_PPGPMGAC', fRetornaGrupoItem(edtPpgPMGAc.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMGAC', fRetornaGrupoItem(edtPpgPMGAc.Text));
  conf.pSet('G_PPGPMGIN', fRetornaGrupoItem(edtPpgPMGIn.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMGIN', fRetornaGrupoItem(edtPpgPMGIn.Text));
  conf.pSet('G_PPGPMGSG', fRetornaGrupoItem(edtPpgPMGSg.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMGSG', fRetornaGrupoItem(edtPpgPMGSg.Text));
  conf.pSet('G_PPGPMGZY', fRetornaGrupoItem(edtPpgPMGZy.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMGZY', fRetornaGrupoItem(edtPpgPMGZy.Text));
  conf.pSet('G_PPGPML2K', fRetornaGrupoItem(edtPpgPML2k.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPML2K', fRetornaGrupoItem(edtPpgPML2k.Text));
  conf.pSet('G_PPGPMLAC', fRetornaGrupoItem(edtPpgPMLAc.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMLAC', fRetornaGrupoItem(edtPpgPMLAc.Text));
  conf.pSet('G_PPGPMLIN', fRetornaGrupoItem(edtPpgPMLIn.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMLIN', fRetornaGrupoItem(edtPpgPMLIn.Text));
  conf.pSet('G_PPGPMLSG', fRetornaGrupoItem(edtPpgPMLSg.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMLSG', fRetornaGrupoItem(edtPpgPMLSg.Text));
  conf.pSet('G_PPGPMLZY', fRetornaGrupoItem(edtPpgPMLZy.Text));  //fArqIniTinta(1, 'PPG', 'G_PPGPMLZY', fRetornaGrupoItem(edtPpgPMLZy.Text));
  conf.pSetInteger('ACUABS', IIF(chkAcuAbs.Checked, 1, 2));
  //

  conf.pSetBoolean('USAFOR',chkUsaFor.Checked);

  conf.pSet('PROCOD', edtProCod.Text);

  conf.pSetBoolean('NOVFOR', chkNovFor.Checked); //fArqIniTinta(1, 'PPG', 'NOVFOR', IfThen(chkNovFor.Checked, 'S', 'N'));

  conf.pSetInteger('VERARQ', rgVersaoArquivo.ItemIndex + 1);
  frmConfConsultaPPG.pSalvarConfs;
  fCommit;
end;

procedure TfrmConfiguracoesPPG.pRetornaDescricaoItem(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 6);
  edtDesIte := TEdit(FindComponent(strNomEdt));
  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesPPG.FormCreate(Sender: TObject);
begin
  inherited;
  fStartTransaction;

  conf  := fGetConfTinta('PPG');
  tinta := fGetConsultaTinta('PPG');
  //Configuracoes de embalagens
  confEmb := fGetConfEmb('PPG');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}

  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'PPG', 'USATIN', ''));
  conf.pInsereCodigo('PROPPG', 'Produto para venda', fArqIniTinta(0, 'PPG', 'PROPPG', ''));
  conf.pInsereCodigo('TRAPPG', 'Trava para valor de venda PPG_PRE', fArqIniTinta(0, 'PPG', 'TRAPPG', ''));
  conf.pInsereCodigo('FATPPG', 'Fator', fArqIniTinta(0, 'PPG', 'FATPPG', ''));
  conf.pInsereCodigo('EMBPPG', 'Preço de embalagem', fArqIniTinta(0, 'PPG', 'EMBPPG', ''));
  conf.pInsereCodigo('GALPPG', 'Preço de galão', fArqIniTinta(0, 'PPG', 'GALPPG', ''));
  conf.pInsereCodigo('PATPPG', 'Path para arquivos (*.txt)', fArqIniTinta(0, 'PPG', 'PATPPG', ''));
  conf.pInsereCodigo('PPGGDU', 'Embalagem Galão Dulon', fArqIniTinta(0, 'PPG', 'PPGGDU', ''));
  conf.pInsereCodigo('PPGGDF', 'Embalagem Galão Delfleet', fArqIniTinta(0, 'PPG', 'PPGGDF', ''));
  conf.pInsereCodigo('PPGGDT', 'Embalagem Galão Deltron', fArqIniTinta(0, 'PPG', 'PPGGDT', ''));
  conf.pInsereCodigo('PPGGOM', 'Embalagem Galão Omni', fArqIniTinta(0, 'PPG', 'PPGGOM', ''));
  conf.pInsereCodigo('PPGLDU', 'Embalagem Litro Dulon', fArqIniTinta(0, 'PPG', 'PPGLDU', ''));
  conf.pInsereCodigo('PPGLDF', 'Embalagem Litro Delfleet', fArqIniTinta(0, 'PPG', 'PPGLDF', ''));
  conf.pInsereCodigo('PPGLDT', 'Embalagem Litro Deltron', fArqIniTinta(0, 'PPG', 'PPGLDT', ''));
  conf.pInsereCodigo('PPGLOM', 'Embalagem Litro Omni', fArqIniTinta(0, 'PPG', 'PPGLOM', ''));
  conf.pInsereCodigo('PPGLADU', 'Embalagem Balde Dulon', fArqIniTinta(0, 'PPG', 'PPGLADU', ''));
  conf.pInsereCodigo('PPGLADF', 'Embalagem Balde Delfleet', fArqIniTinta(0, 'PPG', 'PPGLADF', ''));
  conf.pInsereCodigo('PPGLADT', 'Embalagem Balde Deltron', fArqIniTinta(0, 'PPG', 'PPGLADT', ''));
  conf.pInsereCodigo('PPGLAOM', 'Embalagem Balde Omni', fArqIniTinta(0, 'PPG', 'PPGLAOM', ''));
  conf.pInsereCodigo('PPGTDU', 'Embalagem Tambor Dulon', fArqIniTinta(0, 'PPG', 'PPGTDU', ''));
  conf.pInsereCodigo('PPGTDF', 'Embalagem Tambor Delfleet', fArqIniTinta(0, 'PPG', 'PPGTDF', ''));
  conf.pInsereCodigo('PPGTDT', 'Embalagem Tambor Deltron', fArqIniTinta(0, 'PPG', 'PPGTDT', ''));
  conf.pInsereCodigo('PPGTOM', 'Embalagem Tambor Omni', fArqIniTinta(0, 'PPG', 'PPGTOM', ''));
  conf.pInsereCodigo('MODTXT', 'Modo Geração Txt', '0');
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');
  conf.pInsereCodigo('VERARQ', 'Versão do arquivo de geração PPG', '1');

  //As embalagens agora serão gravadas em tabela a parte
  confEmb.pInsereCodigo('PPGPMGDU', 'GALAO', 'Dulon(LA)', conf.fGet('PPGPMGDU'));
  confEmb.pInsereCodigo('PPGPMGDF', 'GALAO', 'Delfleet(LA)', conf.fGet('PPGPMGDF'));
  confEmb.pInsereCodigo('PPGPMGDT', 'GALAO', 'Deltron(LA)', conf.fGet('PPGPMGDT'));
  confEmb.pInsereCodigo('PPGPMGEB', 'GALAO', 'Envirobase HP', conf.fGet('PPGPMGEB'));
  confEmb.pInsereCodigo('PPGPMLDU', 'LITRO', 'Dulon(LA)', conf.fGet('PPGPMLDU'));
  confEmb.pInsereCodigo('PPGPMLDF', 'LITRO', 'Delfleet(LA)', conf.fGet('PPGPMLDF'));
  confEmb.pInsereCodigo('PPGPMLDT', 'LITRO', 'Deltron(LA)', conf.fGet('PPGPMLDT'));
  confEmb.pInsereCodigo('PPGPMLEB', 'LITRO', 'Envirobase HP', conf.fGet('PPGPMLEB'));
  confEmb.pInsereCodigo('PPGPMLADU', 'BALDE', 'Dulon(LA)', conf.fGet('PPGPMLADU'));
  confEmb.pInsereCodigo('PPGPMLADF', 'BALDE', 'Delfleet(LA)', conf.fGet('PPGPMLADF'));
  confEmb.pInsereCodigo('PPGPMLADT', 'BALDE', 'Deltron(LA)', conf.fGet('PPGPMLADT'));
  confEmb.pInsereCodigo('PPGPMLAEB', 'BALDE', 'Envirobase HP', conf.fGet('PPGPMLAEB'));
  confEmb.pInsereCodigo('PPGPMTDU', 'TAMBOR', 'Dulon(LA)', conf.fGet('PPGPMTDU'));
  confEmb.pInsereCodigo('PPGPMTDF', 'TAMBOR', 'Delfleet(LA)', conf.fGet('PPGPMTDF'));
  confEmb.pInsereCodigo('PPGPMTDT', 'TAMBOR', 'Deltron(LA)', conf.fGet('PPGPMTDT'));
  confEmb.pInsereCodigo('PPGPMTEB', 'TAMBOR', 'Envirobase HP', conf.fGet('PPGPMTEB'));

  //As embalagens agora serão gravadas em tabela a parte
  confEmb.pInsereCodigo('PPGPMG2K', 'GALAO', '2K', conf.fGet('PPGPMG2K'));
  confEmb.pInsereCodigo('PPGPMGAC', 'GALAO', 'ACS (LA)', conf.fGet('PPGPMGAC'));
  confEmb.pInsereCodigo('PPGPMGIN', 'GALAO', 'Industran', conf.fGet('PPGPMGIN'));
  confEmb.pInsereCodigo('PPGPMGSG', 'GALAO', 'Spectral grey', conf.fGet('PPGPMGSG'));
  confEmb.pInsereCodigo('PPGPMGZY', 'GALAO', 'Zynamix', conf.fGet('PPGPMGZY'));
  confEmb.pInsereCodigo('PPGPML2K', 'LITRO', '2K', conf.fGet('PPGPML2K'));
  confEmb.pInsereCodigo('PPGPMLAC', 'LITRO', 'ACS (LA)', conf.fGet('PPGPMLAC'));
  confEmb.pInsereCodigo('PPGPMLIN', 'LITRO', 'Industran', conf.fGet('PPGPMLIN'));
  confEmb.pInsereCodigo('PPGPMLSG', 'LITRO', 'Spectral grey', conf.fGet('PPGPMLSG'));
  confEmb.pInsereCodigo('PPGPMLZY', 'LITRO', 'Zynamix', conf.fGet('PPGPMLZY'));
  confEmb.pInsereCodigo('PPGPMLA2K', 'BALDE', '2K', conf.fGet('PPGPMLA2K'));
  confEmb.pInsereCodigo('PPGPMLAAC', 'BALDE', 'ACS (LA)', conf.fGet('PPGPMLAAC'));
  confEmb.pInsereCodigo('PPGPMLAIN', 'BALDE', 'Industran', conf.fGet('PPGPMLAIN'));
  confEmb.pInsereCodigo('PPGPMLASG', 'BALDE', 'Spectral grey', conf.fGet('PPGPMLASG'));
  confEmb.pInsereCodigo('PPGPMLAZY', 'BALDE', 'Zynamix', conf.fGet('PPGPMLAZY'));
  confEmb.pInsereCodigo('PPGPMT2K', 'TAMBOR', '2K', conf.fGet('PPGPMT2K'));
  confEmb.pInsereCodigo('PPGPMTAC', 'TAMBOR', 'ACS (LA)', conf.fGet('PPGPMTAC'));
  confEmb.pInsereCodigo('PPGPMTIN', 'TAMBOR', 'Industran', conf.fGet('PPGPMTIN'));
  confEmb.pInsereCodigo('PPGPMTSG', 'TAMBOR', 'Spectral grey', conf.fGet('PPGPMTSG'));
  confEmb.pInsereCodigo('PPGPMTZY', 'TAMBOR', 'Zynamix', conf.fGet('PPGPMTZY'));    
  //

  conf.pInsereCodigo('PATPPG', 'Path para arquivos (*.txt)', fArqIniTinta(0, 'PPG', 'PATPPG', ''));
  conf.pInsereCodigo('PATVVD', 'Valor de venda litro diluente', fArqIniTinta(0, 'PPG', 'PATVVD', ''));
  conf.pInsereCodigo('PATVCD', 'Valor de custo litro diluente', fArqIniTinta(0, 'PPG', 'PATVCD', ''));
  conf.pInsereCodigo('PATPPG', 'Path para arquivos (*.txt)', fArqIniTinta(0, 'PPG', 'PATPPG', ''));
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', fArqIniTinta(0, 'USA_FORMUL', 'PPG', 'S'));
  conf.pInsereCodigo('PROCOD', 'Próximo Código Novas Fórmulas', fArqIniTinta(0, 'PPG', 'PROCOD', ''));
//  conf.pInsereCodigo('PPGCOP', 'Embalagem copo', fArqIniTinta(0, 'PPG', 'PPGCOP', ''));
  confEmb.pInsereCodigo('PPGCOP', 'COPO', 'SEM LINHA', conf.fGet('PPGCOP'));
  conf.pInsereCodigo('NOVFOR', 'Utilizar Nova Formullação', 'N');  

  {*******************************************}
  {* GRUPOS DOS ITENS                        *}
  {****************************************AC*}

  conf.pInsereCodigo('G_PPGGDU', 'Grupo item Embalagem Galão Dulon', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGGDU', '')));
  conf.pInsereCodigo('G_PPGGDF', 'Grupo item Embalagem Galão Delfleet', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGGDF', '')));
  conf.pInsereCodigo('G_PPGGDT', 'Grupo item Embalagem Galão Deltron', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGGDT', '')));
  conf.pInsereCodigo('G_PPGGOM', 'Grupo item Embalagem Galão Omni', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGGOM', '')));
  conf.pInsereCodigo('G_PPGLDU', 'Grupo item Embalagem Litro Dulon', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGLDU', '')));
  conf.pInsereCodigo('G_PPGLDF', 'Grupo item Embalagem Litro Delfleet', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGLDF', '')));
  conf.pInsereCodigo('G_PPGLDT', 'Grupo item Embalagem Litro Deltron', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGLDT', '')));
  conf.pInsereCodigo('G_PPGLOM', 'Grupo item Embalagem Litro Omni', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGLOM', '')));

  //PAINT MANAGER - PPG
  conf.pInsereCodigo('G_PPGPMGDU', 'Grupo item Embalagem Galão Dulon', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMGDU', '')));
  conf.pInsereCodigo('G_PPGPMGDF', 'Grupo item Embalagem Galão Delfleet', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMGDF', '')));
  conf.pInsereCodigo('G_PPGPMGDT', 'Grupo item Embalagem Galão Deltron', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMGDT', '')));
  conf.pInsereCodigo('G_PPGPMGEB', 'Grupo item Embalagem Galão Envirobase', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMGEB', '')));
  conf.pInsereCodigo('G_PPGPMLDU', 'Grupo item Embalagem Litro Dulon', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMLDU', '')));
  conf.pInsereCodigo('G_PPGPMLDF', 'Grupo item Embalagem Litro Delfleet', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMLDF', '')));
  conf.pInsereCodigo('G_PPGPMLDT', 'Grupo item Embalagem Litro Deltron', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMLDT', '')));
  conf.pInsereCodigo('G_PPGPMLEB', 'Grupo item Embalagem Litro Envirobase', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMLEB', '')));
  //

  //PAINT MANAGER - NEXA
  conf.pInsereCodigo('G_PPGPMG2K', 'Grupo item Embalagem Galão 2K', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMG2K', '')));
  conf.pInsereCodigo('G_PPGPMGAC', 'Grupo item Embalagem Galão ACS', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMGAC', '')));
  conf.pInsereCodigo('G_PPGPMGIN', 'Grupo item Embalagem Galão Industran', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMGIN', '')));
  conf.pInsereCodigo('G_PPGPMGSG', 'Grupo item Embalagem Galão Spectral grey', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMGSG', '')));
  conf.pInsereCodigo('G_PPGPMGZY', 'Grupo item Embalagem Galão Zynamix', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMGZY', '')));
  conf.pInsereCodigo('G_PPGPML2K', 'Grupo item Embalagem Litro 2K', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPML2K', '')));
  conf.pInsereCodigo('G_PPGPMLAC', 'Grupo item Embalagem Litro ACS', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMLAC', '')));
  conf.pInsereCodigo('G_PPGPMLIN', 'Grupo item Embalagem Litro Industran', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMLIN', '')));
  conf.pInsereCodigo('G_PPGPMLSG', 'Grupo item Embalagem Litro Spectral grey', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMLSG', '')));
  conf.pInsereCodigo('G_PPGPMLZY', 'Grupo item Embalagem Litro Zynamix', fRetornaGrupoItem(fArqIniTinta(0, 'PPG', 'PPGPMLZY', '')));
  conf.pInsereCodigo('VERARQ', 'Versão do arquivo de geração PPG', '1');
  conf.pInsereCodigo('ACUABS', 'Formulação Acumulada Absoluta', '2');
  //

  PageControl1.ActivePageIndex := 0;
  frmConfConsultaPPG := TfrmConfConsulta.Create(Self, tbsConfCampos, Canvas, tinta);
end;

procedure TfrmConfiguracoesPPG.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
  qryCadIte := fCriaQuery(Self);
  if (not chkNovFor.Checked) then
    EscondeTabEmbPM;
end;

procedure TfrmConfiguracoesPPG.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    pGravaArqIni;
    Close;
  End;
end;

procedure TfrmConfiguracoesPPG.edtPpgCopKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  Inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesPPG.edtPpgGduKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesPPG.edtProPpgKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItem(TEdit(Sender), edtDesProPpg);
  End;

end;

procedure TfrmConfiguracoesPPG.btnPreVisClick(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPML2K','PPG','LITRO','2K');
  edtPpgPML2k.Text := confEmb.fGet('PPGPML2K');
  fValidaCampos(edtPpgPML2k,True);
end;

procedure TfrmConfiguracoesPPG.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaPPG.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesPPG.chkNovForClick(Sender: TObject);
begin
  inherited;
  if chkNovFor.Checked then
    EscondeTabEmb
  else
    EscondeTabEmbPM;
end;

destructor TfrmConfiguracoesPPG.Destroy;
begin
  fRollBack;
  if Assigned(frmConfConsultaPPG) then FreeAndNil(frmConfConsultaPPG);  
  inherited;
end;

procedure TfrmConfiguracoesPPG.edtPpgLAduKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  Inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 7)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesPPG.edtPpgPMLAduKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 9)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesPPG.edtPpgPMLduKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 8)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesPPG.pRetornaDescricaoItem2(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 7);
  edtDesIte := TEdit(FindComponent(strNomEdt));
  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesPPG.EscondeTabEmb;
begin
  PageControl1.Pages[1].TabVisible := False;
  PageControl1.Pages[3].TabVisible := True;
  PageControl1.Pages[4].TabVisible := True;
end;

procedure TfrmConfiguracoesPPG.EscondeTabEmbPM;
begin
  PageControl1.Pages[3].TabVisible := False;
  PageControl1.Pages[4].TabVisible := False;
  PageControl1.Pages[1].TabVisible := True;
end;

procedure TfrmConfiguracoesPPG.pRetornaDescricaoItem3(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 8);
  edtDesIte := TEdit(FindComponent(strNomEdt));
  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesPPG.pRetornaDescricaoItem4(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 9);
  edtDesIte := TEdit(FindComponent(strNomEdt));
  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesPPG.SpeedButton10Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLA2K','PPG','BALDE','2K');
  edtPpgPMLA2k.Text := confEmb.fGet('PPGPMLA2K');
  fValidaCampos(edtPpgPMLA2k,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton11Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLAAC','PPG','BALDE','ACS (LA)');
  edtPpgPMLAAc.Text := confEmb.fGet('PPGPMLAAC');
  fValidaCampos(edtPpgPMLAAc,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton12Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLAIN','PPG','BALDE','INDUSTRAN');
  edtPpgPMLAIn.Text := confEmb.fGet('PPGPMLAIN');
  fValidaCampos(edtPpgPMLAIn,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton13Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLASG','PPG','BALDE','SPECTRAL GREY');
  edtPpgPMLASg.Text := confEmb.fGet('PPGPMLASG');
  fValidaCampos(edtPpgPMLASg,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton14Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLAZY','PPG','BALDE','ZYNAMIX');
  edtPpgPMLAZy.Text := confEmb.fGet('PPGPMLAZY');
  fValidaCampos(edtPpgPMLAZy,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton15Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMT2K','PPG','TAMBOR','2K');
  edtPpgPMT2k.Text := confEmb.fGet('PPGPMT2K');
  fValidaCampos(edtPpgPMT2k,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton16Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMTAC','PPG','TAMBOR','ACS (LA)');
  edtPpgPMTAc.Text := confEmb.fGet('PPGPMTAC');
  fValidaCampos(edtPpgPMTAc,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton17Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMTIN','PPG','TAMBOR','INDUSTRAN');
  edtPpgPMTin.Text := confEmb.fGet('PPGPMTIN');
  fValidaCampos(edtPpgPMTin,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton18Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMTSG','PPG','TAMBOR','SPECTRAL GREY');
  edtPpgPMTSg.Text := confEmb.fGet('PPGPMTSG');
  fValidaCampos(edtPpgPMTSg,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton19Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMTZY','PPG','TAMBOR','ZYNAMIX');
  edtPpgPMTZy.Text := confEmb.fGet('PPGPMTZY');
  fValidaCampos(edtPpgPMTZy,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLAC','PPG','LITRO','ACS (LA)');
  edtPpgPMLAc.Text := confEmb.fGet('PPGPMLAC');
  fValidaCampos(edtPpgPMLAc,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton20Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLDU', 'PPG','LITRO','DULON(LA)');
  edtPpgPMLdu.Text := confEmb.fGet('PPGPMLDU');
  fValidaCampos(edtPpgPMLdu,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton21Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLDF','PPG','LITRO','DELFLEET(LA)');
  edtPpgPMLdf.Text := confEmb.fGet('PPGPMLDF');
  fValidaCampos(edtPpgPMLdf,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton22Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLDT','PPG','LITRO','DELTRON(LA)');
  edtPpgPMLdt.Text := confEmb.fGet('PPGPMLDT');
  fValidaCampos(edtPpgPMLdt,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton23Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLEB','PPG','LITRO','ENVIROBASE');
  edtPpgPMLeb.Text := confEmb.fGet('PPGPMLEB');
  fValidaCampos(edtPpgPMLeb,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton24Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMGDU','PPG','GALAO','DULON(LA)');
  edtPpgPMGdu.Text := confEmb.fGet('PPGPMGDU');
  fValidaCampos(edtPpgPMGdu,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton25Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMGDF','PPG','GALAO','DELFLEET(LA)');
  edtPpgPMGdf.Text := confEmb.fGet('PPGPMGDF');
  fValidaCampos(edtPpgPMGdf,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton26Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMGDT','PPG','GALAO','DELTRON(LA)');
  edtPpgPMGdt.Text := confEmb.fGet('PPGPMGDT');
  fValidaCampos(edtPpgPMGdt,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton27Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMGEB','PPG','GALAO','ENVIROBASE');
  edtPpgPMGeb.Text := confEmb.fGet('PPGPMGEB');
  fValidaCampos(edtPpgPMGeb,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton28Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLADU','PPG','BALDE','DULON(LA)');
  edtPpgPMLAdu.Text := confEmb.fGet('PPGPMLADU');
  fValidaCampos(edtPpgPMLAdu,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton29Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLADF','PPG','BALDE','DELFLEET(LA)');
  edtPpgPMLAdf.Text := confEmb.fGet('PPGPMLADF');
  fValidaCampos(edtPpgPMLAdf,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton2Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLIN','PPG','LITRO','INDUSTRAN');
  edtPpgPMLIn.Text := confEmb.fGet('PPGPMLIN');
  fValidaCampos(edtPpgPMLIn,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton30Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLADT','PPG','BALDE','DELTRON(LA)');
  edtPpgPMLAdt.Text := confEmb.fGet('PPGPMLADT');
  fValidaCampos(edtPpgPMLAdt,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton31Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLAEB','PPG','BALDE','ENVIROBASE');
  edtPpgPMLAeb.Text := confEmb.fGet('PPGPMLAEB');
  fValidaCampos(edtPpgPMLAeb,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton32Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMTDU','PPG','TAMBOR','DULON(LA)');
  edtPpgPMTdu.Text := confEmb.fGet('PPGPMTDU');
  fValidaCampos(edtPpgPMTdu,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton33Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMTDF','PPG','TAMBOR','DELFLEET(LA)');
  edtPpgPMTdf.Text := confEmb.fGet('PPGPMTDF');
  fValidaCampos(edtPpgPMTdf,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton34Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMTDT','PPG','TAMBOR','DELTRON(LA)');
  edtPpgPMTdt.Text := confEmb.fGet('PPGPMTDT');
  fValidaCampos(edtPpgPMTdt,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton35Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMTEB','PPG','TAMBOR','ENVIROBASE');
  edtPpgPMTeb.Text := confEmb.fGet('PPGPMTEB');
  fValidaCampos(edtPpgPMTeb,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton36Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGCOP','PPG','COPO','SEM LINHA');
  edtPpgCopEb.Text := confEmb.fGet('PPGCOP');
  fValidaCampos(edtPpgCopEb,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton3Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLSG','PPG','LITRO','SPECTRAL GREY');
  edtPpgPMLSg.Text := confEmb.fGet('PPGPMLSG');
  fValidaCampos(edtPpgPMLSg,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton4Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMLZY','PPG','LITRO','ZYNAMIX');
  edtPpgPMLZy.Text := confEmb.fGet('PPGPMLZY');
  fValidaCampos(edtPpgPMLZy,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton5Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMG2K','PPG','GALAO','2K');
  edtPpgPMG2k.Text := confEmb.fGet('PPGPMG2K');
  fValidaCampos(edtPpgPMG2k,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton6Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMGAC','PPG','GALAO','ACS (LA)');
  edtPpgPMGAc.Text := confEmb.fGet('PPGPMGAC');
  fValidaCampos(edtPpgPMGAc,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton7Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMGIN','PPG','GALAO','INDUSTRAN');
  edtPpgPMGIn.Text := confEmb.fGet('PPGPMGIN');
  fValidaCampos(edtPpgPMGIn,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton8Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMGSG','PPG','GALAO','SPECTRAL GREY');
  edtPpgPMGSg.Text := confEmb.fGet('PPGPMGSG');
  fValidaCampos(edtPpgPMGSg,True);
end;

procedure TfrmConfiguracoesPPG.SpeedButton9Click(Sender: TObject);
begin
  inherited;
  pCriaCadEmbTinta('PPGPMGZY','PPG','GALAO','ZYNAMIX');
  edtPpgPMGZy.Text := confEmb.fGet('PPGPMGZY');
  fValidaCampos(edtPpgPMGZy,True);
end;

procedure TfrmConfiguracoesPPG.pCriaCadEmbTinta(strCodCfg, strIdePro, strEmbala,
  strLinha: String);
begin
  Try
    pCriarFormularios(TfrmCadEmbTinta,frmCadEmbTinta);
    frmCadEmbTinta.pSetaParametros(strCodCfg,strIdePro,strEmbala,strLinha);
    frmCadEmbTinta.ShowModal;
    confEmb := fGetConfEmb('PPG');
  Finally
    FreeAndNil(frmCadEmbTinta);
  End;
end;

end.

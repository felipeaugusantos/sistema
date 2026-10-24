unit untRelGarantiaRefPre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus, untGarant,
  untfuncoesSimples, frxDesgn, frxClass, frxDBSet, untTypesSistema,
  frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  AppEvnts, BitBtnLockedIncrem;

type
  TfrmRelGarantiaRefPre = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    rdgFiltros: TRadioGroup;
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }

    objMovGag: TMovGag;
    
  public
    { Public declarations }

  arrFornecedor: TConsultasArray;

  protected

    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

    { Public declarations }
  end;

var
  frmRelGarantiaRefPre: TfrmRelGarantiaRefPre;

implementation

uses untFuncoesConsulta, untConsultas, Data.DB;

{$R *.dfm}

{ TfrmRelGarantiaRefPre }

{*******************************************}
{* VALIDA CAMPOS                           *}
{****************************************RL*}
function TfrmRelGarantiaRefPre.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    {*********************}
    {* VALIDA DATAS      *}
    {******************LU*}
    If (Sender = mskDtaIni) Or (Sender = mskDtaFin) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
        Result := False;
        If (Sender = mskDtaFin) Then
          Sender := mskDtaIni;
      End
      Else
      Begin
        If (Sender = mskDtaFin) Then
        Begin
          If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
          Begin
            fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A data inicial deve ser menor que a data final!',['&O K']);
              Result := False;
            End;
          End;
        End
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelGarantiaRefPre.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrFornecedor, False) Then
  Begin
    fValidaCampos(edtFornecedor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelGarantiaRefPre.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtFornecedor,edtDesFornecedor,arrFornecedor,fRetNomFornecedor,Nil ,'do forncedor');
  
end;

procedure TfrmRelGarantiaRefPre.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
                 SelectNext(ActiveControl, True, True);
    VK_ESCAPE: Close;
  End;
  
end;

procedure TfrmRelGarantiaRefPre.FormCreate(Sender: TObject);
begin
  inherited;

  objMovGag := TMovGag.Create(Self);

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);  
  
end;

procedure TfrmRelGarantiaRefPre.btnImprimirClick(Sender: TObject);
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin

      Try

        objMovGag.pImprimirRelatorio(4,
                                     StrToDate(mskDtaIni.Text),
                                     StrToDate(mskDtaFin.Text),
                                     edtDestino.Text,
                                     rdgFiltros.ItemIndex,
                                     -1,
                                     -1,
                                     edtFornecedor,
                                     nil,
                                     nil,
                                     edtDesFornecedor,
                                     Nil,
                                     Nil,
                                     arrFornecedor,
                                     nil,
                                     nil);

      Except
        On E: Exception Do
        Begin
					pMensagensErro(E.Message,'[TfrmRelGarantiaRefPre.btnImprimirClick]');
        End;
      End;

   End;

  If objMovGag.qryRelatorio.IsEmpty Then
    pTabelaVazia;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';
  pSetFocus(mskDtaIni);

end;

end.


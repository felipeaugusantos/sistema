unit untRelGarantiaPecasPendentes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, RLFilters, RLDraftFilter, Menus, StdCtrls,
  EditFocus, QColorLabel, Buttons, ExtCtrls, Mask, MaskEditFocus,
  untfuncoesSimples, untGarant, frxDesgn, frxClass, frxDBSet, untTypesSistema,
  frxDMPExport, frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF,
  AppEvnts, BitBtnLockedIncrem;

type
  TfrmRelGarantiaPecasPendentes = class(TfrmPaiRelatorio)
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    rdgFiltros: TRadioGroup;
    edtDesIte: TEditFocus;
    edtCodIte: TEditFocus;
    Label10: TLabel;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }

    objMovGag: TMovGag;

  public
    { Public declarations }

    arrCliente: TConsultasArray;
    arrProduto: TConsultasArray;    

  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  end;

var
  frmRelGarantiaPecasPendentes: TfrmRelGarantiaPecasPendentes;

implementation

uses untFuncoesConsulta, untConsultas, Data.DB;

{$R *.dfm}

{ TfrmRelGarantiaPecasPendentes }

function TfrmRelGarantiaPecasPendentes.fValidaCampos(Sender: TWinControl;
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

procedure TfrmRelGarantiaPecasPendentes.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrCliente, False) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelGarantiaPecasPendentes.edtCodCliExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodCli,edtNomCli,arrCliente,Nil,fRetNomCliente ,'do cliente');

end;

procedure TfrmRelGarantiaPecasPendentes.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, nil, Key, arrProduto, False, nil, 'Consulta de Itens', '1') then  
  Begin
    if fvalidaCampos(edtCodIte,False) then
      self.SelectNext(ActiveControl, True, True);
  End;

end;


procedure TfrmRelGarantiaPecasPendentes.edtCodIteExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtCodIte,edtDesIte,arrProduto,nil,fRetNomProduto,'do Produto');
  
end;

procedure TfrmRelGarantiaPecasPendentes.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_RETURN: If (ActiveControl <> Nil) And (ActiveControl.Name = '') Then
                 SelectNext(ActiveControl, True, True);
    VK_ESCAPE: Close;
  End;

end;

procedure TfrmRelGarantiaPecasPendentes.FormCreate(Sender: TObject);
begin
  inherited;

  objMovGag := TMovGag.Create(Self);

  mskDtaIni.Text := DateToStr(VS_Date);
  mskDtaFin.Text := DateToStr(VS_Date);
    
end;

procedure TfrmRelGarantiaPecasPendentes.btnImprimirClick(Sender: TObject);
begin
  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;

  If blnImprime Then
  Begin

      Try

        objMovGag.pImprimirRelatorio(3,
                                     StrToDate(mskDtaIni.Text),
                                     StrToDate(mskDtaFin.Text),
                                     edtDestino.Text,
                                     rdgFiltros.ItemIndex,
                                     -1,
                                     -1,
                                     nil,
                                     edtCodCli,
                                     edtCodIte,
                                     nil,
                                     edtNomCli,
                                     edtDesIte,
                                     nil,
                                     arrCliente,
                                     arrProduto);

      Except
        On E: Exception Do
        Begin
					pMensagensErro(E.Message,'[TfrmRelGarantiaPecasPendentes.btnImprimirClick]');
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




{*********************************************************}
{* MANUTENÇÃO DE ORDEM DE SERVIÇO                        *}
{*                                                       *}
{* DATA......: 04/10/2007                                *}
{* AUTOR.....: ALEXANDRE OLIVEIRA FERRI "FALTA MUITO???" *}
{*                                                       *}
{******************************************************AF*}
unit untFatManOrdSer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  EditFocus, untFatOrdSer, DB, Uni, AppEvnts, frxClass, untTypesSistema,
  frxExportCSVTestabilidade, BitBtnLockedIncrem, DBGridCitel;

type
  TfrmFatManOrdSer = class(TfrmPai)
    pnlTotais: TPanel;
    pnlObserv: TPanel;
    dbgItens: TDBGridCitel;
    edtObserv: TEditFocus;
    edtCliente: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    gpbMedidas: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    edtLargura: TEditFocus;
    edtAltura: TEditFocus;
    gpbTotais: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    edtQuant: TEditFocus;
    edtTotal: TEditFocus;
    gpbOutros: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    edtTarja: TEditFocus;
    edtRecLoc: TEditFocus;
    btnBaixar: TBitBtnLocked;
    btnImprime: TBitBtnLocked;
    btnProcura: TBitBtnLocked;
    btnApaga: TBitBtnLocked;
    pnlQtdEti: TPanel;
    lblQtdEti: TLabel;
    edtQtdEti: TEditFocus;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnApagaClick(Sender: TObject);
    procedure btnImprimeClick(Sender: TObject);
    procedure btnBaixarClick(Sender: TObject);
    procedure btnProcuraClick(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    objOrdSer  : TOrdSer;
    intRegistro: Integer;

    procedure pMarcaDesmarca;

    procedure pAfterScrol(Dataset: TDataset);
  public
    { Public declarations }
    opeTipOpe: TOperacaoServico;
    odTipoFiltro: TFiltroOrdServProd;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

uses untFuncoes, untfuncoesSimples, untConsultas;

{$R *.dfm}

procedure TfrmFatManOrdSer.FormCreate(Sender: TObject);
begin
  inherited;

  opeTipOpe := opeBaixaSer;
  odTipoFiltro := odTodos;
end;

procedure TfrmFatManOrdSer.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
    btnSair.Click();
end;

{**************************************}
{* AÇÃO A SER EXECUTADA AO MOVIMENTAR *}
{* TABELA                             *}
{***********************************AF*}
procedure TfrmFatManOrdSer.pAfterScrol(Dataset: TDataset);
Begin

  objOrdSer.pAtuDados;
  edtObserv.Text    := objOrdSer.strObserv;
  edtCliente.Text   := objOrdSer.strCodCli;
  edtLargura.Text   := objOrdSer.strLargur;
  edtAltura.Text    := objOrdSer.strAltura;
  edtQuant.Text     := objOrdSer.strQtdSer;
  edtTotal.Text     := objOrdSer.strTot_M2;
  edtTarja.Text     := objOrdSer.strTarja_;
  edtRecLoc.Text    := objOrdSer.strRecLoc;
  edtQtdEti.Text    := IntToStr(objOrdSer.intQtdEti);
  edtQtdEti.Enabled := objOrdSer.cdsOrdSer.FieldByName('MARDES').AsString = 'M';

  intRegistro     := objOrdSer.cdsOrdSer.RecNo;

End;

procedure TfrmFatManOrdSer.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  objOrdSer.cdsOrdSer.AfterScroll := Nil;
  FreeAndNil(objOrdSer);
end;

procedure TfrmFatManOrdSer.pMarcaDesmarca;
  Var
    intRecNo: Integer;
Begin
  objOrdSer.pMarcaManOrdSer;
  intRecNo := objOrdSer.cdsOrdSer.RecNo;
  objOrdSer.pAtualizaDados('', '', VS_strCodEmp, '', 0, False);
  objOrdSer.cdsOrdSer.RecNo := intRecNo;

  If objOrdSer.cdsOrdSer.FieldByName('MARDES').AsString = 'M' Then
  Begin
    edtQtdEti.Enabled := TRUE;
    pSetFocus(edtQtdEti);
  End;
End;

procedure TfrmFatManOrdSer.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_Escape Then
  Begin
    btnSair.Click;
  End

  Else If Key = VK_Return Then
  Begin
    pMarcaDesmarca;
  End;

end;

procedure TfrmFatManOrdSer.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If objOrdSer.cdsOrdSer.FieldByName('MARDES').AsString = 'M' Then
  Begin
    dbgItens.Canvas.Font.Color := clBlue;
    dbgItens.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  End;

  If (intRegistro = objOrdSer.cdsOrdSer.RecNo) Then
  Begin
    dbgItens.Canvas.Font.Color  := clWhite;
    dbgItens.Canvas.Brush.Color := clNavy;
    dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;

end;

procedure TfrmFatManOrdSer.btnApagaClick(Sender: TObject);
begin
  inherited;

  Try
    objOrdSer.pDeletaManOrdSer;
  Except

    On E:Exception Do
    Begin
      pMensagensErro(E.Message,'TfrmFatManOrdSer.btnApagaClick');
    end

  End;

end;

procedure TfrmFatManOrdSer.btnImprimeClick(Sender: TObject);
begin
  inherited;

  Case opeTipOpe Of
    opeBaixaSer:     Try
                       objOrdSer.pImprimeOrdSerIndiv;
                     Except
                       On E:Exception Do
                       Begin
                         pMensagensErro(E.Message,'[TfrmFatManOrdSer.btnImprimeClick]');
                       End;
                     End;
    opeEtiquetasSer: objOrdSer.fImprimeEtiquetas;

  End;

  dbgItens.BorderStyle := bsNone;
  dbgItens.BorderStyle := bsSingle;
  ShowScrollBar(dbgItens.handle, SB_VERT, True);
end;

procedure TfrmFatManOrdSer.btnBaixarClick(Sender: TObject);
begin
  inherited;

  Try
    objOrdSer.pBaixaManOrdSer;
    pAfterScrol(Nil);
  Except

    On E:Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmFatManOrdSer.btnBaixarClick]');
    End;

  End;

end;

procedure TfrmFatManOrdSer.btnProcuraClick(Sender: TObject);
  Var
    chrKey: Char;
    arrOrdSer: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE ATIVIDADES *}
  {****************************RV*}
  chrKey := '/';

  If fPesqOrdemServicoProdVenda(Self, Nil, Nil, objOrdSer.qryOrdSer, chrKey, arrOrdSer, odTipoFiltro) Then Begin
    objOrdSer.cdsOrdSer.Locate('AUTOINCREM', objOrdSer.qryOrdSer.FieldByName('AUTOINCREM').AsString, []);

    objOrdSer.pAtuDados;
    edtObserv.Text    := objOrdSer.cdsOrdSer.FieldByName('ORD_OBSERV').AsString;
    edtCliente.Text   := objOrdSer.cdsOrdSer.FieldByName('ORD_NOMCLI').AsString;
    edtLargura.Text   := objOrdSer.cdsOrdSer.FieldByName('ORD_LARGUR').AsString;
    edtAltura.Text    := objOrdSer.cdsOrdSer.FieldByName('ORD_ALTURA').AsString;
    edtQuant.Text     := objOrdSer.cdsOrdSer.FieldByName('ORD_QTDSER').AsString;
    edtTotal.Text     := objOrdSer.cdsOrdSer.FieldByName('ORD_TOT_M2').AsString;
    edtTarja.Text     := objOrdSer.cdsOrdSer.FieldByName('ORD_TARJA_').AsString;
    edtRecLoc.Text    := objOrdSer.cdsOrdSer.FieldByName('ORD_RECLOC').AsString;
    edtQtdEti.Text    := objOrdSer.cdsOrdSer.FieldByName('ORD_QTDETI').AsString;
    edtQtdEti.Enabled := objOrdSer.cdsOrdSer.FieldByName('MARDES').AsString = 'M';

    intRegistro     := objOrdSer.cdsOrdSer.RecNo;

    pSetFocus(btnBaixar);
  End;
end;

procedure TfrmFatManOrdSer.dbgItensDblClick(Sender: TObject);
begin
  inherited;

  pMarcaDesmarca;
end;

function TfrmFatManOrdSer.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
  Var
    intRecNo: Integer;
begin

  Result := True;


  If (Sender = edtQtdEti) And edtQtdEti.Enabled Then
  Begin

      If (StrToIntDef(edtQtdEti.Text,0) < 0) Then
      Begin
        fMensagem('','A quantidade de etiquetas deve ser igual ou maior que zero!', ['&OK']);
        Result := False;
      End

      Else
      Begin
        objOrdSer.intQtdEti := StrToIntDef(edtQtdEti.Text,0);

        If (objOrdSer.intQtdEti = 0) And (opeTipOpe = opeEtiquetasSer)  Then
        Begin
          pMarcaDesmarca;
        End Else
        Begin
          intRecNo := objOrdSer.cdsOrdSer.RecNo;
          objOrdSer.pAtualizaDados('', '', VS_strCodEmp, '', 0, False);
          objOrdSer.cdsOrdSer.RecNo := intRecNo;
          pSetFocus(dbgItens);
          blnMudarFoco := FALSE;
        End;

      End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatManOrdSer.FormShow(Sender: TObject);
begin
  inherited;

  Case opeTipOpe Of
    opeEtiquetasSer: Begin
                       btnApaga.Visible := FALSE;
                       btnBaixar.Visible := FALSE;
                       btnImprime.Left := btnBaixar.Left;
                       btnImprime.Width := 140;
                       btnImprime.Caption := 'Imprimir Etiquetas';
                       self.Caption       := 'Reimpressão de Etiquetas de Ordem de Serviço';
                     End;
  End;

  Try

    {**************************************}
    {* CRIA OBJETO E LINKA NO GRID        *}
    {***********************************AF*}
    objOrdSer := TOrdSer.Create;
    objOrdSer.opeTipOpe := opeTipOpe;
    objOrdSer.cdsOrdSer.AfterScroll := pAfterScrol;
    objOrdSer.pCarregaManOrdSer(odTipoFiltro);
    dbgItens.DataSource := objOrdSer.dtsOrdSer;
    objOrdSer.cdsOrdSer.First();

  Except
    On E:Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmFatManOrdSer.FormShow]');
    End;
  End;

end;

end.


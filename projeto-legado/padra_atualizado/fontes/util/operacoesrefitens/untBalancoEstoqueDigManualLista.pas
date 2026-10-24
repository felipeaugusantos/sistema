unit untBalancoEstoqueDigManualLista;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider,
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, untCadLote,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, frxClass,
  frxExportCSVTestabilidade, Datasnap.DBClient;

type
  TpZeraContagemColetiva = Procedure(strCodIte, strCodLot: String) Of Object;

  TfrmBalancoEstoqueDigManualLista = class(TfrmPaiOrdena)
    rdgMostrar: TRadioGroup;
    shaDig: TShape;
    Label1: TLabel;
    lblObsSaldo: TLabel;
    btnZerCon: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure rdgMostrarClick(Sender: TObject);
    procedure dbgConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnZerConClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    stlListItem, stlListLot: TStringList;

    procedure pZeraContagemManual;

  public
    { Public declarations }
    objCadLot: TCadLot;

    blnControleContagem: Boolean;
    strLocFisContador: String;
    strCodContador: String;
    pZeraContagemColetiva: TpZeraContagemColetiva;


    Procedure pAtualiza(strCodIte, strAutLot: String; blnRelerBanco: Boolean = True; AblnControleContagem: Boolean = False; AstrCodContador: string = ''; AstrLocFisContador: String = '');

    procedure pAbreConsulta;

  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fGetOrderBy: String; Override;
    Procedure pOrdenaClient; Override;
  end;

var
  frmBalancoEstoqueDigManualLista: TfrmBalancoEstoqueDigManualLista;

implementation

uses untBalancoEstoqueAjuste, untfuncoesSimples, System.UITypes;

{$R *.dfm}

function TfrmBalancoEstoqueDigManualLista.fGetSql(blnLike: Boolean): String;
Begin
  Result := fSqlContagem(rdgMostrar.ItemIndex = 1, stlListItem, stlListLot, True, True, blnControleContagem, strCodContador, strLocFisContador);
End;

procedure TfrmBalancoEstoqueDigManualLista.FormCreate(Sender: TObject);
begin
  inherited;

  stlListItem := TStringList.Create;
  stlListItem.Duplicates := dupIgnore;

  stlListLot  := TStringList.Create;
  stlListLot.Duplicates := dupIgnore;

  pZeraContagemColetiva := Nil;
end;

procedure TfrmBalancoEstoqueDigManualLista.FormDestroy(Sender: TObject);
begin
  inherited;

  FreeAndNil(stlListItem);
  FreeAndNil(stlListLot);

end;

procedure TfrmBalancoEstoqueDigManualLista.FormShow(Sender: TObject);
begin
  inherited;

  intDigDec := 3;

  cdsConsulta.IndexDefs.Add('ITE_ORDCON', 'ITE_ORDCON', [ixDescending]);

  lflLastField.intIndCol := 8;
  lflLastField.strNomCam := dbgConsulta.Columns[8].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[8].Title.Caption;
  lflLastField.ftyTipCam := ftInteger;

  If fCfgSis('CONEST') = 1 Then
  Begin
    dbgConsulta.Columns[5].Visible := False;   // ITE_DIFSAL
    dbgConsulta.Columns[7].Visible := False;   // ITE_DIF_ML
    lblObsSaldo.Visible            := False;
    dbgConsulta.Columns[1].Width   := 180;

  End Else
  Begin
    dbgConsulta.Columns[4].Title.Caption := 'Saldo de Contagem';  // ITE_SALCON
    dbgConsulta.Columns[6].Title.Caption := 'Saldo Cont.(ML/GR)'; // ITE_GMLCON
  End;

  If Not fCfgSis('CONACU', varBoolean) Then
  Begin
    dbgConsulta.Columns[4].Title.Caption := 'Saldo de Contagem';  // ITE_SALCON
    dbgConsulta.Columns[6].Title.Caption := 'Saldo Cont.(ML/GR)'; // ITE_GMLCON
  End;

  blnSempreRelerBanco := False;
  blnTemSelecao       := False;
  intCorSelecao       := clMoneyGreen;

  fAbreConsulta(True);
end;

procedure TfrmBalancoEstoqueDigManualLista.pAtualiza(strCodIte, strAutLot: String; blnRelerBanco: Boolean = True; AblnControleContagem: Boolean = False; AstrCodContador: string = ''; AstrLocFisContador: String = '');
  Var
    intIndice: Integer;
    strInfo: String;
Begin
  blnControleContagem := AblnControleContagem;
  strCodContador := AstrCodContador;
  strLocFisContador := AstrLocFisContador;
  strInfo := QuotedStr(strCodIte + strAutLot);

  If Not stlListSelecao.Find(strInfo, intIndice) Then
    stlListSelecao.Add(strInfo);

  stlListItem.Add(QuotedStr(strCodIte));

  stlListLot.Add(QuotedStr(strAutLot));

  If blnRelerBanco Then
    fAbreConsulta(True);
End;

procedure TfrmBalancoEstoqueDigManualLista.pAbreConsulta;
Begin
  fAbreConsulta(True);
End;

procedure TfrmBalancoEstoqueDigManualLista.rdgMostrarClick(
  Sender: TObject);
begin
  inherited;
  fAbreConsulta(True);
end;

procedure TfrmBalancoEstoqueDigManualLista.dbgConsultaDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin

  With dbgConsulta.Canvas Do
  Begin
    If cdsConsulta.IsEmpty Then
      Exit;

    If (blnTemSelecao Or (Assigned(stlListSelecao) And (stlListSelecao.Count > 0))) And fInLista Then
    Begin

      If Brush.Color = clHighLight Then
      Begin
        Font.Color := clHighLightText;
      End Else
      Begin
        Brush.Color := intCorSelecao;
      End;

    End;
  End;

  If Column.Index = lflLastField.intIndCol then
  Begin
    dbgConsulta.Canvas.Brush.Color:= clInfoBk;
    dbgConsulta.Canvas.Font.Color:= clWindowText;
    dbgConsulta.Canvas.FillRect(Rect);
  End;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TfrmBalancoEstoqueDigManualLista.dbgConsultaKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE: btnZerCon.Click;
  End;

end;

procedure TfrmBalancoEstoqueDigManualLista.pZeraContagemManual;
begin
  If cdsConsulta.IsEmpty Then
    Exit;
    
  If Assigned(pZeraContagemColetiva) Then
    pZeraContagemColetiva(cdsConsulta.FieldByName('ITE_CODITE').AsString,
                          cdsConsulta.FieldByName('ITE_NUMLOT').AsString);

  pZeraContagem(cdsConsulta, objCadLot, stlListSelecao, Self,strLocFisContador, strCodContador);
  fAbreConsulta(True);

End;

procedure TfrmBalancoEstoqueDigManualLista.btnZerConClick(Sender: TObject);
begin
  inherited;

  With cdsConsulta Do
    If Active And (Not IsEmpty) And
       (fMensagem('', 'Zerar a contagem do item ' + FieldByName('ITE_CODITE').AsString +
                  ' - ' + FieldByName('ITE_DESITE').AsString + '?', ['&Sim', '&Nao']) = 1) Then
     pZeraContagemManual;
end;

function TfrmBalancoEstoqueDigManualLista.fGetOrderBy: String;
Begin
  If SameText(lflLastField.strNomCam, 'ITE_ORDCON') Then
  Begin
    cdsConsulta.IndexFieldNames := '';
    cdsConsulta.IndexName := 'ITE_ORDCON';
  End Else
  Begin
    cdsConsulta.IndexName := '';
    cdsConsulta.IndexFieldNames := fGetAliasField(lflLastField.strNomCam);
  End;

  Result := ' ORDER BY ITE_ORDCON DESC';
End;

Procedure TfrmBalancoEstoqueDigManualLista.pOrdenaClient;
Begin
  If SameText(lflLastField.strNomCam, 'ITE_ORDCON') Then
  Begin
    cdsConsulta.IndexFieldNames := '';
    cdsConsulta.IndexName := 'ITE_ORDCON';
  End Else
  Begin
    cdsConsulta.IndexName := '';
    cdsConsulta.IndexFieldNames := fGetAliasField(lflLastField.strNomCam);
  End;
End;

end.

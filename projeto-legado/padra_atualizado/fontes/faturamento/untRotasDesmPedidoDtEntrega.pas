unit untRotasDesmPedidoDtEntrega;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untFuncFatTypes, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Datasnap.DBClient, Datasnap.Provider,
  Faturamento.Classes.TFatVendaBase, untFuncFat;

type
  TfrmRotasDesmPedidoDtEntrega = class(TfrmPai)
    cdsPedDesm: TClientDataSet;
    DBGridCitel1: TDBGridCitel;
    cdsPedDesmDtEntrega: TDateField;
    cdsPedDesmCodItems: TStringField;
    cdsPedDesmTotValor: TFloatField;
    cdsPedDesmTotPeso: TFloatField;
    cdsPedDesmCodSeqRota: TStringField;
    dsPedDesm: TDataSource;
    DataSetProvider1: TDataSetProvider;
    LPedidos: TLabel;
    btnConfirmar: TBitBtnLocked;
    Legenda: TLabel;
    procedure FormShow(Sender: TObject);
    procedure DBGridCitel1KeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
  private
    { Private declarations }
    procedure MontaGridPedDesmPorEntrega;
    function  fRetCidadeEndEnt(strAutEnt: String): String;
    procedure ArmazenaSeqRotaNoArrayPedidos;
    function  ValidaSeqRotaEndEntrega: boolean;
    function  ValidaRota(strCodRot: String; var dtaDtaEnt: TDateTime): boolean;
    procedure CalculaTotaisRota(strCodRot: String; Var APesoTotal: Extended; Var AValorTotal: Extended);
  public
    { Public declarations }
    RotasPorEntregaOk: boolean;
    arrPedidos: TMatrizesFechamento;
    objVenda  : TFatVenda;
  end;

var
  frmRotasDesmPedidoDtEntrega: TfrmRotasDesmPedidoDtEntrega;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema, Uni, untLiberacao, untFuncoesGenerica, untValidacoesRotasRegiao;

procedure TfrmRotasDesmPedidoDtEntrega.ArmazenaSeqRotaNoArrayPedidos;
var
  LidxPed : integer;

begin
  inherited;
  cdsPedDesm.First;
  while not cdsPedDesm.Eof do
  begin
    For LidxPed := 0 To Length(arrPedidos) - 1 Do
    begin
      if arrPedidos[LidxPed][0].dtadtentr = cdsPedDesmDtEntrega.AsDateTime then
      begin
        arrPedidos[LidxPed][0].strCodRot := cdsPedDesmCodSeqRota.AsString;
        break;
      end;
    end;
    cdsPedDesm.Next;
  end;

end;

procedure TfrmRotasDesmPedidoDtEntrega.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if not ValidaSeqRotaEndEntrega then
  begin
    pMensagemOk('A Rota deve ser informada para todas as datas de entrega do pedido!');
    Exit;
  end;
  RotasPorEntregaOk := True;
  ArmazenaSeqRotaNoArrayPedidos;
  Close;
end;

procedure TfrmRotasDesmPedidoDtEntrega.DBGridCitel1KeyPress(Sender: TObject;
  var Key: Char);
var
   arrRotReg     : TConsultasArray;
   LedtCodRot     : TCustomEdit;
   LDtaEnt       : TDateTime;
   LVerificaRota : Boolean;

begin
  inherited;

  LedtCodRot := TcustomEdit.Create(nil);
  try
    If fPesqEntregasRotasRegiaoPdOr(GetParentForm(self) as TForm, LedtCodRot, Nil, Nil, Key, arrRotReg, True,
        IIF(fEmptyStr(fRetCidadeEndEnt(objVenda.strAutEnt)),objVenda.strCodCid, fRetCidadeEndEnt(objVenda.strAutEnt)),
        IIF(fEmptyStr(fRetCidadeEndEnt(objVenda.strAutEnt)),objVenda.strCliCep, objVenda.strCepEnt),
        True,
        objVenda.fltPesBru,
        objVenda.strIncOrc) Then
    Begin
      If Not ValidaRota(LedtCodRot.Text, LDtaEnt) Then
      Begin
        fMensagem('ATENÇÃO!', 'Rota não permitida!', ['&Ok']);
        LVerificaRota := False;
      End
      else LVerificaRota := True;

      If LVerificaRota Then
      Begin
        cdsPedDesm.Edit;
        cdsPedDesmCodSeqRota.asString := LedtCodRot.Text;
        cdsPedDesm.Post;
      End;
    End;
  finally
    LedtCodRot.Free;
  end;
end;

procedure TfrmRotasDesmPedidoDtEntrega.FormShow(Sender: TObject);
begin
  inherited;
  RotasPorEntregaOk := False;
  MontaGridPedDesmPorEntrega;
end;

function TfrmRotasDesmPedidoDtEntrega.fRetCidadeEndEnt(
  strAutEnt: String): String;

  function fRetSQL: String;
  Begin
    Result := '';
    Result := Result + ' SELECT ETC_CIDENT ';
    Result := Result + '   FROM ENTCLI     ';
    Result := Result + '  WHERE AUTOINCREM = :AUTINC ';
  End;

var
  qryCons: TUniQuery;
begin
  Result := '';
  If Not fEmptyStr(strAutEnt) Then
  Begin
    Try
      qryCons := fCriaQuery(Nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSQL);
        ParamByName('AUTINC').AsString := strAutEnt;
        Open;

        Result := FieldByName('ETC_CIDENT').AsString;
      End;
    Finally
      FreeAndNil(qryCons);
    End;
  End;
end;

procedure TfrmRotasDesmPedidoDtEntrega.MontaGridPedDesmPorEntrega;

var Lindice, LindiceItem : integer;
    LcodItens : string;
    Lpeso     : Double;
    Lvalor    : Double;

begin
  cdsPedDesm.CreateDataSet;
  cdsPedDesm.Close;
  cdsPedDesm.Open;
  cdsPedDesm.EmptyDataSet;
  For Lindice := 0 To Length(arrPedidos) - 1 Do
  begin
    cdsPedDesm.Append;
    cdsPedDesmDtEntrega.AsDateTime := arrPedidos[Lindice][0].dtadtentr;
    LcodItens := '';
    Lpeso  := 0;
    Lvalor := 0;
    For LindiceItem := 0 To Length(arrPedidos[Lindice]) - 1 Do
    begin
      LcodItens := LcodItens + IIF(LcodItens = '', arrPedidos[Lindice][LindiceItem].strCodIte, ',' + arrPedidos[Lindice][LindiceItem].strCodIte);
      Lpeso  := Lpeso  + arrPedidos[Lindice][LindiceItem].fltPesoItCalc;
      Lvalor := Lvalor + arrPedidos[Lindice][LindiceItem].fltTotIte;
    end;
    cdsPedDesmCodItems.AsString := LcodItens;
    cdsPedDesmTotValor.AsFloat := Lvalor;
    cdsPedDesmTotPeso.AsFloat  := Lpeso;
    cdsPedDesm.Post;

  end;
end;

function TfrmRotasDesmPedidoDtEntrega.ValidaRota(strCodRot: String; var dtaDtaEnt: TDateTime) : boolean;
var
  objRotReg : TRotReg;
  LPeso, LValor : Extended;

begin
  objRotReg := nil;
  Try
    Try
      CalculaTotaisRota(strCodRot, LPeso, LValor);

      objRotReg           := TRotReg.Create(Self);
      objRotReg.strCodRot := strCodRot;
      objRotReg.fltPesBru := LPeso + cdsPedDesmTotPeso.AsFloat;
      objRotReg.fltTotPro := LValor + cdsPedDesmTotValor.AsFloat;
      objRotReg.strCodVen := objVenda.strCodVen;
      objRotReg.strCodDig := objVenda.strCodDig;
      objRotReg.strNumOrc := IIF(fEmptyStr(objVenda.strNumOrc),'',objVenda.strNumOrc + '-' + objVenda.strEspDoc + '-' + VS_strCodEmp);
      objRotReg.strCodCli := objVenda.strCodCli;
      objRotReg.strEspDoc := objVenda.strOpcDoc;
      objRotReg.strSeqFgo := objVenda.strIncOrc;
      objRotReg.fltTotPed := LValor + cdsPedDesmTotValor.AsFloat;

      Result := objRotReg.fIniciaValidacoes;

      dtaDtaEnt := objRotReg.dtaDtaEnt;

    Except
      On E: Exception do
      Begin
        Result := False;
        pMensagensErro(E.Message,'[ValidaRota]');
      End;
    End;
  Finally
    objRotReg.Free;
  End;
end;

function TfrmRotasDesmPedidoDtEntrega.ValidaSeqRotaEndEntrega: boolean;
begin
  cdsPedDesm.First;
  while not cdsPedDesm.Eof do
  begin
    If cdsPedDesmCodSeqRota.AsString = '' Then
      Exit(False);
    cdsPedDesm.Next;
  end;
  Exit(True);
end;

procedure TfrmRotasDesmPedidoDtEntrega.CalculaTotaisRota(strCodRot: String; var APesoTotal: Extended;
  var AValorTotal: Extended);
var
  LPos    : TBookmark;

begin
  APesoTotal  := 0;
  AValorTotal := 0;

  LPos := cdsPedDesm.GetBookmark;
  cdsPedDesm.DisableControls;
  cdsPedDesm.First;
  while not cdsPedDesm.Eof do
  begin
    if strCodRot = cdsPedDesmCodSeqRota.AsString then
    begin
      APesoTotal  := APesoTotal  + cdsPedDesmTotPeso.AsFloat;
      AValorTotal := AValorTotal + cdsPedDesmTotValor.AsFloat;
    end;
    cdsPedDesm.Next;
  end;

  cdsPedDesm.GotoBookmark(LPos);
  if not fEmptyStr(cdsPedDesmCodSeqRota.AsString) then
  begin
    APesoTotal  := APesoTotal  - cdsPedDesmTotPeso.AsFloat;
    AValorTotal := AValorTotal - cdsPedDesmTotValor.AsFloat;
  end;
  cdsPedDesm.EnableControls;

end;

end.

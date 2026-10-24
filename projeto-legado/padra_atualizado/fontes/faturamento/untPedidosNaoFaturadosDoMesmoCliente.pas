unit untPedidosNaoFaturadosDoMesmoCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, QColorLabel, EditFocus, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, MemDS, DBAccess, Uni;

type
  TfrmPedidosNaoFaturadosDoMesmoCliente = class(TfrmPaiConfirma)
    pnlRodape               : TPanel;
    edtCarregarPedidos      : TEditFocus;
    lblCarregarPedidosColor : TColorLabel;
    lblCarregarPedidos      : TLabel;
    dbgPedidos              : TDBGridCitel;
    dtsPedidos              : TDataSource;
  private
    qryPedidos       : TUniQuery;
    function fRetSQL : String;
  public
    function fExistePedidosEmAbertoParaOCliente(strCodCli, strNomCli, strNumDoc, strEspDoc, strCodEmp: String) : Boolean;
    function fDesejaCarregarOsPedidosEmAbertoDoMesmoClienteQueEstaoNaExpedicao : Boolean;
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmPedidosNaoFaturadosDoMesmoCliente }

function TfrmPedidosNaoFaturadosDoMesmoCliente.fDesejaCarregarOsPedidosEmAbertoDoMesmoClienteQueEstaoNaExpedicao: Boolean;
begin

  Self.dtsPedidos.DataSet := qryPedidos;

  Self.ShowModal;
  Result := Self.edtCarregarPedidos.Text = 'S';
end;

function TfrmPedidosNaoFaturadosDoMesmoCliente.fExistePedidosEmAbertoParaOCliente(strCodCli, strNomCli, strNumDoc, strEspDoc, strCodEmp: String) : Boolean;
begin

  Result := False;

  If strCodCli.IsEmpty Then
    Exit;

  If Not Assigned(qryPedidos) Then
    qryPedidos := fCriaQuery();

  qryPedidos.Close;
  qryPedidos.SQL.Add(fRetSQL);
  qryPedidos.ParamByName('CODCLI').AsString := strCodCli;
  qryPedidos.ParamByName('DOCATU').AsString := (strNumDoc + strEspDoc + strCodEmp);
  qryPedidos.Open;

  (qryPedidos.FieldByName('VLRPED') As TFloatField).DisplayFormat := '#,####0.0000';

  Result := Not qryPedidos.IsEmpty;

end;

function TfrmPedidosNaoFaturadosDoMesmoCliente.fRetSQL: String;
begin
  Result := 'SELECT                                           ' +
            '  FGO_DTAENT                          AS DTAEMI, ' +
            '  CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC) AS PEDIDO, ' +
            '  FGO_CODEMP                          AS CODEMP, ' +
            '  CONCAT(FGO_CODVEN, "-", (SELECT O.OPE_NOMOPE FROM CADOPE O WHERE O.OPE_CODOPE = FGO_CODVEN)) AS CODVEN,  ' +
            '  FGO_VLRCON                                                                                   AS VLRPED,  ' +
            '  (SELECT F.STA_DESCRI FROM FGOSTA F WHERE F.STA_CODIGO = FGO_STATUS)                          AS STATUS   ' +
            'FROM     ' +
            '  FATGOR ' +
            '  INNER JOIN EXTGOR ON (EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM) ' +
            'WHERE                                                          ' +
            '  FGO_CODCLI = :CODCLI AND FGO_JAFATU <> "1" AND CONCAT(FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP) <> :DOCATU AND ' +
            '  FGO_ESPDOC = "PD" AND FGO_EMPEXP = ' + QuotedStr(VS_strCodEmp) + ' ' +
            'ORDER BY      ' +
            '  FGO_DTAENT, ' +
            '  FGO_CODEMP, ' +
            '  FGO_ESPDOC, ' +
            '  FGO_NUMDOC  ';
end;

function TfrmPedidosNaoFaturadosDoMesmoCliente.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCarregarPedidos) Then
    Begin

      If Pos(edtCarregarPedidos.Text,'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "Deseja carregar os pedidos do mesmo cliente que estão aqui na Expedição?" deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End;

    End;

  End;

end;

end.

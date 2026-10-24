unit untPnlDadosPedidoCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, UniClientDataSet, ExtCtrls, Uni,
  DB, BitBtnLockedIncrem;

type
  TfrmPnlDadosPedidoCompra = class(TForm)
    btnCancPedidoFilhote: TBitBtnLocked;
    dtsPedidos: TDataSource;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancPedidoFilhoteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cdsConsulta: TUniClientDataSet;
  end;
TfrmPnlDadosPedidoCompraClass = Class Of TfrmPnlDadosPedidoCompra;

var
  frmPnlDadosPedidoCompra: TfrmPnlDadosPedidoCompra;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmPnlDadosPedidoCompra.btnCancPedidoFilhoteClick(Sender: TObject);

  Var
    qryGen: TUniQuery;
    strSql: String;
    strAutoInc : String;

begin

  If cdsConsulta.FieldByName('PCG_NUMCTN').AsInteger > 0 Then
  Begin
    If fMensagem('', 'Confirma o cancelamento do Container ' + cdsConsulta.FieldByName('PCG_NUMPED').AsString +
                 ' - ' + cdsConsulta.FieldByName('PCG_NUMCTN').AsString , ['&Sim', '&Não']) = 1 Then
    Begin
      Try
        fStartTransaction;
        qryGen := fCriaQuery;

        strSql := '';
        strSql := strSql + ' DELETE FROM PCMGER           ';
        strSql := strSql + ' WHERE                        ';
        strSql := strSql + '   AUTOINCREM =  :AUTOIN  AND ';
        strSql := strSql + '   PCG_NUMPED =  :NUMPED  AND ';
        strSql := strSql + '   PCG_CODFOR =  :CODFOR  AND ';
        strSql := strSql + '   PCG_NUMCTN =  :NUMCTN  AND ';
        strSql := strSql + '   PCG_CODEMP =  :CODEMP      ';

        qryGen.SQL.Clear;
        qryGen.SQL.Add(strSql);
        qryGen.ParamByName('AUTOIN').AsString  := cdsConsulta.FieldByName('AUTOINCREM').AsString;
        qryGen.ParamByName('NUMPED').AsString  := cdsConsulta.FieldByName('PCG_NUMPED').AsString;
        qryGen.ParamByName('CODFOR').AsString  := cdsConsulta.FieldByName('FOR_CODFOR').AsString;
        qryGen.ParamByName('NUMCTN').AsInteger := cdsConsulta.FieldByName('PCG_NUMCTN').AsInteger;
        qryGen.ParamByName('CODEMP').AsString  := VS_strCodEmp;
        qryGen.ExecSQL;

        FreeAndNil(qryGen);
        fCommit;

        cdsConsulta.Prior;
        If Not cdsConsulta.Eof Then
          strAutoInc := cdsConsulta.FieldByName('AUTOINCREM').AsString
        Else
          strAutoInc := '';

        If strAutoInc <> '' Then
          cdsConsulta.Locate('AUTOINCREM',strAutoInc,[loCaseInsensitive, loPartialKey]);

      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[Cancelamento de Pedido Filhote]');
        End;
      End;
    End;
  End Else
   fMensagem('ATENÇÃO!', 'Somente Pedidos Filhotes podem ser cancelados.', ['&Ok']);

end;

procedure TfrmPnlDadosPedidoCompra.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F4 : btnCancPedidoFilhote.Click;
  end;

  case key of
    VK_F4 : Key := 0;
  end;

end;

end.

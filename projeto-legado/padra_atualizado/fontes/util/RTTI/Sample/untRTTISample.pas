{
Exemplo de como utilizar a TRTTIEngine para importar arquivos texto.

Arquivos para teste, utilizando a classe da geosales para este exemplo;

PEDIDO.TXT
1001	13	2015-06-21	1000.00	1	1	1001	1	1	2015-06-21	1	1	1	998	2015-06-21	1	1	Apenas alguma observação idiota para um teste simples.	Guilherme Borges	Rua Doutor Paulo Barra, 1380	Jardim Iraja	Ribeirão Preto	São Paulo	14020320			35598032848	0		Guilherme Borges		0	1		1	1	0	0	Faturar e enviar por e-mail a nota fiscal	2015-06-21	Guilherme Teste	1010.00	0.00	0			10	11	0.00	2015-06-21	998	2015-06-21		10.00	0.00	2015-06-21
1002	13	2015-06-21	1000.00	1	1	1001	1	1	2015-06-21	1	1	1	998	2015-06-21	1	1	Apenas alguma observação idiota para um teste simples.	Guilherme Borges	Rua Doutor Paulo Barra, 1380	Jardim Iraja	Ribeirão Preto	São Paulo	14020320			35598032848	0		Guilherme Borges		0	1		1	1	0	0	Faturar e enviar por e-mail a nota fiscal	2015-06-21	Guilherme Teste	1010.00	0.00	0			10	11	0.00	2015-06-21	998	2015-06-21		10.00	0.00	2015-06-21
1003	13	2015-06-21	1000.00	1	1	1001	1	1	2015-06-21	1	1	1	998	2015-06-21	1	1	Apenas alguma observação idiota para um teste simples.	Guilherme Borges	Rua Doutor Paulo Barra, 1380	Jardim Iraja	Ribeirão Preto	São Paulo	14020320			35598032848	0		Guilherme Borges		0	1		1	1	0	0	Faturar e enviar por e-mail a nota fiscal	2015-06-21	Guilherme Teste	1010.00	0.00	0			10	11	0.00	2015-06-21	998	2015-06-21		10.00	0.00	2015-06-21
1004	13	2015-06-21	1000.00	1	1	1001	1	1	2015-06-21	1	1	1	998	2015-06-21	1	1	Apenas alguma observação idiota para um teste simples.	Guilherme Borges	Rua Doutor Paulo Barra, 1380	Jardim Iraja	Ribeirão Preto	São Paulo	14020320			35598032848	0		Guilherme Borges		0	1		1	1	0	0	Faturar e enviar por e-mail a nota fiscal	2015-06-21	Guilherme Teste	1010.00	0.00	0			10	11	0.00	2015-06-21	998	2015-06-21		10.00	0.00	2015-06-21


ITEM_PEDIDO.TXT
1001	1	115	10.00	100.00	0	0	10.00	Embrulho para presente1	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1001	1	115	10.00	100.00	0	0	10.00	Embrulho para presente2	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1001	1	115	10.00	100.00	0	0	10.00	Embrulho para presente3	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1001	1	115	10.00	100.00	0	0	10.00	Embrulho para presente4	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1004	1	115	10.00	100.00	0	0	10.00	Embrulho para presente5	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1004	1	115	10.00	100.00	0	0	10.00	Embrulho para presente6	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1004	1	115	10.00	100.00	0	0	10.00	Embrulho para presente7	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1004	1	115	10.00	100.00	0	0	10.00	Embrulho para presente8	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1003	1	115	10.00	100.00	0	0	10.00	Embrulho para presente9	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1003	1	115	10.00	100.00	0	0	10.00	Embrulho para presente10	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1003	1	115	10.00	100.00	0	0	10.00	Embrulho para presente11	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1002	1	115	10.00	100.00	0	0	10.00	Guilherme borges	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1002	1	115	10.00	100.00	0	0	10.00	Embrulho para presente12	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1002	1	115	10.00	100.00	0	0	10.00	Embrulho para presente13	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1002	1	115	10.00	100.00	0	0	10.00	Embrulho para presente14	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00
1002	1	115	10.00	100.00	0	0	10.00	Embrulho para presente15	0.00	0	0	1		0	0	100.00	0	10.00	0		0	0.00	0.00	0.00	0.00	0.00	0.00	2015-06-21	0.00	0.00

}


unit untRTTISample;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  BitBtnLockedIncrem;

type
  TfrmRTTISample = class(TForm)
    ProgressBar: TProgressBar;
    mmoPedido: TMemo;
    mmoItemPed: TMemo;
    Label2: TLabel;
    Label1: TLabel;
    btnImportar: TBitBtnLocked;
    procedure btnImportarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untGeoSale_Pedido, untGeoSale_Item_Pedido, untRTTIEngine,
  untRTTISingletonCollection;


procedure TfrmRTTISample.btnImportarClick(Sender: TObject);
  Var
    objEngine : TRTTIEngine;
    intHandle : Integer;
    intWait   : Integer;

    intIndex  : Integer;

begin
  //Importando Arquivo de Pedidos e colocando na TRTTISingletonCollection
  objEngine := TRTTIEngine.Create( TGeoSale_Pedido.Create( ExtractFilePath(Application.ExeName),'' ), Nil, True);
  intHandle := objEngine.Handle;

  objEngine.Start;

  Repeat
    intWait:= WaitForSingleObject(intHandle, 0);

    ProgressBar.Position := Trunc(objEngine.fltStatus);
    Application.ProcessMessages;
    Sleep(500);

  Until intWait <> WAIT_TIMEOUT;
  objEngine.Free;

  //Importando Arquivo de Itens de Pedidos e colocando na TRTTISingletonCollection
  objEngine := TRTTIEngine.Create( TGeoSale_Item_Pedido.Create( ExtractFilePath(Application.ExeName), '' ), Nil, True);
  intHandle := objEngine.Handle;

  objEngine.Start;

  Repeat
    intWait:= WaitForSingleObject(intHandle, 0);

    ProgressBar.Position := Trunc(objEngine.fltStatus);
    Application.ProcessMessages;
    Sleep(500);

  Until intWait <> WAIT_TIMEOUT;

  objEngine.Free;


  //Lendo Os Resultados

  For intIndex := 0 To TRTTISingletonCollection.Instance.fGetListObj(TGeoSale_Pedido).Count-1 Do
  Begin
    With TGeoSale_Pedido(TRTTISingletonCollection.Instance.fGetListObj(TGeoSale_Pedido)[IntIndex]) Do
      mmoPedido.Lines.Add( 'Pedido Numero: ' + IntToStr(CD_PEDIDO_PALM) + ' OBS: ' +  DS_OBSERVACAO);
  End;

  For intIndex := 0 To TRTTISingletonCollection.Instance.fGetListObj(TGeoSale_Item_Pedido).Count-1 Do
  Begin
    With TGeoSale_Item_Pedido(TRTTISingletonCollection.Instance.fGetListObj(TGeoSale_Item_Pedido)[IntIndex]) Do
      mmoItemPed.Lines.Add( 'Pedido Numero: ' + IntToStr(CD_PEDIDO_PALM) + ' CODIGO ITEM: ' + IntToStr(CD_PRODUTO));
  End;

  //Liberando todos objetos da memoria.
  TRTTISingletonCollection.Instance.Destroy;


end;

End.

unit FormPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts, REST.Types, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Web.HTTPApp, FMX.Edit, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    lblGitFinder: TLabel;
    Panel1: TPanel;
    Layout1: TLayout;
    btnClique: TButton;
    lblInfoUsuario: TLabel;
    edtUsuario: TEdit;
    lblInfoSeguidores: TLabel;
    lblInfoSeguindo: TLabel;
    lblInfoRepositorios: TLabel;
    lblInfoLocal: TLabel;
    lblInfoNome: TLabel;
    lblInfoID: TLabel;
    lblInfoEmail: TLabel;
    procedure btnCliqueClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    //FHttpRequest: IHTTPRequest;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.LgXhdpiTb.fmx ANDROID}
{$R *.LgXhdpiPh.fmx ANDROID}
{$R *.iPad.fmx IOS}
{$R *.iPhone4in.fmx IOS}

uses
  System.JSON;

procedure TForm1.btnCliqueClick(Sender: TObject);
var
  //LRetorno: IHTTPResponse;
  LRetornoJSON: TJSONObject;
begin

    RESTClient := TRESTClient.Create('https://api.github.com/');
    RESTRequest := TRESTRequest.Create(nil);
    RESTRequest.Client := RESTClient;
    RESTRequest.Resource := 'users/{usuario}';
    RESTRequest.Params.AddUrlSegment('usuario', edtUsuario.Text);
    RESTRequest.Execute;
    LRetornoJSON := RESTRequest.Response.JSONValue as TJSONObject;

  //NetHTTPRequest1.URL := 'https://api.github.com/users/' + edtUsuario.Text;
  //NetHTTPRequest1.


   //LRetornoJSON := LRetorno.ContentAsString as TJSONObject;

   lblInfoNome.Text := 'Nome: ' + LRetornoJSON.GetValue('name').Value;
    lblInfoID.Text := 'Id: ' + LRetornoJSON.GetValue('id').Value;
    lblInfoSeguidores.Text := 'Seguidores: ' + LRetornoJSON.GetValue
    ('followers').Value;
    lblInfoSeguindo.Text := 'Seguindo: ' + LRetornoJSON.GetValue
    ('following').Value;
    lblInfoRepositorios.Text := 'Repositórios: ' + LRetornoJSON.GetValue
    ('public_repos').Value;
    lblInfoLocal.Text := 'Local: ' + LRetornoJSON.GetValue('location').Value;
    lblInfoEmail.Text := 'Email: ' + LRetornoJSON.GetValue('email').Value;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  RESTClient.Free;
  RESTRequest.Free;
end;

end.
